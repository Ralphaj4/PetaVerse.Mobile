// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(serviceProviderRepository)
final serviceProviderRepositoryProvider = ServiceProviderRepositoryProvider._();

final class ServiceProviderRepositoryProvider
    extends
        $FunctionalProvider<
          ServiceProviderRepository,
          ServiceProviderRepository,
          ServiceProviderRepository
        >
    with $Provider<ServiceProviderRepository> {
  ServiceProviderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceProviderRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceProviderRepositoryHash();

  @$internal
  @override
  $ProviderElement<ServiceProviderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ServiceProviderRepository create(Ref ref) {
    return serviceProviderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceProviderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceProviderRepository>(value),
    );
  }
}

String _$serviceProviderRepositoryHash() =>
    r'91a8ea953c75cbdd1fc6363023ab8884845a97ef';

/// The map center used to query providers.
///
/// Synchronous by design: it starts at the app default center immediately so
/// the provider list can load without EVER waiting on location (a stalled
/// permission dialog or a device with no fix must not be able to hang the
/// list in its shimmer state). A background one-shot location read then
/// refines the center when it arrives, which re-runs the query for the user's
/// real position. Not changed as the user pans — panning re-sorts the loaded
/// set client-side (see [visibleProviders]).

@ProviderFor(ProviderQueryCenter)
final providerQueryCenterProvider = ProviderQueryCenterProvider._();

/// The map center used to query providers.
///
/// Synchronous by design: it starts at the app default center immediately so
/// the provider list can load without EVER waiting on location (a stalled
/// permission dialog or a device with no fix must not be able to hang the
/// list in its shimmer state). A background one-shot location read then
/// refines the center when it arrives, which re-runs the query for the user's
/// real position. Not changed as the user pans — panning re-sorts the loaded
/// set client-side (see [visibleProviders]).
final class ProviderQueryCenterProvider
    extends $NotifierProvider<ProviderQueryCenter, LatLng> {
  /// The map center used to query providers.
  ///
  /// Synchronous by design: it starts at the app default center immediately so
  /// the provider list can load without EVER waiting on location (a stalled
  /// permission dialog or a device with no fix must not be able to hang the
  /// list in its shimmer state). A background one-shot location read then
  /// refines the center when it arrives, which re-runs the query for the user's
  /// real position. Not changed as the user pans — panning re-sorts the loaded
  /// set client-side (see [visibleProviders]).
  ProviderQueryCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerQueryCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerQueryCenterHash();

  @$internal
  @override
  ProviderQueryCenter create() => ProviderQueryCenter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LatLng value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LatLng>(value),
    );
  }
}

String _$providerQueryCenterHash() =>
    r'033594bd057987b95ee5b1a616e57d95fe8bedf7';

/// The map center used to query providers.
///
/// Synchronous by design: it starts at the app default center immediately so
/// the provider list can load without EVER waiting on location (a stalled
/// permission dialog or a device with no fix must not be able to hang the
/// list in its shimmer state). A background one-shot location read then
/// refines the center when it arrives, which re-runs the query for the user's
/// real position. Not changed as the user pans — panning re-sorts the loaded
/// set client-side (see [visibleProviders]).

abstract class _$ProviderQueryCenter extends $Notifier<LatLng> {
  LatLng build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LatLng, LatLng>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LatLng, LatLng>,
              LatLng,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Loads nearby providers for the current query center. Re-runs if the center
/// changes (e.g. once the real location resolves). Carries the full unfiltered
/// set; filtering/search/sort are applied downstream in [visibleProviders] so
/// those never trigger a refetch.

@ProviderFor(ServiceProvidersNotifier)
final serviceProvidersProvider = ServiceProvidersNotifierProvider._();

/// Loads nearby providers for the current query center. Re-runs if the center
/// changes (e.g. once the real location resolves). Carries the full unfiltered
/// set; filtering/search/sort are applied downstream in [visibleProviders] so
/// those never trigger a refetch.
final class ServiceProvidersNotifierProvider
    extends
        $AsyncNotifierProvider<
          ServiceProvidersNotifier,
          List<ServiceProvider>
        > {
  /// Loads nearby providers for the current query center. Re-runs if the center
  /// changes (e.g. once the real location resolves). Carries the full unfiltered
  /// set; filtering/search/sort are applied downstream in [visibleProviders] so
  /// those never trigger a refetch.
  ServiceProvidersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceProvidersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceProvidersNotifierHash();

  @$internal
  @override
  ServiceProvidersNotifier create() => ServiceProvidersNotifier();
}

String _$serviceProvidersNotifierHash() =>
    r'f73da3fa26d9220a7b505b7a2b3ecabe15f1547a';

/// Loads nearby providers for the current query center. Re-runs if the center
/// changes (e.g. once the real location resolves). Carries the full unfiltered
/// set; filtering/search/sort are applied downstream in [visibleProviders] so
/// those never trigger a refetch.

abstract class _$ServiceProvidersNotifier
    extends $AsyncNotifier<List<ServiceProvider>> {
  FutureOr<List<ServiceProvider>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ServiceProvider>>, List<ServiceProvider>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ServiceProvider>>,
                List<ServiceProvider>
              >,
              AsyncValue<List<ServiceProvider>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Selected category filter (single-select). [ProviderCategory.all] shows all.

@ProviderFor(ProviderCategoryFilter)
final providerCategoryFilterProvider = ProviderCategoryFilterProvider._();

/// Selected category filter (single-select). [ProviderCategory.all] shows all.
final class ProviderCategoryFilterProvider
    extends $NotifierProvider<ProviderCategoryFilter, ProviderCategory> {
  /// Selected category filter (single-select). [ProviderCategory.all] shows all.
  ProviderCategoryFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerCategoryFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerCategoryFilterHash();

  @$internal
  @override
  ProviderCategoryFilter create() => ProviderCategoryFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProviderCategory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProviderCategory>(value),
    );
  }
}

