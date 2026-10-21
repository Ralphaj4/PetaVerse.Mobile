// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_pet_radius_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lostPetRadiusStore)
final lostPetRadiusStoreProvider = LostPetRadiusStoreProvider._();

final class LostPetRadiusStoreProvider
    extends
        $FunctionalProvider<
          LostPetRadiusStore,
          LostPetRadiusStore,
          LostPetRadiusStore
        >
    with $Provider<LostPetRadiusStore> {
  LostPetRadiusStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostPetRadiusStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostPetRadiusStoreHash();

  @$internal
  @override
  $ProviderElement<LostPetRadiusStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LostPetRadiusStore create(Ref ref) {
    return lostPetRadiusStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LostPetRadiusStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LostPetRadiusStore>(value),
    );
  }
}

String _$lostPetRadiusStoreHash() =>
    r'cc77a56cb047ba01d2fa061cdcea565c3920a763';

/// The lost-pet alert radius (km). Reads Hive immediately so the UI shows the
/// cached value without waiting on the network, then syncs from the API in the
/// background. Edits optimistically update + persist, PUT just the radius, and
/// revert on failure.

@ProviderFor(LostPetRadiusNotifier)
final lostPetRadiusProvider = LostPetRadiusNotifierProvider._();

/// The lost-pet alert radius (km). Reads Hive immediately so the UI shows the
/// cached value without waiting on the network, then syncs from the API in the
/// background. Edits optimistically update + persist, PUT just the radius, and
/// revert on failure.
final class LostPetRadiusNotifierProvider
    extends $AsyncNotifierProvider<LostPetRadiusNotifier, double> {
  /// The lost-pet alert radius (km). Reads Hive immediately so the UI shows the
  /// cached value without waiting on the network, then syncs from the API in the
  /// background. Edits optimistically update + persist, PUT just the radius, and
  /// revert on failure.
  LostPetRadiusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostPetRadiusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostPetRadiusNotifierHash();

  @$internal
  @override
  LostPetRadiusNotifier create() => LostPetRadiusNotifier();
}

String _$lostPetRadiusNotifierHash() =>
    r'540a4116e8b1b0adc04bc8db4594ca98b4f2a099';

/// The lost-pet alert radius (km). Reads Hive immediately so the UI shows the
/// cached value without waiting on the network, then syncs from the API in the
/// background. Edits optimistically update + persist, PUT just the radius, and
/// revert on failure.

abstract class _$LostPetRadiusNotifier extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<double>, double>,
              AsyncValue<double>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
