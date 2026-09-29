// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  locationName: json['locationName'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'firstName': ?instance.firstName,
  'lastName': ?instance.lastName,
  'email': ?instance.email,
  'dateOfBirth': ?instance.dateOfBirth?.toIso8601String(),
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'locationName': ?instance.locationName,
};
