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
    r'49c4babf5d662b952c5a70f0e635ebdffa35626d';

/// The admin-configurable category list (id ↔ slug ↔ name), backing the filter
/// bar. Loaded once; widgets map each row to a client [ProviderCategory].

@ProviderFor(providerCategories)
final providerCategoriesProvider = ProviderCategoriesProvider._();

/// The admin-configurable category list (id ↔ slug ↔ name), backing the filter
/// bar. Loaded once; widgets map each row to a client [ProviderCategory].

final class ProviderCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProviderCategoryRef>>,
          List<ProviderCategoryRef>,
          FutureOr<List<ProviderCategoryRef>>
        >
    with
        $FutureModifier<List<ProviderCategoryRef>>,
        $FutureProvider<List<ProviderCategoryRef>> {
  /// The admin-configurable category list (id ↔ slug ↔ name), backing the filter
  /// bar. Loaded once; widgets map each row to a client [ProviderCategory].
  ProviderCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<ProviderCategoryRef>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProviderCategoryRef>> create(Ref ref) {
    return providerCategories(ref);
  }
}

String _$providerCategoriesHash() =>
    r'f557f36ae201ff032cf98a70c796d66b73bd180e';

/// The device's current location, resolved once in the background. Null until
/// (or unless) it lands - the search runs against the viewport regardless, and
/// distance is simply omitted when this is null.

@ProviderFor(ProviderUserLocation)
final providerUserLocationProvider = ProviderUserLocationProvider._();

/// The device's current location, resolved once in the background. Null until
/// (or unless) it lands - the search runs against the viewport regardless, and
/// distance is simply omitted when this is null.
final class ProviderUserLocationProvider
    extends $NotifierProvider<ProviderUserLocation, LatLng?> {
  /// The device's current location, resolved once in the background. Null until
  /// (or unless) it lands - the search runs against the viewport regardless, and
  /// distance is simply omitted when this is null.
  ProviderUserLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerUserLocationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerUserLocationHash();

  @$internal
  @override
  ProviderUserLocation create() => ProviderUserLocation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LatLng? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LatLng?>(value),
    );
  }
}

String _$providerUserLocationHash() =>
    r'f20cee0a81697c1e17bfb01780545de0892afe4b';

/// The device's current location, resolved once in the background. Null until
/// (or unless) it lands - the search runs against the viewport regardless, and
/// distance is simply omitted when this is null.

abstract class _$ProviderUserLocation extends $Notifier<LatLng?> {
  LatLng? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LatLng?, LatLng?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LatLng?, LatLng?>,
              LatLng?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The visible map bounding box, updated when the camera settles after a pan.
/// Null until the map reports its first viewport; the search waits for it.

@ProviderFor(ProviderViewport)
final providerViewportProvider = ProviderViewportProvider._();

/// The visible map bounding box, updated when the camera settles after a pan.
/// Null until the map reports its first viewport; the search waits for it.
final class ProviderViewportProvider
    extends $NotifierProvider<ProviderViewport, GeoBounds?> {
  /// The visible map bounding box, updated when the camera settles after a pan.
  /// Null until the map reports its first viewport; the search waits for it.
  ProviderViewportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerViewportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerViewportHash();

  @$internal
  @override
  ProviderViewport create() => ProviderViewport();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeoBounds? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeoBounds?>(value),
    );
  }
}

String _$providerViewportHash() => r'ebce9966eb2ccb8e43d3b47d93045864468e64a6';

/// The visible map bounding box, updated when the camera settles after a pan.
/// Null until the map reports its first viewport; the search waits for it.

