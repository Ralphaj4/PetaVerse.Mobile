import '../../../../core/errors/result.dart';
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
  /// lookup) OR [customMedicationName] — not both.
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

  /// Changes a medication's frequency (and optionally end date / notes); the
  /// backend recomputes the next due date and returns the updated medication.
  /// [medicationName] is the med's current name, re-sent to satisfy the API's
  /// name-required update validation.
  Future<Result<Medication>> updateMedication(
    int petId,
    int medicationId, {
    required String medicationName,
    required int frequencyDays,
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

  // ── Lookups ─────────────────────────────────────────────────────────────

  /// Known medications for the add-medication picker.
  Future<Result<List<HealthLookup>>> getMedicationLookups();

  /// Known vaccines for the add-vaccination picker.
  Future<Result<List<HealthLookup>>> getVaccineLookups();

  // ── Health score ──────────────────────────────────────────────────────────

  /// The pet's server-computed health score. Read-only; recompute by re-calling
  /// after the owner logs a vaccination / medication / weight / activity.
  Future<Result<PetHealthScore>> getHealthScore(int petId);
}
