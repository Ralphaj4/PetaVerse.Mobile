// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hiveService)
final hiveServiceProvider = HiveServiceProvider._();

final class HiveServiceProvider
    extends $FunctionalProvider<HiveService, HiveService, HiveService>
    with $Provider<HiveService> {
  HiveServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hiveServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hiveServiceHash();

  @$internal
  @override
  $ProviderElement<HiveService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HiveService create(Ref ref) {
    return hiveService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HiveService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HiveService>(value),
    );
  }
}

String _$hiveServiceHash() => r'c9d824b0522c0ac427f042ab5cae0343a242bdd7';

@ProviderFor(syncFlagStore)
final syncFlagStoreProvider = SyncFlagStoreProvider._();

final class SyncFlagStoreProvider
    extends $FunctionalProvider<SyncFlagStore, SyncFlagStore, SyncFlagStore>
    with $Provider<SyncFlagStore> {
  SyncFlagStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncFlagStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncFlagStoreHash();

  @$internal
  @override
  $ProviderElement<SyncFlagStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncFlagStore create(Ref ref) {
    return syncFlagStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncFlagStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncFlagStore>(value),
    );
  }
}

String _$syncFlagStoreHash() => r'da96309fcb046df039a5f672b4cebe1d1b598d84';
