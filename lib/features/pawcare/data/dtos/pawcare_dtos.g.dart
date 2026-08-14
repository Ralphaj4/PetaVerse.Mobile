// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pawcare_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeightRecordDto _$WeightRecordDtoFromJson(Map<String, dynamic> json) =>
    _WeightRecordDto(
      id: (json['id'] as num).toInt(),
      weight: (json['weight'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String? ?? 'kg',
      recordedDate: DateTime.parse(json['recordedDate'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WeightRecordDtoToJson(_WeightRecordDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'unit': instance.unit,
      'recordedDate': instance.recordedDate.toIso8601String(),
      'notes': instance.notes,
    };

_MedicationDto _$MedicationDtoFromJson(Map<String, dynamic> json) =>
    _MedicationDto(
      id: (json['id'] as num).toInt(),
      medicationName: json['medicationName'] as String? ?? '',
      frequencyDays: (json['frequencyDays'] as num?)?.toInt() ?? 1,
      nextDueDate: DateTime.parse(json['nextDueDate'] as String),
      lastGivenDate: json['lastGivenDate'] == null
          ? null
          : DateTime.parse(json['lastGivenDate'] as String),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      isDueSoon: json['isDueSoon'] as bool? ?? false,
      isOverdue: json['isOverdue'] as bool? ?? false,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$MedicationDtoToJson(_MedicationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicationName': instance.medicationName,
      'frequencyDays': instance.frequencyDays,
      'nextDueDate': instance.nextDueDate.toIso8601String(),
      'lastGivenDate': instance.lastGivenDate?.toIso8601String(),
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'isDueSoon': instance.isDueSoon,
      'isOverdue': instance.isOverdue,
      'notes': instance.notes,
    };

_UpcomingMedicationDto _$UpcomingMedicationDtoFromJson(
  Map<String, dynamic> json,
) => _UpcomingMedicationDto(
  medicationHistoryId: (json['medicationHistoryId'] as num).toInt(),
  petId: (json['petId'] as num).toInt(),
  petName: json['petName'] as String? ?? '',
  medicationName: json['medicationName'] as String? ?? '',
  nextDueDate: DateTime.parse(json['nextDueDate'] as String),
  daysUntilDue: (json['daysUntilDue'] as num?)?.toInt() ?? 0,
  isOverdue: json['isOverdue'] as bool? ?? false,
);

Map<String, dynamic> _$UpcomingMedicationDtoToJson(
  _UpcomingMedicationDto instance,
) => <String, dynamic>{
  'medicationHistoryId': instance.medicationHistoryId,
  'petId': instance.petId,
  'petName': instance.petName,
  'medicationName': instance.medicationName,
  'nextDueDate': instance.nextDueDate.toIso8601String(),
  'daysUntilDue': instance.daysUntilDue,
  'isOverdue': instance.isOverdue,
};

_VaccinationDto _$VaccinationDtoFromJson(Map<String, dynamic> json) =>
    _VaccinationDto(
      id: (json['id'] as num).toInt(),
      vaccineName: json['vaccineName'] as String? ?? '',
      dateAdministered: DateTime.parse(json['dateAdministered'] as String),
      nextDueDate: json['nextDueDate'] == null
          ? null
          : DateTime.parse(json['nextDueDate'] as String),
      vetName: json['vetName'] as String?,
      notes: json['notes'] as String?,
      documentUrl: json['documentUrl'] as String?,
    );

Map<String, dynamic> _$VaccinationDtoToJson(_VaccinationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vaccineName': instance.vaccineName,
      'dateAdministered': instance.dateAdministered.toIso8601String(),
      'nextDueDate': instance.nextDueDate?.toIso8601String(),
      'vetName': instance.vetName,
      'notes': instance.notes,
      'documentUrl': instance.documentUrl,
    };

_MedicationLookupDto _$MedicationLookupDtoFromJson(Map<String, dynamic> json) =>
    _MedicationLookupDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      dosage: json['dosage'] as String?,
      frequency: json['frequency'] as String?,
    );

Map<String, dynamic> _$MedicationLookupDtoToJson(
  _MedicationLookupDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'dosage': instance.dosage,
  'frequency': instance.frequency,
};

_VaccineLookupDto _$VaccineLookupDtoFromJson(Map<String, dynamic> json) =>
    _VaccineLookupDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      syndicateCode: json['syndicateCode'] as String?,
    );

Map<String, dynamic> _$VaccineLookupDtoToJson(_VaccineLookupDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'syndicateCode': instance.syndicateCode,
    };

_PetHealthScoreDto _$PetHealthScoreDtoFromJson(Map<String, dynamic> json) =>
    _PetHealthScoreDto(
      petId: (json['petId'] as num).toInt(),
      value: (json['value'] as num?)?.toInt() ?? 0,
      band: json['band'] as String? ?? 'No data',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      applicableCount: (json['applicableCount'] as num?)?.toInt() ?? 0,
      components:
          (json['components'] as List<dynamic>?)
              ?.map(
                (e) => HealthComponentDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <HealthComponentDto>[],
      reasons:
          (json['reasons'] as List<dynamic>?)
              ?.map((e) => HealthReasonDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <HealthReasonDto>[],
      conditionsContext: json['conditionsContext'] == null
          ? null
          : ConditionsContextDto.fromJson(
              json['conditionsContext'] as Map<String, dynamic>,
            ),
      computedAt: DateTime.parse(json['computedAt'] as String),
    );

Map<String, dynamic> _$PetHealthScoreDtoToJson(_PetHealthScoreDto instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'value': instance.value,
      'band': instance.band,
      'confidence': instance.confidence,
      'applicableCount': instance.applicableCount,
      'components': instance.components,
      'reasons': instance.reasons,
      'conditionsContext': instance.conditionsContext,
      'computedAt': instance.computedAt.toIso8601String(),
    };

_HealthComponentDto _$HealthComponentDtoFromJson(Map<String, dynamic> json) =>
    _HealthComponentDto(
      key: json['key'] as String? ?? '',
      label: json['label'] as String? ?? '',
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      applicable: json['applicable'] as bool? ?? false,
      ratio: (json['ratio'] as num?)?.toDouble() ?? 0,
      earned: (json['earned'] as num?)?.toDouble() ?? 0,
      naReason: json['naReason'] as String?,
    );

Map<String, dynamic> _$HealthComponentDtoToJson(_HealthComponentDto instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'weight': instance.weight,
      'applicable': instance.applicable,
      'ratio': instance.ratio,
      'earned': instance.earned,
      'naReason': instance.naReason,
    };

_HealthReasonDto _$HealthReasonDtoFromJson(Map<String, dynamic> json) =>
    _HealthReasonDto(
      severity: json['severity'] as String? ?? 'warn',
      text: json['text'] as String? ?? '',
      deltaPoints: (json['deltaPoints'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$HealthReasonDtoToJson(_HealthReasonDto instance) =>
    <String, dynamic>{
      'severity': instance.severity,
      'text': instance.text,
      'deltaPoints': instance.deltaPoints,
    };

_ConditionsContextDto _$ConditionsContextDtoFromJson(
  Map<String, dynamic> json,
) => _ConditionsContextDto(
  count: (json['count'] as num?)?.toInt() ?? 0,
  labels:
      (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$ConditionsContextDtoToJson(
  _ConditionsContextDto instance,
) => <String, dynamic>{'count': instance.count, 'labels': instance.labels};
