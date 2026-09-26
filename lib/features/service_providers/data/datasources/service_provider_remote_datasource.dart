import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/entities/provider_search.dart';
import '../dtos/provider_category_dto.dart';
import '../dtos/service_provider_detail_dto.dart';
import '../dtos/service_provider_search_dto.dart';

/// Remote data source for the service-providers map. Talks to the API only
/// through [ApiClient]; throws AppExceptions the repository maps into Failures.
class ServiceProviderRemoteDataSource {
  const ServiceProviderRemoteDataSource(this._client);

  final ApiClient _client;

  /// GET /service-providers/search — branch pins within the bbox.
  ///
  /// [categoryId] is the resolved server category id (the repository maps the
  /// client [ProviderCategory] → id via the categories lookup), or null for no
  /// category filter.
  Future<ServiceProviderSearchDto> search(
    ProviderSearchParams params, {
    int? categoryId,
  }) async {
    final bounds = params.bounds;
    final query = <String, dynamic>{
      'minLat': bounds.south,
      'minLng': bounds.west,
      'maxLat': bounds.north,
      'maxLng': bounds.east,
      'sort': params.sort.wire,
      'limit': params.limit,
    };
    final origin = params.userLocation;
    if (origin != null) {
      query['userLat'] = origin.latitude;
      query['userLng'] = origin.longitude;
    }
    if (categoryId != null) query['categoryId'] = categoryId;
    final q = params.query;
    if (q != null && q.trim().isNotEmpty) query['q'] = q.trim();
    if (params.petId != null) query['petId'] = params.petId;
    if (params.openNow == true) query['openNow'] = true;

    final json = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.serviceProviderSearch,
      queryParameters: query,
    );
    return ServiceProviderSearchDto.fromJson(json);
  }

  /// GET /service-providers/categories — the filter/legend list.
  Future<List<ProviderCategoryDto>> getCategories() async {
    final json = await _client.get<List<dynamic>>(
      ApiEndpoints.serviceProviderCategories,
    );
    return json
        .cast<Map<String, dynamic>>()
        .map(ProviderCategoryDto.fromJson)
        .toList();
  }

  /// GET /service-providers/{id} — full provider detail.
  Future<ServiceProviderDetailDto> getDetail(
    int id, {
    double? userLat,
    double? userLng,
  }) async {
    final json = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.serviceProvider(id),
      queryParameters: (userLat != null && userLng != null)
          ? {'userLat': userLat, 'userLng': userLng}
          : null,
    );
    return ServiceProviderDetailDto.fromJson(json);
  }

  /// POST /service-providers/{id}/rate — submit the user's stars.
  Future<ProviderRatingDto> rate(int id, int stars) async {
    final json = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.serviceProviderRating(id),
      data: {'stars': stars},
    );
    return ProviderRatingDto.fromJson(json);
  }
}
