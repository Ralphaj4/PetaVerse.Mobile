import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/lost_found_dashboard_dto.dart';
import '../dtos/lost_found_report_dto.dart';

/// Remote Lost & Found data source. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly. Throws AppExceptions (mapped by
/// ApiClient) — the repository turns those into Failures.
class LostFoundRemoteDataSource {
  const LostFoundRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /lost-found/dashboard — map pins, recent alerts, volunteer status for
  /// the given location. [filter] is "lost" | "found" (omit for all).
  Future<LostFoundDashboardDto> getDashboard({
    required double latitude,
    required double longitude,
    double radiusKm = 10,
    String? filter,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.lostFoundDashboard,
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'radiusKm': radiusKm,
        'filter': ?filter,
      },
    );
    return LostFoundDashboardDto.fromJson(data);
  }

  /// POST /lost-found/listings — creates a report and returns it. [type] is the
  /// integer enum (1 = lost, 2 = found). [avatarMediaAssetId] is optional and
  /// omitted when null.
  Future<LostFoundReportDto> createListing({
    required int type,
    required String petName,
    required int speciesId,
    int? breedId,
    required String description,
    required String lastSeenAddress,
    required double latitude,
    required double longitude,
    int? petId,
    int? reward,
    String? avatarMediaAssetId,
  }) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.lostFoundListings,
      data: {
        'type': type,
        'petName': petName,
        'speciesId': speciesId,
        'breedId': ?breedId,
        'description': description,
        'lastSeenAddress': lastSeenAddress,
        'latitude': latitude,
        'longitude': longitude,
        // Links the report to an existing pet; the backend resolves the image
        // from that pet's avatar when no explicit asset is given.
        'petId': ?petId,
        // Reward (Lost only, 0–999); server ignores it for Found.
        'reward': ?reward,
        'avatarMediaAssetId': ?avatarMediaAssetId,
      },
    );
    return LostFoundReportDto.fromJson(data);
  }

  /// GET /lost-found/listings/{id} — fetches a single report by id.
  Future<LostFoundReportDto> getListing(int id) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.lostFoundListing(id),
    );
    return LostFoundReportDto.fromJson(data);
  }

  /// DELETE /lost-found/listings/{id} — deletes the user's own report (204).
  Future<void> deleteListing(int id) async {
    await _client.delete<void>(ApiEndpoints.lostFoundListing(id));
  }

  /// GET /lost-found/volunteer — the viewer's current volunteer status.
  Future<VolunteerInfoDto> getVolunteerStatus() async {
    final data =
        await _client.get<Map<String, dynamic>>(ApiEndpoints.lostFoundVolunteer);
    return VolunteerInfoDto.fromJson(data);
  }

  /// POST /lost-found/volunteer — join the volunteers; returns the updated
  /// status/count.
  Future<VolunteerInfoDto> joinVolunteers() async {
    final data = await _client
        .post<Map<String, dynamic>>(ApiEndpoints.lostFoundVolunteer);
    return VolunteerInfoDto.fromJson(data);
  }

  /// DELETE /lost-found/volunteer — leave the volunteers (204 No Content).
  Future<void> leaveVolunteers() async {
    await _client.delete<void>(ApiEndpoints.lostFoundVolunteer);
  }
}
