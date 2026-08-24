import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/entities/health_lookup.dart';
import '../../domain/entities/medication.dart';
import '../../domain/entities/pet_health_score.dart';
import '../../domain/entities/vaccination.dart';
import '../../domain/entities/weight_record.dart';

part 'pawcare_dtos.freezed.dart';
part 'pawcare_dtos.g.dart';

// ── Weight ────────────────────────────────────────────────────────────────

/// Wire shape of a weight record
/// (`{id, weight, unit, recordedDate, notes, createdAt, updatedAt}`).
@freezed
abstract class WeightRecordDto with _$WeightRecordDto {
  const factory WeightRecordDto({
    required int id,
    @Default(0) double weight,
    @Default('kg') String unit,
    required DateTime recordedDate,
    String? notes,
  }) = _WeightRecordDto;

  const WeightRecordDto._();

  factory WeightRecordDto.fromJson(Map<String, dynamic> json) =>
      _$WeightRecordDtoFromJson(json);

  WeightRecord toEntity() => WeightRecord(
        id: id,
        value: weight,
        unit: WeightUnit.fromWire(unit),
        recordedAt: recordedDate.toLocal(),
        notes: notes,
      );
}

// ── Medication ────────────────────────────────────────────────────────────

/// Wire shape of a medication history record.
@freezed
abstract class MedicationDto with _$MedicationDto {
  const factory MedicationDto({
    required int id,
    @Default('') String medicationName,
    @Default(1) int frequencyDays,
    required DateTime nextDueDate,
    DateTime? lastGivenDate,
    DateTime? startDate,
    DateTime? endDate,
    @Default(true) bool isActive,
    @Default(false) bool isDueSoon,
    @Default(false) bool isOverdue,
    String? notes,
  }) = _MedicationDto;

  const MedicationDto._();

  factory MedicationDto.fromJson(Map<String, dynamic> json) =>
      _$MedicationDtoFromJson(json);

  Medication toEntity() => Medication(
        id: id,
        name: medicationName,
        frequencyDays: frequencyDays,
        nextDueDate: nextDueDate.toLocal(),
        lastGivenDate: lastGivenDate?.toLocal(),
        startDate: startDate?.toLocal(),
        endDate: endDate?.toLocal(),
        isActive: isActive,
        isDueSoon: isDueSoon,
        isOverdue: isOverdue,
        notes: notes,
      );
}

/// Wire shape of an upcoming medication row (flat, across pets).
@freezed
abstract class UpcomingMedicationDto with _$UpcomingMedicationDto {
  const factory UpcomingMedicationDto({
    required int medicationHistoryId,
    required int petId,
    @Default('') String petName,
    @Default('') String medicationName,
    required DateTime nextDueDate,
    @Default(0) int daysUntilDue,
    @Default(false) bool isOverdue,
  }) = _UpcomingMedicationDto;

  const UpcomingMedicationDto._();

  factory UpcomingMedicationDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingMedicationDtoFromJson(json);

  UpcomingMedication toEntity() => UpcomingMedication(
        medicationHistoryId: medicationHistoryId,
        petId: petId,
        petName: petName,
        medicationName: medicationName,
        nextDueDate: nextDueDate.toLocal(),
        daysUntilDue: daysUntilDue,
        isOverdue: isOverdue,
      );
}

// ── Vaccination ─────────────────────────────────────────────────────────────

/// Wire shape of a vaccination
/// (`{id, vaccineName, dateAdministered, nextDueDate, vetName, notes,
/// documentUrl}`).
@freezed
abstract class VaccinationDto with _$VaccinationDto {
  const factory VaccinationDto({
    required int id,
    @Default('') String vaccineName,
    required DateTime dateAdministered,
    DateTime? nextDueDate,
    String? vetName,
    String? notes,
    String? documentUrl,
  }) = _VaccinationDto;

  const VaccinationDto._();

  factory VaccinationDto.fromJson(Map<String, dynamic> json) =>
      _$VaccinationDtoFromJson(json);

  Vaccination toEntity() => Vaccination(
        id: id,
        name: vaccineName,
        administeredAt: dateAdministered.toLocal(),
        nextDueDate: nextDueDate?.toLocal(),
        vetName: vetName,
        notes: notes,
        documentUrl: documentUrl,
      );
}

// ── Lookups ────────────────────────────────────────────────────────────────

/// Wire shape of a medication lookup (`{id, name, dosage, frequency}`).
@freezed
abstract class MedicationLookupDto with _$MedicationLookupDto {
  const factory MedicationLookupDto({
    required int id,
    @Default('') String name,
    String? dosage,
    String? frequency,
  }) = _MedicationLookupDto;

  const MedicationLookupDto._();

  factory MedicationLookupDto.fromJson(Map<String, dynamic> json) =>
      _$MedicationLookupDtoFromJson(json);

