// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdoptionPetDto _$AdoptionPetDtoFromJson(Map<String, dynamic> json) =>
    _AdoptionPetDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      speciesId: (json['speciesId'] as num?)?.toInt(),
      speciesName: json['speciesName'] as String?,
      breedName: json['breedName'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$AdoptionPetDtoToJson(_AdoptionPetDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'speciesId': instance.speciesId,
      'speciesName': instance.speciesName,
      'breedName': instance.breedName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'avatarUrl': instance.avatarUrl,
    };

_AdoptionUserDto _$AdoptionUserDtoFromJson(Map<String, dynamic> json) =>
    _AdoptionUserDto(
      id: json['id'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$AdoptionUserDtoToJson(_AdoptionUserDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
    };

_AdoptionListingDto _$AdoptionListingDtoFromJson(Map<String, dynamic> json) =>
    _AdoptionListingDto(
      id: (json['id'] as num).toInt(),
      statusId: (json['statusId'] as num?)?.toInt(),
      pet: AdoptionPetDto.fromJson(json['pet'] as Map<String, dynamic>),
      lister: AdoptionUserDto.fromJson(json['lister'] as Map<String, dynamic>),
      description: json['description'] as String?,
      locationLabel: json['locationLabel'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      vaccinated: json['vaccinated'] as bool? ?? false,
      neutered: json['neutered'] as bool? ?? false,
      goodWithKids: json['goodWithKids'] as bool? ?? false,
      applicantCount: (json['applicantCount'] as num?)?.toInt() ?? 0,
      isOwnListing: json['isOwnListing'] as bool? ?? false,
      hasApplied: json['hasApplied'] as bool? ?? false,
      isShelter: json['isShelter'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AdoptionListingDtoToJson(_AdoptionListingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statusId': instance.statusId,
      'pet': instance.pet,
      'lister': instance.lister,
      'description': instance.description,
      'locationLabel': instance.locationLabel,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'vaccinated': instance.vaccinated,
      'neutered': instance.neutered,
      'goodWithKids': instance.goodWithKids,
      'applicantCount': instance.applicantCount,
      'isOwnListing': instance.isOwnListing,
      'hasApplied': instance.hasApplied,
      'isShelter': instance.isShelter,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_AdoptionListingPageDto _$AdoptionListingPageDtoFromJson(
  Map<String, dynamic> json,
) => _AdoptionListingPageDto(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => AdoptionListingDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AdoptionListingDto>[],
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$AdoptionListingPageDtoToJson(
  _AdoptionListingPageDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'page': instance.page,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'totalPages': instance.totalPages,
};

_AdoptionRequestDto _$AdoptionRequestDtoFromJson(Map<String, dynamic> json) =>
    _AdoptionRequestDto(
      id: (json['id'] as num).toInt(),
      statusId: (json['statusId'] as num?)?.toInt(),
      requester: AdoptionUserDto.fromJson(
        json['requester'] as Map<String, dynamic>,
      ),
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
      isShelter: json['isShelter'] as bool? ?? false,
      listerConfirmedAt: json['listerConfirmedAt'] == null
          ? null
          : DateTime.parse(json['listerConfirmedAt'] as String),
      adopterConfirmedAt: json['adopterConfirmedAt'] == null
          ? null
          : DateTime.parse(json['adopterConfirmedAt'] as String),
    );

Map<String, dynamic> _$AdoptionRequestDtoToJson(_AdoptionRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'statusId': instance.statusId,
      'requester': instance.requester,
      'requestedAt': instance.requestedAt?.toIso8601String(),
      'isShelter': instance.isShelter,
      'listerConfirmedAt': instance.listerConfirmedAt?.toIso8601String(),
      'adopterConfirmedAt': instance.adopterConfirmedAt?.toIso8601String(),
    };

_MyRequestListingDto _$MyRequestListingDtoFromJson(Map<String, dynamic> json) =>
    _MyRequestListingDto(
      id: (json['id'] as num).toInt(),
      statusId: (json['statusId'] as num?)?.toInt(),
      isShelter: json['isShelter'] as bool? ?? false,
    );

Map<String, dynamic> _$MyRequestListingDtoToJson(
  _MyRequestListingDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'statusId': instance.statusId,
  'isShelter': instance.isShelter,
};

_MyAdoptionRequestDto _$MyAdoptionRequestDtoFromJson(
  Map<String, dynamic> json,
) => _MyAdoptionRequestDto(
  id: (json['id'] as num).toInt(),
  statusId: (json['statusId'] as num?)?.toInt(),
  listing: MyRequestListingDto.fromJson(
    json['listing'] as Map<String, dynamic>,
  ),
  pet: AdoptionPetDto.fromJson(json['pet'] as Map<String, dynamic>),
  lister: AdoptionUserDto.fromJson(json['lister'] as Map<String, dynamic>),
  requestedAt: json['requestedAt'] == null
      ? null
      : DateTime.parse(json['requestedAt'] as String),
  listerConfirmedAt: json['listerConfirmedAt'] == null
      ? null
      : DateTime.parse(json['listerConfirmedAt'] as String),
  adopterConfirmedAt: json['adopterConfirmedAt'] == null
      ? null
      : DateTime.parse(json['adopterConfirmedAt'] as String),
);

Map<String, dynamic> _$MyAdoptionRequestDtoToJson(
  _MyAdoptionRequestDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'statusId': instance.statusId,
  'listing': instance.listing,
  'pet': instance.pet,
  'lister': instance.lister,
  'requestedAt': instance.requestedAt?.toIso8601String(),
  'listerConfirmedAt': instance.listerConfirmedAt?.toIso8601String(),
  'adopterConfirmedAt': instance.adopterConfirmedAt?.toIso8601String(),
};
