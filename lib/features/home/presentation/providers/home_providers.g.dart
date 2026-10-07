// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeSummaryCache)
final homeSummaryCacheProvider = HomeSummaryCacheProvider._();

final class HomeSummaryCacheProvider
    extends
        $FunctionalProvider<
          HomeLocalDataSource,
          HomeLocalDataSource,
          HomeLocalDataSource
        >
    with $Provider<HomeLocalDataSource> {
  HomeSummaryCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSummaryCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSummaryCacheHash();

  @$internal
  @override
  $ProviderElement<HomeLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeLocalDataSource create(Ref ref) {
    return homeSummaryCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeLocalDataSource>(value),
    );
  }
}

String _$homeSummaryCacheHash() => r'eb6fafa0d505278130407ba2b2d64ce7463eeeb5';

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository>
    with $Provider<HomeRepository> {
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'd5bc125208cdecea23d1678e756c598a557fd66f';

/// The aggregated home dashboard for the currently-selected pet (cards) plus
/// the cross-pet upcoming timeline. Re-fetches when the active pet changes so
/// the hero + stat cards follow the pet switcher; the timeline is always all
/// pets regardless of selection.
///
/// Offline-first: yields the cached snapshot immediately (instant paint), then
/// the fresh network result to reconcile. The repository also returns cache on
/// a network failure, so an offline refresh keeps the last snapshot rather than
/// erroring.

@ProviderFor(homeSummary)
final homeSummaryProvider = HomeSummaryProvider._();

/// The aggregated home dashboard for the currently-selected pet (cards) plus
/// the cross-pet upcoming timeline. Re-fetches when the active pet changes so
/// the hero + stat cards follow the pet switcher; the timeline is always all
/// pets regardless of selection.
///
/// Offline-first: yields the cached snapshot immediately (instant paint), then
/// the fresh network result to reconcile. The repository also returns cache on
/// a network failure, so an offline refresh keeps the last snapshot rather than
/// erroring.

final class HomeSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeSummary>,
          HomeSummary,
          Stream<HomeSummary>
        >
    with $FutureModifier<HomeSummary>, $StreamProvider<HomeSummary> {
  /// The aggregated home dashboard for the currently-selected pet (cards) plus
  /// the cross-pet upcoming timeline. Re-fetches when the active pet changes so
  /// the hero + stat cards follow the pet switcher; the timeline is always all
  /// pets regardless of selection.
  ///
  /// Offline-first: yields the cached snapshot immediately (instant paint), then
  /// the fresh network result to reconcile. The repository also returns cache on
  /// a network failure, so an offline refresh keeps the last snapshot rather than
  /// erroring.
  HomeSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSummaryHash();

  @$internal
  @override
  $StreamProviderElement<HomeSummary> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<HomeSummary> create(Ref ref) {
    return homeSummary(ref);
  }
}

String _$homeSummaryHash() => r'f144fc09b6d52da170237ec3d98206572fb7d056';
