import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/presentation/providers/session_provider.dart';
import '../../../../core/network/api_client.dart';
import '../../../home/domain/entities/home_summary.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../../data/datasources/legal_remote_datasource.dart';
import '../../data/repositories/legal_repository_impl.dart';
import '../../domain/entities/legal.dart';
import '../../domain/repositories/legal_repository.dart';

part 'legal_providers.g.dart';

@Riverpod(keepAlive: true)
LegalRepository legalRepository(Ref ref) => LegalRepositoryImpl(
      remote: LegalRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// Current published legal documents (versions, URLs, acceptance kind). Public
/// endpoint, so it doesn't depend on the session. The acceptance screen watches
/// this to label each document and open its hosted URL.
@Riverpod(keepAlive: true)
Future<LegalDocuments> legalCurrent(Ref ref) async {
  final result = await ref.watch(legalRepositoryProvider).getCurrent();
  return result.when(
    success: (value) => value,
    failure: (f) => throw f,
  );
}

/// The full renderable content (markdown body + metadata) of one published
/// document version. Fetched on demand when the user opens a document at the
/// consent gate; not kept alive, so it's released when the viewer closes.
@riverpod
Future<LegalContent> legalContent(
  Ref ref,
  LegalDocumentType type,
  String version,
) async {
  final result =
      await ref.watch(legalRepositoryProvider).getContent(type: type, version: version);
  return result.when(
    success: (value) => value,
    failure: (f) => throw f,
  );
}

/// Legal-acceptance routing-gate state, read synchronously by the router's
/// redirect.
///
/// [ready] flips true once the gate has an authoritative answer (a successful
/// status fetch) OR a failed one. [requiresAction] is only ever true off a
/// successful fetch - if the fetch fails we FAIL OPEN (let the user through)
/// rather than trap them behind an acceptance screen they can't dismiss while
/// offline. The backend re-checks acceptance on every authenticated call, so a
/// user who genuinely owes an acceptance will be caught again on the next
/// successful status fetch; this only affects transient-offline UX.
class LegalGateState {
  const LegalGateState({
    required this.ready,
    required this.status,
    required this.reconcileFailed,
    this.failure,
  });

  const LegalGateState.initial()
      : ready = false,
        status = null,
        reconcileFailed = false,
        failure = null;

  final bool ready;

  /// The last authoritative status, or null before the first successful fetch.
  final LegalStatus? status;

  /// True when the last status fetch failed (offline / server error).
  final bool reconcileFailed;

  /// The failure behind [reconcileFailed], for surfacing a retry message.
  final Failure? failure;

  /// Documents the user must accept before proceeding. Empty when the gate has
  /// no authoritative status (fail-open) so the router never blocks on it.
  List<LegalStatusItem> get pending => status?.pending ?? const [];

  /// True only when a successful fetch says the user must act. A failed fetch
  /// never blocks the user (see class doc).
  bool get requiresAction => pending.isNotEmpty;

  /// True when the only pending document is Community Guidelines. In this case
  /// the router does NOT show the legal wall - the user is let through and the
  /// PetaHub tab shows a non-closable popup instead.
  bool get onlyCommunityGuidelinesPending =>
      pending.length == 1 &&
      pending.first.documentType == LegalDocumentType.communityGuidelines;

  /// True when the legal wall should block navigation (i.e. there is pending
  /// action that is NOT community-guidelines-only).
  bool get blocksNavigation => requiresAction && !onlyCommunityGuidelinesPending;

  /// The pending community-guidelines item when it is the sole pending document,
  /// or null otherwise. Used by the PetaHub tab to show the inline popup.
  LegalStatusItem? get pendingCommunityGuidelines =>
      onlyCommunityGuidelinesPending ? pending.first : null;
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
@Riverpod(keepAlive: true)
class LegalGateNotifier extends _$LegalGateNotifier {
  @override
  LegalGateState build() {
    // Reset on logout; a fresh login is handled by the home-summary seed below
    // (and by the auth pages, which await reconcile() before navigating).
    ref.listen(sessionProvider, (previous, next) {
      final wasLoggedIn = previous?.loggedIn ?? false;
      if (previous != null && wasLoggedIn && !next.loggedIn) {
        reset();
      }
    });

    // Seed from the home-summary the app fetches anyway. Listening here also
    // activates that (autoDispose) provider, so the summary is fetched even
    // before HomePage mounts - e.g. when the user is about to be walled.
    // fireImmediately so an already-resolved summary (gate built/rebuilt after
    // home-summary landed) is handled too, not just later transitions.
    ref.listen(homeSummaryProvider, fireImmediately: true, (_, next) {
      // Only act for a logged-in user; ignore everything post-logout.
      if (!ref.read(sessionProvider).loggedIn) return;
      next.when(
        loading: () {},
        data: _onHomeSummary,
        // Home-summary failed: fall back to the authoritative status (which is
        // itself fail-open) unless we already resolved the gate this boot.
        error: (_, _) {
          if (!state.ready) reconcile();
        },
      );
    });

    return const LegalGateState.initial();
  }

  /// Seeds the gate from a home-summary emission, preserving the
  /// authoritative-only invariant.
  void _onHomeSummary(HomeSummary summary) {
    // Never seed from a cached snapshot - legal status must be authoritative.
    if (summary.fromCache) return;
    final legal = summary.legal;
    // Block absent (older backend): fall back to /legal/status once.
    if (legal == null) {
      if (!state.ready) reconcile();
      return;
    }
    // Fresh, authoritative block present: seed the gate and skip /status.
    state = LegalGateState(
      ready: true,
      status: _statusFromHomeLegal(legal),
      reconcileFailed: false,
    );
  }

  /// Builds a [LegalStatus] from the home-summary legal block so the downstream
  /// [LegalGateState.pending]/[requiresAction] work unchanged. The block carries
  /// only (documentType, currentVersion); acceptedVersion is unknown here and
  /// irrelevant to the gate - [requiresAction] is taken straight from the
  /// server's pre-check (every pending item requires action).
  LegalStatus _statusFromHomeLegal(HomeLegal legal) => LegalStatus(
        items: legal.pending
            .map((p) => LegalStatusItem(
                  documentType: p.documentType,
                  currentVersion: p.currentVersion,
                  acceptedVersion: null,
                  requiresAction: true,
                ))
            .toList(growable: false),
      );

  /// Fetches the authoritative acceptance status and resolves the gate. This is
  /// the source of truth for the retry path and the auth-flow pre-nav check;
  /// the boot path prefers the home-summary seed to save a round-trip.
  Future<void> reconcile() async {
    final result = await ref.read(legalRepositoryProvider).getStatus();
    result.when(
      success: (status) => state = LegalGateState(
        ready: true,
        status: status,
        reconcileFailed: false,
      ),
      // Fail open: mark the failure but don't block routing (see class doc).
      failure: (f) => state = LegalGateState(
        ready: true,
        status: state.status,
        reconcileFailed: true,
        failure: f,
      ),
    );
  }

  /// Re-runs [reconcile] after a failure (driven by the acceptance/error UI).
  Future<void> retry() => reconcile();

  /// Adopts the refreshed status returned by POST /legal/accept, flipping the
  /// gate without a re-fetch. The router re-evaluates and lets the user through
  /// once nothing is left pending.
  void markStatus(LegalStatus status) {
    state = LegalGateState(
      ready: true,
      status: status,
      reconcileFailed: false,
    );
  }

  /// Clears the gate on logout.
  void reset() {
    state = const LegalGateState.initial();
  }
}
