import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/new_pet.dart';
import '../../domain/entities/pet_ref.dart';
import 'pet_list_provider.dart';
import 'pet_repository_provider.dart';
import 'pets_provider.dart';

part 'create_pet_provider.g.dart';

/// Drives the create-pet submission state.
///
/// The AsyncValue carries loading + the last [Failure] (for a spinner and a
/// localized error), while [create] returns a bool for the page's navigation.
@riverpod
class CreatePetNotifier extends _$CreatePetNotifier {
  @override
  FutureOr<void> build() {}

  /// The failure from the most recent attempt, or null if it succeeded.
  Failure? get lastFailure {
    final err = state.error;
    return err is Failure ? err : null;
  }

  /// Creates the pet. On success returns the slim [PetRef] from the API
  /// response. The caller is responsible for navigating first, then calling
  /// [commitCreated] — this avoids a race where the gate update fires the
  /// router redirect before the page has had a chance to pop/go.
  Future<PetRef?> create(NewPet pet) async {
    state = const AsyncLoading();
    final result = await ref.read(petRepositoryProvider).createPet(pet);
    return result.when(
      success: (petRef) {
        state = const AsyncData(null);
        return petRef;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }

  /// Updates the routing gate and invalidates the display list. Call this
  /// AFTER navigating away from the create-pet page so the redirect triggered
  /// by the gate update never races with the pending pop.
  void commitCreated(PetRef petRef) {
    ref.read(petsProvider.notifier).addCreatedPet(petRef);
    ref.invalidate(petListProvider);
  }
}
