import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/provider_category.dart';
import '../../domain/entities/provider_search.dart';
import '../../domain/entities/service_provider.dart';

part 'service_provider_search_dto.freezed.dart';
part 'service_provider_search_dto.g.dart';

/// Wire shape of `GET /api/service-providers/search`.
@freezed
abstract class ServiceProviderSearchDto with _$ServiceProviderSearchDto {
  const factory ServiceProviderSearchDto({
    @Default(<ServiceProviderItemDto>[]) List<ServiceProviderItemDto> items,
    @Default(0) int totalInViewport,
    @Default(false) bool hasMore,
    @Default(false) bool tooZoomedOut,
  }) = _ServiceProviderSearchDto;

  const ServiceProviderSearchDto._();

  factory ServiceProviderSearchDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderSearchDtoFromJson(json);

  /// Maps to the domain result. [resolveCategory] turns a `primaryCategoryId`
  /// into a client [ProviderCategory] via the categories lookup.
  ProviderSearchResult toEntity(
    ProviderCategory Function(int id) resolveCategory,
  ) =>
      ProviderSearchResult(
        items: items.map((e) => e.toEntity(resolveCategory)).toList(),
        totalInViewport: totalInViewport,
        hasMore: hasMore,
        tooZoomedOut: tooZoomedOut,
      );
}

/// One branch pin. `id` = provider (repeats), `branchId` = the pin.
@freezed
abstract class ServiceProviderItemDto with _$ServiceProviderItemDto {
  const factory ServiceProviderItemDto({
    required int id,
    required int branchId,
    @Default('') String name,
    @Default(<int>[]) List<int> categoryIds,
    @Default(0) int primaryCategoryId,
    @Default(<int>[]) List<int> serviceIds,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default('') String address,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(false) bool isOpen,
    String? hoursLabel,
    String? photoUrl,
    String? phone,
    double? distanceKm,
    @Default(<String>[]) List<String> badges,
    @Default(<int>[]) List<int> supportedSpecies,
    @Default(false) bool servesAllSpecies,
  }) = _ServiceProviderItemDto;

  const ServiceProviderItemDto._();

  factory ServiceProviderItemDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderItemDtoFromJson(json);

  ServiceProvider toEntity(
    ProviderCategory Function(int id) resolveCategory,
  ) =>
      ServiceProvider(
        id: id,
        branchId: branchId,
        name: name,
        categoryIds: categoryIds,
        primaryCategory: resolveCategory(primaryCategoryId),
        serviceIds: serviceIds,
        location: LatLng(latitude, longitude),
        address: address,
        rating: rating,
        reviewCount: reviewCount,
        isOpen: isOpen,
        hoursLabel: hoursLabel,
        photoUrl: photoUrl,
        distanceKm: distanceKm,
        phone: phone,
        badges: badges
            .map(ProviderBadge.fromWire)
            .whereType<ProviderBadge>()
            .toSet(),
        supportedSpecies: supportedSpecies,
        servesAllSpecies: servesAllSpecies,
      );
}
