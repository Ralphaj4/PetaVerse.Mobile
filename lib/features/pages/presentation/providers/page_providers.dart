import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../community/domain/entities/community_entities.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/page_remote_datasource.dart';
import '../../data/repositories/page_repository_impl.dart';
import '../../domain/entities/page_entities.dart';
import '../../domain/repositories/page_repository.dart';

export '../../domain/entities/page_entities.dart' show PageProfile;

part 'page_providers.g.dart';

/// The pages repository, wired to the shared [ApiClient].
@Riverpod(keepAlive: true)
PageRepository pageRepository(Ref ref) => PageRepositoryImpl(
      PageRemoteDataSource(ref.watch(apiClientProvider)),
      () => ref.read(petsProvider).refs.map((r) => r.id).toSet(),
    );

/// Loads a page's full profile by id.
@riverpod
Future<PageProfile> pageProfile(Ref ref, int pageId) async {
  final result = await ref.read(pageRepositoryProvider).getPage(pageId);
  return result.when(
    success: (p) => p,
    failure: (f) => throw f,
  );
}

/// Accumulated feed state for a page's post list.
class PageFeedState {
  const PageFeedState({
    required this.posts,
    required this.cursor,
    this.loadingMore = false,
  });

  final List<Post> posts;
  final PageCursor cursor;
  final bool loadingMore;

  PageFeedState copyWith({
    List<Post>? posts,
    PageCursor? cursor,
    bool? loadingMore,
  }) =>
      PageFeedState(
        posts: posts ?? this.posts,
        cursor: cursor ?? this.cursor,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].
@riverpod
class PageFeed extends _$PageFeed {
  @override
  Future<PageFeedState> build(int pageId) async {
    final result =
        await ref.read(pageRepositoryProvider).getPageFeed(pageId);
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PageFeedState(posts: page.posts, cursor: page.cursor);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore || current.loadingMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(pageRepositoryProvider).getPageFeed(
          pageId,
          cursor: current.cursor.nextCursor,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          posts: [...current.posts, ...page.posts],
          cursor: page.cursor,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }
}

/// Follow / unfollow a page. Invalidates [pageProfileProvider] so the header
/// updates immediately.
@Riverpod(keepAlive: true)
PageFollowActions pageFollowActions(Ref ref) => PageFollowActions(ref);

class PageFollowActions {
  PageFollowActions(this._ref);

  final Ref _ref;

  PageRepository get _repo => _ref.read(pageRepositoryProvider);

  Future<PageProfile?> toggleFollow(PageProfile page) async {
    final result = page.isFollowing == true
        ? await _repo.unfollow(page.id)
        : await _repo.follow(page.id);

    return result.when(
      success: (updated) {
        _ref.invalidate(pageProfileProvider(page.id));
        return updated;
      },
      failure: (_) => null,
    );
  }

  /// Lightweight variant used by the Discover rail where only [pageId] and the
  /// current follow state are known (no full [PageProfile] loaded).
  Future<void> toggleFollowById(int pageId,
      {required bool currentlyFollowing}) async {
    final result = currentlyFollowing
        ? await _repo.unfollow(pageId)
        : await _repo.follow(pageId);
    result.when(
      success: (_) => _ref.invalidate(pageProfileProvider(pageId)),
      failure: (_) {},
    );
  }
}
