import '../../../../core/app/notification_service.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/storage/sync_flag_store.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/health_lookup.dart';
import '../../domain/entities/health_reminder.dart';
import '../../domain/entities/medication.dart';
import '../../domain/entities/pet_health_score.dart';
import '../../domain/entities/vaccination.dart';
import '../../domain/entities/weight_record.dart';
import '../../domain/repositories/pawcare_repository.dart';
import '../datasources/health_reminder_local_datasource.dart';
import '../datasources/pawcare_remote_datasource.dart';

/// Notification ID ranges — stable so cancel + reschedule always targets the
/// same slot. Derived from entity IDs to avoid collisions across pets.
///
/// Medication:   10_000_000 + medicationId
/// Vaccination:  20_000_000 + vaccinationId
/// Appointment:  30_000_000 + appointmentId * 10      (day-before reminder)
///               30_000_000 + appointmentId * 10 + 1  (hour-before reminder)
const int _medBase = 10000000;
const int _vacBase = 20000000;
const int _apptBase = 30000000;

/// PawCare repository. Maps remote DTOs onto domain entities and turns
/// [AppException]s into [Failure]s.
///
/// On every medication / vaccination fetch it also caches the reminder-bearing
/// records locally (home screen "Upcoming" section) and schedules the
/// corresponding local notifications so the user is alerted even when offline.
class PawCareRepositoryImpl implements PawCareRepository {
  const PawCareRepositoryImpl(
    this._remote,
    this._reminderCache,
    this._notifications,
    this._syncFlags,
  );

  final PawCareRemoteDataSource _remote;
  final HealthReminderLocalDataSource _reminderCache;
  final NotificationService _notifications;
  final SyncFlagStore _syncFlags;

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

  // ── Medications ───────────────────────────────────────────────────────────

  @override
  Future<Result<List<Medication>>> getMedications(int petId) =>
      _guard(() async {
        await _syncFlags.clearSyncFlag(petId); // consume any pending sync signal
        final dtos = await _remote.getMedications(petId);
        final meds = dtos.map((e) => e.toEntity()).toList(growable: false);
        await _cacheMedicationReminders(petId, meds);
        await _reconcileMedicationNotifications(meds);
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
        final med = dto.toEntity();
        await _scheduleMedication(med);
        return med;
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
        final med = dto.toEntity();
        // Cancel the old slot and reschedule for the new nextDueDate.
        await _notifications.cancel(_medBase + medicationId);
        await _scheduleMedication(med);
        return med;
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
        final med = dto.toEntity();
        await _notifications.cancel(_medBase + medicationId);
        await _scheduleMedication(med);
        return med;
      });

