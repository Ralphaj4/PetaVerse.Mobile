// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_feed_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The following feed — posts from pets the acting profile follows. Loads page
/// 0 on build, appends further pages via [loadMore]. Rebuilds when the acting
/// pet changes.

@ProviderFor(FollowingFeed)
final followingFeedProvider = FollowingFeedProvider._();

/// The following feed — posts from pets the acting profile follows. Loads page
/// 0 on build, appends further pages via [loadMore]. Rebuilds when the acting
/// pet changes.
final class FollowingFeedProvider
    extends $AsyncNotifierProvider<FollowingFeed, PagedFeed> {
  /// The following feed — posts from pets the acting profile follows. Loads page
  /// 0 on build, appends further pages via [loadMore]. Rebuilds when the acting
  /// pet changes.
  FollowingFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'followingFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$followingFeedHash();

  @$internal
  @override
  FollowingFeed create() => FollowingFeed();
}

String _$followingFeedHash() => r'3fc560a47cdd438cbf3c1b1c41182b39faf3c5e4';

/// The following feed — posts from pets the acting profile follows. Loads page
/// 0 on build, appends further pages via [loadMore]. Rebuilds when the acting
/// pet changes.

abstract class _$FollowingFeed extends $AsyncNotifier<PagedFeed> {
  FutureOr<PagedFeed> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedFeed>, PagedFeed>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedFeed>, PagedFeed>,
              AsyncValue<PagedFeed>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The discover feed — public posts from pets the profile doesn't follow, plus
/// the suggested-pets rail and lost & found alerts. Accumulates posts across
/// pages; the rail and alerts come from page 0.

@ProviderFor(DiscoverFeed)
final discoverFeedProvider = DiscoverFeedProvider._();

/// The discover feed — public posts from pets the profile doesn't follow, plus
/// the suggested-pets rail and lost & found alerts. Accumulates posts across
/// pages; the rail and alerts come from page 0.
final class DiscoverFeedProvider
    extends $AsyncNotifierProvider<DiscoverFeed, DiscoverState> {
  /// The discover feed — public posts from pets the profile doesn't follow, plus
  /// the suggested-pets rail and lost & found alerts. Accumulates posts across
  /// pages; the rail and alerts come from page 0.
  DiscoverFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverFeedHash();

  @$internal
  @override
  DiscoverFeed create() => DiscoverFeed();
}

String _$discoverFeedHash() => r'814b89d8b06e0d63cd0c439489271cd4fc16336d';

/// The discover feed — public posts from pets the profile doesn't follow, plus
/// the suggested-pets rail and lost & found alerts. Accumulates posts across
/// pages; the rail and alerts come from page 0.

abstract class _$DiscoverFeed extends $AsyncNotifier<DiscoverState> {
  FutureOr<DiscoverState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DiscoverState>, DiscoverState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DiscoverState>, DiscoverState>,
              AsyncValue<DiscoverState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Saved (bookmarked) posts for the acting profile, most-recently-saved first.

@ProviderFor(SavedPosts)
final savedPostsProvider = SavedPostsProvider._();

/// Saved (bookmarked) posts for the acting profile, most-recently-saved first.
final class SavedPostsProvider
    extends $AsyncNotifierProvider<SavedPosts, PagedFeed> {
  /// Saved (bookmarked) posts for the acting profile, most-recently-saved first.
  SavedPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedPostsHash();

  @$internal
  @override
  SavedPosts create() => SavedPosts();
}

String _$savedPostsHash() => r'cad5242692fbe02afcfd5a5d1cc12ecf6e081cb6';

/// Saved (bookmarked) posts for the acting profile, most-recently-saved first.

abstract class _$SavedPosts extends $AsyncNotifier<PagedFeed> {
  FutureOr<PagedFeed> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedFeed>, PagedFeed>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedFeed>, PagedFeed>,
              AsyncValue<PagedFeed>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The current user's own posts. Loads page 0 on build, appends further pages
/// via [loadMore]. Rebuilds when the acting pet changes.

@ProviderFor(MyPosts)
final myPostsProvider = MyPostsProvider._();

/// The current user's own posts. Loads page 0 on build, appends further pages
/// via [loadMore]. Rebuilds when the acting pet changes.
final class MyPostsProvider extends $AsyncNotifierProvider<MyPosts, PagedFeed> {
  /// The current user's own posts. Loads page 0 on build, appends further pages
  /// via [loadMore]. Rebuilds when the acting pet changes.
  MyPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPostsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPostsHash();

