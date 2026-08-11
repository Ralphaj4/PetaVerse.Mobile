// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_group_feed_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The active filter for the communities directory. Changing it rebuilds
/// [CommunityDirectory] (which watches these).

@ProviderFor(CommunityDirectoryFilter)
final communityDirectoryFilterProvider = CommunityDirectoryFilterProvider._();

/// The active filter for the communities directory. Changing it rebuilds
/// [CommunityDirectory] (which watches these).
final class CommunityDirectoryFilterProvider
    extends
        $NotifierProvider<
          CommunityDirectoryFilter,
          ({CommunityCategory? category, CommunitySort sort})
        > {
  /// The active filter for the communities directory. Changing it rebuilds
  /// [CommunityDirectory] (which watches these).
  CommunityDirectoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityDirectoryFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityDirectoryFilterHash();

  @$internal
  @override
  CommunityDirectoryFilter create() => CommunityDirectoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    ({CommunityCategory? category, CommunitySort sort}) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            ({CommunityCategory? category, CommunitySort sort})
          >(value),
    );
  }
}

String _$communityDirectoryFilterHash() =>
    r'0cf29bbc74fefecc5f17cfa22f502194860ec709';

/// The active filter for the communities directory. Changing it rebuilds
/// [CommunityDirectory] (which watches these).

