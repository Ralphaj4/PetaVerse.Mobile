// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceProviderDetailDto _$ServiceProviderDetailDtoFromJson(
  Map<String, dynamic> json,
) => _ServiceProviderDetailDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  photoUrl: json['photoUrl'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  categoryIds:
      (json['categoryIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  primaryCategoryId: (json['primaryCategoryId'] as num?)?.toInt() ?? 0,
  services:
      (json['services'] as List<dynamic>?)
          ?.map((e) => ProviderServiceDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ProviderServiceDto>[],
  supportedSpecies:
      (json['supportedSpecies'] as List<dynamic>?)
          ?.map((e) => ProviderSpeciesDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ProviderSpeciesDto>[],
  servesAllSpecies: json['servesAllSpecies'] as bool? ?? false,
  specializations:
      (json['specializations'] as List<dynamic>?)
          ?.map(
            (e) =>
                ProviderSpecializationDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ProviderSpecializationDto>[],
  branches:
      (json['branches'] as List<dynamic>?)
          ?.map((e) => ProviderBranchDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ProviderBranchDto>[],
  hours:
      (json['hours'] as List<dynamic>?)
          ?.map((e) => ProviderHoursDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ProviderHoursDto>[],
  isOpen: json['isOpen'] as bool? ?? false,
  hoursLabel: json['hoursLabel'] as String?,
  badges:
      (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  myStars: (json['myStars'] as num?)?.toInt(),
);

Map<String, dynamic> _$ServiceProviderDetailDtoToJson(
  _ServiceProviderDetailDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'photoUrl': instance.photoUrl,
  'isVerified': instance.isVerified,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'categoryIds': instance.categoryIds,
  'primaryCategoryId': instance.primaryCategoryId,
  'services': instance.services,
  'supportedSpecies': instance.supportedSpecies,
  'servesAllSpecies': instance.servesAllSpecies,
  'specializations': instance.specializations,
  'branches': instance.branches,
  'hours': instance.hours,
  'isOpen': instance.isOpen,
  'hoursLabel': instance.hoursLabel,
  'badges': instance.badges,
  'myStars': instance.myStars,
};

_ProviderBranchDto _$ProviderBranchDtoFromJson(Map<String, dynamic> json) =>
    _ProviderBranchDto(
      id: (json['id'] as num).toInt(),
      address: json['address'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      phone: json['phone'] as String?,
      whatsApp: json['whatsApp'] as String?,
      emergency: json['emergency'] as String?,
      website: json['website'] as String?,
      instagram: json['instagram'] as String?,
      email: json['email'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProviderBranchDtoToJson(_ProviderBranchDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'phone': instance.phone,
      'whatsApp': instance.whatsApp,
      'emergency': instance.emergency,
      'website': instance.website,
      'instagram': instance.instagram,
      'email': instance.email,
      'distanceKm': instance.distanceKm,
    };

_ProviderHoursDto _$ProviderHoursDtoFromJson(Map<String, dynamic> json) =>
    _ProviderHoursDto(
      dayOfWeek: (json['dayOfWeek'] as num?)?.toInt() ?? 0,
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
    );

Map<String, dynamic> _$ProviderHoursDtoToJson(_ProviderHoursDto instance) =>
    <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

_ProviderSpecializationDto _$ProviderSpecializationDtoFromJson(
  Map<String, dynamic> json,
) => _ProviderSpecializationDto(
  id: (json['specializationId'] as num).toInt(),
  name: json['name'] as String? ?? '',
  otherName: json['otherName'] as String?,
);

Map<String, dynamic> _$ProviderSpecializationDtoToJson(
  _ProviderSpecializationDto instance,
) => <String, dynamic>{
  'specializationId': instance.id,
  'name': instance.name,
  'otherName': instance.otherName,
};

_ProviderServiceDto _$ProviderServiceDtoFromJson(Map<String, dynamic> json) =>
    _ProviderServiceDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$ProviderServiceDtoToJson(_ProviderServiceDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_ProviderSpeciesDto _$ProviderSpeciesDtoFromJson(Map<String, dynamic> json) =>
    _ProviderSpeciesDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$ProviderSpeciesDtoToJson(_ProviderSpeciesDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_ProviderRatingDto _$ProviderRatingDtoFromJson(Map<String, dynamic> json) =>
    _ProviderRatingDto(
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      myStars: (json['myStars'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProviderRatingDtoToJson(_ProviderRatingDto instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'myStars': instance.myStars,
    };
