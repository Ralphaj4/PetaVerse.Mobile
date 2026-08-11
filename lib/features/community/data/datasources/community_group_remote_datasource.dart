import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/community_dtos.dart';
import '../dtos/community_group_dtos.dart';

/// Data-source contract for pet-led **communities**, implemented by
/// [CommunityGroupRemoteDataSource]. Throws AppExceptions (mapped by
/// [ApiClient]); the repository turns those into Failures.
abstract interface class CommunityGroupDataSource {
  Future<CommunityDirectoryResponseDto> getCommunities({
    int? petId,
    int? category,
    required int sort,
    required int page,
    required int limit,
  });

  Future<CommunityDirectoryResponseDto> searchCommunities({
    required String query,
    int? petId,
    required int page,
    required int limit,
  });

  Future<CommunityListResponseDto> getSuggested({int? petId, required int limit});

  Future<CommunityListResponseDto> getMine({required int petId});

  Future<CommunityDto> getCommunity({required int id, int? viewerPetId});

  Future<FeedResponseDto> getCommunityFeed({
    required int id,
    int? petId,
    required int sort,
    required int page,
    required int limit,
  });

  Future<CommunityMembersResponseDto> getMembers({
    required int id,
    required int page,
    required int limit,
  });

  Future<CommunityDto> createCommunity(Map<String, dynamic> body);

  Future<CommunityDto> updateCommunity(int id, Map<String, dynamic> body);

  Future<void> deleteCommunity(int id);

  Future<CommunityJoinResponseDto> join(int id, int petId);

  Future<CommunityJoinResponseDto> leave(int id, int petId);

  Future<void> removeMember(int id, int petId);

  /// Whether [handle] is free to use (`{ "available": bool }`).
  Future<bool> isHandleAvailable(String handle);
}

/// Remote (live API) implementation. Talks to the API exclusively through
/// [ApiClient]; never touches Dio directly.
class CommunityGroupRemoteDataSource implements CommunityGroupDataSource {
  const CommunityGroupRemoteDataSource(this._client);

  final ApiClient _client;

  @override
  Future<CommunityDirectoryResponseDto> getCommunities({
    int? petId,
    int? category,
    required int sort,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communities,
      queryParameters: {
        'petId': ?petId,
        'category': ?category,
        'sort': sort,
        'page': page,
        'limit': limit,
      },
    );
    return CommunityDirectoryResponseDto.fromJson(data);
  }

  @override
  Future<CommunityDirectoryResponseDto> searchCommunities({
    required String query,
    int? petId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitiesSearch,
      queryParameters: {
        'q': query,
        'petId': ?petId,
        'page': page,
        'limit': limit,
      },
    );
    return CommunityDirectoryResponseDto.fromJson(data);
  }

  @override
  Future<CommunityListResponseDto> getSuggested({
    int? petId,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitiesSuggested,
      queryParameters: {'petId': ?petId, 'limit': limit},
    );
    return CommunityListResponseDto.fromJson(data);
  }

  @override
  Future<CommunityListResponseDto> getMine({required int petId}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitiesMine,
      queryParameters: {'petId': petId},
    );
    return CommunityListResponseDto.fromJson(data);
  }

  @override
  Future<CommunityDto> getCommunity({required int id, int? viewerPetId}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.community(id),
      queryParameters: {'viewerPetId': ?viewerPetId},
    );
    return CommunityDto.fromJson(data);
  }

  @override
  Future<FeedResponseDto> getCommunityFeed({
    required int id,
    int? petId,
    required int sort,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityGroupFeed(id),
      queryParameters: {
        'petId': ?petId,
        'sort': sort,
        'page': page,
        'limit': limit,
      },
    );
    return FeedResponseDto.fromJson(data);
  }

  @override
  Future<CommunityMembersResponseDto> getMembers({
    required int id,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityGroupMembers(id),
      queryParameters: {'page': page, 'limit': limit},
    );
    return CommunityMembersResponseDto.fromJson(data);
  }

  @override
  Future<CommunityDto> createCommunity(Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communities,
      data: body,
    );
    return CommunityDto.fromJson(data);
  }

  @override
  Future<CommunityDto> updateCommunity(int id, Map<String, dynamic> body) async {
    final data = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.community(id),
      data: body,
    );
    return CommunityDto.fromJson(data);
  }

  @override
  Future<void> deleteCommunity(int id) async {
    await _client.delete<void>(ApiEndpoints.community(id));
  }

  @override
  Future<CommunityJoinResponseDto> join(int id, int petId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityGroupJoin(id),
      data: {'petId': petId},
    );
    return CommunityJoinResponseDto.fromJson(data);
  }

  @override
  Future<CommunityJoinResponseDto> leave(int id, int petId) async {
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      ApiEndpoints.communityGroupLeave(id),
      data: {'petId': petId},
    );
    return CommunityJoinResponseDto.fromJson(data);
  }

  @override
  Future<void> removeMember(int id, int petId) async {
    await _client.delete<void>(ApiEndpoints.communityGroupMember(id, petId));
  }

  @override
  Future<bool> isHandleAvailable(String handle) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitiesHandleAvailable,
      queryParameters: {'handle': handle},
    );
    return data['available'] == true;
  }
}
