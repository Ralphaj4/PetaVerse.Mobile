// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Full pet records for display screens (Profile, the pet picker), offline-first.
///
/// Cache-first: the cached list renders instantly, then a background fetch
/// reconciles it and updates the cache. On a network failure the cached list
/// stays visible (the error only surfaces when there's nothing cached).
///
/// Independent of the routing gate, which tracks only lightweight refs. Call
/// [refresh] to reconcile (e.g. when the Profile tab opens or after a
/// create/edit/delete); concurrent calls are coalesced.

@ProviderFor(PetListNotifier)
final petListProvider = PetListNotifierProvider._();

/// Full pet records for display screens (Profile, the pet picker), offline-first.
///
/// Cache-first: the cached list renders instantly, then a background fetch
/// reconciles it and updates the cache. On a network failure the cached list
/// stays visible (the error only surfaces when there's nothing cached).
///
/// Independent of the routing gate, which tracks only lightweight refs. Call
/// [refresh] to reconcile (e.g. when the Profile tab opens or after a
/// create/edit/delete); concurrent calls are coalesced.
final class PetListNotifierProvider
    extends $AsyncNotifierProvider<PetListNotifier, List<Pet>> {
  /// Full pet records for display screens (Profile, the pet picker), offline-first.
  ///
  /// Cache-first: the cached list renders instantly, then a background fetch
  /// reconciles it and updates the cache. On a network failure the cached list
  /// stays visible (the error only surfaces when there's nothing cached).
  ///
  /// Independent of the routing gate, which tracks only lightweight refs. Call
  /// [refresh] to reconcile (e.g. when the Profile tab opens or after a
  /// create/edit/delete); concurrent calls are coalesced.
  PetListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'petListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$petListNotifierHash();

  @$internal
  @override
  PetListNotifier create() => PetListNotifier();
}

String _$petListNotifierHash() => r'e95c8a6f56d79371f673e9d225aa7105226c7d77';

/// Full pet records for display screens (Profile, the pet picker), offline-first.
///
/// Cache-first: the cached list renders instantly, then a background fetch
/// reconciles it and updates the cache. On a network failure the cached list
/// stays visible (the error only surfaces when there's nothing cached).
///
/// Independent of the routing gate, which tracks only lightweight refs. Call
/// [refresh] to reconcile (e.g. when the Profile tab opens or after a
/// create/edit/delete); concurrent calls are coalesced.

abstract class _$PetListNotifier extends $AsyncNotifier<List<Pet>> {
  FutureOr<List<Pet>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Pet>>, List<Pet>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Pet>>, List<Pet>>,
              AsyncValue<List<Pet>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
