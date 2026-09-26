import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/provider_category.dart';
import '../../domain/entities/service_provider.dart';
import '../../domain/entities/service_provider_detail.dart'
    show
        ServiceProviderDetail,
        ProviderBranch,
        ProviderHours,
        ProviderSpecialization,
        ProviderService,
        ProviderSpecies;

part 'service_provider_detail_dto.freezed.dart';
part 'service_provider_detail_dto.g.dart';

/// Wire shape of `GET /api/service-providers/{id}`.
@freezed
abstract class ServiceProviderDetailDto with _$ServiceProviderDetailDto {
  const factory ServiceProviderDetailDto({
    required int id,
    @Default('') String name,
    String? description,
    String? photoUrl,
    @Default(false) bool isVerified,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(<int>[]) List<int> categoryIds,
    @Default(0) int primaryCategoryId,
    @Default(<ProviderServiceDto>[]) List<ProviderServiceDto> services,
    @Default(<ProviderSpeciesDto>[]) List<ProviderSpeciesDto> supportedSpecies,
    @Default(false) bool servesAllSpecies,
    @Default(<ProviderSpecializationDto>[])
    List<ProviderSpecializationDto> specializations,
    @Default(<ProviderBranchDto>[]) List<ProviderBranchDto> branches,
    @Default(<ProviderHoursDto>[]) List<ProviderHoursDto> hours,
    @Default(false) bool isOpen,
    String? hoursLabel,
    @Default(<String>[]) List<String> badges,
    int? myStars,
  }) = _ServiceProviderDetailDto;

  const ServiceProviderDetailDto._();

  factory ServiceProviderDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderDetailDtoFromJson(json);

  ServiceProviderDetail toEntity(
    ProviderCategory Function(int id) resolveCategory,
  ) =>
      ServiceProviderDetail(
        id: id,
        name: name,
        description: description,
        photoUrl: photoUrl,
        isVerified: isVerified,
        rating: rating,
        reviewCount: reviewCount,
        categoryIds: categoryIds,
        primaryCategory: resolveCategory(primaryCategoryId),
        services: services.map((e) => e.toEntity()).toList(),
        supportedSpecies: supportedSpecies.map((e) => e.toEntity()).toList(),
        servesAllSpecies: servesAllSpecies,
        specializations:
            specializations.map((e) => e.toEntity()).toList(),
        branches: branches.map((e) => e.toEntity()).toList(),
        hours: hours.map((e) => e.toEntity()).toList(),
        isOpen: isOpen,
        hoursLabel: hoursLabel,
        badges: badges
            .map(ProviderBadge.fromWire)
            .whereType<ProviderBadge>()
            .toSet(),
        myStars: myStars,
      );
}

@freezed
abstract class ProviderBranchDto with _$ProviderBranchDto {
  const factory ProviderBranchDto({
    required int id,
    @Default('') String address,
    @Default(0) double latitude,
    @Default(0) double longitude,
    String? phone,
    String? whatsApp,
    String? emergency,
    String? website,
    String? instagram,
    String? email,
    double? distanceKm,
  }) = _ProviderBranchDto;

  const ProviderBranchDto._();

  factory ProviderBranchDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderBranchDtoFromJson(json);

  ProviderBranch toEntity() => ProviderBranch(
        id: id,
        address: address,
        location: LatLng(latitude, longitude),
        phone: phone,
        whatsApp: whatsApp,
        emergency: emergency,
        website: website,
        instagram: instagram,
        email: email,
        distanceKm: distanceKm,
      );
}

@freezed
abstract class ProviderHoursDto with _$ProviderHoursDto {
  const factory ProviderHoursDto({
    @Default(0) int dayOfWeek,
    @Default('') String startTime,
    @Default('') String endTime,
  }) = _ProviderHoursDto;

  const ProviderHoursDto._();

  factory ProviderHoursDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderHoursDtoFromJson(json);

  ProviderHours toEntity() => ProviderHours(
        dayOfWeek: dayOfWeek,
        startTime: startTime,
        endTime: endTime,
      );
}

@freezed
abstract class ProviderSpecializationDto with _$ProviderSpecializationDto {
  const factory ProviderSpecializationDto({
    @JsonKey(name: 'specializationId') required int id,
    @Default('') String name,
    String? otherName,
  }) = _ProviderSpecializationDto;

  const ProviderSpecializationDto._();

  factory ProviderSpecializationDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderSpecializationDtoFromJson(json);

  ProviderSpecialization toEntity() => ProviderSpecialization(
        id: id,
        name: name,
        otherName: otherName,
      );
}

@freezed
abstract class ProviderServiceDto with _$ProviderServiceDto {
  const factory ProviderServiceDto({
    required int id,
    @Default('') String name,
  }) = _ProviderServiceDto;

  const ProviderServiceDto._();

  factory ProviderServiceDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderServiceDtoFromJson(json);

  ProviderService toEntity() => ProviderService(id: id, name: name);
}

@freezed
abstract class ProviderSpeciesDto with _$ProviderSpeciesDto {
  const factory ProviderSpeciesDto({
    required int id,
    @Default('') String name,
  }) = _ProviderSpeciesDto;

  const ProviderSpeciesDto._();

  factory ProviderSpeciesDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderSpeciesDtoFromJson(json);

  ProviderSpecies toEntity() => ProviderSpecies(id: id, name: name);
}

/// Wire shape of the rating submission response.
@freezed
abstract class ProviderRatingDto with _$ProviderRatingDto {
  const factory ProviderRatingDto({
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int myStars,
  }) = _ProviderRatingDto;

  const ProviderRatingDto._();

  factory ProviderRatingDto.fromJson(Map<String, dynamic> json) =>
      _$ProviderRatingDtoFromJson(json);
}
