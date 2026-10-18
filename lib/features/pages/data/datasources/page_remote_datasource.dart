import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../community/data/dtos/community_dtos.dart';
import '../dtos/page_dtos.dart';

abstract interface class PageDataSource {
  Future<PageDto> getPage(int pageId);
  Future<FeedResponseDto> getPageFeed(int pageId, {String? cursor, int limit});
  Future<PageDto> follow(int pageId);
  Future<PageDto> unfollow(int pageId);
}

class PageRemoteDataSource implements PageDataSource {
  const PageRemoteDataSource(this._client);

  final ApiClient _client;

  @override
  Future<PageDto> getPage(int pageId) async {
    final data = await _client.get<Map<String, dynamic>>(ApiEndpoints.page(pageId));
    return PageDto.fromJson(data);
  }

  @override
  Future<FeedResponseDto> getPageFeed(
    int pageId, {
    String? cursor,
    int limit = 20,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.pageFeed(pageId),
      queryParameters: {
        'cursor': ?cursor,
        'limit': limit,
      },
    );
    return FeedResponseDto.fromJson(data);
  }

  @override
  Future<PageDto> follow(int pageId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.pageFollow(pageId),
    );
    return PageDto.fromJson(data);
  }

  @override
  Future<PageDto> unfollow(int pageId) async {
    final data = await _client.delete<Map<String, dynamic>>(
      ApiEndpoints.pageFollow(pageId),
    );
    return PageDto.fromJson(data);
  }
}
