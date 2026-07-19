import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/health_lookup.dart';
import '../../domain/entities/medication.dart';
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