abstract class _$CommunityDirectoryFilter
    extends $Notifier<({CommunityCategory? category, CommunitySort sort})> {
  ({CommunityCategory? category, CommunitySort sort}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({CommunityCategory? category, CommunitySort sort}),
              ({CommunityCategory? category, CommunitySort sort})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({CommunityCategory? category, CommunitySort sort}),
                ({CommunityCategory? category, CommunitySort sort})
              >,
              ({CommunityCategory? category, CommunitySort sort}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The communities directory. Loads page 0 on build (respecting the current
/// [CommunityDirectoryFilter]), appends further pages via [loadMore]. Rebuilds
/// when the filter or acting pet changes.

@ProviderFor(CommunityDirectory)
final communityDirectoryProvider = CommunityDirectoryProvider._();

/// The communities directory. Loads page 0 on build (respecting the current
/// [CommunityDirectoryFilter]), appends further pages via [loadMore]. Rebuilds
/// when the filter or acting pet changes.
final class CommunityDirectoryProvider
    extends $AsyncNotifierProvider<CommunityDirectory, PagedCommunities> {
  /// The communities directory. Loads page 0 on build (respecting the current
  /// [CommunityDirectoryFilter]), appends further pages via [loadMore]. Rebuilds
  /// when the filter or acting pet changes.
  CommunityDirectoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityDirectoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityDirectoryHash();

  @$internal
  @override
  CommunityDirectory create() => CommunityDirectory();
}

String _$communityDirectoryHash() =>
    r'e4b1b244720a53316bd018fa8bc68a46196b2ea4';

/// The communities directory. Loads page 0 on build (respecting the current
/// [CommunityDirectoryFilter]), appends further pages via [loadMore]. Rebuilds
/// when the filter or acting pet changes.

abstract class _$CommunityDirectory extends $AsyncNotifier<PagedCommunities> {
  FutureOr<PagedCommunities> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PagedCommunities>, PagedCommunities>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedCommunities>, PagedCommunities>,
              AsyncValue<PagedCommunities>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// A live search over communities (debounced by the page). Empty query → empty.

@ProviderFor(communitySearch)
final communitySearchProvider = CommunitySearchFamily._();

/// A live search over communities (debounced by the page). Empty query → empty.

final class CommunitySearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<PagedCommunities>,
          PagedCommunities,
          FutureOr<PagedCommunities>
        >
    with $FutureModifier<PagedCommunities>, $FutureProvider<PagedCommunities> {
  /// A live search over communities (debounced by the page). Empty query → empty.
  CommunitySearchProvider._({
    required CommunitySearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communitySearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communitySearchHash();

  @override
  String toString() {
    return r'communitySearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PagedCommunities> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PagedCommunities> create(Ref ref) {
    final argument = this.argument as String;
    return communitySearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunitySearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communitySearchHash() => r'd31ab7054e37b85a45d9e0bbd5ee26cdf1c66878';

/// A live search over communities (debounced by the page). Empty query → empty.

final class CommunitySearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PagedCommunities>, String> {
  CommunitySearchFamily._()
    : super(
        retry: null,
        name: r'communitySearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A live search over communities (debounced by the page). Empty query → empty.

  CommunitySearchProvider call(String query) =>
      CommunitySearchProvider._(argument: query, from: this);

  @override
  String toString() => r'communitySearchProvider';
}

/// Communities the acting pet has joined (the "My Communities" rail).

@ProviderFor(myCommunities)
final myCommunitiesProvider = MyCommunitiesProvider._();

/// Communities the acting pet has joined (the "My Communities" rail).

final class MyCommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommunityGroup>>,
          List<CommunityGroup>,
          FutureOr<List<CommunityGroup>>
        >
    with
        $FutureModifier<List<CommunityGroup>>,
        $FutureProvider<List<CommunityGroup>> {
  /// Communities the acting pet has joined (the "My Communities" rail).
  MyCommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myCommunitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myCommunitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<CommunityGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommunityGroup>> create(Ref ref) {
    return myCommunities(ref);
  }
}

String _$myCommunitiesHash() => r'd555664e6e7a66f4fed542308b4abd91eff8a885';

/// Communities to join, for the Discover-tab rail.

@ProviderFor(suggestedCommunities)
final suggestedCommunitiesProvider = SuggestedCommunitiesProvider._();

/// Communities to join, for the Discover-tab rail.

final class SuggestedCommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommunityGroup>>,
          List<CommunityGroup>,
          FutureOr<List<CommunityGroup>>
        >
    with
        $FutureModifier<List<CommunityGroup>>,
        $FutureProvider<List<CommunityGroup>> {
  /// Communities to join, for the Discover-tab rail.
  SuggestedCommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'suggestedCommunitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$suggestedCommunitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<CommunityGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommunityGroup>> create(Ref ref) {
    return suggestedCommunities(ref);
  }
}

String _$suggestedCommunitiesHash() =>
    r'3ca4d5563b8ed849487fa057f531e11a4bb52399';

/// A single community's header/profile. Family-keyed by id.

@ProviderFor(CommunityDetail)
final communityDetailProvider = CommunityDetailFamily._();

/// A single community's header/profile. Family-keyed by id.
final class CommunityDetailProvider
    extends $AsyncNotifierProvider<CommunityDetail, CommunityGroup> {
  /// A single community's header/profile. Family-keyed by id.
  CommunityDetailProvider._({
    required CommunityDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'communityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityDetailHash();

  @override
  String toString() {
    return r'communityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityDetail create() => CommunityDetail();

  @override
  bool operator ==(Object other) {
    return other is CommunityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityDetailHash() => r'bda4abdd2fb188a98d2d9b8ad996b12eab2bf687';

/// A single community's header/profile. Family-keyed by id.

final class CommunityDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityDetail,
          AsyncValue<CommunityGroup>,
          CommunityGroup,
          FutureOr<CommunityGroup>,
          int
        > {
  CommunityDetailFamily._()
    : super(
        retry: null,
        name: r'communityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single community's header/profile. Family-keyed by id.

  CommunityDetailProvider call(int communityId) =>
      CommunityDetailProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityDetailProvider';
}

/// A single community's header/profile. Family-keyed by id.

abstract class _$CommunityDetail extends $AsyncNotifier<CommunityGroup> {
  late final _$args = ref.$arg as int;
  int get communityId => _$args;

  FutureOr<CommunityGroup> build(int communityId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CommunityGroup>, CommunityGroup>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommunityGroup>, CommunityGroup>,
              AsyncValue<CommunityGroup>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// A community's post feed. Reuses [PagedFeed] (same shape as every other
/// feed), so [PostCard] and the feed-list machinery render it unchanged.

@ProviderFor(CommunityFeed)
final communityFeedProvider = CommunityFeedFamily._();

/// A community's post feed. Reuses [PagedFeed] (same shape as every other
/// feed), so [PostCard] and the feed-list machinery render it unchanged.
final class CommunityFeedProvider
    extends $AsyncNotifierProvider<CommunityFeed, PagedFeed> {
  /// A community's post feed. Reuses [PagedFeed] (same shape as every other
  /// feed), so [PostCard] and the feed-list machinery render it unchanged.
  CommunityFeedProvider._({
    required CommunityFeedFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'communityFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityFeedHash();

  @override
  String toString() {
    return r'communityFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityFeed create() => CommunityFeed();

  @override
  bool operator ==(Object other) {
    return other is CommunityFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityFeedHash() => r'51ab4b5b8502593d26f59cab2af37abac28fc1df';

/// A community's post feed. Reuses [PagedFeed] (same shape as every other
/// feed), so [PostCard] and the feed-list machinery render it unchanged.

final class CommunityFeedFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityFeed,
          AsyncValue<PagedFeed>,
          PagedFeed,
          FutureOr<PagedFeed>,
          int
        > {
  CommunityFeedFamily._()
    : super(
        retry: null,
        name: r'communityFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A community's post feed. Reuses [PagedFeed] (same shape as every other
  /// feed), so [PostCard] and the feed-list machinery render it unchanged.

  CommunityFeedProvider call(int communityId) =>
      CommunityFeedProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityFeedProvider';
}

/// A community's post feed. Reuses [PagedFeed] (same shape as every other
/// feed), so [PostCard] and the feed-list machinery render it unchanged.

abstract class _$CommunityFeed extends $AsyncNotifier<PagedFeed> {
  late final _$args = ref.$arg as int;
  int get communityId => _$args;

  FutureOr<PagedFeed> build(int communityId);
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

/// A community's members list. Family-keyed by id. Throws on failure so the
/// dedicated members page can show an error state with retry.

@ProviderFor(communityMembers)
final communityMembersProvider = CommunityMembersFamily._();

/// A community's members list. Family-keyed by id. Throws on failure so the
/// dedicated members page can show an error state with retry.

final class CommunityMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<CommunityMemberPage>,
          CommunityMemberPage,
          FutureOr<CommunityMemberPage>
        >
    with
        $FutureModifier<CommunityMemberPage>,
        $FutureProvider<CommunityMemberPage> {
  /// A community's members list. Family-keyed by id. Throws on failure so the
  /// dedicated members page can show an error state with retry.
  CommunityMembersProvider._({
    required CommunityMembersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'communityMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityMembersHash();

  @override
  String toString() {
    return r'communityMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CommunityMemberPage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CommunityMemberPage> create(Ref ref) {
    final argument = this.argument as int;
    return communityMembers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityMembersHash() => r'e6aaa8ace2ea37e56bca3ec7f1e9dd2483ba9463';

/// A community's members list. Family-keyed by id. Throws on failure so the
/// dedicated members page can show an error state with retry.

final class CommunityMembersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CommunityMemberPage>, int> {
  CommunityMembersFamily._()
    : super(
        retry: null,
        name: r'communityMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A community's members list. Family-keyed by id. Throws on failure so the
  /// dedicated members page can show an error state with retry.

  CommunityMembersProvider call(int communityId) =>
      CommunityMembersProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityMembersProvider';
}

/// A non-throwing members preview for the detail-page card: returns null on
/// failure instead of throwing, so a failing members endpoint degrades to a
/// header-only card rather than storming the API with Riverpod's auto-retry.

@ProviderFor(communityMemberPreview)
final communityMemberPreviewProvider = CommunityMemberPreviewFamily._();

/// A non-throwing members preview for the detail-page card: returns null on
/// failure instead of throwing, so a failing members endpoint degrades to a
/// header-only card rather than storming the API with Riverpod's auto-retry.

final class CommunityMemberPreviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<CommunityMemberPage?>,
          CommunityMemberPage?,
          FutureOr<CommunityMemberPage?>
        >
    with
        $FutureModifier<CommunityMemberPage?>,
        $FutureProvider<CommunityMemberPage?> {
  /// A non-throwing members preview for the detail-page card: returns null on
  /// failure instead of throwing, so a failing members endpoint degrades to a
  /// header-only card rather than storming the API with Riverpod's auto-retry.
  CommunityMemberPreviewProvider._({
    required CommunityMemberPreviewFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'communityMemberPreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityMemberPreviewHash();

  @override
  String toString() {
    return r'communityMemberPreviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CommunityMemberPage?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CommunityMemberPage?> create(Ref ref) {
    final argument = this.argument as int;
    return communityMemberPreview(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityMemberPreviewProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityMemberPreviewHash() =>
    r'ca9811ee74f9113fcfc61a18575dbe28036acba3';

/// A non-throwing members preview for the detail-page card: returns null on
/// failure instead of throwing, so a failing members endpoint degrades to a
/// header-only card rather than storming the API with Riverpod's auto-retry.

final class CommunityMemberPreviewFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CommunityMemberPage?>, int> {
  CommunityMemberPreviewFamily._()
    : super(
        retry: null,
        name: r'communityMemberPreviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A non-throwing members preview for the detail-page card: returns null on
  /// failure instead of throwing, so a failing members endpoint degrades to a
  /// header-only card rather than storming the API with Riverpod's auto-retry.

  CommunityMemberPreviewProvider call(int communityId) =>
      CommunityMemberPreviewProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityMemberPreviewProvider';
}
