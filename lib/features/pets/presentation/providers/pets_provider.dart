import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/presentation/providers/session_provider.dart';
import '../../domain/entities/pet_ref.dart';
import 'pet_repository_provider.dart';

part 'pets_provider.g.dart';

/// Pet routing-gate state, read synchronously by the router's redirect.
///
/// Holds only lightweight [PetRef]s ({id, name, image}) — enough to answer
/// "does the user have a pet?" and to point at the current pet. Full records
/// (breed, DOB, gender) are NOT here; display screens fetch those on demand.
///
/// [ready] flips true once the gate has a usable answer (a cache hydrate or
/// an authoritative fetch). Until then the router holds the current screen.
///
/// The offline edge case matters: when the cache is empty AND the
/// authoritative fetch fails, [hasPets] is false but [reconcileFailed] is
/// true — the router must NOT send such a user to pet onboarding (they may
/// own pets on another device), it must hold on a retryable gate instead.
class PetsState {
  const PetsState({
    required this.ready,
    required this.refs,
    required this.reconcileFailed,
    this.currentPetId,
    this.failure,
  });

  const PetsState.initial()
      : ready = false,
        refs = const [],
        reconcileFailed = false,
        currentPetId = null,
        failure = null;

  final bool ready;

  /// Lightweight identities of the user's pets.
  final List<PetRef> refs;

  /// True when the last authoritative fetch failed (offline / server error).
  final bool reconcileFailed;

  /// The active pet for downstream screens; defaults to the first pet.
  final int? currentPetId;

  /// The failure behind [reconcileFailed], for surfacing a retry message.
  final Failure? failure;

  bool get hasPets => refs.isNotEmpty;

  /// The active pet, or null if none is selected (or the id no longer maps).
  PetRef? get currentPet {
    for (final r in refs) {
      if (r.id == currentPetId) return r;
    }
    return null;
  }

  /// We can't confidently route: no pets known AND the fetch failed, so the
  /// emptiness is unconfirmed. The router holds and offers a retry.
  bool get unresolvedEmpty => ready && !hasPets && reconcileFailed;
}

/// Gate for "does the signed-in user have a pet", driving post-auth routing.
///
/// Mirrors the session gate: synchronous state, hydrate-from-cache then
/// reconcile-from-API, with an explicit-set guard so a late async completion
/// can't clobber a reset (logout) that happened first.
@Riverpod(keepAlive: true)
class PetsNotifier extends _$PetsNotifier {
  @override
  PetsState build() {
    // Drive the gate off the session: reconcile when the user becomes
    // logged-in (login / verify / cold start with a stored token), reset on
    // logout. Reading the session here also resolves the cold-start case —
    // the gate is built on the first router redirect, by which time the
    // session has hydrated.
    ref.listen(sessionProvider, (previous, next) {
      final wasLoggedIn = previous?.loggedIn ?? false;
      if (next.ready && next.loggedIn && !wasLoggedIn) {
        reconcile();
      } else if (previous != null && wasLoggedIn && !next.loggedIn) {
        reset();
      }
    });

    // Cold start: the session may already be logged-in by the time this gate
    // is first built, in which case the listener above won't fire for it.
    final session = ref.read(sessionProvider);
    if (session.ready && session.loggedIn) {
      Future.microtask(reconcile);
    }

    return const PetsState.initial();
  }

  /// Loads the gate: hydrate from the ref cache for an instant answer, then
  /// fetch refs from the API (the source of truth) and reconcile.
  ///
  /// Call this once the session is logged-in (after login/verify and on a
  /// cold start with a stored session).
  Future<void> reconcile() async {
    final repo = ref.read(petRepositoryProvider);

    // Restore the persisted selection so a cold start doesn't clear currentPet.
    final persistedId = await repo.cachedCurrentPetId();

    // 1. Instant answer from cache (may be stale, may be empty).
    final cached = await repo.cachedRefs();
    final cachedRefs = cached.valueOrNull ?? const <PetRef>[];
    if (cachedRefs.isNotEmpty) {
      state = _resolved(cachedRefs,
          reconcileFailed: false, currentPetId: persistedId);
    }

    // 2. Authoritative fetch; the API always wins.
    final fetched = await repo.fetchRefs();
    fetched.when(
      success: (refs) =>
          state = _resolved(refs, reconcileFailed: false, currentPetId: persistedId),
      failure: (f) {
        // Keep the cached list if we had one; otherwise mark the emptiness
        // as unconfirmed so the router holds instead of routing to onboarding.
        state = _resolved(cachedRefs,
            reconcileFailed: true, currentPetId: persistedId, failure: f);
      },
    );
  }

  /// Re-runs [reconcile] after a failure (driven by the onboarding/error UI).
  Future<void> retry() => reconcile();

  /// Optimistically adds a just-created pet from the slim create response —
  /// no re-fetch. Flips [PetsState.hasPets] true instantly and makes the new
  /// pet the current one. The next [reconcile] reconciles any drift.
  void addCreatedPet(PetRef petRef) {
    state = _resolved(
      [...state.refs, petRef],
      reconcileFailed: false,
      currentPetId: petRef.id,
    );
    ref.read(petRepositoryProvider).saveCurrentPetId(petRef.id);
  }

  /// Selects the active pet for downstream screens.
  void selectPet(int petId) {
    if (!state.refs.any((r) => r.id == petId)) return;
    state = PetsState(
      ready: state.ready,
      refs: state.refs,
      reconcileFailed: state.reconcileFailed,
      currentPetId: petId,
      failure: state.failure,
    );
    ref.read(petRepositoryProvider).saveCurrentPetId(petId);
  }

  /// Removes a deleted pet from the gate instantly. If it was the active pet,
  /// [_resolved] auto-selects the first remaining one (or routes to select-pet
  /// if none remain). The next [reconcile] confirms with the API.
  void removePet(int petId) {
    final remaining = state.refs.where((r) => r.id != petId).toList();
    // Pass null for currentPetId so _resolved picks the best candidate from
    // the remaining list rather than keeping a stale id.
    final nextCurrentId =
        state.currentPetId == petId ? null : state.currentPetId;
    state = _resolved(remaining,
        reconcileFailed: state.reconcileFailed, currentPetId: nextCurrentId);
    // Persist the new selection (or clear it if no pet remains).
    final repo = ref.read(petRepositoryProvider);
    if (state.currentPetId != null) {
      repo.saveCurrentPetId(state.currentPetId!);
    }
  }

  /// Clears the gate and the cache on logout.
  Future<void> reset() async {
    await ref.read(petRepositoryProvider).clearCache();
    state = const PetsState.initial();
  }

  /// Resolves the gate to [refs] and decides the current pet:
  ///   • an explicit [currentPetId] wins (e.g. a just-created pet),
  ///   • else a still-present existing selection is kept,
  ///   • else a SINGLE pet is auto-selected (no need to ask),
  ///   • else (2+ pets, no selection) it stays null so the router shows the
  ///     pet-selection page.
  PetsState _resolved(
    List<PetRef> refs, {
    required bool reconcileFailed,
    int? currentPetId,
    Failure? failure,
  }) {
    final ids = refs.map((r) => r.id).toSet();
    final int? selected;
    if (currentPetId != null) {
      selected = currentPetId;
    } else if (ids.contains(state.currentPetId)) {
      selected = state.currentPetId;
    } else if (refs.length == 1) {
      selected = refs.first.id;
    } else {
      selected = null;
    }
    return PetsState(
      ready: true,
      refs: refs,
      reconcileFailed: reconcileFailed,
      currentPetId: selected,
      failure: failure,
    );
  }
}
