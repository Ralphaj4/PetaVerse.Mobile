import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/lost_found_dashboard.dart';
import '../../domain/entities/lost_found_report.dart';
import 'lost_found_report_dto.dart';

part 'lost_found_dashboard_dto.freezed.dart';
part 'lost_found_dashboard_dto.g.dart';

/// Lightweight map pin: id/type/lat/lng only.
@freezed
abstract class MapPinDto with _$MapPinDto {
  const factory MapPinDto({
    required int id,
    @Default(ReportTypeJson.lost) ReportTypeJson type,
    @Default(0) double latitude,
    @Default(0) double longitude,
  }) = _MapPinDto;

  const MapPinDto._();

  factory MapPinDto.fromJson(Map<String, dynamic> json) =>
      _$MapPinDtoFromJson(json);

  LostFoundMapPin toEntity() => LostFoundMapPin(
        id: id,
        type: type == ReportTypeJson.found ? ReportType.found : ReportType.lost,
        latitude: latitude,
        longitude: longitude,
      );
}

/// The viewer's volunteer status + global active count.
@freezed
abstract class VolunteerInfoDto with _$VolunteerInfoDto {
  const factory VolunteerInfoDto({
    @Default(false) bool isVolunteer,
    @Default(0) int activeVolunteerCount,
  }) = _VolunteerInfoDto;

  const VolunteerInfoDto._();

  factory VolunteerInfoDto.fromJson(Map<String, dynamic> json) =>
      _$VolunteerInfoDtoFromJson(json);

  VolunteerInfo toEntity() => VolunteerInfo(
        isVolunteer: isVolunteer,
        activeVolunteerCount: activeVolunteerCount,
      );
}

/// Wire shape of LostFoundDashboardResponse.
@freezed
abstract class LostFoundDashboardDto with _$LostFoundDashboardDto {
  const factory LostFoundDashboardDto({
    @Default(0) int activeAlertCount,
    @Default(10) double radiusKm,
    @Default(<MapPinDto>[]) List<MapPinDto> mapPins,
    @Default(<LostFoundReportDto>[]) List<LostFoundReportDto> recentAlerts,
    @Default(VolunteerInfoDto()) VolunteerInfoDto volunteerInfo,
  }) = _LostFoundDashboardDto;

  const LostFoundDashboardDto._();

  factory LostFoundDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$LostFoundDashboardDtoFromJson(json);

  LostFoundDashboard toEntity() => LostFoundDashboard(
        activeAlertCount: activeAlertCount,
        radiusKm: radiusKm,
        mapPins: mapPins.map((p) => p.toEntity()).toList(growable: false),
        recentAlerts:
            recentAlerts.map((r) => r.toEntity()).toList(growable: false),
        volunteerInfo: volunteerInfo.toEntity(),
      );
}