abstract class _$ProviderViewport extends $Notifier<GeoBounds?> {
  GeoBounds? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<GeoBounds?, GeoBounds?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GeoBounds?, GeoBounds?>,
              GeoBounds?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Selected category filter (single-select). [ProviderCategory.all] = no filter.

@ProviderFor(ProviderCategoryFilter)
final providerCategoryFilterProvider = ProviderCategoryFilterProvider._();

/// Selected category filter (single-select). [ProviderCategory.all] = no filter.
final class ProviderCategoryFilterProvider
    extends $NotifierProvider<ProviderCategoryFilter, ProviderCategory> {
  /// Selected category filter (single-select). [ProviderCategory.all] = no filter.
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

/// Selected category filter (single-select). [ProviderCategory.all] = no filter.

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

/// Debounced search query. The text field debounces before writing here.

@ProviderFor(ProviderSearchQuery)
final providerSearchQueryProvider = ProviderSearchQueryProvider._();

/// Debounced search query. The text field debounces before writing here.
final class ProviderSearchQueryProvider
    extends $NotifierProvider<ProviderSearchQuery, String> {
  /// Debounced search query. The text field debounces before writing here.
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

/// Debounced search query. The text field debounces before writing here.

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

/// Active sort order for the search.

@ProviderFor(ProviderSortOrder)
final providerSortOrderProvider = ProviderSortOrderProvider._();

/// Active sort order for the search.
final class ProviderSortOrderProvider
    extends $NotifierProvider<ProviderSortOrder, ProviderSort> {
  /// Active sort order for the search.
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

/// Active sort order for the search.

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

/// "Open now" toggle for the search.

@ProviderFor(ProviderOpenNowFilter)
final providerOpenNowFilterProvider = ProviderOpenNowFilterProvider._();

/// "Open now" toggle for the search.
final class ProviderOpenNowFilterProvider
    extends $NotifierProvider<ProviderOpenNowFilter, bool> {
  /// "Open now" toggle for the search.
  ProviderOpenNowFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerOpenNowFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerOpenNowFilterHash();

  @$internal
  @override
  ProviderOpenNowFilter create() => ProviderOpenNowFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$providerOpenNowFilterHash() =>
    r'6d1f688acecaefa6d03307a45760495551f16ec6';

/// "Open now" toggle for the search.

abstract class _$ProviderOpenNowFilter extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Whether results are tailored to the active pet's species ("For [Pet]" vs
/// "All"). Defaults on when the user has an active pet.

@ProviderFor(ProviderPetTailoring)
final providerPetTailoringProvider = ProviderPetTailoringProvider._();

/// Whether results are tailored to the active pet's species ("For [Pet]" vs
/// "All"). Defaults on when the user has an active pet.
final class ProviderPetTailoringProvider
    extends $NotifierProvider<ProviderPetTailoring, bool> {
  /// Whether results are tailored to the active pet's species ("For [Pet]" vs
  /// "All"). Defaults on when the user has an active pet.
  ProviderPetTailoringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerPetTailoringProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerPetTailoringHash();

  @$internal
  @override
  ProviderPetTailoring create() => ProviderPetTailoring();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$providerPetTailoringHash() =>
    r'd72a4b181ef4d79dfd1c485b3c8d7229aa745169';

/// Whether results are tailored to the active pet's species ("For [Pet]" vs
/// "All"). Defaults on when the user has an active pet.

abstract class _$ProviderPetTailoring extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The active pet id to send for tailoring, or null when tailoring is off / no
/// pet is selected.

@ProviderFor(providerTailoringPetId)
final providerTailoringPetIdProvider = ProviderTailoringPetIdProvider._();

/// The active pet id to send for tailoring, or null when tailoring is off / no
/// pet is selected.

final class ProviderTailoringPetIdProvider
    extends $FunctionalProvider<int?, int?, int?>
    with $Provider<int?> {
  /// The active pet id to send for tailoring, or null when tailoring is off / no
  /// pet is selected.
  ProviderTailoringPetIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerTailoringPetIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerTailoringPetIdHash();

  @$internal
  @override
  $ProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int? create(Ref ref) {
    return providerTailoringPetId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$providerTailoringPetIdHash() =>
    r'cb6d29ba01fff5d3f362e8f4ffa4d9473a5b5ac6';

/// The currently highlighted branch pin (tapped pin or card), keyed by
/// `branchId`, or null. Drives pin highlight + the map camera fly-to. Separate
/// from the search so selecting never refetches.

@ProviderFor(SelectedProvider)
final selectedProviderProvider = SelectedProviderProvider._();

/// The currently highlighted branch pin (tapped pin or card), keyed by
/// `branchId`, or null. Drives pin highlight + the map camera fly-to. Separate
/// from the search so selecting never refetches.
final class SelectedProviderProvider
    extends $NotifierProvider<SelectedProvider, int?> {
  /// The currently highlighted branch pin (tapped pin or card), keyed by
  /// `branchId`, or null. Drives pin highlight + the map camera fly-to. Separate
  /// from the search so selecting never refetches.
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
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$selectedProviderHash() => r'3be33655417fc58a5f1bc020090394f081e7a8fc';

/// The currently highlighted branch pin (tapped pin or card), keyed by
/// `branchId`, or null. Drives pin highlight + the map camera fly-to. Separate
/// from the search so selecting never refetches.

abstract class _$SelectedProvider extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Runs the viewport search and re-runs whenever the viewport or any filter
/// changes. Debounced so a fast pan/typing burst issues one request once things
/// settle. Returns the full result (items + paging guardrails).

@ProviderFor(ServiceProvidersNotifier)
final serviceProvidersProvider = ServiceProvidersNotifierProvider._();

/// Runs the viewport search and re-runs whenever the viewport or any filter
/// changes. Debounced so a fast pan/typing burst issues one request once things
/// settle. Returns the full result (items + paging guardrails).
final class ServiceProvidersNotifierProvider
    extends
        $AsyncNotifierProvider<ServiceProvidersNotifier, ProviderSearchResult> {
  /// Runs the viewport search and re-runs whenever the viewport or any filter
  /// changes. Debounced so a fast pan/typing burst issues one request once things
  /// settle. Returns the full result (items + paging guardrails).
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
    r'45a801b686d2d9861acab09e7e89c19caa6d37f4';

/// Runs the viewport search and re-runs whenever the viewport or any filter
/// changes. Debounced so a fast pan/typing burst issues one request once things
/// settle. Returns the full result (items + paging guardrails).

abstract class _$ServiceProvidersNotifier
    extends $AsyncNotifier<ProviderSearchResult> {
  FutureOr<ProviderSearchResult> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ProviderSearchResult>, ProviderSearchResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ProviderSearchResult>,
                ProviderSearchResult
              >,
              AsyncValue<ProviderSearchResult>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Caches provider pins across viewport changes. Since the API returns results
/// for the current viewport (bbox), panning can cause pins to appear/disappear.
/// This notifier keeps a union of all pins ever fetched and reconciles with new
/// API results (added/removed/updated). Prevents flickering when zooming in/out.
///
/// Reconciliation is driven by listening to [serviceProvidersProvider] rather
/// than by a derived provider writing here during its build - Riverpod forbids
/// one provider mutating another mid-build.

@ProviderFor(ProviderPinCache)
final providerPinCacheProvider = ProviderPinCacheProvider._();

/// Caches provider pins across viewport changes. Since the API returns results
/// for the current viewport (bbox), panning can cause pins to appear/disappear.
/// This notifier keeps a union of all pins ever fetched and reconciles with new
/// API results (added/removed/updated). Prevents flickering when zooming in/out.
///
/// Reconciliation is driven by listening to [serviceProvidersProvider] rather
/// than by a derived provider writing here during its build - Riverpod forbids
/// one provider mutating another mid-build.
final class ProviderPinCacheProvider
    extends $NotifierProvider<ProviderPinCache, Map<int, ServiceProvider>> {
  /// Caches provider pins across viewport changes. Since the API returns results
  /// for the current viewport (bbox), panning can cause pins to appear/disappear.
  /// This notifier keeps a union of all pins ever fetched and reconciles with new
  /// API results (added/removed/updated). Prevents flickering when zooming in/out.
  ///
  /// Reconciliation is driven by listening to [serviceProvidersProvider] rather
  /// than by a derived provider writing here during its build - Riverpod forbids
  /// one provider mutating another mid-build.
  ProviderPinCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerPinCacheProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerPinCacheHash();

  @$internal
  @override
  ProviderPinCache create() => ProviderPinCache();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, ServiceProvider> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, ServiceProvider>>(value),
    );
  }
}

String _$providerPinCacheHash() => r'004fdb62f4b097bdd158b407175c9f7f25f04b76';

/// Caches provider pins across viewport changes. Since the API returns results
/// for the current viewport (bbox), panning can cause pins to appear/disappear.
/// This notifier keeps a union of all pins ever fetched and reconciles with new
/// API results (added/removed/updated). Prevents flickering when zooming in/out.
///
/// Reconciliation is driven by listening to [serviceProvidersProvider] rather
/// than by a derived provider writing here during its build - Riverpod forbids
/// one provider mutating another mid-build.

abstract class _$ProviderPinCache extends $Notifier<Map<int, ServiceProvider>> {
  Map<int, ServiceProvider> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<int, ServiceProvider>, Map<int, ServiceProvider>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, ServiceProvider>, Map<int, ServiceProvider>>,
              Map<int, ServiceProvider>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The branch pins actually shown (map + list). A pure derivation of the pin
/// cache and the current selection - the selected pin floats to the top.

@ProviderFor(visibleProviders)
final visibleProvidersProvider = VisibleProvidersProvider._();

/// The branch pins actually shown (map + list). A pure derivation of the pin
/// cache and the current selection - the selected pin floats to the top.

final class VisibleProvidersProvider
    extends
        $FunctionalProvider<
          List<ServiceProvider>,
          List<ServiceProvider>,
          List<ServiceProvider>
        >
    with $Provider<List<ServiceProvider>> {
  /// The branch pins actually shown (map + list). A pure derivation of the pin
  /// cache and the current selection - the selected pin floats to the top.
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

String _$visibleProvidersHash() => r'27334949c9ce57735d7d1381fc4ac4928d49c7cf';
