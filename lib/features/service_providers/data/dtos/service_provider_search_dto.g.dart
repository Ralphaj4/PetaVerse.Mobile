// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceProviderSearchDto _$ServiceProviderSearchDtoFromJson(
  Map<String, dynamic> json,
) => _ServiceProviderSearchDto(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => ServiceProviderItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ServiceProviderItemDto>[],
  totalInViewport: (json['totalInViewport'] as num?)?.toInt() ?? 0,
  hasMore: json['hasMore'] as bool? ?? false,
  tooZoomedOut: json['tooZoomedOut'] as bool? ?? false,
);

Map<String, dynamic> _$ServiceProviderSearchDtoToJson(
  _ServiceProviderSearchDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalInViewport': instance.totalInViewport,
  'hasMore': instance.hasMore,
  'tooZoomedOut': instance.tooZoomedOut,
};

_ServiceProviderItemDto _$ServiceProviderItemDtoFromJson(
  Map<String, dynamic> json,
) => _ServiceProviderItemDto(
  id: (json['id'] as num).toInt(),
  branchId: (json['branchId'] as num).toInt(),
  name: json['name'] as String? ?? '',
  categoryIds:
      (json['categoryIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  primaryCategoryId: (json['primaryCategoryId'] as num?)?.toInt() ?? 0,
  serviceIds:
      (json['serviceIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
  longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
  address: json['address'] as String? ?? '',
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  isOpen: json['isOpen'] as bool? ?? false,
  hoursLabel: json['hoursLabel'] as String?,
  photoUrl: json['photoUrl'] as String?,
  phone: json['phone'] as String?,
  distanceKm: (json['distanceKm'] as num?)?.toDouble(),
  badges:
      (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  supportedSpecies:
      (json['supportedSpecies'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  servesAllSpecies: json['servesAllSpecies'] as bool? ?? false,
);

Map<String, dynamic> _$ServiceProviderItemDtoToJson(
  _ServiceProviderItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'branchId': instance.branchId,
  'name': instance.name,
  'categoryIds': instance.categoryIds,
  'primaryCategoryId': instance.primaryCategoryId,
  'serviceIds': instance.serviceIds,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'isOpen': instance.isOpen,
  'hoursLabel': instance.hoursLabel,
  'photoUrl': instance.photoUrl,
  'phone': instance.phone,
  'distanceKm': instance.distanceKm,
  'badges': instance.badges,
  'supportedSpecies': instance.supportedSpecies,
  'servesAllSpecies': instance.servesAllSpecies,
};
