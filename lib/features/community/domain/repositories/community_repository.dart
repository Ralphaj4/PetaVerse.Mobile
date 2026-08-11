import '../../../../core/errors/result.dart';
import '../entities/community_entities.dart';
import '../entities/community_enums.dart';

/// Contract for PawHub (Community) data access. Implemented in the data layer;
/// consumed by presentation providers. Every method returns a [Result] so the
/// UI never sees raw exceptions.
///
/// The **acting pet** is passed explicitly as `actingPetId` where the API takes
/// it (as a query param or in the body). When it is optional the server falls
/// back to the caller's first pet, so null is allowed there.
abstract interface class CommunityRepository {
  // ── Feeds & post CRUD ────────────────────────────────────────────────────

  Future<Result<FeedPage>> getFollowingFeed({
    int? actingPetId,
    FeedSort sort = FeedSort.latest,
    int page = 0,
    int limit = 20,
  });

  Future<Result<DiscoverPage>> getDiscoverFeed({
    int? actingPetId,
    FeedSort sort = FeedSort.trending,
    int page = 0,
    int limit = 20,
  });

  Future<Result<FeedPage>> getSavedPosts({
    int? actingPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<FeedPage>> getPetPosts({
    required int petId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<PostDetail>> getPost({required int postId, int? viewerPetId});

  Future<Result<Post>> createPost({
    required int authorPetId,
    String? caption,
    String? locationName,
    PostVisibility visibility = PostVisibility.public,
    List<PostMediaDraft> media = const [],
    List<int> taggedPetIds = const [],
    List<String> hashtags = const [],
    int? communityId,
  });

  Future<Result<Post>> updatePost({
    required int postId,
    String? caption,
    String? locationName,
    PostVisibility? visibility,
    List<int>? taggedPetIds,
    List<String>? hashtags,
  });

  Future<Result<void>> deletePost(int postId);

  // ── Interactions ─────────────────────────────────────────────────────────

  Future<Result<Post>> likePost({required int postId, required int actingPetId});
  Future<Result<Post>> unlikePost({
    required int postId,
    required int actingPetId,
  });

  Future<Result<SaveResult>> savePost({
    required int postId,
    required int actingPetId,
  });
  Future<Result<SaveResult>> unsavePost({
    required int postId,
    required int actingPetId,
  });

  Future<Result<ShareResult>> sharePost({
    required int postId,
    required int actingPetId,
    String? shareMethod,
  });

  // ── Comments ─────────────────────────────────────────────────────────────

  Future<Result<CommentPage>> getComments({
    required int postId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<Comment>> addComment({
    required int postId,
    required int authorPetId,
    required String body,
    int? parentCommentId,
  });

  Future<Result<Comment>> updateComment({
    required int commentId,
    required String body,
  });

  Future<Result<void>> deleteComment(int commentId);

  Future<Result<int>> likeComment({
    required int commentId,
    required int actingPetId,
  });
  Future<Result<int>> unlikeComment({
    required int commentId,
    required int actingPetId,
  });

  Future<Result<bool>> pinComment({
    required int commentId,
    required int actingPetId,
    required bool pin,
  });

  // ── Follows & suggestions ────────────────────────────────────────────────

  Future<Result<FollowResult>> follow({
    required int petId,
    required int followerPetId,
  });
  Future<Result<FollowResult>> unfollow({
    required int petId,
    required int followerPetId,
  });

  Future<Result<PetPage>> getFollowers({
    required int petId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<PetPage>> getFollowing({
    required int petId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<List<CommunityPet>>> getSuggestedPets({
    int? actingPetId,
    int limit = 10,
  });

  // ── Notifications ────────────────────────────────────────────────────────

  Future<Result<NotificationPage>> getNotifications({
    int? actingPetId,
    bool unreadOnly = false,
    int page = 0,
    int limit = 20,
  });

  Future<Result<MarkReadResult>> markNotificationRead({
    required int notificationId,
    bool isRead = true,
  });

  Future<Result<MarkReadResult>> markAllNotificationsRead({int? actingPetId});

  // ── Moderation ───────────────────────────────────────────────────────────

  Future<Result<ReportResult>> reportPost({
    required int postId,
    required ReportReason reason,
    int? reporterPetId,
    String? details,
  });

  Future<Result<ReportResult>> reportComment({
    required int commentId,
    required ReportReason reason,
    int? reporterPetId,
    String? details,
  });

  Future<Result<ReportResult>> reportPet({
    required int petId,
    required ReportReason reason,
    int? reporterPetId,
    String? details,
  });

  Future<Result<BlockResult>> block({
    required int petId,
    required int blockerPetId,
  });
  Future<Result<BlockResult>> unblock({
    required int petId,
    required int blockerPetId,
  });

  Future<Result<PetPage>> getBlockedPets({
    int? actingPetId,
    int page = 0,
    int limit = 20,
  });

  // ── Search & discovery ───────────────────────────────────────────────────

  Future<Result<SearchResultsPage>> search({
    required String query,
    int? actingPetId,
    SearchType type = SearchType.all,
    int page = 0,
    int limit = 20,
  });

  Future<Result<HashtagFeed>> getHashtagFeed({
    required String tag,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  });

  Future<Result<Trending>> getTrending({int? actingPetId, int limit = 10});
}

/// A media item being attached to a *new* post. Carries the confirmed
/// `mediaAssetId` from the presign/confirm flow (raw URLs are never accepted).
class PostMediaDraft {
  const PostMediaDraft({
    required this.mediaAssetId,
    this.altText,
    this.durationSeconds,
  });

  final String mediaAssetId;
  final String? altText;

  /// Videos only (1–600). Must be null for images.
  final int? durationSeconds;
}
