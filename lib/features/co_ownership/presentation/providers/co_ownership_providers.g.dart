// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'co_ownership_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(coOwnershipRepository)
final coOwnershipRepositoryProvider = CoOwnershipRepositoryProvider._();

final class CoOwnershipRepositoryProvider
    extends
        $FunctionalProvider<
          CoOwnershipRepository,
          CoOwnershipRepository,
          CoOwnershipRepository
        >
    with $Provider<CoOwnershipRepository> {
  CoOwnershipRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coOwnershipRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coOwnershipRepositoryHash();

  @$internal
  @override
  $ProviderElement<CoOwnershipRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CoOwnershipRepository create(Ref ref) {
    return coOwnershipRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CoOwnershipRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CoOwnershipRepository>(value),
    );
  }
}

String _$coOwnershipRepositoryHash() =>
    r'e84dc4567de839364e9c50c6156fd5ecd541d0e2';

/// Invites addressed to the current user (invitee side).

@ProviderFor(IncomingInvitesNotifier)
final incomingInvitesProvider = IncomingInvitesNotifierProvider._();

/// Invites addressed to the current user (invitee side).
final class IncomingInvitesNotifierProvider
    extends
        $AsyncNotifierProvider<
          IncomingInvitesNotifier,
          List<IncomingCoOwnerInvite>
        > {
  /// Invites addressed to the current user (invitee side).
  IncomingInvitesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingInvitesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingInvitesNotifierHash();

  @$internal
  @override
  IncomingInvitesNotifier create() => IncomingInvitesNotifier();
}

String _$incomingInvitesNotifierHash() =>
    r'af9b54bf7190606d67b035c42aedd0cf87161a2f';

/// Invites addressed to the current user (invitee side).

abstract class _$IncomingInvitesNotifier
    extends $AsyncNotifier<List<IncomingCoOwnerInvite>> {
  FutureOr<List<IncomingCoOwnerInvite>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<IncomingCoOwnerInvite>>,
              List<IncomingCoOwnerInvite>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<IncomingCoOwnerInvite>>,
                List<IncomingCoOwnerInvite>
              >,
              AsyncValue<List<IncomingCoOwnerInvite>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Invites the current user has sent for a given pet (owner side).

@ProviderFor(SentInvitesNotifier)
final sentInvitesProvider = SentInvitesNotifierFamily._();

/// Invites the current user has sent for a given pet (owner side).
final class SentInvitesNotifierProvider
    extends
        $AsyncNotifierProvider<SentInvitesNotifier, List<SentCoOwnerInvite>> {
  /// Invites the current user has sent for a given pet (owner side).
  SentInvitesNotifierProvider._({
    required SentInvitesNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'sentInvitesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sentInvitesNotifierHash();

  @override
  String toString() {
    return r'sentInvitesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SentInvitesNotifier create() => SentInvitesNotifier();

  @override
  bool operator ==(Object other) {
    return other is SentInvitesNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sentInvitesNotifierHash() =>
    r'798ce1ce03e514d537f07473f888eaccf7e2ad99';

/// Invites the current user has sent for a given pet (owner side).

final class SentInvitesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          SentInvitesNotifier,
          AsyncValue<List<SentCoOwnerInvite>>,
          List<SentCoOwnerInvite>,
          FutureOr<List<SentCoOwnerInvite>>,
          int
        > {
  SentInvitesNotifierFamily._()
    : super(
        retry: null,
        name: r'sentInvitesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Invites the current user has sent for a given pet (owner side).

  SentInvitesNotifierProvider call(int petId) =>
      SentInvitesNotifierProvider._(argument: petId, from: this);

  @override
  String toString() => r'sentInvitesProvider';
}

/// Invites the current user has sent for a given pet (owner side).

abstract class _$SentInvitesNotifier
    extends $AsyncNotifier<List<SentCoOwnerInvite>> {
  late final _$args = ref.$arg as int;
  int get petId => _$args;

  FutureOr<List<SentCoOwnerInvite>> build(int petId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<SentCoOwnerInvite>>,
              List<SentCoOwnerInvite>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SentCoOwnerInvite>>,
                List<SentCoOwnerInvite>
              >,
              AsyncValue<List<SentCoOwnerInvite>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// A pet's current owners (primary owner + accepted co-owners).

@ProviderFor(PetOwnersNotifier)
final petOwnersProvider = PetOwnersNotifierFamily._();

/// A pet's current owners (primary owner + accepted co-owners).
final class PetOwnersNotifierProvider
    extends $AsyncNotifierProvider<PetOwnersNotifier, List<PetOwner>> {
  /// A pet's current owners (primary owner + accepted co-owners).
  PetOwnersNotifierProvider._({
    required PetOwnersNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petOwnersProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petOwnersNotifierHash();

  @override
  String toString() {
    return r'petOwnersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PetOwnersNotifier create() => PetOwnersNotifier();

  @override
  bool operator ==(Object other) {
    return other is PetOwnersNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petOwnersNotifierHash() => r'76551d3399c8beb9f5e690c2bd778d94853abdcc';

/// A pet's current owners (primary owner + accepted co-owners).

final class PetOwnersNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PetOwnersNotifier,
          AsyncValue<List<PetOwner>>,
          List<PetOwner>,
          FutureOr<List<PetOwner>>,
          int
        > {
  PetOwnersNotifierFamily._()
    : super(
        retry: null,
        name: r'petOwnersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A pet's current owners (primary owner + accepted co-owners).

  PetOwnersNotifierProvider call(int petId) =>
      PetOwnersNotifierProvider._(argument: petId, from: this);

  @override
  String toString() => r'petOwnersProvider';
}

/// A pet's current owners (primary owner + accepted co-owners).

abstract class _$PetOwnersNotifier extends $AsyncNotifier<List<PetOwner>> {
  late final _$args = ref.$arg as int;
  int get petId => _$args;

  FutureOr<List<PetOwner>> build(int petId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<PetOwner>>, List<PetOwner>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PetOwner>>, List<PetOwner>>,
              AsyncValue<List<PetOwner>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
