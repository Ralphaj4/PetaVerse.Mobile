import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/health_lookup.dart';
import '../../domain/entities/health_reminder.dart';
import '../../domain/entities/medication.dart';
import '../../domain/entities/vaccination.dart';
import '../../domain/entities/weight_record.dart';
import '../../domain/repositories/pawcare_repository.dart';
import '../datasources/health_reminder_local_datasource.dart';
import '../datasources/pawcare_remote_datasource.dart';

/// PawCare repository. Maps remote DTOs onto domain entities and turns
/// [AppException]s into [Failure]s.
///
/// On every medication / vaccination fetch it also caches the reminder-bearing
/// records (upcoming doses, vaccination boosters) locally, so the home screen's
/// "Upcoming" section has data before a dedicated home endpoint exists.
class PawCareRepositoryImpl implements PawCareRepository {
  const PawCareRepositoryImpl(this._remote, this._reminderCache);

  final PawCareRemoteDataSource _remote;
  final HealthReminderLocalDataSource _reminderCache;

  Future<Result<T>> _guard<T>(Future<T> Function() run) async {
    try {
      return Result.success(await run());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  // ── Weight ────────────────────────────────────────────────────────────────

  @override
  Future<Result<List<WeightRecord>>> getWeightHistory(int petId) =>
      _guard(() async {
        final dtos = await _remote.getWeightHistory(petId);
        return dtos.map((e) => e.toEntity()).toList(growable: false);
      });

  @override
  Future<Result<WeightRecord>> addWeight(
    int petId, {
    required double weight,
    required WeightUnit unit,
    required DateTime recordedDate,
    String? notes,
  }) =>
      _guard(() async {
        final dto = await _remote.addWeight(
          petId,
          weight: weight,
          unit: unit.wire,
          recordedDate: recordedDate,
          notes: notes,
        );
        return dto.toEntity();
      });

  @override
  Future<Result<void>> deleteWeight(int petId, int weightId) =>
      _guard(() => _remote.deleteWeight(petId, weightId));

  // ── Medications ─────────────────────────────────────────────────────────

  @override
  Future<Result<List<Medication>>> getMedications(int petId) =>
      _guard(() async {
        final dtos = await _remote.getMedications(petId);
        final meds = dtos.map((e) => e.toEntity()).toList(growable: false);
        await _cacheMedicationReminders(petId, meds);
        return meds;
      });

  @override
  Future<Result<Medication>> addMedication(
    int petId, {
    int? medicationId,
    String? customMedicationName,
    required int frequencyDays,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) =>
      _guard(() async {
        final dto = await _remote.addMedication(
          petId,
          medicationId: medicationId,
          customMedicationName: customMedicationName,
          frequencyDays: frequencyDays,
          startDate: startDate,
          endDate: endDate,
          notes: notes,
        );
        return dto.toEntity();
      });

  @override
  Future<Result<Medication>> markMedicationGiven(
    int petId,
    int medicationId, {
    DateTime? givenDate,
  }) =>
      _guard(() async {
        final dto = await _remote.markMedicationGiven(
          petId,
          medicationId,
          givenDate: givenDate,
        );
        return dto.toEntity();
      });

  @override
  Future<Result<Medication>> updateMedication(
    int petId,
    int medicationId, {
    required String medicationName,
    required int frequencyDays,
    DateTime? endDate,
    String? notes,
  }) =>
      _guard(() async {
        final dto = await _remote.updateMedication(
          petId,
          medicationId,
          medicationName: medicationName,
          frequencyDays: frequencyDays,
          endDate: endDate,
          notes: notes,
        );
        return dto.toEntity();
      });

  @override
  Future<Result<void>> deleteMedication(int petId, int medicationId) =>
      _guard(() => _remote.deleteMedication(petId, medicationId));

  @override
  Future<Result<List<UpcomingMedication>>> getUpcomingMedications({
    int daysAhead = 14,
  }) =>
      _guard(() async {
        final dtos = await _remote.getUpcomingMedications(daysAhead: daysAhead);
        return dtos.map((e) => e.toEntity()).toList(growable: false);
      });

  // ── Vaccinations ──────────────────────────────────────────────────────────

  @override
  Future<Result<List<Vaccination>>> getVaccinations(int petId) =>
      _guard(() async {
        final dtos = await _remote.getVaccinations(petId);
        final vaccines = dtos.map((e) => e.toEntity()).toList(growable: false);
        await _cacheVaccinationReminders(petId, vaccines);
        return vaccines;
      });

  @override
  Future<Result<Vaccination>> addVaccination(
    int petId, {
    required int vaccineId,
    required DateTime dateAdministered,
    DateTime? nextDueDate,
    String? vetName,
    String? notes,
    String? documentUrl,
  }) =>
      _guard(() async {
        final dto = await _remote.addVaccination(
          petId,
          vaccineId: vaccineId,
          dateAdministered: dateAdministered,
          nextDueDate: nextDueDate,
          vetName: vetName,
          notes: notes,
          documentUrl: documentUrl,
        );
        return dto.toEntity();
      });

  @override
  Future<Result<void>> deleteVaccination(int petId, int vaccinationId) =>
      _guard(() => _remote.deleteVaccination(petId, vaccinationId));

  // ── Lookups ─────────────────────────────────────────────────────────────

  @override
  Future<Result<List<HealthLookup>>> getMedicationLookups() => _guard(() async {
        final dtos = await _remote.getMedicationLookups();
        return dtos.map((e) => e.toEntity()).toList(growable: false);
      });

  @override
  Future<Result<List<HealthLookup>>> getVaccineLookups() => _guard(() async {
        final dtos = await _remote.getVaccineLookups();
        return dtos.map((e) => e.toEntity()).toList(growable: false);
      });

  // ── Reminder caching ──────────────────────────────────────────────────────

  /// Caches active, non-expired medication doses as reminders. Best-effort:
  /// a cache failure must never break the medication fetch.
  Future<void> _cacheMedicationReminders(
    int petId,
    List<Medication> meds,
  ) async {
    try {
      final reminders = [
        for (final m in meds)
          if (m.isActive)
            HealthReminder(
              kind: HealthReminderKind.medication,
              sourceId: m.id,
              petId: petId,
              petName: '',
              title: m.name,
              dueDate: m.nextDueDate,
            ),
      ];
      await _reminderCache.writeForPet(
        petId,
        HealthReminderKind.medication,
        reminders,
      );
    } catch (_) {
      // Ignore — reminders are a convenience cache, not source of truth.
    }
  }

  /// Caches vaccinations that have a booster due date. Best-effort.
  Future<void> _cacheVaccinationReminders(
    int petId,
    List<Vaccination> vaccines,
  ) async {
    try {
      final reminders = [
        for (final v in vaccines)
          if (v.nextDueDate != null)
            HealthReminder(
              kind: HealthReminderKind.vaccination,
              sourceId: v.id,
              petId: petId,
              petName: '',
              title: v.name,
              dueDate: v.nextDueDate!,
            ),
      ];
      await _reminderCache.writeForPet(
        petId,
        HealthReminderKind.vaccination,
        reminders,
      );
    } catch (_) {
      // Ignore — reminders are a convenience cache, not source of truth.
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        RateLimitException() => RateLimitFailure(
            message: e.message,
            retryAfter: e.retryAfter,
          ),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
