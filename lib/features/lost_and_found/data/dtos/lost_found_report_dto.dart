import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/lost_found_report.dart';

part 'lost_found_report_dto.freezed.dart';
part 'lost_found_report_dto.g.dart';

/// Wire `type` values. Responses use strings ("Lost" | "Found"); the create
/// request uses integers (1 | 2). This enum maps the READ strings; the write
/// integer is produced separately by the datasource.
enum ReportTypeJson {
  @JsonValue('Lost')
  lost,
  @JsonValue('Found')
  found,
}

enum ReportStatusJson {
  @JsonValue('Active')
  active,
  @JsonValue('Resolved')
  resolved,
}

/// Wire shape of the API's PetReportResponse (the core listing object, also
/// embedded in the dashboard's `recentAlerts`).
@freezed
abstract class LostFoundReportDto with _$LostFoundReportDto {
  const factory LostFoundReportDto({
    required int id,
    @Default(ReportTypeJson.lost) ReportTypeJson type,
    @Default('') String petName,
    @Default('') String speciesName,
    String? breedName,
    @Default('') String description,
    @Default('') String lastSeenAddress,
    @Default(0) double latitude,
    @Default(0) double longitude,
    String? imageUrl,
    @Default(ReportStatusJson.active) ReportStatusJson status,
    DateTime? createdAt,
    String? reporterName,
    String? reporterPhone,
    // The linked pet, when the report references one of the user's pets.
    int? petId,
    // True when the current user owns this report (can edit/delete it).
    @Default(false) bool isOwner,
    // Reward offered for a Lost pet (0–999); null when none / Found.
    int? reward,
  }) = _LostFoundReportDto;

  const LostFoundReportDto._();

  factory LostFoundReportDto.fromJson(Map<String, dynamic> json) =>
      _$LostFoundReportDtoFromJson(json);

  LostFoundReport toEntity() => LostFoundReport(
        id: id,
        type: type == ReportTypeJson.found ? ReportType.found : ReportType.lost,
        petName: petName,
        speciesName: speciesName,
        breedName: breedName,
        description: description,
        lastSeenAddress: lastSeenAddress,
        latitude: latitude,
        longitude: longitude,
        imageUrl: imageUrl,
        status: status == ReportStatusJson.resolved
            ? ReportStatus.resolved
            : ReportStatus.active,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        reporterName: reporterName,
        reporterPhone: reporterPhone,
        petId: petId,
        isOwner: isOwner,
        reward: reward,
      );
}
