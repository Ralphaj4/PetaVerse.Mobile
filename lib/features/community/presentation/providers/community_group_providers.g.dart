// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_group_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The community (group) repository, wired to the shared [ApiClient].
///
/// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
/// lead/member pets always reflects the current pet set without holding a
/// stale snapshot — same pattern as `communityRepository`.

@ProviderFor(communityGroupRepository)
final communityGroupRepositoryProvider = CommunityGroupRepositoryProvider._();

/// The community (group) repository, wired to the shared [ApiClient].
///
/// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
/// lead/member pets always reflects the current pet set without holding a
/// stale snapshot — same pattern as `communityRepository`.

final class CommunityGroupRepositoryProvider
    extends
        $FunctionalProvider<
          CommunityGroupRepository,
          CommunityGroupRepository,
          CommunityGroupRepository
        >
    with $Provider<CommunityGroupRepository> {
  /// The community (group) repository, wired to the shared [ApiClient].
  ///
  /// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
  /// lead/member pets always reflects the current pet set without holding a
  /// stale snapshot — same pattern as `communityRepository`.
  CommunityGroupRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityGroupRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityGroupRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommunityGroupRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunityGroupRepository create(Ref ref) {
    return communityGroupRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityGroupRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityGroupRepository>(value),
    );
  }
}

String _$communityGroupRepositoryHash() =>
    r'74d60304e3ed40bf1af147f25c3dedb0f5741eac';
