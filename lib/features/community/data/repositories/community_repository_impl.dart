import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/community_local_datasource.dart';
import '../datasources/community_remote_datasource.dart';

/// Community repository. Maps remote DTOs onto domain entities and turns
/// [AppException]s into [Failure]s.
///
/// [myPetIds] supplies the ids of the pets the signed-in user owns, so the
/// mapper can stamp `isMine` on authors/actors without a wire flag. It is a
/// callback (not a snapshot) so it always reflects the current pet set.
///
/// Offline-first for the two read-mostly surfaces (following feed page 0 and
/// notifications page 0): a successful fetch refreshes the cache, and a
/// transport failure on the first page falls back to the cache when present.
class CommunityRepositoryImpl implements CommunityRepository {
  const CommunityRepositoryImpl(this._remote, this._local, this._myPetIds);

  final CommunityRemoteDataSource _remote;
  final CommunityLocalDataSource _local;
  final Set<int> Function() _myPetIds;

  Set<int> get _mine => _myPetIds();

  // ── Feeds & post CRUD ────────────────────────────────────────────────────

  @override
  Future<Result<FeedPage>> getFollowingFeed({
    int? actingPetId,
    FeedSort sort = FeedSort.latest,
    int page = 0,
    int limit = 20,
  }) async {
    // Only the default first page (latest sort) is cached for offline use.
    final cacheable = page == 0 && sort == FeedSort.latest;
    try {
      final dto = await _remote.getFollowingFeed(
        petId: actingPetId,
        sort: sort.wire,
        page: page,
        limit: limit,
      );
      if (cacheable) await _local.writeFollowingFeed(dto);
      return Result.success(dto.toEntity(myPetIds: _mine));
    } on AppException catch (e) {
      // Offline fallback: serve the cached first page if we have one.
      if (cacheable && e is NetworkException) {
        final cached = await _local.readFollowingFeed();
        if (cached != null) {
          return Result.success(cached.toEntity(myPetIds: _mine));
        }
      }
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<DiscoverPage>> getDiscoverFeed({
    int? actingPetId,
    FeedSort sort = FeedSort.trending,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getDiscoverFeed(
          petId: actingPetId,
          sort: sort.wire,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<FeedPage>> getSavedPosts({
    int? actingPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getSaved(
          petId: actingPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<FeedPage>> getPetPosts({
    required int petId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getPetPosts(
          petId: petId,
          viewerPetId: viewerPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<PostDetail>> getPost({required int postId, int? viewerPetId}) =>
      _guard(() async {
        final dto = await _remote.getPost(postId: postId, viewerPetId: viewerPetId);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Post>> createPost({
    required int authorPetId,
    String? caption,
    String? locationName,
    PostVisibility visibility = PostVisibility.public,
    List<PostMediaDraft> media = const [],
    List<int> taggedPetIds = const [],
    List<String> hashtags = const [],
    int? communityId,
  }) =>
      _guard(() async {
        final dto = await _remote.createPost({
          'authorPetId': authorPetId,
          'caption': ?caption,
          'locationName': ?locationName,
          'communityId': ?communityId,
          'visibility': visibility.wire,
          'media': media
              .map((m) => {
                    'mediaAssetId': m.mediaAssetId,
                    'altText': ?m.altText,
                    'durationSeconds': ?m.durationSeconds,
                  })
              .toList(growable: false),
          'taggedPetIds': taggedPetIds,
          'hashtags': hashtags,
        });
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Post>> updatePost({
    required int postId,
    String? caption,
    String? locationName,
    PostVisibility? visibility,
    List<int>? taggedPetIds,
    List<String>? hashtags,
  }) =>
      _guard(() async {
        final dto = await _remote.updatePost(postId, {
          'caption': ?caption,
          'locationName': ?locationName,
          'visibility': ?visibility?.wire,
          'taggedPetIds': ?taggedPetIds,
          'hashtags': ?hashtags,
        });
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<void>> deletePost(int postId) =>
      _guardVoid(() => _remote.deletePost(postId));

  // ── Interactions ─────────────────────────────────────────────────────────

  @override
  Future<Result<Post>> likePost({
    required int postId,
    required int actingPetId,
  }) =>
      _guard(() async {
        final dto = await _remote.likePost(postId, actingPetId);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Post>> unlikePost({
    required int postId,
    required int actingPetId,
  }) =>
      _guard(() async {
        final dto = await _remote.unlikePost(postId, actingPetId);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<SaveResult>> savePost({
    required int postId,
    required int actingPetId,
  }) =>
      _guard(() async => (await _remote.savePost(postId, actingPetId)).toEntity());

  @override
  Future<Result<SaveResult>> unsavePost({
    required int postId,
    required int actingPetId,
  }) =>
      _guard(
          () async => (await _remote.unsavePost(postId, actingPetId)).toEntity());

  @override
  Future<Result<ShareResult>> sharePost({
    required int postId,
    required int actingPetId,
    String? shareMethod,
  }) =>
      _guard(() async =>
          (await _remote.sharePost(postId, actingPetId, shareMethod)).toEntity());

  // ── Comments ─────────────────────────────────────────────────────────────

  @override
  Future<Result<CommentPage>> getComments({
    required int postId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getComments(
          postId: postId,
          viewerPetId: viewerPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Comment>> addComment({
    required int postId,
    required int authorPetId,
    required String body,
    int? parentCommentId,
  }) =>
      _guard(() async {
        final dto = await _remote.addComment(postId, {
          'authorPetId': authorPetId,
          'body': body,
          'parentCommentId': ?parentCommentId,
        });
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Comment>> updateComment({
    required int commentId,
    required String body,
  }) =>
      _guard(() async {
        final dto = await _remote.updateComment(commentId, body);
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<void>> deleteComment(int commentId) =>
      _guardVoid(() => _remote.deleteComment(commentId));

  @override
  Future<Result<int>> likeComment({
    required int commentId,
    required int actingPetId,
  }) =>
      _guard(() async =>
          (await _remote.likeComment(commentId, actingPetId)).likes);

  @override
  Future<Result<int>> unlikeComment({
    required int commentId,
    required int actingPetId,
  }) =>
      _guard(() async =>
          (await _remote.unlikeComment(commentId, actingPetId)).likes);

  @override
  Future<Result<bool>> pinComment({
    required int commentId,
    required int actingPetId,
    required bool pin,
  }) =>
      _guard(() async =>
          (await _remote.pinComment(commentId, actingPetId, pin)).isPinned);

  // ── Follows & suggestions ────────────────────────────────────────────────

  @override
  Future<Result<FollowResult>> follow({
    required int petId,
    required int followerPetId,
  }) =>
      _guard(() async => (await _remote.follow(petId, followerPetId)).toEntity());

  @override
  Future<Result<FollowResult>> unfollow({
    required int petId,
    required int followerPetId,
  }) =>
      _guard(
          () async => (await _remote.unfollow(petId, followerPetId)).toEntity());

  @override
  Future<Result<PetPage>> getFollowers({
    required int petId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getFollowers(
          petId: petId,
          viewerPetId: viewerPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<PetPage>> getFollowing({
    required int petId,
    int? viewerPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getFollowing(
          petId: petId,
          viewerPetId: viewerPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<List<CommunityPet>>> getSuggestedPets({
    int? actingPetId,
    int limit = 10,
  }) =>
      _guard(() async {
        final dto = await _remote.getSuggested(petId: actingPetId, limit: limit);
        return dto.toEntities(myPetIds: _mine);
      });

  // ── Notifications ────────────────────────────────────────────────────────

  @override
  Future<Result<NotificationPage>> getNotifications({
    int? actingPetId,
    bool unreadOnly = false,
    int page = 0,
    int limit = 20,
  }) async {
    final cacheable = page == 0 && !unreadOnly;
    try {
      final dto = await _remote.getNotifications(
        petId: actingPetId,
        unreadOnly: unreadOnly,
        page: page,
        limit: limit,
      );
      if (cacheable) await _local.writeNotifications(dto);
      return Result.success(dto.toEntity());
    } on AppException catch (e) {
      if (cacheable && e is NetworkException) {
        final cached = await _local.readNotifications();
        if (cached != null) return Result.success(cached.toEntity());
      }
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<MarkReadResult>> markNotificationRead({
    required int notificationId,
    bool isRead = true,
  }) =>
      _guard(() async =>
          (await _remote.markNotificationRead(notificationId, isRead)).toEntity());

  @override
  Future<Result<MarkReadResult>> markAllNotificationsRead({int? actingPetId}) =>
      _guard(() async =>
          (await _remote.markAllRead(petId: actingPetId)).toEntity());

  // ── Moderation ───────────────────────────────────────────────────────────

  @override
  Future<Result<ReportResult>> reportPost({
    required int postId,
    required ReportReason reason,
    int? reporterPetId,
    String? details,
  }) =>
      _guard(() async => (await _remote.reportPost(
            postId,
            _reportBody(reason, reporterPetId, details),
          )).toEntity());

  @override
  Future<Result<ReportResult>> reportComment({
    required int commentId,
    required ReportReason reason,
    int? reporterPetId,
    String? details,
  }) =>
      _guard(() async => (await _remote.reportComment(
            commentId,
            _reportBody(reason, reporterPetId, details),
          )).toEntity());

  @override
  Future<Result<ReportResult>> reportPet({
    required int petId,
    required ReportReason reason,
    int? reporterPetId,
    String? details,
  }) =>
      _guard(() async => (await _remote.reportPet(
            petId,
            _reportBody(reason, reporterPetId, details),
          )).toEntity());

  Map<String, dynamic> _reportBody(
    ReportReason reason,
    int? reporterPetId,
    String? details,
  ) =>
      {
        'reporterPetId': ?reporterPetId,
        'reason': reason.wire,
        'details': ?details,
      };

  @override
  Future<Result<BlockResult>> block({
    required int petId,
    required int blockerPetId,
  }) =>
      _guard(() async => (await _remote.block(petId, blockerPetId)).toEntity());

  @override
  Future<Result<BlockResult>> unblock({
    required int petId,
    required int blockerPetId,
  }) =>
      _guard(() async => (await _remote.unblock(petId, blockerPetId)).toEntity());

  @override
  Future<Result<PetPage>> getBlockedPets({
    int? actingPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getBlocked(
          petId: actingPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  // ── Search & discovery ───────────────────────────────────────────────────

  @override
  Future<Result<SearchResultsPage>> search({
    required String query,
    int? actingPetId,
    SearchType type = SearchType.all,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.search(
          query: query,
          petId: actingPetId,
          type: type.wire,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<HashtagFeed>> getHashtagFeed({
    required String tag,
    int? actingPetId,
    int page = 0,
    int limit = 20,
  }) =>
      _guard(() async {
        final dto = await _remote.getHashtagFeed(
          tag: tag,
          petId: actingPetId,
          page: page,
          limit: limit,
        );
        return dto.toEntity(myPetIds: _mine);
      });

  @override
  Future<Result<Trending>> getTrending({int? actingPetId, int limit = 10}) =>
      _guard(() async {
        final dto = await _remote.getTrending(petId: actingPetId, limit: limit);
        return dto.toEntity(myPetIds: _mine);
      });

  // ── Plumbing ─────────────────────────────────────────────────────────────

  /// Runs [body], wrapping the value in [Result.success] or mapping any
  /// [AppException] to a [Result.failure].
  Future<Result<T>> _guard<T>(Future<T> Function() body) async {
    try {
      return Result.success(await body());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Future<Result<void>> _guardVoid(Future<void> Function() body) async {
    try {
      await body();
      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        RateLimitException() => RateLimitFailure(
            message: e.message,
            retryAfter: e.retryAfter,
          ),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
