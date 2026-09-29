// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_social_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A pet's followers list.

@ProviderFor(Followers)
final followersProvider = FollowersFamily._();

/// A pet's followers list.
final class FollowersProvider
    extends $AsyncNotifierProvider<Followers, PetPage> {
  /// A pet's followers list.
  FollowersProvider._({
    required FollowersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'followersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$followersHash();

  @override
  String toString() {
    return r'followersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Followers create() => Followers();

  @override
  bool operator ==(Object other) {
    return other is FollowersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followersHash() => r'516ae84bfacd5d34e1511439057ef2416825961d';

/// A pet's followers list.

final class FollowersFamily extends $Family
    with
        $ClassFamilyOverride<
          Followers,
          AsyncValue<PetPage>,
          PetPage,
          FutureOr<PetPage>,
          int
        > {
  FollowersFamily._()
    : super(
        retry: null,
        name: r'followersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A pet's followers list.

  FollowersProvider call(int petId) =>
      FollowersProvider._(argument: petId, from: this);

  @override
  String toString() => r'followersProvider';
}

/// A pet's followers list.

abstract class _$Followers extends $AsyncNotifier<PetPage> {
  late final _$args = ref.$arg as int;
  int get petId => _$args;

  FutureOr<PetPage> build(int petId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PetPage>, PetPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PetPage>, PetPage>,
              AsyncValue<PetPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// A pet's following list.

@ProviderFor(Following)
final followingProvider = FollowingFamily._();

/// A pet's following list.
final class FollowingProvider
    extends $AsyncNotifierProvider<Following, PetPage> {
  /// A pet's following list.
  FollowingProvider._({
    required FollowingFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'followingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$followingHash();

  @override
  String toString() {
    return r'followingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Following create() => Following();

  @override
  bool operator ==(Object other) {
    return other is FollowingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$followingHash() => r'7267a66adbfc5ca3479466b8354a79f353c513df';

/// A pet's following list.

final class FollowingFamily extends $Family
    with
        $ClassFamilyOverride<
          Following,
          AsyncValue<PetPage>,
          PetPage,
          FutureOr<PetPage>,
          int
        > {
  FollowingFamily._()
    : super(
        retry: null,
        name: r'followingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A pet's following list.

  FollowingProvider call(int petId) =>
      FollowingProvider._(argument: petId, from: this);

  @override
  String toString() => r'followingProvider';
}

/// A pet's following list.

abstract class _$Following extends $AsyncNotifier<PetPage> {
  late final _$args = ref.$arg as int;
  int get petId => _$args;

  FutureOr<PetPage> build(int petId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PetPage>, PetPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PetPage>, PetPage>,
              AsyncValue<PetPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Pets the acting profile has blocked.

@ProviderFor(BlockedPets)
final blockedPetsProvider = BlockedPetsProvider._();

/// Pets the acting profile has blocked.
final class BlockedPetsProvider
    extends $AsyncNotifierProvider<BlockedPets, PetPage> {
  /// Pets the acting profile has blocked.
  BlockedPetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedPetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedPetsHash();

  @$internal
  @override
  BlockedPets create() => BlockedPets();
}

String _$blockedPetsHash() => r'46630e89a5ba74aec6cb0391a8837a40a74944c5';

/// Pets the acting profile has blocked.

abstract class _$BlockedPets extends $AsyncNotifier<PetPage> {
  FutureOr<PetPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PetPage>, PetPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PetPage>, PetPage>,
              AsyncValue<PetPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The active search query. The search field writes here after debouncing, so
/// this never churns on every keystroke.

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

/// The active search query. The search field writes here after debouncing, so
/// this never churns on every keystroke.
final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  /// The active search query. The search field writes here after debouncing, so
  /// this never churns on every keystroke.
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'2ab221c441fd042c8cbf58b17e7e766363f36b6f';

/// The active search query. The search field writes here after debouncing, so
/// this never churns on every keystroke.

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The active search scope (All / Posts / Hashtags / Pets).

@ProviderFor(SearchScope)
final searchScopeProvider = SearchScopeProvider._();

/// The active search scope (All / Posts / Hashtags / Pets).
final class SearchScopeProvider
    extends $NotifierProvider<SearchScope, SearchType> {
  /// The active search scope (All / Posts / Hashtags / Pets).
  SearchScopeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchScopeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchScopeHash();

  @$internal
  @override
  SearchScope create() => SearchScope();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchType>(value),
    );
  }
}

String _$searchScopeHash() => r'df1a25deb4bc5bbbd9a3e518cfcb610c21b7c7cd';

/// The active search scope (All / Posts / Hashtags / Pets).

abstract class _$SearchScope extends $Notifier<SearchType> {
  SearchType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SearchType, SearchType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchType, SearchType>,
              SearchType,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Mixed search results for the current query + scope. Loads page 0 on build
/// (rebuilding whenever the debounced query, scope, or acting pet changes) and
/// appends further pages via [loadMore]. Returns an empty page for a blank
/// query so the screen shows its idle state, not a spinner.

@ProviderFor(CommunitySearch)
final communitySearchProvider = CommunitySearchProvider._();

/// Mixed search results for the current query + scope. Loads page 0 on build
/// (rebuilding whenever the debounced query, scope, or acting pet changes) and
/// appends further pages via [loadMore]. Returns an empty page for a blank
/// query so the screen shows its idle state, not a spinner.
final class CommunitySearchProvider
    extends $AsyncNotifierProvider<CommunitySearch, PagedSearch> {
  /// Mixed search results for the current query + scope. Loads page 0 on build
  /// (rebuilding whenever the debounced query, scope, or acting pet changes) and
  /// appends further pages via [loadMore]. Returns an empty page for a blank
  /// query so the screen shows its idle state, not a spinner.
  CommunitySearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communitySearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communitySearchHash();

  @$internal
  @override
  CommunitySearch create() => CommunitySearch();
}

String _$communitySearchHash() => r'2b4adb752de84c589889fce086360ebeeae0a5ab';

/// Mixed search results for the current query + scope. Loads page 0 on build
/// (rebuilding whenever the debounced query, scope, or acting pet changes) and
/// appends further pages via [loadMore]. Returns an empty page for a blank
/// query so the screen shows its idle state, not a spinner.

abstract class _$CommunitySearch extends $AsyncNotifier<PagedSearch> {
  FutureOr<PagedSearch> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedSearch>, PagedSearch>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedSearch>, PagedSearch>,
              AsyncValue<PagedSearch>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
