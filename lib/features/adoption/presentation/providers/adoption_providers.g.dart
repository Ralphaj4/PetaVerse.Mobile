// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adoptionRepository)
final adoptionRepositoryProvider = AdoptionRepositoryProvider._();

final class AdoptionRepositoryProvider
    extends
        $FunctionalProvider<
          AdoptionRepository,
          AdoptionRepository,
          AdoptionRepository
        >
    with $Provider<AdoptionRepository> {
  AdoptionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adoptionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adoptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdoptionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdoptionRepository create(Ref ref) {
    return adoptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdoptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdoptionRepository>(value),
    );
  }
}

String _$adoptionRepositoryHash() =>
    r'69e4f2f6703c8dad697b254725bd79f1ddc65216';

/// The map center used to scope the board query. Starts at the app default
/// center immediately (so the list never waits on location) and refines in the
/// background when a fix arrives — same pattern as the providers board.

@ProviderFor(AdoptionQueryCenter)
final adoptionQueryCenterProvider = AdoptionQueryCenterProvider._();

/// The map center used to scope the board query. Starts at the app default
/// center immediately (so the list never waits on location) and refines in the
/// background when a fix arrives — same pattern as the providers board.
final class AdoptionQueryCenterProvider
    extends $NotifierProvider<AdoptionQueryCenter, LatLng> {
  /// The map center used to scope the board query. Starts at the app default
  /// center immediately (so the list never waits on location) and refines in the
  /// background when a fix arrives — same pattern as the providers board.
  AdoptionQueryCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adoptionQueryCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adoptionQueryCenterHash();

  @$internal
  @override
  AdoptionQueryCenter create() => AdoptionQueryCenter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LatLng value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LatLng>(value),
    );
  }
}

String _$adoptionQueryCenterHash() =>
    r'd820b353b21ae77f3baf5a08c5758db192d744e3';

/// The map center used to scope the board query. Starts at the app default
/// center immediately (so the list never waits on location) and refines in the
/// background when a fix arrives — same pattern as the providers board.

