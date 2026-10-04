import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_dispatch_dto.freezed.dart';
part 'otp_dispatch_dto.g.dart';

/// Response from endpoints that trigger an OTP send (`register`,
/// `resend-otp`, `forgot-password`). [devOtp] is populated only by the
/// Development environment - null otherwise - and is shown in debug builds
/// to ease local testing. [isOtp] is only meaningful for `forgot-password`:
/// true = SMS OTP was sent, false = email reset link was sent.
@freezed
abstract class OtpDispatchDto with _$OtpDispatchDto {
  const factory OtpDispatchDto({
    @Default('') String message,
    @Default(false) bool requiresVerification,
    @Default(false) bool isOtp,
    String? userCode,
    String? devOtp,
  }) = _OtpDispatchDto;

  factory OtpDispatchDto.fromJson(Map<String, dynamic> json) =>
      _$OtpDispatchDtoFromJson(json);
}
