import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_enums.dart';
import 'community_providers.dart';

part 'community_social_providers.g.dart';

/// A pet's followers list.
@riverpod
class Followers extends _$Followers {
  @override
  Future<PetPage> build(int petId) async {
    final result = await ref.read(communityRepositoryProvider).getFollowers(
          petId: petId,
          viewerPetId: ref.watch(actingPetIdProvider),
        );
    return result.when(success: (p) => p, failure: (f) => throw f);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore) return;
    final result = await ref.read(communityRepositoryProvider).getFollowers(
          petId: petId,
          viewerPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        PetPage(
          pets: [...current.pets, ...page.pets],
          count: page.count,
          cursor: page.cursor,
        ),
      ),
      failure: (_) {},
    );
  }
}

/// A pet's following list.
@riverpod
class Following extends _$Following {
  @override
  Future<PetPage> build(int petId) async {
    final result = await ref.read(communityRepositoryProvider).getFollowing(
          petId: petId,
          viewerPetId: ref.watch(actingPetIdProvider),
        );
    return result.when(success: (p) => p, failure: (f) => throw f);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore) return;
    final result = await ref.read(communityRepositoryProvider).getFollowing(
          petId: petId,
          viewerPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        PetPage(
          pets: [...current.pets, ...page.pets],
          count: page.count,
          cursor: page.cursor,
        ),
      ),
      failure: (_) {},
    );
  }
}

/// Pets the acting profile has blocked.
@riverpod
class BlockedPets extends _$BlockedPets {
  @override
  Future<PetPage> build() async {
    final result = await ref
        .read(communityRepositoryProvider)
        .getBlockedPets(actingPetId: ref.watch(actingPetIdProvider));
    return result.when(success: (p) => p, failure: (f) => throw f);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// The active search query. The search field writes here after debouncing, so
/// this never churns on every keystroke.
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

/// The active search scope (All / Posts / Hashtags / Pets).
@riverpod
class SearchScope extends _$SearchScope {
  @override
  SearchType build() => SearchType.all;

  void select(SearchType type) => state = type;
}

/// Accumulated search state: results loaded so far + paging cursor + a footer
/// "loading more" flag. Mirrors [PagedFeed] / [PagedPolls].
class PagedSearch {
  const PagedSearch({
    required this.results,
    required this.cursor,
    this.loadingMore = false,
  });

  final List<SearchResult> results;
  final PageCursor cursor;
  final bool loadingMore;

  bool get hasMore => cursor.hasMore;

  PagedSearch copyWith({
    List<SearchResult>? results,
    PageCursor? cursor,
    bool? loadingMore,
  }) =>
      PagedSearch(
        results: results ?? this.results,
        cursor: cursor ?? this.cursor,
        loadingMore: loadingMore ?? this.loadingMore,
      );
}

/// Mixed search results for the current query + scope. Loads page 0 on build
/// (rebuilding whenever the debounced query, scope, or acting pet changes) and
/// appends further pages via [loadMore]. Returns an empty page for a blank
/// query so the screen shows its idle state, not a spinner.
@riverpod
class CommunitySearch extends _$CommunitySearch {
  @override
  Future<PagedSearch> build() async {
    final query = ref.watch(searchQueryProvider).trim();
    if (query.isEmpty) {
      return const PagedSearch(results: [], cursor: PageCursor.empty);
    }
    final result = await ref.read(communityRepositoryProvider).search(
          query: query,
          type: ref.watch(searchScopeProvider),
          actingPetId: ref.watch(actingPetIdProvider),
        );
    final page = result.when(success: (p) => p, failure: (f) => throw f);
    return PagedSearch(results: page.results, cursor: page.cursor);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(current.copyWith(loadingMore: true));
    final result = await ref.read(communityRepositoryProvider).search(
          query: ref.read(searchQueryProvider).trim(),
          type: ref.read(searchScopeProvider),
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        current.copyWith(
          results: [...current.results, ...page.results],
          cursor: page.cursor,
          loadingMore: false,
        ),
      ),
      failure: (_) => state = AsyncData(current.copyWith(loadingMore: false)),
    );
  }
}
