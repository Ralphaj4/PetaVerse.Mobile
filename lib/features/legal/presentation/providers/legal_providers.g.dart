// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(legalRepository)
final legalRepositoryProvider = LegalRepositoryProvider._();

final class LegalRepositoryProvider
    extends
        $FunctionalProvider<LegalRepository, LegalRepository, LegalRepository>
    with $Provider<LegalRepository> {
  LegalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'legalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$legalRepositoryHash();

  @$internal
  @override
  $ProviderElement<LegalRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LegalRepository create(Ref ref) {
    return legalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LegalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LegalRepository>(value),
    );
  }
}

String _$legalRepositoryHash() => r'034f9d297b4352aed74d584bb4fd9725b04c25c1';

/// Current published legal documents (versions, URLs, acceptance kind). Public
/// endpoint, so it doesn't depend on the session. The acceptance screen watches
/// this to label each document and open its hosted URL.

@ProviderFor(legalCurrent)
final legalCurrentProvider = LegalCurrentProvider._();

/// Current published legal documents (versions, URLs, acceptance kind). Public
/// endpoint, so it doesn't depend on the session. The acceptance screen watches
/// this to label each document and open its hosted URL.

final class LegalCurrentProvider
    extends
        $FunctionalProvider<
          AsyncValue<LegalDocuments>,
          LegalDocuments,
          FutureOr<LegalDocuments>
        >
    with $FutureModifier<LegalDocuments>, $FutureProvider<LegalDocuments> {
  /// Current published legal documents (versions, URLs, acceptance kind). Public
  /// endpoint, so it doesn't depend on the session. The acceptance screen watches
  /// this to label each document and open its hosted URL.
  LegalCurrentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'legalCurrentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$legalCurrentHash();

  @$internal
  @override
  $FutureProviderElement<LegalDocuments> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LegalDocuments> create(Ref ref) {
    return legalCurrent(ref);
  }
}

String _$legalCurrentHash() => r'824ad77eaf6e7bb3f7ac7e09693d7cb0d500ef8a';

/// The full renderable content (markdown body + metadata) of one published
/// document version. Fetched on demand when the user opens a document at the
/// consent gate; not kept alive, so it's released when the viewer closes.

@ProviderFor(legalContent)
final legalContentProvider = LegalContentFamily._();

/// The full renderable content (markdown body + metadata) of one published
/// document version. Fetched on demand when the user opens a document at the
/// consent gate; not kept alive, so it's released when the viewer closes.

