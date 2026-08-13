import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/community_dtos.dart';

/// Remote data source for PawHub (Community). Talks to the API exclusively
/// through [ApiClient]; never touches Dio directly. Throws AppExceptions
/// (mapped by ApiClient) — the repository turns those into Failures.
///
/// The acting pet is passed here as a plain int where the API takes it (query
/// param or body field); the repository decides whether it may be null.
class CommunityRemoteDataSource {
  const CommunityRemoteDataSource(this._client);

  final ApiClient _client;

  // ── Feeds & post CRUD ────────────────────────────────────────────────────

  Future<FeedResponseDto> getFollowingFeed({
    int? petId,
    required int sort,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityFeed,
      queryParameters: {
        'petId': ?petId,
        'sort': sort,
        'page': page,
        'limit': limit,
      },
    );
    return FeedResponseDto.fromJson(data);
  }

  Future<DiscoverResponseDto> getDiscoverFeed({
    int? petId,
    required int sort,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityDiscover,
      queryParameters: {
        'petId': ?petId,
        'sort': sort,
        'page': page,
        'limit': limit,
      },
    );
    return DiscoverResponseDto.fromJson(data);
  }

  Future<FeedResponseDto> getSaved({
    int? petId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitySaved,
      queryParameters: {'petId': ?petId, 'page': page, 'limit': limit},
    );
    return FeedResponseDto.fromJson(data);
  }

  /// A single pet's PawHub profile (`PetSummaryResponse`), with follow state
  /// relative to [viewerPetId].
  Future<PetSummaryDto> getPet({
    required int petId,
    int? viewerPetId,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityPet(petId),
      queryParameters: {'viewerPetId': ?viewerPetId},
    );
    return PetSummaryDto.fromJson(data);
  }

  Future<FeedResponseDto> getPetPosts({
    required int petId,
    int? viewerPetId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityPetPosts(petId),
      queryParameters: {
        'viewerPetId': ?viewerPetId,
        'page': page,
        'limit': limit,
      },
    );
    return FeedResponseDto.fromJson(data);
  }

