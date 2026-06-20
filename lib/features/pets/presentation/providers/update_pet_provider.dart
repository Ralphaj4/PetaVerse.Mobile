import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/new_pet.dart';
import '../../domain/entities/pet.dart';
import 'pet_repository_provider.dart';

part 'update_pet_provider.g.dart';

@riverpod
class UpdatePetNotifier extends _$UpdatePetNotifier {
  @override
  AsyncValue<Pet?> build() => const AsyncData(null);

  Future<Pet?> update(int petId, NewPet data) async {
    state = const AsyncLoading();
    final result =
        await ref.read(petRepositoryProvider).updatePet(petId, data);
    return result.when(
      success: (pet) {
        state = AsyncData(pet);
        return pet;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }

  Failure? get lastFailure =>
      state.error is Failure ? state.error as Failure : null;
}
