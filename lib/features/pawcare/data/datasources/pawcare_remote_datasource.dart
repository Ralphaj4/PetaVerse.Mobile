import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  /// Builds Dio [Options] carrying the current FCM token so the backend can
  /// exclude this device when fanning out a silent sync push to co-owners /
  /// other sessions of the same user.
  static Future<Options> _mutationOptions() async {
    final token = await FirebaseMessaging.instance.getToken();
    return Options(
      headers: {
        'X-Device-Token': ?token,
      },
    );
  }

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
      options: await _mutationOptions(),
    );
    return WeightRecordDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/weight/{weightId} → 204.
  Future<void> deleteWeight(int petId, int weightId) async {
    await _client.delete<void>(
      ApiEndpoints.petWeightRecord(petId, weightId),
      options: await _mutationOptions(),
    );
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
      options: await _mutationOptions(),
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
      options: await _mutationOptions(),
    );
    return MedicationDto.fromJson(json);
  }

  /// PUT /pets/{petId}/medications/{id} → updated medication.
  ///
  /// The API's update contract requires the medication identity too (a
  /// name-required validation). The GET response only carries the resolved
  /// [medicationName], not the original lookup id, so we round-trip the current
  /// name as [customMedicationName] — it keeps the name unchanged and satisfies
  /// the validation.
  ///
  /// [nextDueDate] is sent explicitly because the backend does not recompute it
  /// on a frequency-only change; the caller is responsible for deriving the
  /// correct value (lastGivenDate + newFrequency, or startDate + newFrequency).
  Future<MedicationDto> updateMedication(
    int petId,
    int medicationId, {
    required String medicationName,
    required int frequencyDays,
    required DateTime nextDueDate,
    DateTime? endDate,
    String? notes,
  }) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.petMedication(petId, medicationId),
      data: {
        'medicationId': null,
        'customMedicationName': medicationName,
        'frequencyDays': frequencyDays,
        'nextDueDate': nextDueDate.toUtc().toIso8601String(),
        'endDate': endDate?.toUtc().toIso8601String(),
        'notes': ?notes,
      },
      options: await _mutationOptions(),
    );
    return MedicationDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/medications/{medicationId} → 204.
  Future<void> deleteMedication(int petId, int medicationId) async {
    await _client.delete<void>(
      ApiEndpoints.petMedication(petId, medicationId),
      options: await _mutationOptions(),
    );
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
      options: await _mutationOptions(),
    );
    return VaccinationDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/vaccinations/{vaccinationId} → 204.
  Future<void> deleteVaccination(int petId, int vaccinationId) async {
    await _client.delete<void>(
      ApiEndpoints.petVaccination(petId, vaccinationId),
      options: await _mutationOptions(),
    );
  }

  /// POST /pets/{petId}/vaccinations/{id}/mark-administered → updated record.
  /// Omitting [dateAdministered] stamps today; omitting [nextDueDate] rolls the
  /// prior administered→due cadence forward. An empty body is valid.
  Future<VaccinationDto> markVaccinationAdministered(
    int petId,
    int vaccinationId, {
    DateTime? dateAdministered,
    DateTime? nextDueDate,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.markVaccinationAdministered(petId, vaccinationId),
      data: {
        if (dateAdministered != null)
          'dateAdministered': dateAdministered.toUtc().toIso8601String(),
        if (nextDueDate != null)
          'nextDueDate': nextDueDate.toUtc().toIso8601String(),
      },
      options: await _mutationOptions(),
    );
    return VaccinationDto.fromJson(json);
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

  // ── Appointments ─────────────────────────────────────────────────────────

  /// GET /pets/{petId}/appointments → list, soonest first.
  Future<List<AppointmentDto>> getAppointments(int petId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.petAppointments(petId),
    );
    return _mapList(data, AppointmentDto.fromJson);
  }

  /// POST /pets/{petId}/appointments → the created appointment.
  Future<AppointmentDto> addAppointment(
    int petId, {
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.petAppointments(petId),
      data: {
        'title': title,
        'scheduledAt': scheduledAt.toUtc().toIso8601String(),
        if (location != null && location.isNotEmpty) 'location': location,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      },
      options: await _mutationOptions(),
    );
    return AppointmentDto.fromJson(json);
  }

  /// PUT /pets/{petId}/appointments/{appointmentId} → the updated appointment.
  Future<AppointmentDto> updateAppointment(
    int petId,
    int appointmentId, {
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  }) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.petAppointment(petId, appointmentId),
      data: {
        'title': title,
        'scheduledAt': scheduledAt.toUtc().toIso8601String(),
        'location': location?.isNotEmpty == true ? location : null,
        'notes': notes?.isNotEmpty == true ? notes : null,
      },
      options: await _mutationOptions(),
    );
    return AppointmentDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/appointments/{appointmentId} → 204.
  Future<void> deleteAppointment(int petId, int appointmentId) async {
    await _client.delete<void>(
      ApiEndpoints.petAppointment(petId, appointmentId),
      options: await _mutationOptions(),
    );
  }

  /// POST /pets/{petId}/appointments/{id}/complete → the completed appointment.
  /// Omitting [completedAt] defaults to now; an empty body is valid.
  Future<AppointmentDto> completeAppointment(
    int petId,
    int appointmentId, {
    DateTime? completedAt,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.completePetAppointment(petId, appointmentId),
      data: {
        if (completedAt != null)
          'completedAt': completedAt.toUtc().toIso8601String(),
      },
      options: await _mutationOptions(),
    );
    return AppointmentDto.fromJson(json);
  }

  // ── Feeding schedule ──────────────────────────────────────────────────────

  /// GET /pets/{petId}/feeding-schedule → the schedule, or null when the API
  /// returns 204 (nothing configured). The nullable body type keeps the 204's
  /// null payload from throwing on the cast.
  Future<FeedingScheduleDto?> getFeedingSchedule(int petId) async {
    final json = await _client.get<Map<String, dynamic>?>(
      ApiEndpoints.petFeedingSchedule(petId),
    );
    return json == null ? null : FeedingScheduleDto.fromJson(json);
  }

  /// PUT /pets/{petId}/feeding-schedule → the saved schedule (each time now
  /// carries a stable id). An empty [times] list clears the schedule.
  Future<FeedingScheduleDto> putFeedingSchedule(
    int petId, {
    required int daysOfWeek,
    required List<FeedingTimeDto> times,
  }) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.petFeedingSchedule(petId),
      data: {
        'daysOfWeek': daysOfWeek,
        'times': [
          for (final t in times)
            {
              'timeOfDay': t.timeOfDay,
              if (t.quantity != null) 'quantity': t.quantity,
              'unit': t.unit,
            },
        ],
      },
      options: await _mutationOptions(),
    );
    return FeedingScheduleDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/feeding-schedule → 204.
  Future<void> deleteFeedingSchedule(int petId) async {
    await _client.delete<void>(
      ApiEndpoints.petFeedingSchedule(petId),
      options: await _mutationOptions(),
    );
  }

  // ── Grooming schedule ─────────────────────────────────────────────────────

  /// GET /pets/{petId}/grooming-schedule → the schedule, or null on 204.
  Future<GroomingScheduleDto?> getGroomingSchedule(int petId) async {
    final json = await _client.get<Map<String, dynamic>?>(
      ApiEndpoints.petGroomingSchedule(petId),
    );
    return json == null ? null : GroomingScheduleDto.fromJson(json);
  }

  /// PUT /pets/{petId}/grooming-schedule → the saved schedule.
  Future<GroomingScheduleDto> putGroomingSchedule(
    int petId, {
    required int intervalDays,
    required DateTime nextDueDate,
    DateTime? lastGroomedDate,
  }) async {
    final json = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.petGroomingSchedule(petId),
      data: {
        'intervalDays': intervalDays,
        'nextDueDate': nextDueDate.toUtc().toIso8601String(),
        'lastGroomedDate': lastGroomedDate?.toUtc().toIso8601String(),
      },
      options: await _mutationOptions(),
    );
    return GroomingScheduleDto.fromJson(json);
  }

  /// POST /pets/{petId}/grooming-schedule/mark-groomed → the updated schedule
  /// with [lastGroomedDate] set and [nextDueDate] advanced. [groomedDate]
  /// defaults to now server-side and must not be in the future.
  Future<GroomingScheduleDto> markGroomed(
    int petId, {
    DateTime? groomedDate,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.markGroomed(petId),
      data: {
        if (groomedDate != null)
          'groomedDate': groomedDate.toUtc().toIso8601String(),
      },
      options: await _mutationOptions(),
    );
    return GroomingScheduleDto.fromJson(json);
  }

  /// DELETE /pets/{petId}/grooming-schedule → 204.
  Future<void> deleteGroomingSchedule(int petId) async {
    await _client.delete<void>(
      ApiEndpoints.petGroomingSchedule(petId),
      options: await _mutationOptions(),
    );
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
