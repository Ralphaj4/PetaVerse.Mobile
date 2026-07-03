// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_found_dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapPinDto _$MapPinDtoFromJson(Map<String, dynamic> json) => _MapPinDto(
  id: (json['id'] as num).toInt(),
  type:
      $enumDecodeNullable(_$ReportTypeJsonEnumMap, json['type']) ??
      ReportTypeJson.lost,
  latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
  longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$MapPinDtoToJson(_MapPinDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ReportTypeJsonEnumMap[instance.type]!,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

const _$ReportTypeJsonEnumMap = {
  ReportTypeJson.lost: 'Lost',
  ReportTypeJson.found: 'Found',
};

_VolunteerInfoDto _$VolunteerInfoDtoFromJson(Map<String, dynamic> json) =>
    _VolunteerInfoDto(
      isVolunteer: json['isVolunteer'] as bool? ?? false,
      activeVolunteerCount:
          (json['activeVolunteerCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$VolunteerInfoDtoToJson(_VolunteerInfoDto instance) =>
    <String, dynamic>{
      'isVolunteer': instance.isVolunteer,
      'activeVolunteerCount': instance.activeVolunteerCount,
    };

_LostFoundDashboardDto _$LostFoundDashboardDtoFromJson(
  Map<String, dynamic> json,
) => _LostFoundDashboardDto(
  activeAlertCount: (json['activeAlertCount'] as num?)?.toInt() ?? 0,
  radiusMiles: (json['radiusMiles'] as num?)?.toDouble() ?? 5,
  mapPins:
      (json['mapPins'] as List<dynamic>?)
          ?.map((e) => MapPinDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MapPinDto>[],
  recentAlerts:
      (json['recentAlerts'] as List<dynamic>?)
          ?.map((e) => LostFoundReportDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LostFoundReportDto>[],
  volunteerInfo: json['volunteerInfo'] == null
      ? const VolunteerInfoDto()
      : VolunteerInfoDto.fromJson(
          json['volunteerInfo'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$LostFoundDashboardDtoToJson(
  _LostFoundDashboardDto instance,
) => <String, dynamic>{
  'activeAlertCount': instance.activeAlertCount,
  'radiusMiles': instance.radiusMiles,
  'mapPins': instance.mapPins,
  'recentAlerts': instance.recentAlerts,
  'volunteerInfo': instance.volunteerInfo,
};