  @override
  Future<Result<void>> deleteMedication(int petId, int medicationId) =>
      _guard(() async {
        await _remote.deleteMedication(petId, medicationId);
        await _notifications.cancel(_medBase + medicationId);
      });

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
        await _syncFlags.clearSyncFlag(petId);
        final dtos = await _remote.getVaccinations(petId);
        final vaccines = dtos.map((e) => e.toEntity()).toList(growable: false);
        await _cacheVaccinationReminders(petId, vaccines);
        await _reconcileVaccinationNotifications(vaccines);
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
        final vaccine = dto.toEntity();
        await _scheduleVaccination(vaccine);
        return vaccine;
      });

  @override
  Future<Result<void>> deleteVaccination(int petId, int vaccinationId) =>
      _guard(() async {
        await _remote.deleteVaccination(petId, vaccinationId);
        await _notifications.cancel(_vacBase + vaccinationId);
      });

  // ── Appointments ──────────────────────────────────────────────────────────

  @override
  Future<Result<List<Appointment>>> getAppointments(int petId) =>
      _guard(() async {
        await _syncFlags.clearSyncFlag(petId);
        final dtos = await _remote.getAppointments(petId);
        final appts = dtos.map((e) => e.toEntity()).toList(growable: false);
        await _cacheAppointmentReminders(petId, appts);
        await _reconcileAppointmentNotifications(appts);
        return appts;
      });

  @override
  Future<Result<Appointment>> addAppointment(
    int petId, {
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  }) =>
      _guard(() async {
        final dto = await _remote.addAppointment(
          petId,
          title: title,
          scheduledAt: scheduledAt,
          location: location,
          notes: notes,
        );
        final appt = dto.toEntity();
        await _scheduleAppointment(appt);
        return appt;
      });

  @override
  Future<Result<Appointment>> updateAppointment(
    int petId,
    int appointmentId, {
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  }) =>
      _guard(() async {
        final dto = await _remote.updateAppointment(
          petId,
          appointmentId,
          title: title,
          scheduledAt: scheduledAt,
          location: location,
          notes: notes,
        );
        await _cancelAppointmentNotifications(appointmentId);
        final appt = dto.toEntity();
        await _scheduleAppointment(appt);
        // Refresh the reminder cache with the updated list.
        final all = await _remote.getAppointments(petId);
        await _cacheAppointmentReminders(
          petId,
          all.map((e) => e.toEntity()).toList(growable: false),
        );
        return appt;
      });

  @override
  Future<Result<void>> deleteAppointment(int petId, int appointmentId) =>
      _guard(() async {
        await _remote.deleteAppointment(petId, appointmentId);
        await _cancelAppointmentNotifications(appointmentId);
        // Refresh the reminder cache without the deleted entry.
        final all = await _remote.getAppointments(petId);
        await _cacheAppointmentReminders(
          petId,
          all.map((e) => e.toEntity()).toList(growable: false),
        );
      });

  // ── Lookups ───────────────────────────────────────────────────────────────

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

  // ── Health score ──────────────────────────────────────────────────────────

  @override
  Future<Result<PetHealthScore>> getHealthScore(int petId) => _guard(() async {
        final dto = await _remote.getHealthScore(petId);
        return dto.toEntity();
      });

  // ── Notification scheduling ───────────────────────────────────────────────

  Future<void> _scheduleMedication(Medication med) async {
    if (!med.isActive) return;
    await _notifications.schedule(
      id: _medBase + med.id,
      title: '${med.name} due',
      body: 'Time to give ${med.name} to your pet.',
      when: med.nextDueDate,
      category: NotificationCategory.medication,
    );
  }

  /// On full list sync: cancel all old slots and reschedule from the
  /// server list. Handles changes made on other devices or the web.
  Future<void> _reconcileMedicationNotifications(List<Medication> meds) async {
    for (final med in meds) {
      await _notifications.cancel(_medBase + med.id);
      if (med.isActive) await _scheduleMedication(med);
    }
  }

  Future<void> _scheduleVaccination(Vaccination vaccine) async {
    final due = vaccine.nextDueDate;
    if (due == null) return;
    await _notifications.schedule(
      id: _vacBase + vaccine.id,
      title: '${vaccine.name} booster due',
      body: "Your pet's ${vaccine.name} booster is coming up.",
      when: due,
      category: NotificationCategory.vaccination,
    );
  }

  Future<void> _reconcileVaccinationNotifications(
      List<Vaccination> vaccines) async {
    for (final v in vaccines) {
      await _notifications.cancel(_vacBase + v.id);
      await _scheduleVaccination(v);
    }
  }

  /// Two reminders per appointment: 24 h before and 1 h before.
  Future<void> _scheduleAppointment(Appointment appt) async {
    final dayBefore = appt.scheduledAt.subtract(const Duration(hours: 24));
    final hourBefore = appt.scheduledAt.subtract(const Duration(hours: 1));
    await _notifications.schedule(
      id: _apptBase + appt.id * 10,
      title: '${appt.title} tomorrow',
      body: appt.location != null
          ? 'Appointment at ${appt.location} tomorrow.'
          : 'You have an appointment tomorrow.',
      when: dayBefore,
      category: NotificationCategory.appointment,
    );
    await _notifications.schedule(
      id: _apptBase + appt.id * 10 + 1,
      title: '${appt.title} in 1 hour',
      body: appt.location != null
          ? 'Appointment at ${appt.location} in 1 hour.'
          : 'You have an appointment in 1 hour.',
      when: hourBefore,
      category: NotificationCategory.appointment,
    );
  }

  Future<void> _cancelAppointmentNotifications(int appointmentId) async {
    await _notifications.cancel(_apptBase + appointmentId * 10);
    await _notifications.cancel(_apptBase + appointmentId * 10 + 1);
  }

  Future<void> _reconcileAppointmentNotifications(
      List<Appointment> appts) async {
    for (final a in appts) {
      await _cancelAppointmentNotifications(a.id);
      if (!a.isPast) await _scheduleAppointment(a);
    }
  }

  // ── Reminder caching ──────────────────────────────────────────────────────

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
    } catch (_) {}
  }

  Future<void> _cacheAppointmentReminders(
    int petId,
    List<Appointment> appts,
  ) async {
    try {
      final reminders = [
        for (final a in appts)
          if (!a.isPast)
            HealthReminder(
              kind: HealthReminderKind.appointment,
              sourceId: a.id,
              petId: petId,
              petName: '',
              title: a.title,
              dueDate: a.scheduledAt,
            ),
      ];
      await _reminderCache.writeForPet(
        petId,
        HealthReminderKind.appointment,
        reminders,
      );
    } catch (_) {}
  }

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
    } catch (_) {}
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
