import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/home_summary_dto.dart';

/// Remote data source for the aggregated home dashboard. Talks to the API only
/// through [ApiClient]; throws AppExceptions the repository maps into Failures.
class HomeRemoteDataSource {
  const HomeRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /users/me/home-summary[?petId=N] → the active pet's cards plus the
  /// cross-pet upcoming timeline. Omitting [petId] lets the backend pick the
  /// primary (then first) pet.
  Future<HomeSummaryDto> getHomeSummary({int? petId}) async {
    final json = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.homeSummary,
      queryParameters: petId == null ? null : {'petId': petId},
    );
    return HomeSummaryDto.fromJson(json);
  }
}