abstract class _$AdoptionQueryCenter extends $Notifier<LatLng> {
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

/// Selected species filter as a species id, or null for "All". Populated from
/// the shared `/species` lookup (see the create-pet form's speciesListProvider).

@ProviderFor(AdoptionSpeciesFilter)
final adoptionSpeciesFilterProvider = AdoptionSpeciesFilterProvider._();

/// Selected species filter as a species id, or null for "All". Populated from
/// the shared `/species` lookup (see the create-pet form's speciesListProvider).
final class AdoptionSpeciesFilterProvider
    extends $NotifierProvider<AdoptionSpeciesFilter, int?> {
  /// Selected species filter as a species id, or null for "All". Populated from
  /// the shared `/species` lookup (see the create-pet form's speciesListProvider).
  AdoptionSpeciesFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adoptionSpeciesFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adoptionSpeciesFilterHash();

  @$internal
  @override
  AdoptionSpeciesFilter create() => AdoptionSpeciesFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$adoptionSpeciesFilterHash() =>
    r'0239007ecd846fc62a674115483d589157de9c40';

/// Selected species filter as a species id, or null for "All". Populated from
/// the shared `/species` lookup (see the create-pet form's speciesListProvider).

abstract class _$AdoptionSpeciesFilter extends $Notifier<int?> {
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

/// Debounced search query. The text field debounces before writing here, so
/// this never churns on every keystroke.

@ProviderFor(AdoptionSearchQuery)
final adoptionSearchQueryProvider = AdoptionSearchQueryProvider._();

/// Debounced search query. The text field debounces before writing here, so
/// this never churns on every keystroke.
final class AdoptionSearchQueryProvider
    extends $NotifierProvider<AdoptionSearchQuery, String> {
  /// Debounced search query. The text field debounces before writing here, so
  /// this never churns on every keystroke.
  AdoptionSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adoptionSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adoptionSearchQueryHash();

  @$internal
  @override
  AdoptionSearchQuery create() => AdoptionSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$adoptionSearchQueryHash() =>
    r'41a897f44463e172c23174b1a77307735e254df0';

/// Debounced search query. The text field debounces before writing here, so
/// this never churns on every keystroke.

abstract class _$AdoptionSearchQuery extends $Notifier<String> {
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

/// The board: Available listings for the current center, species filter, and
/// search query. The server does the filtering (speciesId + q), so changing a
/// filter re-runs this query. Distance is stamped client-side against the
/// center and the list is sorted nearest-first.

@ProviderFor(AdoptionListingsNotifier)
final adoptionListingsProvider = AdoptionListingsNotifierProvider._();

/// The board: Available listings for the current center, species filter, and
/// search query. The server does the filtering (speciesId + q), so changing a
/// filter re-runs this query. Distance is stamped client-side against the
/// center and the list is sorted nearest-first.
final class AdoptionListingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          AdoptionListingsNotifier,
          List<AdoptionListing>
        > {
  /// The board: Available listings for the current center, species filter, and
  /// search query. The server does the filtering (speciesId + q), so changing a
  /// filter re-runs this query. Distance is stamped client-side against the
  /// center and the list is sorted nearest-first.
  AdoptionListingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adoptionListingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adoptionListingsNotifierHash();

  @$internal
  @override
  AdoptionListingsNotifier create() => AdoptionListingsNotifier();
}

String _$adoptionListingsNotifierHash() =>
    r'ebb98e960a90f28ba1a35e1021c435517028942e';

/// The board: Available listings for the current center, species filter, and
/// search query. The server does the filtering (speciesId + q), so changing a
/// filter re-runs this query. Distance is stamped client-side against the
/// center and the list is sorted nearest-first.

abstract class _$AdoptionListingsNotifier
    extends $AsyncNotifier<List<AdoptionListing>> {
  FutureOr<List<AdoptionListing>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AdoptionListing>>, List<AdoptionListing>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AdoptionListing>>,
                List<AdoptionListing>
              >,
              AsyncValue<List<AdoptionListing>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// A single listing by id, for the detail screen. Seeded instantly from the
/// already-loaded board list when present (so the detail opens with no spinner),
/// otherwise fetched by id.

@ProviderFor(adoptionListing)
final adoptionListingProvider = AdoptionListingFamily._();

/// A single listing by id, for the detail screen. Seeded instantly from the
/// already-loaded board list when present (so the detail opens with no spinner),
/// otherwise fetched by id.

final class AdoptionListingProvider
    extends
        $FunctionalProvider<
          AsyncValue<AdoptionListing>,
          AdoptionListing,
          FutureOr<AdoptionListing>
        >
    with $FutureModifier<AdoptionListing>, $FutureProvider<AdoptionListing> {
  /// A single listing by id, for the detail screen. Seeded instantly from the
  /// already-loaded board list when present (so the detail opens with no spinner),
  /// otherwise fetched by id.
  AdoptionListingProvider._({
    required AdoptionListingFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'adoptionListingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adoptionListingHash();

  @override
  String toString() {
    return r'adoptionListingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AdoptionListing> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AdoptionListing> create(Ref ref) {
    final argument = this.argument as int;
    return adoptionListing(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdoptionListingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adoptionListingHash() => r'696b3f73d3fad6966dbf0e3acfaedcfe611713fe';

/// A single listing by id, for the detail screen. Seeded instantly from the
/// already-loaded board list when present (so the detail opens with no spinner),
/// otherwise fetched by id.

final class AdoptionListingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AdoptionListing>, int> {
  AdoptionListingFamily._()
    : super(
        retry: null,
        name: r'adoptionListingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single listing by id, for the detail screen. Seeded instantly from the
  /// already-loaded board list when present (so the detail opens with no spinner),
  /// otherwise fetched by id.

  AdoptionListingProvider call(int id) =>
      AdoptionListingProvider._(argument: id, from: this);

  @override
  String toString() => r'adoptionListingProvider';
}

/// The current user's adoption applications (adopter side).

@ProviderFor(MyAdoptionRequestsNotifier)
final myAdoptionRequestsProvider = MyAdoptionRequestsNotifierProvider._();

/// The current user's adoption applications (adopter side).
final class MyAdoptionRequestsNotifierProvider
    extends
        $AsyncNotifierProvider<
          MyAdoptionRequestsNotifier,
          List<MyAdoptionRequest>
        > {
  /// The current user's adoption applications (adopter side).
  MyAdoptionRequestsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAdoptionRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAdoptionRequestsNotifierHash();

  @$internal
  @override
  MyAdoptionRequestsNotifier create() => MyAdoptionRequestsNotifier();
}

String _$myAdoptionRequestsNotifierHash() =>
    r'0e3cf1518e4b95bdac6c1a239f00104990940bc8';

/// The current user's adoption applications (adopter side).

abstract class _$MyAdoptionRequestsNotifier
    extends $AsyncNotifier<List<MyAdoptionRequest>> {
  FutureOr<List<MyAdoptionRequest>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<MyAdoptionRequest>>,
              List<MyAdoptionRequest>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MyAdoptionRequest>>,
                List<MyAdoptionRequest>
              >,
              AsyncValue<List<MyAdoptionRequest>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The current user's own listings (lister side), all statuses — so a listing
/// stays findable after it leaves the public board (PendingTransfer/Adopted/
/// Withdrawn).

@ProviderFor(MyAdoptionListingsNotifier)
final myAdoptionListingsProvider = MyAdoptionListingsNotifierProvider._();

/// The current user's own listings (lister side), all statuses — so a listing
/// stays findable after it leaves the public board (PendingTransfer/Adopted/
/// Withdrawn).
final class MyAdoptionListingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          MyAdoptionListingsNotifier,
          List<AdoptionListing>
        > {
  /// The current user's own listings (lister side), all statuses — so a listing
  /// stays findable after it leaves the public board (PendingTransfer/Adopted/
  /// Withdrawn).
  MyAdoptionListingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAdoptionListingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAdoptionListingsNotifierHash();

  @$internal
  @override
  MyAdoptionListingsNotifier create() => MyAdoptionListingsNotifier();
}

String _$myAdoptionListingsNotifierHash() =>
    r'aaa5cd58b4f36dbfd44f477c5e665a7684a31e11';

/// The current user's own listings (lister side), all statuses — so a listing
/// stays findable after it leaves the public board (PendingTransfer/Adopted/
/// Withdrawn).

abstract class _$MyAdoptionListingsNotifier
    extends $AsyncNotifier<List<AdoptionListing>> {
  FutureOr<List<AdoptionListing>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AdoptionListing>>, List<AdoptionListing>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AdoptionListing>>,
                List<AdoptionListing>
              >,
              AsyncValue<List<AdoptionListing>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Applicants on a specific listing the current user owns (lister side).

@ProviderFor(adoptionListingRequests)
final adoptionListingRequestsProvider = AdoptionListingRequestsFamily._();

/// Applicants on a specific listing the current user owns (lister side).

final class AdoptionListingRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AdoptionRequest>>,
          List<AdoptionRequest>,
          FutureOr<List<AdoptionRequest>>
        >
    with
        $FutureModifier<List<AdoptionRequest>>,
        $FutureProvider<List<AdoptionRequest>> {
  /// Applicants on a specific listing the current user owns (lister side).
  AdoptionListingRequestsProvider._({
    required AdoptionListingRequestsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'adoptionListingRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adoptionListingRequestsHash();

  @override
  String toString() {
    return r'adoptionListingRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AdoptionRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AdoptionRequest>> create(Ref ref) {
    final argument = this.argument as int;
    return adoptionListingRequests(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdoptionListingRequestsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adoptionListingRequestsHash() =>
    r'1099c4dc5833579d5cbcec5e8a86042c03131cd0';

/// Applicants on a specific listing the current user owns (lister side).

final class AdoptionListingRequestsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AdoptionRequest>>, int> {
  AdoptionListingRequestsFamily._()
    : super(
        retry: null,
        name: r'adoptionListingRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Applicants on a specific listing the current user owns (lister side).

  AdoptionListingRequestsProvider call(int listingId) =>
      AdoptionListingRequestsProvider._(argument: listingId, from: this);

  @override
  String toString() => r'adoptionListingRequestsProvider';
}

/// Creates an adoption listing for one of the current user's pets.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future).

@ProviderFor(CreateAdoptionListing)
final createAdoptionListingProvider = CreateAdoptionListingProvider._();

/// Creates an adoption listing for one of the current user's pets.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future).
final class CreateAdoptionListingProvider
    extends $AsyncNotifierProvider<CreateAdoptionListing, void> {
  /// Creates an adoption listing for one of the current user's pets.
  ///
  /// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
  /// the returned Future).
  CreateAdoptionListingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createAdoptionListingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createAdoptionListingHash();

  @$internal
  @override
  CreateAdoptionListing create() => CreateAdoptionListing();
}

String _$createAdoptionListingHash() =>
    r'c1802815ca6167e41346579e9b1fe13f2d6da162';

/// Creates an adoption listing for one of the current user's pets.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future).

abstract class _$CreateAdoptionListing extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
