import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
abstract class UpdateProfileRequest with _$UpdateProfileRequest {
  /// `includeIfNull: false` so only the fields actually set are serialized —
  /// the profile PUT accepts partial bodies (send only what changed), and an
  /// omitted field must not be sent as an explicit `null` (which would clear
  /// it server-side).
  @JsonSerializable(includeIfNull: false)
  const factory UpdateProfileRequest({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dateOfBirth,
    double? latitude,
    double? longitude,
    String? locationName,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}
