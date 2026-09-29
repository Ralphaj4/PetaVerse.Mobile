import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/walk_activity_dto.dart';

class ActivityRemoteDataSource {
  const ActivityRemoteDataSource(this._client);

  final ApiClient _client;

  /// POST /pets/{petId}/activities → the saved record.
  Future<WalkActivityDto> saveActivity({
    required int petId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationSeconds,
    double? distanceMeters,
    double? avgSpeedKmh,
  }) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.petActivities(petId),
      data: {
        'startedAt': startedAt.toUtc().toIso8601String(),
        'endedAt': endedAt.toUtc().toIso8601String(),
        'durationSeconds': durationSeconds,
        'distanceMeters': ?distanceMeters,
        'avgSpeedKmh': ?avgSpeedKmh,
      },
    );
    return WalkActivityDto.fromJson(json, petId: petId);
  }

  /// GET /pets/{petId}/activities?page=N&pageSize=20
  ///
  /// Tolerates either a paged object ({ items, totalCount, ... }) or a bare
  /// JSON array, depending on what the backend returns.
  Future<WalkActivityPageDto> getActivities(
    int petId, {
    int page = 1,
    int pageSize = 20,
  }) async {
    final data = await _client.get<dynamic>(
      ApiEndpoints.petActivities(petId),
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
    if (data is List) {
      return WalkActivityPageDto.fromList(data, petId: petId);
    }
    return WalkActivityPageDto.fromJson(data as Map<String, dynamic>,
        petId: petId);
  }

  /// DELETE /pets/{petId}/activities/{activityId} → 204.
  Future<void> deleteActivity(int petId, int activityId) async {
    await _client.delete<void>(ApiEndpoints.petActivity(petId, activityId));
  }
}