final class LegalContentProvider
    extends
        $FunctionalProvider<
          AsyncValue<LegalContent>,
          LegalContent,
          FutureOr<LegalContent>
        >
    with $FutureModifier<LegalContent>, $FutureProvider<LegalContent> {
  /// The full renderable content (markdown body + metadata) of one published
  /// document version. Fetched on demand when the user opens a document at the
  /// consent gate; not kept alive, so it's released when the viewer closes.
  LegalContentProvider._({
    required LegalContentFamily super.from,
    required (LegalDocumentType, String) super.argument,
  }) : super(
         retry: null,
         name: r'legalContentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$legalContentHash();

  @override
  String toString() {
    return r'legalContentProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<LegalContent> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LegalContent> create(Ref ref) {
    final argument = this.argument as (LegalDocumentType, String);
    return legalContent(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is LegalContentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$legalContentHash() => r'20f30c746e9b02c812e1e5164d04b913756fd770';

/// The full renderable content (markdown body + metadata) of one published
/// document version. Fetched on demand when the user opens a document at the
/// consent gate; not kept alive, so it's released when the viewer closes.

final class LegalContentFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<LegalContent>,
          (LegalDocumentType, String)
        > {
  LegalContentFamily._()
    : super(
        retry: null,
        name: r'legalContentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The full renderable content (markdown body + metadata) of one published
  /// document version. Fetched on demand when the user opens a document at the
  /// consent gate; not kept alive, so it's released when the viewer closes.

  LegalContentProvider call(LegalDocumentType type, String version) =>
      LegalContentProvider._(argument: (type, version), from: this);

  @override
  String toString() => r'legalContentProvider';
}

/// Gate for "has the signed-in user accepted the current legal documents",
/// driving post-auth routing.
///
/// Mirrors the pet gate: synchronous state driven off the session, with an
/// explicit-reset guard on logout. Unlike the pet gate there is no cache
/// hydrate - legal status is cheap, authoritative-only, and must not be answered
/// from stale local data.
///
/// Boot optimization (round-trip saver): on a logged-in boot the gate seeds
/// itself from the legal block the home-summary call already carries, so the
/// standalone /legal/status call is skipped in the common "nothing owed" case.
/// It only seeds from a FRESH (non-cache) home-summary that actually carries the
/// block; if the block is absent (older backend), the summary came from cache,
/// or the summary fails, it falls back to the authoritative [reconcile]
/// (/legal/status). /legal/status therefore stays the source of truth for the
/// retry/reconcile path and the auth-flow pre-navigation checks.

@ProviderFor(LegalGateNotifier)
final legalGateProvider = LegalGateNotifierProvider._();

/// Gate for "has the signed-in user accepted the current legal documents",
/// driving post-auth routing.
///
/// Mirrors the pet gate: synchronous state driven off the session, with an
/// explicit-reset guard on logout. Unlike the pet gate there is no cache
/// hydrate - legal status is cheap, authoritative-only, and must not be answered
/// from stale local data.
///
/// Boot optimization (round-trip saver): on a logged-in boot the gate seeds
/// itself from the legal block the home-summary call already carries, so the
/// standalone /legal/status call is skipped in the common "nothing owed" case.
/// It only seeds from a FRESH (non-cache) home-summary that actually carries the
/// block; if the block is absent (older backend), the summary came from cache,
/// or the summary fails, it falls back to the authoritative [reconcile]
/// (/legal/status). /legal/status therefore stays the source of truth for the
/// retry/reconcile path and the auth-flow pre-navigation checks.
final class LegalGateNotifierProvider
    extends $NotifierProvider<LegalGateNotifier, LegalGateState> {
  /// Gate for "has the signed-in user accepted the current legal documents",
  /// driving post-auth routing.
  ///
  /// Mirrors the pet gate: synchronous state driven off the session, with an
  /// explicit-reset guard on logout. Unlike the pet gate there is no cache
  /// hydrate - legal status is cheap, authoritative-only, and must not be answered
  /// from stale local data.
  ///
  /// Boot optimization (round-trip saver): on a logged-in boot the gate seeds
  /// itself from the legal block the home-summary call already carries, so the
  /// standalone /legal/status call is skipped in the common "nothing owed" case.
  /// It only seeds from a FRESH (non-cache) home-summary that actually carries the
  /// block; if the block is absent (older backend), the summary came from cache,
  /// or the summary fails, it falls back to the authoritative [reconcile]
  /// (/legal/status). /legal/status therefore stays the source of truth for the
  /// retry/reconcile path and the auth-flow pre-navigation checks.
  LegalGateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'legalGateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$legalGateNotifierHash();

  @$internal
  @override
  LegalGateNotifier create() => LegalGateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LegalGateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LegalGateState>(value),
    );
  }
}

String _$legalGateNotifierHash() => r'0402b3cb4e26fde0501c021342b92212122a7ddd';

/// Gate for "has the signed-in user accepted the current legal documents",
/// driving post-auth routing.
///
/// Mirrors the pet gate: synchronous state driven off the session, with an
/// explicit-reset guard on logout. Unlike the pet gate there is no cache
/// hydrate - legal status is cheap, authoritative-only, and must not be answered
/// from stale local data.
///
/// Boot optimization (round-trip saver): on a logged-in boot the gate seeds
/// itself from the legal block the home-summary call already carries, so the
/// standalone /legal/status call is skipped in the common "nothing owed" case.
/// It only seeds from a FRESH (non-cache) home-summary that actually carries the
/// block; if the block is absent (older backend), the summary came from cache,
/// or the summary fails, it falls back to the authoritative [reconcile]
/// (/legal/status). /legal/status therefore stays the source of truth for the
/// retry/reconcile path and the auth-flow pre-navigation checks.

abstract class _$LegalGateNotifier extends $Notifier<LegalGateState> {
  LegalGateState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LegalGateState, LegalGateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LegalGateState, LegalGateState>,
              LegalGateState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
