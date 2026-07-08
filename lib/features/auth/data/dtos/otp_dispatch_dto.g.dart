// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_dispatch_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtpDispatchDto _$OtpDispatchDtoFromJson(Map<String, dynamic> json) =>
    _OtpDispatchDto(
      message: json['message'] as String? ?? '',
      requiresVerification: json['requiresVerification'] as bool? ?? false,
      userCode: json['userCode'] as String?,
      devOtp: json['devOtp'] as String?,
    );

Map<String, dynamic> _$OtpDispatchDtoToJson(_OtpDispatchDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'requiresVerification': instance.requiresVerification,
      'userCode': instance.userCode,
      'devOtp': instance.devOtp,
    };
