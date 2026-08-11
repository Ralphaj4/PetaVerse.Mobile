import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_group_entities.dart';
import 'community_providers.dart';

part 'community_feed_providers.g.dart';

/// Accumulated state for a paginated post feed: the posts loaded so far plus
/// the paging cursor and a "loading more" flag for the footer spinner.
class PagedFeed {
  const PagedFeed({
    required this.posts,
    required this.cursor,
    this.postCount,
    this.loadingMore = false,
  });

  final List<Post> posts;
  final PageCursor cursor;
  final int? postCount;
  final bool loadingMore;

  bool get hasMore => cursor.hasMore;

  PagedFeed copyWith({
    List<Post>? posts,
    PageCursor? cursor,
    int? postCount,
    bool? loadingMore,
  }) =>
      PagedFeed(
        posts: posts ?? this.posts,
        cursor: cursor ?? this.cursor,
        postCount: postCount ?? this.postCount,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// The following feed — posts from pets the acting profile follows. Loads page
/// 0 on build, appends further pages via [loadMore]. Rebuilds when the acting
/// pet changes.
@riverpod
class FollowingFeed extends _$FollowingFeed {
  @override
  Future<PagedFeed> build() async {
    final actingPetId = ref.watch(actingPetIdProvider);
    final result = await ref.read(communityRepositoryProvider).getFollowingFeed(
          actingPetId: actingPetId,
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedFeed(posts: page.posts, cursor: page.cursor);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));

    final result = await ref.read(communityRepositoryProvider).getFollowingFeed(
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          posts: [...current.posts, ...page.posts],
          cursor: page.cursor,
          loadingMore: false,
        ),
      ),
      // Keep what we have; drop the spinner so the user can retry the scroll.
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }

  /// Replaces a post in place after an interaction (like/save) so the row
  /// reflects the server's fresh counts without a full refetch.
  void replacePost(Post updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        posts: [
          for (final p in current.posts) p.id == updated.id ? updated : p,
        ],
      ),
    );
  }

  /// Removes a post (after delete / hide / block).
  void removePost(int postId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        posts: current.posts.where((p) => p.id != postId).toList(),
      ),
    );
  }
}

