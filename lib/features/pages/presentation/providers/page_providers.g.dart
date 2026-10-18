// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The pages repository, wired to the shared [ApiClient].

@ProviderFor(pageRepository)
final pageRepositoryProvider = PageRepositoryProvider._();

/// The pages repository, wired to the shared [ApiClient].

final class PageRepositoryProvider
    extends $FunctionalProvider<PageRepository, PageRepository, PageRepository>
    with $Provider<PageRepository> {
  /// The pages repository, wired to the shared [ApiClient].
  PageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pageRepositoryHash();

  @$internal
  @override
  $ProviderElement<PageRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PageRepository create(Ref ref) {
    return pageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PageRepository>(value),
    );
  }
}

String _$pageRepositoryHash() => r'07549d15ef35472c91f2311d3db8b57d41ababb3';

/// Loads a page's full profile by id.

@ProviderFor(pageProfile)
final pageProfileProvider = PageProfileFamily._();

/// Loads a page's full profile by id.

final class PageProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<PageProfile>,
          PageProfile,
          FutureOr<PageProfile>
        >
    with $FutureModifier<PageProfile>, $FutureProvider<PageProfile> {
  /// Loads a page's full profile by id.
  PageProfileProvider._({
    required PageProfileFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pageProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pageProfileHash();

  @override
  String toString() {
    return r'pageProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PageProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PageProfile> create(Ref ref) {
    final argument = this.argument as int;
    return pageProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PageProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pageProfileHash() => r'da7f8c8b78c39a4526a40bfb63b153abad07ad3a';

/// Loads a page's full profile by id.

final class PageProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PageProfile>, int> {
  PageProfileFamily._()
    : super(
        retry: null,
        name: r'pageProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Loads a page's full profile by id.

  PageProfileProvider call(int pageId) =>
      PageProfileProvider._(argument: pageId, from: this);

  @override
  String toString() => r'pageProfileProvider';
}

/// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].

@ProviderFor(PageFeed)
final pageFeedProvider = PageFeedFamily._();

/// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].
final class PageFeedProvider
    extends $AsyncNotifierProvider<PageFeed, PageFeedState> {
  /// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].
  PageFeedProvider._({
    required PageFeedFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pageFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pageFeedHash();

  @override
  String toString() {
    return r'pageFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PageFeed create() => PageFeed();

  @override
  bool operator ==(Object other) {
    return other is PageFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pageFeedHash() => r'3e6855f3fcbff208ab984a0e6775a360d506cc90';

/// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].

final class PageFeedFamily extends $Family
    with
        $ClassFamilyOverride<
          PageFeed,
          AsyncValue<PageFeedState>,
          PageFeedState,
          FutureOr<PageFeedState>,
          int
        > {
  PageFeedFamily._()
    : super(
        retry: null,
        name: r'pageFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].

  PageFeedProvider call(int pageId) =>
      PageFeedProvider._(argument: pageId, from: this);

  @override
  String toString() => r'pageFeedProvider';
}

/// Paginated feed for a page. Supports infinite scroll via [PageFeedNotifier.loadMore].

abstract class _$PageFeed extends $AsyncNotifier<PageFeedState> {
  late final _$args = ref.$arg as int;
  int get pageId => _$args;

  FutureOr<PageFeedState> build(int pageId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PageFeedState>, PageFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PageFeedState>, PageFeedState>,
              AsyncValue<PageFeedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Follow / unfollow a page. Invalidates [pageProfileProvider] so the header
/// updates immediately.

@ProviderFor(pageFollowActions)
final pageFollowActionsProvider = PageFollowActionsProvider._();

/// Follow / unfollow a page. Invalidates [pageProfileProvider] so the header
/// updates immediately.

final class PageFollowActionsProvider
    extends
        $FunctionalProvider<
          PageFollowActions,
          PageFollowActions,
          PageFollowActions
        >
    with $Provider<PageFollowActions> {
  /// Follow / unfollow a page. Invalidates [pageProfileProvider] so the header
  /// updates immediately.
  PageFollowActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pageFollowActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pageFollowActionsHash();

  @$internal
  @override
  $ProviderElement<PageFollowActions> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PageFollowActions create(Ref ref) {
    return pageFollowActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PageFollowActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PageFollowActions>(value),
    );
  }
}

String _$pageFollowActionsHash() => r'ac331a5085442ea44ba898e1dcf629a8e17e372a';