  @$internal
  @override
  MyPosts create() => MyPosts();
}

String _$myPostsHash() => r'8d569fe7e20354abd8064a843e9c364d9ff3ff85';

/// The current user's own posts. Loads page 0 on build, appends further pages
/// via [loadMore]. Rebuilds when the acting pet changes.

abstract class _$MyPosts extends $AsyncNotifier<PagedFeed> {
  FutureOr<PagedFeed> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedFeed>, PagedFeed>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedFeed>, PagedFeed>,
              AsyncValue<PagedFeed>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
/// against the acting profile.

@ProviderFor(PetPosts)
final petPostsProvider = PetPostsFamily._();

/// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
/// against the acting profile.
final class PetPostsProvider
    extends $AsyncNotifierProvider<PetPosts, PagedFeed> {
  /// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
  /// against the acting profile.
  PetPostsProvider._({
    required PetPostsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petPostsHash();

  @override
  String toString() {
    return r'petPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PetPosts create() => PetPosts();

  @override
  bool operator ==(Object other) {
    return other is PetPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petPostsHash() => r'f62c727c4c232d27f4e63daabf3c033397409eef';

/// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
/// against the acting profile.

final class PetPostsFamily extends $Family
    with
        $ClassFamilyOverride<
          PetPosts,
          AsyncValue<PagedFeed>,
          PagedFeed,
          FutureOr<PagedFeed>,
          int
        > {
  PetPostsFamily._()
    : super(
        retry: null,
        name: r'petPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
  /// against the acting profile.

  PetPostsProvider call(int petId) =>
      PetPostsProvider._(argument: petId, from: this);

  @override
  String toString() => r'petPostsProvider';
}

/// A specific pet's post grid. `viewerPetId` resolves like/save/follow flags
/// against the acting profile.

abstract class _$PetPosts extends $AsyncNotifier<PagedFeed> {
  late final _$args = ref.$arg as int;
  int get petId => _$args;

  FutureOr<PagedFeed> build(int petId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedFeed>, PagedFeed>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedFeed>, PagedFeed>,
              AsyncValue<PagedFeed>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Suggested pets to follow (Discover rail / follow suggestions).

@ProviderFor(suggestedPets)
final suggestedPetsProvider = SuggestedPetsProvider._();

/// Suggested pets to follow (Discover rail / follow suggestions).

final class SuggestedPetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommunityPet>>,
          List<CommunityPet>,
          FutureOr<List<CommunityPet>>
        >
    with
        $FutureModifier<List<CommunityPet>>,
        $FutureProvider<List<CommunityPet>> {
  /// Suggested pets to follow (Discover rail / follow suggestions).
  SuggestedPetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'suggestedPetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$suggestedPetsHash();

  @$internal
  @override
  $FutureProviderElement<List<CommunityPet>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommunityPet>> create(Ref ref) {
    return suggestedPets(ref);
  }
}

String _$suggestedPetsHash() => r'afe52e0fa73f88e07870388ac2170d960a24f45e';

/// A single post + its comment thread, for the detail / shareable screen.

@ProviderFor(postDetail)
final postDetailProvider = PostDetailFamily._();

/// A single post + its comment thread, for the detail / shareable screen.

final class PostDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<PostDetail>,
          PostDetail,
          FutureOr<PostDetail>
        >
    with $FutureModifier<PostDetail>, $FutureProvider<PostDetail> {
  /// A single post + its comment thread, for the detail / shareable screen.
  PostDetailProvider._({
    required PostDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'postDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postDetailHash();

  @override
  String toString() {
    return r'postDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PostDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PostDetail> create(Ref ref) {
    final argument = this.argument as int;
    return postDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postDetailHash() => r'6176842d72fdbeb2031790a3dc3dcc460cf9a4b1';

/// A single post + its comment thread, for the detail / shareable screen.

final class PostDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PostDetail>, int> {
  PostDetailFamily._()
    : super(
        retry: null,
        name: r'postDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single post + its comment thread, for the detail / shareable screen.

  PostDetailProvider call(int postId) =>
      PostDetailProvider._(argument: postId, from: this);

  @override
  String toString() => r'postDetailProvider';
}

/// Trending hashtags + posts.

@ProviderFor(trending)
final trendingProvider = TrendingProvider._();

/// Trending hashtags + posts.

final class TrendingProvider
    extends
        $FunctionalProvider<AsyncValue<Trending>, Trending, FutureOr<Trending>>
    with $FutureModifier<Trending>, $FutureProvider<Trending> {
  /// Trending hashtags + posts.
  TrendingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendingHash();

  @$internal
  @override
  $FutureProviderElement<Trending> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Trending> create(Ref ref) {
    return trending(ref);
  }
}

String _$trendingHash() => r'76a5f51ee268f96d12c28d6fb52d7ff991bd3ed6';

/// A hashtag feed. Accumulates posts across pages.

@ProviderFor(HashtagFeedNotifier)
final hashtagFeedProvider = HashtagFeedNotifierFamily._();

/// A hashtag feed. Accumulates posts across pages.
final class HashtagFeedNotifierProvider
    extends $AsyncNotifierProvider<HashtagFeedNotifier, HashtagFeed> {
  /// A hashtag feed. Accumulates posts across pages.
  HashtagFeedNotifierProvider._({
    required HashtagFeedNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hashtagFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hashtagFeedNotifierHash();

  @override
  String toString() {
    return r'hashtagFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HashtagFeedNotifier create() => HashtagFeedNotifier();

  @override
  bool operator ==(Object other) {
    return other is HashtagFeedNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hashtagFeedNotifierHash() =>
    r'cf0b173c7ccd9785e33007749f70d165b761d214';

/// A hashtag feed. Accumulates posts across pages.

final class HashtagFeedNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          HashtagFeedNotifier,
          AsyncValue<HashtagFeed>,
          HashtagFeed,
          FutureOr<HashtagFeed>,
          String
        > {
  HashtagFeedNotifierFamily._()
    : super(
        retry: null,
        name: r'hashtagFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A hashtag feed. Accumulates posts across pages.

  HashtagFeedNotifierProvider call(String tag) =>
      HashtagFeedNotifierProvider._(argument: tag, from: this);

  @override
  String toString() => r'hashtagFeedProvider';
}

/// A hashtag feed. Accumulates posts across pages.

abstract class _$HashtagFeedNotifier extends $AsyncNotifier<HashtagFeed> {
  late final _$args = ref.$arg as String;
  String get tag => _$args;

  FutureOr<HashtagFeed> build(String tag);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HashtagFeed>, HashtagFeed>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HashtagFeed>, HashtagFeed>,
              AsyncValue<HashtagFeed>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
