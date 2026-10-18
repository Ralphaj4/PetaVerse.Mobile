import '../../../../core/errors/result.dart';
import '../../../community/domain/entities/community_entities.dart';
import '../entities/page_entities.dart';

/// Repository contract for social Pages (shelters, rescues, vets, brands).
abstract interface class PageRepository {
  /// Fetch a page's full profile. Anonymous-accessible.
  Future<Result<PageProfile>> getPage(int pageId);

  /// Fetch a page's posts feed. Anonymous-accessible.
  Future<Result<FeedPage>> getPageFeed(
    int pageId, {
    String? cursor,
    int limit = 20,
  });

  /// Follow a page. Returns the updated profile with [isFollowing] = true.
  Future<Result<PageProfile>> follow(int pageId);

  /// Unfollow a page. Returns the updated profile with [isFollowing] = false.
  Future<Result<PageProfile>> unfollow(int pageId);
}