/// The discover feed — public posts from pets the profile doesn't follow, plus
/// the suggested-pets rail and lost & found alerts. Accumulates posts across
/// pages; the rail and alerts come from page 0.
@riverpod
class DiscoverFeed extends _$DiscoverFeed {
  @override
  Future<DiscoverState> build() async {
    final actingPetId = ref.watch(actingPetIdProvider);
    final result = await ref.read(communityRepositoryProvider).getDiscoverFeed(
          actingPetId: actingPetId,
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return DiscoverState(
      posts: page.posts,
      suggestedPets: page.suggestedPets,
      suggestedCommunities: page.suggestedCommunities,
      alerts: page.alerts,
      cursor: page.cursor,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore || current.loadingMore) {
      return;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(communityRepositoryProvider).getDiscoverFeed(
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
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

  void replacePost(Post updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        posts: [
          for (final p in current.posts) p.id == updated.id ? updated : p,
        ],
      ),
    );
  }
}

/// Accumulated discover state (posts + rails + alerts + cursor).
class DiscoverState {
  const DiscoverState({
    required this.posts,
    required this.suggestedPets,
    required this.suggestedCommunities,
    required this.alerts,
    required this.cursor,
    this.loadingMore = false,
  });

  final List<Post> posts;
  final List<CommunityPet> suggestedPets;
  final List<CommunityGroup> suggestedCommunities;
  final List<LostFoundAlert> alerts;
  final PageCursor cursor;
  final bool loadingMore;

  DiscoverState copyWith({
    List<Post>? posts,
    List<CommunityPet>? suggestedPets,
    List<CommunityGroup>? suggestedCommunities,
    List<LostFoundAlert>? alerts,
    PageCursor? cursor,
    bool? loadingMore,
  }) =>
      DiscoverState(
        posts: posts ?? this.posts,
        suggestedPets: suggestedPets ?? this.suggestedPets,
        suggestedCommunities: suggestedCommunities ?? this.suggestedCommunities,
        alerts: alerts ?? this.alerts,
        cursor: cursor ?? this.cursor,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// Saved (bookmarked) posts for the acting profile, most-recently-saved first.
@riverpod
class SavedPosts extends _$SavedPosts {
  @override
  Future<PagedFeed> build() async {
    final actingPetId = ref.watch(actingPetIdProvider);
    final result = await ref
        .read(communityRepositoryProvider)
        .getSavedPosts(actingPetId: actingPetId);
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedFeed(posts: page.posts, cursor: page.cursor);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(communityRepositoryProvider).getSavedPosts(
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
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

  void removePost(int postId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        posts: current.posts.where((p) => p.id != postId).toList(),
      ),
    );
  }
}

/// The current user's own posts. Loads page 0 on build, appends further pages
/// via [loadMore]. Rebuilds when the acting pet changes.
@Riverpod(keepAlive: true)
class MyPosts extends _$MyPosts {
  @override
  Future<PagedFeed> build() async {
    final actingPetId = ref.watch(actingPetIdProvider);
    final result = await ref.read(communityRepositoryProvider).getPetPosts(
          petId: actingPetId ?? 0,
          viewerPetId: actingPetId,
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedFeed(posts: page.posts, cursor: page.cursor, postCount: page.postCount);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(communityRepositoryProvider).getPetPosts(
          petId: ref.read(actingPetIdProvider) ?? 0,
          viewerPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          posts: [...current.posts, ...page.posts],
          cursor: page.cursor,
          postCount: page.postCount,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }

  void removePost(int postId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        posts: current.posts.where((p) => p.id != postId).toList(),
      ),
    );
  }
}

/// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
/// against the acting profile.
@riverpod
class PetPosts extends _$PetPosts {
  @override
  Future<PagedFeed> build(int petId) async {
    final result = await ref.read(communityRepositoryProvider).getPetPosts(
          petId: petId,
          viewerPetId: ref.watch(actingPetIdProvider),
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedFeed(posts: page.posts, cursor: page.cursor, postCount: page.postCount);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(communityRepositoryProvider).getPetPosts(
          petId: petId,
          viewerPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          posts: [...current.posts, ...page.posts],
          cursor: page.cursor,
          postCount: page.postCount,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }
}

/// Suggested pets to follow (Discover rail / follow suggestions).
@riverpod
Future<List<CommunityPet>> suggestedPets(Ref ref) async {
  final result = await ref.read(communityRepositoryProvider).getSuggestedPets(
        actingPetId: ref.watch(actingPetIdProvider),
      );
  return result.when(success: (p) => p, failure: (f) => throw f);
}

/// A single post + its comment thread, for the detail / shareable screen.
@riverpod
Future<PostDetail> postDetail(Ref ref, int postId) async {
  final result = await ref.read(communityRepositoryProvider).getPost(
        postId: postId,
        viewerPetId: ref.watch(actingPetIdProvider),
      );
  return result.when(success: (d) => d, failure: (f) => throw f);
}

/// Trending hashtags + posts.
@riverpod
Future<Trending> trending(Ref ref) async {
  final result = await ref
      .read(communityRepositoryProvider)
      .getTrending(actingPetId: ref.watch(actingPetIdProvider));
  return result.when(success: (t) => t, failure: (f) => throw f);
}

/// A hashtag feed. Accumulates posts across pages.
@riverpod
class HashtagFeedNotifier extends _$HashtagFeedNotifier {
  @override
  Future<HashtagFeed> build(String tag) async {
    final result = await ref.read(communityRepositoryProvider).getHashtagFeed(
          tag: tag,
          actingPetId: ref.watch(actingPetIdProvider),
        );
    return result.when(success: (f) => f, failure: (f) => throw f);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore) return;
    final result = await ref.read(communityRepositoryProvider).getHashtagFeed(
          tag: tag,
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        HashtagFeed(
          hashtag: current.hashtag,
          postCount: current.postCount,
          posts: [...current.posts, ...page.posts],
          cursor: page.cursor,
        ),
      ),
      failure: (_) {},
    );
  }
}

