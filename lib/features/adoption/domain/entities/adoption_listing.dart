import 'package:latlong2/latlong.dart';

/// Lifecycle of a listing (backend Status ids 16–19). Only [available]
/// listings appear on the board.
enum AdoptionListingStatus { available, pendingTransfer, adopted, withdrawn }

/// Lifecycle of an adoption request (backend Status ids 10–15).
enum AdoptionRequestStatus {
  pending,
  approved,
  rejected,
  cancelled,
  completed,
  expired,
}

/// Maps a backend listing Status id → [AdoptionListingStatus]. Unknown ids fall
/// back to [withdrawn] (treated as closed) so a new server state never crashes.
AdoptionListingStatus adoptionListingStatusFromId(int? id) => switch (id) {
      16 => AdoptionListingStatus.available,
      17 => AdoptionListingStatus.pendingTransfer,
      18 => AdoptionListingStatus.adopted,
      19 => AdoptionListingStatus.withdrawn,
      _ => AdoptionListingStatus.withdrawn,
    };

/// Maps a backend request Status id → [AdoptionRequestStatus]. Unknown ids fall
/// back to [pending].
AdoptionRequestStatus adoptionRequestStatusFromId(int? id) => switch (id) {
      10 => AdoptionRequestStatus.pending,
      11 => AdoptionRequestStatus.approved,
      12 => AdoptionRequestStatus.rejected,
      13 => AdoptionRequestStatus.cancelled,
      14 => AdoptionRequestStatus.completed,
      15 => AdoptionRequestStatus.expired,
      _ => AdoptionRequestStatus.pending,
    };

/// The pet embedded in a listing / request.
///
/// For a rehome listing this mirrors a real Pet record. For a shelter/stray
/// listing there's no pet yet, so [id] is null and the details come straight
/// from the listing — [gender] and [dateOfBirth] may also be null.
class AdoptionPet {
  const AdoptionPet({
    this.id,
    required this.name,
    this.speciesId,
    this.speciesName,
    this.breedName,
    this.gender,
    this.dateOfBirth,
    this.avatarUrl,
  });

  /// The underlying Pet id for a rehome listing, or null for a shelter/stray
  /// listing (no pet exists until the adoption completes).
  final int? id;
  final String name;
  final int? speciesId;
  final String? speciesName;
  final String? breedName;
  final String? gender;

  /// Birth date; the UI computes a coarse age label from it. Nullable.
  final DateTime? dateOfBirth;
  final String? avatarUrl;

  /// A human-readable breed, falling back to the species name.
  String get breedLabel => breedName ?? speciesName ?? '';
}

/// Minimal identity card for the user who posted a listing (or a requester).
class AdoptionUser {
  const AdoptionUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  String get fullName => '$firstName $lastName'.trim();
}

/// A single pet offered for adoption on the board.
///
/// Domain entity: pure Dart, no Flutter/JSON imports. Mirrors the API's
/// AdoptionListingSummary/Detail (currently identical). Distance is stamped
/// client-side from the user's location when available.
class AdoptionListing {
  const AdoptionListing({
    required this.id,
    required this.status,
    required this.pet,
    required this.lister,
    required this.applicantCount,
    required this.isOwnListing,
    required this.hasApplied,
    required this.createdAt,
    this.isShelter = false,
    this.description,
    this.locationLabel,
    this.location,
    this.distanceMeters,
    this.vaccinated = false,
    this.neutered = false,
    this.goodWithKids = false,
  });

  final int id;
  final AdoptionListingStatus status;
  final AdoptionPet pet;
  final AdoptionUser lister;
  final int applicantCount;

  /// True when this is a shelter/stray listing (no backing pet; a new pet is
  /// created for the adopter on completion). False for a rehome of an owned pet.
  final bool isShelter;

  /// True when the current user is the lister — the UI shows "Manage"
  /// instead of "Apply".
  final bool isOwnListing;

  /// True when the current user already has an open request for this pet.
  final bool hasApplied;

  final DateTime createdAt;
  final String? description;
  final String? locationLabel;

  /// Approximate pickup location, or null when the listing has no coordinates.
  final LatLng? location;

  /// Distance from the user in meters, or null when unknown. Stamped
  /// client-side once the user's position is available.
  final double? distanceMeters;

  final bool vaccinated;
  final bool neutered;
  final bool goodWithKids;

  bool get isAvailable => status == AdoptionListingStatus.available;

  /// Copy with a resolved [distanceMeters].
  AdoptionListing copyWithDistance(double? meters) => AdoptionListing(
        id: id,
        status: status,
        pet: pet,
        lister: lister,
        applicantCount: applicantCount,
        isOwnListing: isOwnListing,
        hasApplied: hasApplied,
        createdAt: createdAt,
        isShelter: isShelter,
        description: description,
        locationLabel: locationLabel,
        location: location,
        distanceMeters: meters,
        vaccinated: vaccinated,
        neutered: neutered,
        goodWithKids: goodWithKids,
      );
}

/// An applicant on one of the current user's listings (lister side).
class AdoptionRequest {
  const AdoptionRequest({
    required this.id,
    required this.status,
    required this.requester,
    required this.requestedAt,
    this.isShelter = false,
    this.listerConfirmedAt,
    this.adopterConfirmedAt,
  });

  final int id;
  final AdoptionRequestStatus status;
  final AdoptionUser requester;
  final DateTime requestedAt;

  /// True when the parent listing is a shelter/stray listing.
  final bool isShelter;
  final DateTime? listerConfirmedAt;
  final DateTime? adopterConfirmedAt;
}

/// An application the current user has submitted (adopter side).
class MyAdoptionRequest {
  const MyAdoptionRequest({
    required this.id,
    required this.status,
    required this.listingId,
    required this.listingStatus,
    required this.pet,
    required this.lister,
    required this.requestedAt,
    this.isShelter = false,
    this.listerConfirmedAt,
    this.adopterConfirmedAt,
  });

  final int id;
  final AdoptionRequestStatus status;
  final int listingId;
  final AdoptionListingStatus listingStatus;
  final AdoptionPet pet;
  final AdoptionUser lister;
  final DateTime requestedAt;

  /// True when the parent listing is a shelter/stray listing.
  final bool isShelter;
  final DateTime? listerConfirmedAt;
  final DateTime? adopterConfirmedAt;

  /// The adopter has opted in ("I'll take it") — step 3 of the flow. The owner
  /// can only complete the transfer once this is true.
  bool get accepted => adopterConfirmedAt != null;

  /// Approved by the owner but the adopter hasn't accepted yet — the adopter's
  /// turn to opt in.
  bool get awaitingMyAcceptance =>
      status == AdoptionRequestStatus.approved && !accepted;

  /// Accepted and waiting for the owner to hand over / complete.
  bool get awaitingHandover =>
      status == AdoptionRequestStatus.approved && accepted;

  bool get isCompleted => status == AdoptionRequestStatus.completed;
}
