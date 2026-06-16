import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_dispatch_dto.freezed.dart';
part 'otp_dispatch_dto.g.dart';

/// Response from endpoints that trigger an OTP send (`register`,
/// `resend-otp`). [devOtp] is populated only by the Development
/// environment — null otherwise — and is shown in debug builds to ease
/// local testing.
@freezed
abstract class OtpDispatchDto with _$OtpDispatchDto {
  const factory OtpDispatchDto({
    @Default('') String message,
    @Default(false) bool requiresVerification,
    String? devOtp,
  }) = _OtpDispatchDto;

  factory OtpDispatchDto.fromJson(Map<String, dynamic> json) =>
      _$OtpDispatchDtoFromJson(json);
}
