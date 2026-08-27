import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/app/notification_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/hive_service.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/health_reminder_local_datasource.dart';
import '../../data/datasources/pawcare_remote_datasource.dart';
import '../../data/repositories/pawcare_repository_impl.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/health_lookup.dart';
import '../../domain/entities/health_reminder.dart';
import '../../domain/entities/medication.dart';
import '../../domain/entities/pet_health_score.dart';
import '../../domain/entities/vaccination.dart';
import '../../domain/entities/weight_record.dart';
import '../../domain/repositories/pawcare_repository.dart';

part 'pawcare_providers.g.dart';

@Riverpod(keepAlive: true)
HealthReminderLocalDataSource healthReminderCache(Ref ref) =>
    HealthReminderLocalDataSource(ref.watch(hiveServiceProvider));

@Riverpod(keepAlive: true)
PawCareRepository pawCareRepository(Ref ref) => PawCareRepositoryImpl(
      PawCareRemoteDataSource(ref.watch(apiClientProvider)),
      ref.watch(healthReminderCacheProvider),
      ref.watch(notificationServiceProvider),
      ref.watch(syncFlagStoreProvider),
    );

/// The health sections a pet profile shows, fetched together so the
/// dashboard has a single loading / error surface.
class PetHealthSnapshot {
  const PetHealthSnapshot({
    required this.weights,
    required this.medications,
    required this.vaccinations,
    required this.appointments,
  });

  /// Weight history, oldest first.
  final List<WeightRecord> weights;

  /// Active medications.
  final List<Medication> medications;

  /// Vaccination records, most recent first.
  final List<Vaccination> vaccinations;

  /// Upcoming appointments, soonest first.
  final List<Appointment> appointments;

  WeightRecord? get latestWeight => weights.isEmpty ? null : weights.last;
}

/// Unwraps a [Result], throwing the [Failure] so the surrounding FutureProvider
/// surfaces it as an AsyncError the UI can localize.
T _unwrap<T>(Result<T> result) =>
    result.when(success: (v) => v, failure: (f) => throw f);

/// Unwraps a list [Result], but treats a 404 as "no records yet" (empty) rather
/// than an error — some section endpoints return 404 when a pet has no data (or
/// isn't deployed yet), which shouldn't blank out the whole dashboard.
List<T> _listOrEmptyOnNotFound<T>(Result<List<T>> result) => result.when(
      success: (v) => v,
      failure: (f) => f is NotFoundFailure ? <T>[] : throw f,
    );

/// Loads the health snapshot for a pet — the three sections in parallel, with a
/// single loading / error surface for the dashboard. Family-keyed so each pet
/// caches independently.
@riverpod
Future<PetHealthSnapshot> petHealthSnapshot(Ref ref, int petId) async {
  final repo = ref.watch(pawCareRepositoryProvider);
  final (weights, medications, vaccinations, appointments) = await (
    repo.getWeightHistory(petId),
    repo.getMedications(petId),
    repo.getVaccinations(petId),
    repo.getAppointments(petId),
  ).wait;

  return PetHealthSnapshot(
    weights: _listOrEmptyOnNotFound(weights),
    medications: _listOrEmptyOnNotFound(medications),
    vaccinations: _listOrEmptyOnNotFound(vaccinations),
    appointments: _listOrEmptyOnNotFound(appointments),
  );
}

/// Full weight history for the history page. Separate from the snapshot so the
/// list page can refresh independently after an add.
@riverpod
Future<List<WeightRecord>> weightHistory(Ref ref, int petId) async {
  return _listOrEmptyOnNotFound(
    await ref.watch(pawCareRepositoryProvider).getWeightHistory(petId),
  );
}

/// Active medications for the medications list page.
@riverpod
Future<List<Medication>> petMedications(Ref ref, int petId) async {
  return _listOrEmptyOnNotFound(
    await ref.watch(pawCareRepositoryProvider).getMedications(petId),
  );
}

/// Vaccination records for the vaccinations list page.
@riverpod
Future<List<Vaccination>> petVaccinations(Ref ref, int petId) async {
  return _listOrEmptyOnNotFound(
    await ref.watch(pawCareRepositoryProvider).getVaccinations(petId),
  );
}

/// Upcoming medications across all of the user's pets, within [daysAhead] days.
@riverpod
Future<List<UpcomingMedication>> upcomingMedications(
  Ref ref, {
  int daysAhead = 14,
}) async {
  return _unwrap(
    await ref
        .watch(pawCareRepositoryProvider)
        .getUpcomingMedications(daysAhead: daysAhead),
  );
}

/// Cached upcoming health reminders (medication doses + vaccination boosters)
/// across all pets, for the home "Upcoming" section.
///
/// Reads purely from the local cache written on each medication / vaccination
/// fetch — no network. Pet names are joined from the pet gate (the per-pet
/// health endpoints don't carry them). Sorted soonest-first; overdue included.
/// A dedicated home endpoint will replace this source later.
@riverpod
Future<List<HealthReminder>> upcomingHealthReminders(Ref ref) async {
  final cached = await ref.watch(healthReminderCacheProvider).readAll();

  // Join pet names from the routing gate's refs.
  final names = {
    for (final r in ref.watch(petsProvider).refs) r.id: r.name,
  };

  final resolved = [
    for (final r in cached)
      HealthReminder(
        kind: r.kind,
        sourceId: r.sourceId,
        petId: r.petId,
        petName: names[r.petId] ?? r.petName,
        title: r.title,
        dueDate: r.dueDate,
      ),
  ]..sort((a, b) => a.dueDate.compareTo(b.dueDate));

  return resolved;
}

/// Known medication names for the add-medication picker.
@riverpod
Future<List<HealthLookup>> medicationLookups(Ref ref) async {
  return _unwrap(
    await ref.watch(pawCareRepositoryProvider).getMedicationLookups(),
  );
}

/// Known vaccine names for the add-vaccination picker.
@riverpod
Future<List<HealthLookup>> vaccineLookups(Ref ref) async {
  return _unwrap(
    await ref.watch(pawCareRepositoryProvider).getVaccineLookups(),
  );
}

/// Appointments for a pet, soonest first. Family-keyed per pet.
@riverpod
Future<List<Appointment>> petAppointments(Ref ref, int petId) async {
  return _listOrEmptyOnNotFound(
    await ref.watch(pawCareRepositoryProvider).getAppointments(petId),
  );
}

/// The pet's server-computed health score. Family-keyed per pet. Invalidate it
/// alongside [petHealthSnapshotProvider] after the user logs data — the score
/// is live and will move.
@riverpod
Future<PetHealthScore> petHealthScore(Ref ref, int petId) async {
  return _unwrap(
    await ref.watch(pawCareRepositoryProvider).getHealthScore(petId),
  );
}
