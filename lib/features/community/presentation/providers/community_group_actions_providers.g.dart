// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_group_actions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Write actions for pet-led communities (create, join, leave, delete, remove
/// member). Each mutates the server then reconciles the loaded directory /
/// detail / my-communities views so every screen updates at once.
///
/// Read as a plain object (`ref.read(communityGroupActionsProvider)`); it holds
/// no state. Mirrors [CommunityActions].

@ProviderFor(communityGroupActions)
final communityGroupActionsProvider = CommunityGroupActionsProvider._();

/// Write actions for pet-led communities (create, join, leave, delete, remove
/// member). Each mutates the server then reconciles the loaded directory /
/// detail / my-communities views so every screen updates at once.
///
/// Read as a plain object (`ref.read(communityGroupActionsProvider)`); it holds
/// no state. Mirrors [CommunityActions].

final class CommunityGroupActionsProvider
    extends
        $FunctionalProvider<
          CommunityGroupActions,
          CommunityGroupActions,
          CommunityGroupActions
        >
    with $Provider<CommunityGroupActions> {
  /// Write actions for pet-led communities (create, join, leave, delete, remove
  /// member). Each mutates the server then reconciles the loaded directory /
  /// detail / my-communities views so every screen updates at once.
  ///
  /// Read as a plain object (`ref.read(communityGroupActionsProvider)`); it holds
  /// no state. Mirrors [CommunityActions].
  CommunityGroupActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityGroupActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityGroupActionsHash();

  @$internal
  @override
  $ProviderElement<CommunityGroupActions> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunityGroupActions create(Ref ref) {
    return communityGroupActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityGroupActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityGroupActions>(value),
    );
  }
}

String _$communityGroupActionsHash() =>
    r'455e28826d504343240b1c582884fb1c773ae340';
