import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/adoption_listing.dart';

part 'adoption_dtos.freezed.dart';
part 'adoption_dtos.g.dart';

/// Wire shape of the pet embedded in a listing / request.
@freezed
abstract class AdoptionPetDto with _$AdoptionPetDto {
  const factory AdoptionPetDto({
    // Null for a shelter/stray listing (no pet exists yet).
    int? id,
    @Default('') String name,
    int? speciesId,
    String? speciesName,
    String? breedName,
    String? gender,
    DateTime? dateOfBirth,
    String? avatarUrl,
  }) = _AdoptionPetDto;

  const AdoptionPetDto._();

  factory AdoptionPetDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionPetDtoFromJson(json);

  AdoptionPet toEntity() => AdoptionPet(
        id: id,
        name: name,
        speciesId: speciesId,
        speciesName: speciesName,
        breedName: breedName,
        gender: gender,
        dateOfBirth: dateOfBirth,
        avatarUrl: avatarUrl,
      );
}

/// Wire shape of the user (lister / requester) on a listing or request.
@freezed
abstract class AdoptionUserDto with _$AdoptionUserDto {
  const factory AdoptionUserDto({
    required String id,
    @Default('') String firstName,
    @Default('') String lastName,
    String? avatarUrl,
  }) = _AdoptionUserDto;

  const AdoptionUserDto._();

  factory AdoptionUserDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionUserDtoFromJson(json);

  AdoptionUser toEntity() => AdoptionUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
      );
}

/// Wire shape of AdoptionListingSummary / Detail (currently identical).
@freezed
abstract class AdoptionListingDto with _$AdoptionListingDto {
  const factory AdoptionListingDto({
    required int id,
    int? statusId,
    required AdoptionPetDto pet,
    required AdoptionUserDto lister,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    @Default(false) bool vaccinated,
    @Default(false) bool neutered,
    @Default(false) bool goodWithKids,
    @Default(0) int applicantCount,
    @Default(false) bool isOwnListing,
    @Default(false) bool hasApplied,
    @Default(false) bool isShelter,
    DateTime? createdAt,
  }) = _AdoptionListingDto;

  const AdoptionListingDto._();

  factory AdoptionListingDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionListingDtoFromJson(json);

  AdoptionListing toEntity() => AdoptionListing(
        id: id,
        status: adoptionListingStatusFromId(statusId),
        pet: pet.toEntity(),
        lister: lister.toEntity(),
        description: description,
        locationLabel: locationLabel,
        location: (latitude != null && longitude != null)
            ? LatLng(latitude!, longitude!)
            : null,
        vaccinated: vaccinated,
        neutered: neutered,
        goodWithKids: goodWithKids,
        applicantCount: applicantCount,
        isOwnListing: isOwnListing,
        hasApplied: hasApplied,
        isShelter: isShelter,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// Wire shape of a paged board response.
@freezed
abstract class AdoptionListingPageDto with _$AdoptionListingPageDto {
  const factory AdoptionListingPageDto({
    @Default(<AdoptionListingDto>[]) List<AdoptionListingDto> items,
    @Default(1) int page,
    @Default(20) int pageSize,
    @Default(0) int totalCount,
    @Default(1) int totalPages,
  }) = _AdoptionListingPageDto;

  const AdoptionListingPageDto._();

  factory AdoptionListingPageDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionListingPageDtoFromJson(json);
}

/// Wire shape of an applicant (lister viewing their listing's requests).
@freezed
abstract class AdoptionRequestDto with _$AdoptionRequestDto {
  const factory AdoptionRequestDto({
    required int id,
    int? statusId,
    required AdoptionUserDto requester,
    DateTime? requestedAt,
    @Default(false) bool isShelter,
    DateTime? listerConfirmedAt,
    DateTime? adopterConfirmedAt,
  }) = _AdoptionRequestDto;

  const AdoptionRequestDto._();

  factory AdoptionRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AdoptionRequestDtoFromJson(json);

  AdoptionRequest toEntity() => AdoptionRequest(
        id: id,
        status: adoptionRequestStatusFromId(statusId),
        requester: requester.toEntity(),
        requestedAt: requestedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        isShelter: isShelter,
        listerConfirmedAt: listerConfirmedAt,
        adopterConfirmedAt: adopterConfirmedAt,
      );
}

/// The listing stub embedded in a MyAdoptionRequest.
@freezed
abstract class MyRequestListingDto with _$MyRequestListingDto {
  const factory MyRequestListingDto({
    required int id,
    int? statusId,
    @Default(false) bool isShelter,
  }) = _MyRequestListingDto;

  const MyRequestListingDto._();

  factory MyRequestListingDto.fromJson(Map<String, dynamic> json) =>
      _$MyRequestListingDtoFromJson(json);
}

/// Wire shape of an application the current user submitted (adopter side).
@freezed
abstract class MyAdoptionRequestDto with _$MyAdoptionRequestDto {
  const factory MyAdoptionRequestDto({
    required int id,
    int? statusId,
    required MyRequestListingDto listing,
    required AdoptionPetDto pet,
    required AdoptionUserDto lister,
    DateTime? requestedAt,
    DateTime? listerConfirmedAt,
    DateTime? adopterConfirmedAt,
  }) = _MyAdoptionRequestDto;

  const MyAdoptionRequestDto._();

  factory MyAdoptionRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MyAdoptionRequestDtoFromJson(json);

  MyAdoptionRequest toEntity() => MyAdoptionRequest(
        id: id,
        status: adoptionRequestStatusFromId(statusId),
        listingId: listing.id,
        listingStatus: adoptionListingStatusFromId(listing.statusId),
        pet: pet.toEntity(),
        lister: lister.toEntity(),
        requestedAt: requestedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        isShelter: listing.isShelter,
        listerConfirmedAt: listerConfirmedAt,
        adopterConfirmedAt: adopterConfirmedAt,
      );
}