  Future<PostDetailDto> getPost({required int postId, int? viewerPetId}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityPost(postId),
      queryParameters: {'viewerPetId': ?viewerPetId},
    );
    return PostDetailDto.fromJson(data);
  }

  Future<PostDto> createPost(Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPosts,
      data: body,
    );
    return PostDto.fromJson(data);
  }

  Future<PostDto> updatePost(int postId, Map<String, dynamic> body) async {
    final data = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.communityPost(postId),
      data: body,
    );
    return PostDto.fromJson(data);
  }

  Future<void> deletePost(int postId) async {
    await _client.delete<void>(ApiEndpoints.communityPost(postId));
  }

  // ── Interactions ─────────────────────────────────────────────────────────

  Future<PostDto> likePost(int postId, int petId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPostLike(postId),
      data: {'petId': petId},
    );
    return PostDto.fromJson(data);
  }

  Future<PostDto> unlikePost(int postId, int petId) async {
    // DELETE with a body so the acting pet is identifiable.
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      ApiEndpoints.communityPostLike(postId),
      data: {'petId': petId},
    );
    return PostDto.fromJson(data);
  }

  Future<SaveResponseDto> savePost(int postId, int petId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPostSave(postId),
      data: {'petId': petId},
    );
    return SaveResponseDto.fromJson(data);
  }

  Future<SaveResponseDto> unsavePost(int postId, int petId) async {
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      ApiEndpoints.communityPostSave(postId),
      data: {'petId': petId},
    );
    return SaveResponseDto.fromJson(data);
  }

  Future<ShareResponseDto> sharePost(
    int postId,
    int petId,
    String? shareMethod,
  ) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPostShare(postId),
      data: {'petId': petId, 'shareMethod': ?shareMethod},
    );
    return ShareResponseDto.fromJson(data);
  }

  // ── Comments ─────────────────────────────────────────────────────────────

  Future<CommentsResponseDto> getComments({
    required int postId,
    int? viewerPetId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityPostComments(postId),
      queryParameters: {
        'viewerPetId': ?viewerPetId,
        'page': page,
        'limit': limit,
      },
    );
    return CommentsResponseDto.fromJson(data);
  }

  Future<CommentDto> addComment(int postId, Map<String, dynamic> body) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityPostComments(postId),
      data: body,
    );
    return CommentDto.fromJson(data);
  }

  Future<CommentDto> updateComment(int commentId, String body) async {
    final data = await _client.put<Map<String, dynamic>>(
      ApiEndpoints.communityComment(commentId),
      data: {'body': body},
    );
    return CommentDto.fromJson(data);
  }

  Future<void> deleteComment(int commentId) async {
    await _client.delete<void>(ApiEndpoints.communityComment(commentId));
  }

  Future<LikeCountResponseDto> likeComment(int commentId, int petId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityCommentLike(commentId),
      data: {'petId': petId},
    );
    return LikeCountResponseDto.fromJson(data);
  }

  Future<LikeCountResponseDto> unlikeComment(int commentId, int petId) async {
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      ApiEndpoints.communityCommentLike(commentId),
      data: {'petId': petId},
    );
    return LikeCountResponseDto.fromJson(data);
  }

  Future<PinResponseDto> pinComment(int commentId, int petId, bool pin) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityCommentPin(commentId),
      data: {'petId': petId, 'pin': pin},
    );
    return PinResponseDto.fromJson(data);
  }

  // ── Follows & suggestions ────────────────────────────────────────────────

  Future<FollowResponseDto> follow(int petId, int followerPetId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityFollow(petId),
      data: {'followerPetId': followerPetId},
    );
    return FollowResponseDto.fromJson(data);
  }

  Future<FollowResponseDto> unfollow(int petId, int followerPetId) async {
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      ApiEndpoints.communityFollow(petId),
      data: {'followerPetId': followerPetId},
    );
    return FollowResponseDto.fromJson(data);
  }

  Future<PetPageDto> getFollowers({
    required int petId,
    int? viewerPetId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityFollowers(petId),
      queryParameters: {
        'viewerPetId': ?viewerPetId,
        'page': page,
        'limit': limit,
      },
    );
    return PetPageDto.fromJson(data);
  }

  Future<PetPageDto> getFollowing({
    required int petId,
    int? viewerPetId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityFollowing(petId),
      queryParameters: {
        'viewerPetId': ?viewerPetId,
        'page': page,
        'limit': limit,
      },
    );
    return PetPageDto.fromJson(data);
  }

  Future<SuggestedPetsResponseDto> getSuggested({
    int? petId,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitySuggested,
      queryParameters: {'petId': ?petId, 'limit': limit},
    );
    return SuggestedPetsResponseDto.fromJson(data);
  }

  // ── Notifications ────────────────────────────────────────────────────────

  Future<NotificationsResponseDto> getNotifications({
    int? petId,
    required bool unreadOnly,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityNotifications,
      queryParameters: {
        'petId': ?petId,
        'unreadOnly': unreadOnly,
        'page': page,
        'limit': limit,
      },
    );
    return NotificationsResponseDto.fromJson(data);
  }

  Future<MarkReadResponseDto> markNotificationRead(
    int notificationId,
    bool isRead,
  ) async {
    final data = await _client.patch<Map<String, dynamic>>(
      ApiEndpoints.communityNotification(notificationId),
      data: {'isRead': isRead},
    );
    return MarkReadResponseDto.fromJson(data);
  }

  Future<MarkAllReadResponseDto> markAllRead({int? petId}) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityNotificationsMarkAll,
      data: {'petId': ?petId},
    );
    return MarkAllReadResponseDto.fromJson(data);
  }

  // ── Moderation ───────────────────────────────────────────────────────────

  Future<ReportResponseDto> reportPost(
    int postId,
    Map<String, dynamic> body,
  ) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityReportPost(postId),
      data: body,
    );
    return ReportResponseDto.fromJson(data);
  }

  Future<ReportResponseDto> reportComment(
    int commentId,
    Map<String, dynamic> body,
  ) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityReportComment(commentId),
      data: body,
    );
    return ReportResponseDto.fromJson(data);
  }

  Future<ReportResponseDto> reportPet(
    int petId,
    Map<String, dynamic> body,
  ) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityReportPet(petId),
      data: body,
    );
    return ReportResponseDto.fromJson(data);
  }

  Future<BlockResponseDto> block(int petId, int blockerPetId) async {
    final data = await _client.post<Map<String, dynamic>>(
      ApiEndpoints.communityBlock(petId),
      data: {'blockerPetId': blockerPetId},
    );
    return BlockResponseDto.fromJson(data);
  }

  Future<BlockResponseDto> unblock(int petId, int blockerPetId) async {
    final data = await _client.deleteWithBody<Map<String, dynamic>>(
      ApiEndpoints.communityBlock(petId),
      data: {'blockerPetId': blockerPetId},
    );
    return BlockResponseDto.fromJson(data);
  }

  Future<PetPageDto> getBlocked({
    int? petId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityBlocked,
      queryParameters: {'petId': ?petId, 'page': page, 'limit': limit},
    );
    return PetPageDto.fromJson(data);
  }

  // ── Search & discovery ───────────────────────────────────────────────────

  Future<SearchResponseDto> search({
    required String query,
    int? petId,
    required int type,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communitySearch,
      queryParameters: {
        'q': query,
        'petId': ?petId,
        'type': type,
        'page': page,
        'limit': limit,
      },
    );
    return SearchResponseDto.fromJson(data);
  }

  Future<HashtagFeedResponseDto> getHashtagFeed({
    required String tag,
    int? petId,
    required int page,
    required int limit,
  }) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityHashtag(tag),
      queryParameters: {'petId': ?petId, 'page': page, 'limit': limit},
    );
    return HashtagFeedResponseDto.fromJson(data);
  }

  Future<TrendingResponseDto> getTrending({int? petId, required int limit}) async {
    final data = await _client.get<Map<String, dynamic>>(
      ApiEndpoints.communityTrending,
      queryParameters: {'petId': ?petId, 'limit': limit},
    );
    return TrendingResponseDto.fromJson(data);
  }
}
