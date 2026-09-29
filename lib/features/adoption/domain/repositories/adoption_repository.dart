import '../../../../core/errors/result.dart';
import '../entities/adoption_listing.dart';

/// Contract for the adoption board and its request/transfer flows.
/// Every method returns a [Result] — failures never throw.
abstract interface class AdoptionRepository {
  // ── Board / discovery ──────────────────────────────────────────────────
  /// Paged board of Available listings. Server-side filtered by [speciesId]
  /// and free-text [query]; [lat]/[lng] scope distance.
  Future<Result<List<AdoptionListing>>> getListings({
    int? speciesId,
    String? query,
    double? lat,
    double? lng,
    int page,
    int pageSize,
  });

  /// A single listing by id, for the detail screen.
  Future<Result<AdoptionListing>> getListing(int id);

  // ── Lister side ────────────────────────────────────────────────────────
  /// Rehome a pet the current user owns: [petId] transfers on completion.
  Future<Result<AdoptionListing>> createListing({
    required int petId,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    bool vaccinated,
    bool neutered,
    bool goodWithKids,
  });

  /// List a shelter/stray animal with no backing pet. The pet's details are
  /// supplied inline; a new pet is created for the adopter on completion.
  /// [photoAssetId] is the confirmed AdoptionListingPhoto media asset, if any.
  Future<Result<AdoptionListing>> createShelterListing({
    required String petName,
    required int speciesId,
    required String gender,
    int? breedId,
    DateTime? dateOfBirth,
    int? sizeId,
    int? coatColorId,
    String? photoAssetId,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    bool vaccinated,
    bool neutered,
    bool goodWithKids,
  });

  Future<Result<void>> withdrawListing(int id);

  /// Hard-delete a listing the current user owns (and all its applicant
  /// requests). Fails with a [Failure] on 403 (not owner) / 404 (gone) / 409
  /// (already adopted).
  Future<Result<void>> deleteListing(int id);

  /// All listings the current user created, every status, newest first.
  Future<Result<List<AdoptionListing>>> getMyListings();

  /// Applicants on one of the current user's listings.
  Future<Result<List<AdoptionRequest>>> getListingRequests(int listingId);

  Future<Result<void>> approveRequest(int listingId, int requestId);
  Future<Result<void>> rejectRequest(int listingId, int requestId);

  /// Owner completes the transfer (irreversible). Only succeeds once the adopter
  /// has accepted (else the server returns 409). Returns the transferred pet.
  Future<Result<AdoptionPet>> completeRequest(int listingId, int requestId);

  // ── Adopter side ───────────────────────────────────────────────────────
  /// Applies to adopt the pet behind [listingId].
  Future<Result<MyAdoptionRequest>> apply(int listingId);

  /// The current user's applications.
  Future<Result<List<MyAdoptionRequest>>> getMyRequests();

  Future<Result<void>> cancelRequest(int requestId);

  /// Adopter opts in to an approved request ("I'll take it"). Records consent;
  /// does not transfer. Returns the updated request.
  Future<Result<MyAdoptionRequest>> acceptRequest(int requestId);
}
