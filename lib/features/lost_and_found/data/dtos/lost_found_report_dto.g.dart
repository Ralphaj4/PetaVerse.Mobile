// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_found_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LostFoundReportDto _$LostFoundReportDtoFromJson(Map<String, dynamic> json) =>
    _LostFoundReportDto(
      id: (json['id'] as num).toInt(),
      type:
          $enumDecodeNullable(_$ReportTypeJsonEnumMap, json['type']) ??
          ReportTypeJson.lost,
      petName: json['petName'] as String? ?? '',
      speciesName: json['speciesName'] as String? ?? '',
      breedName: json['breedName'] as String?,
      description: json['description'] as String? ?? '',
      lastSeenAddress: json['lastSeenAddress'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      status:
          $enumDecodeNullable(_$ReportStatusJsonEnumMap, json['status']) ??
          ReportStatusJson.active,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      reporterName: json['reporterName'] as String?,
      reporterPhone: json['reporterPhone'] as String?,
      petId: (json['petId'] as num?)?.toInt(),
      isOwner: json['isOwner'] as bool? ?? false,
      reward: (json['reward'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LostFoundReportDtoToJson(_LostFoundReportDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ReportTypeJsonEnumMap[instance.type]!,
      'petName': instance.petName,
      'speciesName': instance.speciesName,
      'breedName': instance.breedName,
      'description': instance.description,
      'lastSeenAddress': instance.lastSeenAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrl': instance.imageUrl,
      'status': _$ReportStatusJsonEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'reporterName': instance.reporterName,
      'reporterPhone': instance.reporterPhone,
      'petId': instance.petId,
      'isOwner': instance.isOwner,
      'reward': instance.reward,
    };

const _$ReportTypeJsonEnumMap = {
  ReportTypeJson.lost: 'Lost',
  ReportTypeJson.found: 'Found',
};

const _$ReportStatusJsonEnumMap = {
  ReportStatusJson.active: 'Active',
  ReportStatusJson.resolved: 'Resolved',
};
