import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/community_entities.dart' show PageCursor;
import '../../domain/entities/community_group_entities.dart';
import '../../domain/entities/community_group_enums.dart';
import 'community_feed_providers.dart' show PagedFeed;
import 'community_group_providers.dart';
import 'community_providers.dart';

part 'community_group_feed_providers.g.dart';

/// The active filter for the communities directory. Changing it rebuilds
/// [CommunityDirectory] (which watches these).
@riverpod
class CommunityDirectoryFilter extends _$CommunityDirectoryFilter {
  @override
  ({CommunityCategory? category, CommunitySort sort}) build() =>
      (category: null, sort: CommunitySort.popular);

  void setCategory(CommunityCategory? category) =>
      state = (category: category, sort: state.sort);

  void setSort(CommunitySort sort) =>
      state = (category: state.category, sort: sort);
}

/// Accumulated directory state: communities loaded so far + paging cursor +
/// a footer "loading more" flag. Mirrors [PagedFeed].
class PagedCommunities {
  const PagedCommunities({
    required this.communities,
    required this.cursor,
    this.total,
    this.loadingMore = false,
  });

  final List<CommunityGroup> communities;
  final PageCursor cursor;
  final int? total;
  final bool loadingMore;

  bool get hasMore => cursor.hasMore;

  PagedCommunities copyWith({
    List<CommunityGroup>? communities,
    PageCursor? cursor,
    int? total,
    bool? loadingMore,
  }) =>
      PagedCommunities(
        communities: communities ?? this.communities,
        cursor: cursor ?? this.cursor,
        total: total ?? this.total,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// The communities directory. Loads page 0 on build (respecting the current
/// [CommunityDirectoryFilter]), appends further pages via [loadMore]. Rebuilds
/// when the filter or acting pet changes.
@riverpod
class CommunityDirectory extends _$CommunityDirectory {
  @override
  Future<PagedCommunities> build() async {
    final filter = ref.watch(communityDirectoryFilterProvider);
    final actingPetId = ref.watch(actingPetIdProvider);
    final result = await ref.read(communityGroupRepositoryProvider).getCommunities(
          actingPetId: actingPetId,
          category: filter.category,
          sort: filter.sort,
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedCommunities(
      communities: page.communities,
      cursor: page.cursor,
      total: page.total,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final filter = ref.read(communityDirectoryFilterProvider);
    final result = await ref.read(communityGroupRepositoryProvider).getCommunities(
          actingPetId: ref.read(actingPetIdProvider),
          category: filter.category,
          sort: filter.sort,
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          communities: [...current.communities, ...page.communities],
          cursor: page.cursor,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }

  /// Replaces a community in place after join/leave so the row reflects the
  /// fresh membership/count without a full refetch.
  void replace(CommunityGroup updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        communities: [
          for (final c in current.communities) c.id == updated.id ? updated : c,
        ],
      ),
    );
  }
}

/// A live search over communities (debounced by the page). Empty query → empty.
@riverpod
Future<PagedCommunities> communitySearch(Ref ref, String query) async {
  final q = query.trim();
  if (q.isEmpty) {
    return const PagedCommunities(communities: [], cursor: PageCursor.empty);
  }
  final result = await ref.read(communityGroupRepositoryProvider).searchCommunities(
        query: q,
        actingPetId: ref.watch(actingPetIdProvider),
      );
  final page = result.when(success: (p) => p, failure: (f) => throw f);
  return PagedCommunities(
    communities: page.communities,
    cursor: page.cursor,
    total: page.total,
  );
}

/// Communities the acting pet has joined (the "My Communities" rail).
@riverpod
Future<List<CommunityGroup>> myCommunities(Ref ref) async {
  final actingPetId = ref.watch(actingPetIdProvider);
  if (actingPetId == null) return const [];
  final result = await ref
      .read(communityGroupRepositoryProvider)
      .getMyCommunities(actingPetId: actingPetId);
  return result.when(success: (list) => list, failure: (f) => throw f);
}

/// Communities to join, for the Discover-tab rail.
@riverpod
Future<List<CommunityGroup>> suggestedCommunities(Ref ref) async {
  final result = await ref
      .read(communityGroupRepositoryProvider)
      .getSuggestedCommunities(actingPetId: ref.watch(actingPetIdProvider));
  return result.when(success: (list) => list, failure: (f) => throw f);
}

/// A single community's header/profile. Family-keyed by id.
@riverpod
class CommunityDetail extends _$CommunityDetail {
  @override
  Future<CommunityGroup> build(int communityId) async {
    final result = await ref.read(communityGroupRepositoryProvider).getCommunity(
          communityId: communityId,
          viewerPetId: ref.watch(actingPetIdProvider),
        );
    return result.when(success: (c) => c, failure: (f) => throw f);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  /// Optimistically updates membership/count (used by join/leave).
  void setMembership({required bool isMember, required int memberCount}) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(isMember: isMember, memberCount: memberCount),
    );
  }
}

/// A community's post feed. Reuses [PagedFeed] (same shape as every other
/// feed), so [PostCard] and the feed-list machinery render it unchanged.
@riverpod
class CommunityFeed extends _$CommunityFeed {
  @override
  Future<PagedFeed> build(int communityId) async {
    final result = await ref.read(communityGroupRepositoryProvider).getCommunityFeed(
          communityId: communityId,
          actingPetId: ref.watch(actingPetIdProvider),
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
    final result = await ref.read(communityGroupRepositoryProvider).getCommunityFeed(
          communityId: communityId,
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

  /// Removes a post from the loaded feed (after delete / hide / block).
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

/// A community's members list. Family-keyed by id. Throws on failure so the
/// dedicated members page can show an error state with retry.
@riverpod
Future<CommunityMemberPage> communityMembers(Ref ref, int communityId) async {
  final result = await ref
      .read(communityGroupRepositoryProvider)
      .getMembers(communityId: communityId);
  return result.when(success: (p) => p, failure: (f) => throw f);
}

/// A non-throwing members preview for the detail-page card: returns null on
/// failure instead of throwing, so a failing members endpoint degrades to a
/// header-only card rather than storming the API with Riverpod's auto-retry.
@riverpod
Future<CommunityMemberPage?> communityMemberPreview(
  Ref ref,
  int communityId,
) async {
  final result = await ref
      .read(communityGroupRepositoryProvider)
      .getMembers(communityId: communityId);
  return result.when(success: (p) => p, failure: (_) => null);
}
