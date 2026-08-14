import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/pawcare_dtos.dart';

/// Remote PawCare data source (weight / medications / vaccinations / lookups).
/// Talks to the API only through [ApiClient]; throws AppExceptions that the
/// repository maps into Failures.
class PawCareRemoteDataSource {
  const PawCareRemoteDataSource(this._client);

  final ApiClient _client;

  List<T> _mapList<T>(
    List<dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) =>
      data
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList(growable: false);

  // ── Weight ────────────────────────────────────────────────────────────────

  /// GET /pets/{petId}/weight → array, newest first.
  Future<List<WeightRecordDto>> getWeightHistory(int petId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.petWeight(petId),
    );
    return _mapList(data, WeightRecordDto.fromJson);
  }

  /// POST /pets/{petId}/weight → the created record.
  Future<WeightRecordDto> addWeight(
    int petId, {
    required double weight,
    required String unit,
    required DateTime recordedDate,
    String? notes,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.petWeight(petId),
      data: {
        'weight': weight,
        'unit': unit,
        'recordedDate': recordedDate.toUtc().toIso8601String(),
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      },
    );
    return WeightRecordDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/weight/{weightId} → 204.
  Future<void> deleteWeight(int petId, int weightId) async {
    await _client.delete<void>(ApiEndpoints.petWeightRecord(petId, weightId));
  }

  // ── Medications ─────────────────────────────────────────────────────────

  /// GET /pets/{petId}/medications → active medications.
  Future<List<MedicationDto>> getMedications(int petId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.petMedications(petId),
    );
    return _mapList(data, MedicationDto.fromJson);
  }

  /// POST /pets/{petId}/medications → the created medication. Provide exactly
  /// one of [medicationId] / [customMedicationName].
  Future<MedicationDto> addMedication(
    int petId, {
    int? medicationId,
    String? customMedicationName,
    required int frequencyDays,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.petMedications(petId),
      data: {
        'medicationId': medicationId,
        'customMedicationName': customMedicationName,
        'frequencyDays': frequencyDays,
        'startDate': startDate.toUtc().toIso8601String(),
        'endDate': endDate?.toUtc().toIso8601String(),
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      },
    );
    return MedicationDto.fromJson(json);
  }

  /// POST /pets/{petId}/medications/{id}/mark-given → updated medication.
  Future<MedicationDto> markMedicationGiven(
    int petId,
    int medicationId, {
    DateTime? givenDate,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.markMedicationGiven(petId, medicationId),
      data: {
        'givenDate': ?givenDate?.toUtc().toIso8601String(),
      },
    );
    return MedicationDto.fromJson(json);
  }

  /// PUT /pets/{petId}/medications/{id} → updated medication (recomputed next
  /// due date from the new frequency).
  ///
  /// The API's update contract requires the medication identity too (a
  /// name-required validation). The GET response only carries the resolved
  /// [medicationName], not the original lookup id, so we round-trip the current
  /// name as [customMedicationName] — it keeps the name unchanged and satisfies
  /// the validation.
  Future<MedicationDto> updateMedication(
    int petId,
    int medicationId, {
    required String medicationName,
    required int frequencyDays,
    DateTime? endDate,
    String? notes,
  }) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.petMedication(petId, medicationId),
      data: {
        'medicationId': null,
        'customMedicationName': medicationName,
        'frequencyDays': frequencyDays,
        'endDate': endDate?.toUtc().toIso8601String(),
        'notes': ?notes,
      },
    );
    return MedicationDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/medications/{medicationId} → 204.
  Future<void> deleteMedication(int petId, int medicationId) async {
    await _client.delete<void>(ApiEndpoints.petMedication(petId, medicationId));
  }

  /// GET /medications/upcoming?daysAhead=N → upcoming meds across all pets.
  Future<List<UpcomingMedicationDto>> getUpcomingMedications({
    int daysAhead = 14,
  }) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.upcomingMedications,
      queryParameters: {'daysAhead': daysAhead},
    );
    return _mapList(data, UpcomingMedicationDto.fromJson);
  }

  // ── Vaccinations ──────────────────────────────────────────────────────────

  /// GET /pets/{petId}/vaccinations → records, most recent first.
  Future<List<VaccinationDto>> getVaccinations(int petId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.petVaccinations(petId.toString()),
    );
    return _mapList(data, VaccinationDto.fromJson);
  }

  /// POST /pets/{petId}/vaccinations → the created record.
  Future<VaccinationDto> addVaccination(
    int petId, {
    required int vaccineId,
    required DateTime dateAdministered,
    DateTime? nextDueDate,
    String? vetName,
    String? notes,
    String? documentUrl,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.petVaccinations(petId.toString()),
      data: {
        'vaccineId': vaccineId,
        'dateAdministered': dateAdministered.toUtc().toIso8601String(),
        'nextDueDate': nextDueDate?.toUtc().toIso8601String(),
        if (vetName != null && vetName.isNotEmpty) 'vetName': vetName,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
        if (documentUrl != null && documentUrl.isNotEmpty)
          'documentUrl': documentUrl,
      },
    );
    return VaccinationDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/vaccinations/{vaccinationId} → 204.
  Future<void> deleteVaccination(int petId, int vaccinationId) async {
    await _client.delete<void>(
      ApiEndpoints.petVaccination(petId, vaccinationId),
    );
  }

  // ── Lookups ─────────────────────────────────────────────────────────────

  /// GET /lookups/medications → known medications.
  Future<List<MedicationLookupDto>> getMedicationLookups() async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.medicationLookups,
    );
    return _mapList(data, MedicationLookupDto.fromJson);
  }

  /// GET /lookups/vaccines → known vaccines.
  Future<List<VaccineLookupDto>> getVaccineLookups() async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.vaccineLookups,
    );
    return _mapList(data, VaccineLookupDto.fromJson);
  }

  // ── Health score ──────────────────────────────────────────────────────────

  /// GET /pets/{petId}/health-score → the server-computed score. Computed fresh
  /// on every call; call it whenever the health screen shows and re-fetch after
  /// the owner logs a vaccination / medication / weight / activity.
  Future<PetHealthScoreDto> getHealthScore(int petId) async {
    final json = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.petHealthScore(petId),
    );
    return PetHealthScoreDto.fromJson(json);
  }
}
