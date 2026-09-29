// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokensDto _$AuthTokensDtoFromJson(Map<String, dynamic> json) =>
    _AuthTokensDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as String? ?? '',
      userCode: json['userCode'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$AuthTokensDtoToJson(_AuthTokensDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'userCode': instance.userCode,
      'roles': instance.roles,
    };
