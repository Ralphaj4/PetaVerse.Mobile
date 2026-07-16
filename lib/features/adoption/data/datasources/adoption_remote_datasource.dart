import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/adoption_dtos.dart';

/// Remote adoption data source. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly. Throws AppExceptions (mapped by
/// ApiClient) — the repository turns those into Failures.
class AdoptionRemoteDataSource {
  const AdoptionRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /adoption/listings — paged board. Only Available (16) listings.
  Future<AdoptionListingPageDto> getListings({
    int? speciesId,
    String? query,
    double? lat,
    double? lng,
    int page = 1,
    int pageSize = 20,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.adoptionListings,
      queryParameters: {
        'speciesId': ?speciesId,
        'q': ?(query != null && query.isNotEmpty ? query : null),
        'lat': ?lat,
        'lng': ?lng,
        'page': page,
        'pageSize': pageSize,
      },
    );
    return AdoptionListingPageDto.fromJson(data);
  }

  /// GET /users/me/adoption-listings → all listings the caller created, every
  /// status, newest first. Same DTO shape as the board.
  Future<List<AdoptionListingDto>> getMyListings() async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.myAdoptionListings,
    );
    return data
        .map((e) => AdoptionListingDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// GET /adoption/listings/{id} → one listing.
  Future<AdoptionListingDto> getListing(int id) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.adoptionListing(id),
    );
    return AdoptionListingDto.fromJson(data);
  }

  /// POST /adoption/listings → 201 AdoptionListingDetail.
  Future<AdoptionListingDto> createListing(
    Map<String, dynamic> body,
  ) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.adoptionListings,
      data: body,
    );
    return AdoptionListingDto.fromJson(data);
  }

  /// PATCH /adoption/listings/{id} → 200 AdoptionListingDetail.
  Future<AdoptionListingDto> updateListing(
    int id,
    Map<String, dynamic> body,
  ) async {
    final data = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.adoptionListing(id),
      data: body,
    );
    return AdoptionListingDto.fromJson(data);
  }

  /// POST /adoption/listings/{id}/withdraw → 204.
  Future<void> withdrawListing(int id) async {
    await _client.post<void>(ApiEndpoints.withdrawAdoptionListing(id));
  }

  /// DELETE /adoption/listings/{id} → 204. Hard delete: removes the listing and
  /// all its applicant requests (and, for a shelter listing, the uploaded
  /// photo). Owner-only; blocked once the adoption has completed (409).
  Future<void> deleteListing(int id) async {
    await _client.delete<void>(ApiEndpoints.adoptionListing(id));
  }

  /// GET /adoption/listings/{id}/requests → applicants (lister only).
  Future<List<AdoptionRequestDto>> getListingRequests(int listingId) async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.adoptionListingRequests(listingId),
    );
    return data
        .map((e) => AdoptionRequestDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// POST .../requests/{reqId}/approve → 204.
  Future<void> approveRequest(int listingId, int reqId) async {
    await _client.post<void>(
      ApiEndpoints.approveAdoptionRequest(listingId, reqId),
    );
  }

  /// POST .../requests/{reqId}/reject → 204.
  Future<void> rejectRequest(int listingId, int reqId) async {
    await _client.post<void>(
      ApiEndpoints.rejectAdoptionRequest(listingId, reqId),
    );
  }

  /// POST .../requests/{reqId}/complete (owner). Triggers the irreversible
  /// transfer — enabled only once the adopter has accepted. → 200 PetResponse
  /// (the pet, now owned by the adopter). Idempotent. 409 if the adopter hasn't
  /// accepted yet.
  Future<AdoptionPetDto> completeRequest(int listingId, int reqId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.completeAdoptionRequest(listingId, reqId),
    );
    return AdoptionPetDto.fromJson(data);
  }

  /// POST /adoption/listings/{id}/requests → 201 MyAdoptionRequest (apply).
  Future<MyAdoptionRequestDto> apply(int listingId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.adoptionListingRequests(listingId),
    );
    return MyAdoptionRequestDto.fromJson(data);
  }

  /// GET /users/me/adoption-requests → my applications.
  Future<List<MyAdoptionRequestDto>> getMyRequests() async {
    final data = await _client.get<List<dynamic>>(
      ApiEndpoints.myAdoptionRequests,
    );
    return data
        .map((e) => MyAdoptionRequestDto.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// POST /users/me/adoption-requests/{reqId}/cancel → 204.
  Future<void> cancelRequest(int reqId) async {
    await _client.post<void>(ApiEndpoints.cancelMyAdoptionRequest(reqId));
  }

  /// POST /users/me/adoption-requests/{reqId}/accept (adopter). Records the
  /// opt-in ("I'll take it") — does NOT transfer. Idempotent. → 200 updated
  /// MyAdoptionRequest.
  Future<MyAdoptionRequestDto> acceptRequest(int reqId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.acceptMyAdoptionRequest(reqId),
    );
    return MyAdoptionRequestDto.fromJson(data);
  }
}
