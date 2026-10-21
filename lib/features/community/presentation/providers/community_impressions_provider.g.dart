// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_impressions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Thin provider over the shared remote datasource, used by the impression
/// tracker so it doesn't have to reach through the repository (impressions are
/// fire-and-forget and don't use the Result/Failure pipeline).

@ProviderFor(communityRemoteDataSource)
final communityRemoteDataSourceProvider = CommunityRemoteDataSourceProvider._();

/// Thin provider over the shared remote datasource, used by the impression
/// tracker so it doesn't have to reach through the repository (impressions are
/// fire-and-forget and don't use the Result/Failure pipeline).

final class CommunityRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CommunityRemoteDataSource,
          CommunityRemoteDataSource,
          CommunityRemoteDataSource
        >
    with $Provider<CommunityRemoteDataSource> {
  /// Thin provider over the shared remote datasource, used by the impression
  /// tracker so it doesn't have to reach through the repository (impressions are
  /// fire-and-forget and don't use the Result/Failure pipeline).
  CommunityRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CommunityRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunityRemoteDataSource create(Ref ref) {
    return communityRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityRemoteDataSource>(value),
    );
  }
}

String _$communityRemoteDataSourceHash() =>
    r'e151ee452f3798d55989d616c3347cdf3af350b9';

/// Debounced, de-duplicated post-impression reporter for the Discover feed.
///
/// Call [record] as a card becomes meaningfully visible. The tracker:
///   * de-dupes per session (a post is reported at most once per surface),
///   * buffers and flushes on a debounce ([_flushDelay]) or when the buffer
///     reaches [_batchThreshold],
///   * caps a batch at [_maxBatch] items (the server caps anyway),
///   * swallows every error - an impression failure must never surface.
///
/// keepAlive so the seen-set survives feed rebuilds (pull-to-refresh, pet
/// switch) within a session; a fresh app launch starts a clean session.

@ProviderFor(ImpressionTracker)
final impressionTrackerProvider = ImpressionTrackerProvider._();

/// Debounced, de-duplicated post-impression reporter for the Discover feed.
///
/// Call [record] as a card becomes meaningfully visible. The tracker:
///   * de-dupes per session (a post is reported at most once per surface),
///   * buffers and flushes on a debounce ([_flushDelay]) or when the buffer
///     reaches [_batchThreshold],
///   * caps a batch at [_maxBatch] items (the server caps anyway),
///   * swallows every error - an impression failure must never surface.
///
/// keepAlive so the seen-set survives feed rebuilds (pull-to-refresh, pet
/// switch) within a session; a fresh app launch starts a clean session.
final class ImpressionTrackerProvider
    extends $NotifierProvider<ImpressionTracker, void> {
  /// Debounced, de-duplicated post-impression reporter for the Discover feed.
  ///
  /// Call [record] as a card becomes meaningfully visible. The tracker:
  ///   * de-dupes per session (a post is reported at most once per surface),
  ///   * buffers and flushes on a debounce ([_flushDelay]) or when the buffer
  ///     reaches [_batchThreshold],
  ///   * caps a batch at [_maxBatch] items (the server caps anyway),
  ///   * swallows every error - an impression failure must never surface.
  ///
  /// keepAlive so the seen-set survives feed rebuilds (pull-to-refresh, pet
  /// switch) within a session; a fresh app launch starts a clean session.
  ImpressionTrackerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'impressionTrackerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$impressionTrackerHash();

  @$internal
  @override
  ImpressionTracker create() => ImpressionTracker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$impressionTrackerHash() => r'a55450233a5a8d075e5c2e39374b758ac26d3fcf';

/// Debounced, de-duplicated post-impression reporter for the Discover feed.
///
/// Call [record] as a card becomes meaningfully visible. The tracker:
///   * de-dupes per session (a post is reported at most once per surface),
///   * buffers and flushes on a debounce ([_flushDelay]) or when the buffer
///     reaches [_batchThreshold],
///   * caps a batch at [_maxBatch] items (the server caps anyway),
///   * swallows every error - an impression failure must never surface.
///
/// keepAlive so the seen-set survives feed rebuilds (pull-to-refresh, pet
/// switch) within a session; a fresh app launch starts a clean session.

abstract class _$ImpressionTracker extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