String _$providerCategoryFilterHash() =>
    r'1edb833f6564011168746a9bd4b1879302118fa1';

/// Selected category filter (single-select). [ProviderCategory.all] shows all.

abstract class _$ProviderCategoryFilter extends $Notifier<ProviderCategory> {
  ProviderCategory build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProviderCategory, ProviderCategory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProviderCategory, ProviderCategory>,
              ProviderCategory,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Debounced search query (business name / category / address). The text field
/// debounces before writing here, so this never churns on every keystroke.

@ProviderFor(ProviderSearchQuery)
final providerSearchQueryProvider = ProviderSearchQueryProvider._();

/// Debounced search query (business name / category / address). The text field
/// debounces before writing here, so this never churns on every keystroke.
final class ProviderSearchQueryProvider
    extends $NotifierProvider<ProviderSearchQuery, String> {
  /// Debounced search query (business name / category / address). The text field
  /// debounces before writing here, so this never churns on every keystroke.
  ProviderSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerSearchQueryHash();

  @$internal
  @override
  ProviderSearchQuery create() => ProviderSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$providerSearchQueryHash() =>
    r'494192aedc83936d5d686128355ac450290407ca';

/// Debounced search query (business name / category / address). The text field
/// debounces before writing here, so this never churns on every keystroke.

abstract class _$ProviderSearchQuery extends $Notifier<String> {
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

/// Active sort order for the list.

@ProviderFor(ProviderSortOrder)
final providerSortOrderProvider = ProviderSortOrderProvider._();

/// Active sort order for the list.
final class ProviderSortOrderProvider
    extends $NotifierProvider<ProviderSortOrder, ProviderSort> {
  /// Active sort order for the list.
  ProviderSortOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerSortOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerSortOrderHash();

  @$internal
  @override
  ProviderSortOrder create() => ProviderSortOrder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProviderSort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProviderSort>(value),
    );
  }
}

String _$providerSortOrderHash() => r'c6d78791438469b555bf31cbd5fed76972827157';

/// Active sort order for the list.

abstract class _$ProviderSortOrder extends $Notifier<ProviderSort> {
  ProviderSort build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ProviderSort, ProviderSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProviderSort, ProviderSort>,
              ProviderSort,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The currently highlighted provider id (tapped pin or card), or null. Drives
/// pin highlight + the map camera fly-to. Kept separate from the list so
/// selecting never rebuilds the (expensive) list computation.

@ProviderFor(SelectedProvider)
final selectedProviderProvider = SelectedProviderProvider._();

/// The currently highlighted provider id (tapped pin or card), or null. Drives
/// pin highlight + the map camera fly-to. Kept separate from the list so
/// selecting never rebuilds the (expensive) list computation.
final class SelectedProviderProvider
    extends $NotifierProvider<SelectedProvider, String?> {
  /// The currently highlighted provider id (tapped pin or card), or null. Drives
  /// pin highlight + the map camera fly-to. Kept separate from the list so
  /// selecting never rebuilds the (expensive) list computation.
  SelectedProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedProviderHash();

  @$internal
  @override
  SelectedProvider create() => SelectedProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedProviderHash() => r'c5f57918264b08b5ca01f19af5080eff63103e7b';

/// The currently highlighted provider id (tapped pin or card), or null. Drives
/// pin highlight + the map camera fly-to. Kept separate from the list so
/// selecting never rebuilds the (expensive) list computation.

abstract class _$SelectedProvider extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The list actually shown in the sheet and as pins: the loaded set with the
/// category filter, search query, and sort order applied. Recomputes only when
/// one of those inputs changes (not on selection), so highlighting a pin is
/// cheap.

@ProviderFor(visibleProviders)
final visibleProvidersProvider = VisibleProvidersProvider._();

/// The list actually shown in the sheet and as pins: the loaded set with the
/// category filter, search query, and sort order applied. Recomputes only when
/// one of those inputs changes (not on selection), so highlighting a pin is
/// cheap.

final class VisibleProvidersProvider
    extends
        $FunctionalProvider<
          List<ServiceProvider>,
          List<ServiceProvider>,
          List<ServiceProvider>
        >
    with $Provider<List<ServiceProvider>> {
  /// The list actually shown in the sheet and as pins: the loaded set with the
  /// category filter, search query, and sort order applied. Recomputes only when
  /// one of those inputs changes (not on selection), so highlighting a pin is
  /// cheap.
  VisibleProvidersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visibleProvidersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visibleProvidersHash();

  @$internal
  @override
  $ProviderElement<List<ServiceProvider>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ServiceProvider> create(Ref ref) {
    return visibleProviders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ServiceProvider> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ServiceProvider>>(value),
    );
  }
}

String _$visibleProvidersHash() => r'019bf6a93c4c2e8ecca554ef903b514815735b6f';
