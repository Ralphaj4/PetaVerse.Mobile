// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: json['id'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String?,
  pendingEmail: json['pendingEmail'] as String?,
  mobileNumber: json['mobileNumber'] as String,
  mobileVerified: json['mobileVerified'] as bool,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  avatarUrl: json['avatarUrl'] as String?,
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'pendingEmail': instance.pendingEmail,
  'mobileNumber': instance.mobileNumber,
  'mobileVerified': instance.mobileVerified,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'avatarUrl': instance.avatarUrl,
  'roles': instance.roles,
  'createdAt': instance.createdAt.toIso8601String(),
};
