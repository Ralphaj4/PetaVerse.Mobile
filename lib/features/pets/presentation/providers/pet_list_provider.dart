import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/pet.dart';
import 'pet_repository_provider.dart';

part 'pet_list_provider.g.dart';

/// Full pet records for display screens (Profile, the pet picker), offline-first.
///
/// Cache-first: the cached list renders instantly, then a background fetch
/// reconciles it and updates the cache. On a network failure the cached list
/// stays visible (the error only surfaces when there's nothing cached).
///
/// Independent of the routing gate, which tracks only lightweight refs. Call
/// [refresh] to reconcile (e.g. when the Profile tab opens or after a
/// create/edit/delete); concurrent calls are coalesced.
@riverpod
class PetListNotifier extends _$PetListNotifier {
  bool _refreshing = false;

  @override
  Future<List<Pet>> build() async {
    final repo = ref.read(petRepositoryProvider);
    final cached = (await repo.cachedPets()).valueOrNull ?? const <Pet>[];
    if (cached.isNotEmpty) {
      // Show the cache immediately, reconcile in the background.
      unawaited(Future.microtask(refresh));
      return cached;
    }
    // Nothing cached — block on the network for the first load.
    return _fetch();
  }

  /// Reconciles with the API in place (no loading flash), keeping the current
  /// list visible on failure. Coalesces overlapping calls.
  Future<void> refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    try {
      state = AsyncData(await _fetch());
    } catch (e, st) {
      // Keep whatever we're showing; only surface the error if we have nothing.
      if (!state.hasValue) state = AsyncError(e, st);
    } finally {
      _refreshing = false;
    }
  }

  Future<List<Pet>> _fetch() async {
    final result = await ref.read(petRepositoryProvider).getPets();
    return result.when(
      success: (pets) => pets,
      failure: (f) => throw f,
    );
  }
}
