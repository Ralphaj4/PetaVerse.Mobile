import '../../../../core/errors/result.dart';
import '../entities/appointment.dart';
import '../entities/feeding_schedule.dart';
import '../entities/grooming_schedule.dart';
import '../entities/health_lookup.dart';
import '../entities/medication.dart';
import '../entities/pet_health_score.dart';
import '../entities/vaccination.dart';
import '../entities/weight_record.dart';

/// Contract for PawCare health data (weight, medications, vaccinations) and the
/// lookup lists that back the add-forms. The data layer maps DTOs onto these
/// entities and turns AppExceptions into Failures.
abstract interface class PawCareRepository {
  // ── Weight ────────────────────────────────────────────────────────────────

  /// Weight history for a pet, newest first (as the API returns it).
  Future<Result<List<WeightRecord>>> getWeightHistory(int petId);

  /// Records a new weight measurement.
  Future<Result<WeightRecord>> addWeight(
    int petId, {
    required double weight,
    required WeightUnit unit,
    required DateTime recordedDate,
    String? notes,
  });

  /// Deletes a weight record.
  Future<Result<void>> deleteWeight(int petId, int weightId);

  // ── Medications ─────────────────────────────────────────────────────────

  /// Active medications for a pet, ordered by next due date.
  Future<Result<List<Medication>>> getMedications(int petId);

  /// Adds a medication schedule. Provide EITHER [medicationId] (from the
  /// lookup) OR [customMedicationName] - not both.
  Future<Result<Medication>> addMedication(
    int petId, {
    int? medicationId,
    String? customMedicationName,
    required int frequencyDays,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  });

  /// Marks a medication as given ([givenDate] defaults to now); the backend
  /// recomputes the next due date and returns the updated medication.
  Future<Result<Medication>> markMedicationGiven(
    int petId,
    int medicationId, {
    DateTime? givenDate,
  });

  /// Changes a medication's frequency (and optionally end date / notes).
  /// [medicationName] is the med's current name, re-sent to satisfy the API's
  /// name-required update validation. [nextDueDate] must be passed explicitly - /// the backend does not recompute it on a frequency-only change.
  Future<Result<Medication>> updateMedication(
    int petId,
    int medicationId, {
    required String medicationName,
    required int frequencyDays,
    required DateTime nextDueDate,
    DateTime? endDate,
    String? notes,
  });

  /// Deletes a medication schedule.
  Future<Result<void>> deleteMedication(int petId, int medicationId);

  /// Upcoming medications across all of the current user's pets, within
  /// [daysAhead] days.
  Future<Result<List<UpcomingMedication>>> getUpcomingMedications({
    int daysAhead = 14,
  });

  // ── Vaccinations ──────────────────────────────────────────────────────────

  /// Vaccination records for a pet, most recent first.
  Future<Result<List<Vaccination>>> getVaccinations(int petId);

  /// Adds a vaccination record. [vaccineId] must be a valid lookup id.
  Future<Result<Vaccination>> addVaccination(
    int petId, {
    required int vaccineId,
    required DateTime dateAdministered,
    DateTime? nextDueDate,
    String? vetName,
    String? notes,
    String? documentUrl,
  });

  /// Deletes a vaccination record.
  Future<Result<void>> deleteVaccination(int petId, int vaccinationId);

  /// Marks a vaccination administered ([dateAdministered] defaults to now); the
  /// backend rolls the next-due date forward by the prior cadence unless
  /// [nextDueDate] is given, and returns the updated record.
  Future<Result<Vaccination>> markVaccinationAdministered(
    int petId,
    int vaccinationId, {
    DateTime? dateAdministered,
    DateTime? nextDueDate,
  });

  // ── Lookups ─────────────────────────────────────────────────────────────

  /// Known medications for the add-medication picker.
  Future<Result<List<HealthLookup>>> getMedicationLookups();

  /// Known vaccines for the add-vaccination picker.
  Future<Result<List<HealthLookup>>> getVaccineLookups();

  // ── Appointments ─────────────────────────────────────────────────────────

  /// Appointments for a pet, soonest first.
  Future<Result<List<Appointment>>> getAppointments(int petId);

  /// Adds an appointment. [scheduledAt] must be in the future.
  Future<Result<Appointment>> addAppointment(
    int petId, {
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  });

  /// Updates an existing appointment.
  Future<Result<Appointment>> updateAppointment(
    int petId,
    int appointmentId, {
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  });

  /// Deletes an appointment.
  Future<Result<void>> deleteAppointment(int petId, int appointmentId);

  /// Marks an appointment done ([completedAt] defaults to now, must not be in
  /// the future) and returns the updated appointment.
  Future<Result<Appointment>> completeAppointment(
    int petId,
    int appointmentId, {
    DateTime? completedAt,
  });

  // ── Feeding schedule ──────────────────────────────────────────────────────

  /// The pet's feeding schedule, or null when none is configured. Fetching also
  /// re-arms the device-local meal reminders (gated on the Feeding pref).
  Future<Result<FeedingSchedule?>> getFeedingSchedule(int petId);

  /// Creates or fully replaces the feeding schedule and reschedules local meal
  /// reminders. Passing an empty [times] list clears the schedule.
  Future<Result<FeedingSchedule>> saveFeedingSchedule(
    int petId, {
    required int daysOfWeek,
    required List<FeedingTime> times,
  });

  /// Deletes the feeding schedule and cancels its local reminders.
  Future<Result<void>> deleteFeedingSchedule(int petId);

  // ── Grooming schedule ─────────────────────────────────────────────────────

  /// The pet's grooming schedule, or null when none is configured. Grooming
  /// reminders are server-pushed (FCM) - nothing is scheduled locally.
  Future<Result<GroomingSchedule?>> getGroomingSchedule(int petId);

  /// Creates or replaces the grooming schedule.
  Future<Result<GroomingSchedule>> saveGroomingSchedule(
    int petId, {
    required int intervalDays,
    required DateTime nextDueDate,
    DateTime? lastGroomedDate,
  });

  /// Marks the pet as groomed ([groomedDate] defaults to now); the backend sets
  /// last-groomed, advances the next-due date, and re-arms the push reminders.
  Future<Result<GroomingSchedule>> markGroomed(
    int petId, {
    DateTime? groomedDate,
  });

  /// Deletes the grooming schedule.
  Future<Result<void>> deleteGroomingSchedule(int petId);

  // ── Health score ──────────────────────────────────────────────────────────

  /// The pet's server-computed health score. Read-only; recompute by re-calling
  /// after the owner logs a vaccination / medication / weight / activity.
  Future<Result<PetHealthScore>> getHealthScore(int petId);
}
