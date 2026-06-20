// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Gate for "does the signed-in user have a pet", driving post-auth routing.
///
/// Mirrors the session gate: synchronous state, hydrate-from-cache then
/// reconcile-from-API, with an explicit-set guard so a late async completion
/// can't clobber a reset (logout) that happened first.

@ProviderFor(PetsNotifier)
final petsProvider = PetsNotifierProvider._();

/// Gate for "does the signed-in user have a pet", driving post-auth routing.
///
/// Mirrors the session gate: synchronous state, hydrate-from-cache then
/// reconcile-from-API, with an explicit-set guard so a late async completion
/// can't clobber a reset (logout) that happened first.
final class PetsNotifierProvider
    extends $NotifierProvider<PetsNotifier, PetsState> {
  /// Gate for "does the signed-in user have a pet", driving post-auth routing.
  ///
  /// Mirrors the session gate: synchronous state, hydrate-from-cache then
  /// reconcile-from-API, with an explicit-set guard so a late async completion
  /// can't clobber a reset (logout) that happened first.
  PetsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'petsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$petsNotifierHash();

  @$internal
  @override
  PetsNotifier create() => PetsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PetsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PetsState>(value),
    );
  }
}

String _$petsNotifierHash() => r'944f85fbeca2df0c9ca2156c071278654b63184a';

/// Gate for "does the signed-in user have a pet", driving post-auth routing.
///
/// Mirrors the session gate: synchronous state, hydrate-from-cache then
/// reconcile-from-API, with an explicit-set guard so a late async completion
/// can't clobber a reset (logout) that happened first.

abstract class _$PetsNotifier extends $Notifier<PetsState> {
  PetsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PetsState, PetsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PetsState, PetsState>,
              PetsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
