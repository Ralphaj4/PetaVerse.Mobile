// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The community repository, wired to the shared [ApiClient] and Hive cache.
///
/// `myPetIds` is supplied as a callback reading [PetsNotifier], so the
/// `isMine` flag on authors always reflects the current pet set without the
/// repository holding a stale snapshot.

@ProviderFor(communityRepository)
final communityRepositoryProvider = CommunityRepositoryProvider._();

/// The community repository, wired to the shared [ApiClient] and Hive cache.
///
/// `myPetIds` is supplied as a callback reading [PetsNotifier], so the
/// `isMine` flag on authors always reflects the current pet set without the
/// repository holding a stale snapshot.

final class CommunityRepositoryProvider
    extends
        $FunctionalProvider<
          CommunityRepository,
          CommunityRepository,
          CommunityRepository
        >
    with $Provider<CommunityRepository> {
  /// The community repository, wired to the shared [ApiClient] and Hive cache.
  ///
  /// `myPetIds` is supplied as a callback reading [PetsNotifier], so the
  /// `isMine` flag on authors always reflects the current pet set without the
  /// repository holding a stale snapshot.
  CommunityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommunityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunityRepository create(Ref ref) {
    return communityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityRepository>(value),
    );
  }
}

String _$communityRepositoryHash() =>
    r'5e32323aaaefe513608c0ee2399507d0ad8acf55';

/// The acting pet — the social identity actions are attributed to. Bound to
/// the app-wide current-pet selection ([PetsNotifier]); switching pets in the
/// PawHub switcher goes through `selectPet`, so the whole app stays in sync.
///
/// Null when the user has no pet yet (the feed then relies on the server's
/// first-pet fallback, and posting is gated in the UI).

@ProviderFor(actingPet)
final actingPetProvider = ActingPetProvider._();

/// The acting pet — the social identity actions are attributed to. Bound to
/// the app-wide current-pet selection ([PetsNotifier]); switching pets in the
/// PawHub switcher goes through `selectPet`, so the whole app stays in sync.
///
/// Null when the user has no pet yet (the feed then relies on the server's
/// first-pet fallback, and posting is gated in the UI).

final class ActingPetProvider
    extends $FunctionalProvider<PetRef?, PetRef?, PetRef?>
    with $Provider<PetRef?> {
  /// The acting pet — the social identity actions are attributed to. Bound to
  /// the app-wide current-pet selection ([PetsNotifier]); switching pets in the
  /// PawHub switcher goes through `selectPet`, so the whole app stays in sync.
  ///
  /// Null when the user has no pet yet (the feed then relies on the server's
  /// first-pet fallback, and posting is gated in the UI).
  ActingPetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'actingPetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$actingPetHash();

  @$internal
  @override
  $ProviderElement<PetRef?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PetRef? create(Ref ref) {
    return actingPet(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PetRef? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PetRef?>(value),
    );
  }
}

String _$actingPetHash() => r'068c5b1812c2fd0128da23c9ef0d278abec55a7e';

/// The acting pet's id, or null. Convenience for the many providers that only
/// need the id to pass as `petId` / `authorPetId` / `followerPetId`.

@ProviderFor(actingPetId)
final actingPetIdProvider = ActingPetIdProvider._();

/// The acting pet's id, or null. Convenience for the many providers that only
/// need the id to pass as `petId` / `authorPetId` / `followerPetId`.

final class ActingPetIdProvider extends $FunctionalProvider<int?, int?, int?>
    with $Provider<int?> {
  /// The acting pet's id, or null. Convenience for the many providers that only
  /// need the id to pass as `petId` / `authorPetId` / `followerPetId`.
  ActingPetIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'actingPetIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$actingPetIdHash();

  @$internal
  @override
  $ProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int? create(Ref ref) {
    return actingPetId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$actingPetIdHash() => r'7b2206c173036e98dbc1e0b4b77efa60c3c93c00';

/// The list of pets the user can act as (the profile switcher's rows).

@ProviderFor(switchablePets)
final switchablePetsProvider = SwitchablePetsProvider._();

/// The list of pets the user can act as (the profile switcher's rows).

final class SwitchablePetsProvider
    extends $FunctionalProvider<List<PetRef>, List<PetRef>, List<PetRef>>
    with $Provider<List<PetRef>> {
  /// The list of pets the user can act as (the profile switcher's rows).
  SwitchablePetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'switchablePetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$switchablePetsHash();

  @$internal
  @override
  $ProviderElement<List<PetRef>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<PetRef> create(Ref ref) {
    return switchablePets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PetRef> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PetRef>>(value),
    );
  }
}

String _$switchablePetsHash() => r'aa9cf445ce94a77407946b38eee505c75b49a88f';
