import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

/// Login can return two HTTP-200 shapes:
///   • verified   → full token set, [requiresVerification] false.
///   • unverified → no tokens, [requiresVerification] true, OTP resent.
/// All token fields are nullable so the unverified shape parses cleanly.
@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    @Default(false) bool requiresVerification,
    String? accessToken,
    String? refreshToken,
    String? userId,
    @Default(<String>[]) List<String> roles,
    String? mobileNumber,
    String? devOtp,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}
