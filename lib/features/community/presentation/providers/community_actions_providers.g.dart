// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_actions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Cross-cutting write actions for PawHub (like, save, share, follow, block,
/// report, post CRUD). Each mutates the server then reconciles the loaded
/// feeds so every screen showing the post updates at once.
///
/// Read as a plain object (`ref.read(communityActionsProvider)`) and call its
/// methods; it holds no state of its own.

@ProviderFor(communityActions)
final communityActionsProvider = CommunityActionsProvider._();

/// Cross-cutting write actions for PawHub (like, save, share, follow, block,
/// report, post CRUD). Each mutates the server then reconciles the loaded
/// feeds so every screen showing the post updates at once.
///
/// Read as a plain object (`ref.read(communityActionsProvider)`) and call its
/// methods; it holds no state of its own.

final class CommunityActionsProvider
    extends
        $FunctionalProvider<
          CommunityActions,
          CommunityActions,
          CommunityActions
        >
    with $Provider<CommunityActions> {
  /// Cross-cutting write actions for PawHub (like, save, share, follow, block,
  /// report, post CRUD). Each mutates the server then reconciles the loaded
  /// feeds so every screen showing the post updates at once.
  ///
  /// Read as a plain object (`ref.read(communityActionsProvider)`) and call its
  /// methods; it holds no state of its own.
  CommunityActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityActionsHash();

  @$internal
  @override
  $ProviderElement<CommunityActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CommunityActions create(Ref ref) {
    return communityActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityActions>(value),
    );
  }
}

String _$communityActionsHash() => r'ba1479384b949b7b2008fc362a44d2a0bc30f436';