  HealthLookup toEntity() =>
      HealthLookup(id: id, name: name, dosage: dosage, frequency: frequency);
}

/// Wire shape of a vaccine lookup (`{id, name, syndicateCode}`).
@freezed
abstract class VaccineLookupDto with _$VaccineLookupDto {
  const factory VaccineLookupDto({
    required int id,
    @Default('') String name,
    String? syndicateCode,
  }) = _VaccineLookupDto;

  const VaccineLookupDto._();

  factory VaccineLookupDto.fromJson(Map<String, dynamic> json) =>
      _$VaccineLookupDtoFromJson(json);

  HealthLookup toEntity() =>
      HealthLookup(id: id, name: name, syndicateCode: syndicateCode);
}

// ── Health score ───────────────────────────────────────────────────────────

/// Wire shape of `GET /api/pets/{petId}/health-score`. Server-computed and
/// read-only. See `docs/Pet-Health-Score-Mobile-Guide.md`.
@freezed
abstract class PetHealthScoreDto with _$PetHealthScoreDto {
  const factory PetHealthScoreDto({
    required int petId,
    @Default(0) int value,
    @Default('No data') String band,
    @Default(0) double confidence,
    @Default(0) int applicableCount,
    @Default(<HealthComponentDto>[]) List<HealthComponentDto> components,
    @Default(<HealthReasonDto>[]) List<HealthReasonDto> reasons,
    ConditionsContextDto? conditionsContext,
    required DateTime computedAt,
  }) = _PetHealthScoreDto;

  const PetHealthScoreDto._();

  factory PetHealthScoreDto.fromJson(Map<String, dynamic> json) =>
      _$PetHealthScoreDtoFromJson(json);

  PetHealthScore toEntity() => PetHealthScore(
        petId: petId,
        value: value,
        band: HealthBand.fromWire(band),
        confidence: confidence,
        applicableCount: applicableCount,
        components: components.map((e) => e.toEntity()).toList(growable: false),
        reasons: reasons.map((e) => e.toEntity()).toList(growable: false),
        conditions: (conditionsContext ?? const ConditionsContextDto())
            .toEntity(),
        computedAt: computedAt.toLocal(),
      );
}

/// Wire shape of a single scored signal.
@freezed
abstract class HealthComponentDto with _$HealthComponentDto {
  const factory HealthComponentDto({
    @Default('') String key,
    @Default('') String label,
    @Default(0) int weight,
    @Default(false) bool applicable,
    @Default(0) double ratio,
    @Default(0) double earned,
    String? naReason,
  }) = _HealthComponentDto;

  const HealthComponentDto._();

  factory HealthComponentDto.fromJson(Map<String, dynamic> json) =>
      _$HealthComponentDtoFromJson(json);

  HealthComponent toEntity() => HealthComponent(
        key: key,
        label: label,
        weight: weight,
        applicable: applicable,
        ratio: ratio,
        earned: earned,
        naReason: naReason,
      );
}

/// Wire shape of a "why this score" line.
@freezed
abstract class HealthReasonDto with _$HealthReasonDto {
  const factory HealthReasonDto({
    @Default('warn') String severity,
    @Default('') String text,
    @Default(0) double deltaPoints,
  }) = _HealthReasonDto;

  const HealthReasonDto._();

  factory HealthReasonDto.fromJson(Map<String, dynamic> json) =>
      _$HealthReasonDtoFromJson(json);

  HealthReason toEntity() => HealthReason(
        severity: HealthReasonSeverity.fromWire(severity),
        text: text,
        deltaPoints: deltaPoints,
      );
}

/// Wire shape of the chronic-conditions context block.
@freezed
abstract class ConditionsContextDto with _$ConditionsContextDto {
  const factory ConditionsContextDto({
    @Default(0) int count,
    @Default(<String>[]) List<String> labels,
  }) = _ConditionsContextDto;

  const ConditionsContextDto._();

  factory ConditionsContextDto.fromJson(Map<String, dynamic> json) =>
      _$ConditionsContextDtoFromJson(json);

  ConditionsContext toEntity() =>
      ConditionsContext(count: count, labels: labels);
}

// ── Appointments ─────────────────────────────────────────────────────────────

/// Wire shape of an appointment record from `GET/POST /pets/{petId}/appointments`.
@freezed
abstract class AppointmentDto with _$AppointmentDto {
  const factory AppointmentDto({
    required int id,
    required int petId,
    required String title,
    required DateTime scheduledAt,
    String? location,
    String? notes,
  }) = _AppointmentDto;

  const AppointmentDto._();

  factory AppointmentDto.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDtoFromJson(json);

  Appointment toEntity() => Appointment(
        id: id,
        petId: petId,
        title: title,
        scheduledAt: scheduledAt,
        location: location,
        notes: notes,
      );
}
