import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import 'pet_repository_provider.dart';

part 'delete_pet_provider.g.dart';

@riverpod
class DeletePetNotifier extends _$DeletePetNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> delete(int petId) async {
    state = const AsyncLoading();
    final result = await ref.read(petRepositoryProvider).deletePet(petId);
    return result.when(
      success: (_) {
        state = const AsyncData(null);
        return true;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return false;
      },
    );
  }

  Failure? get failure => state.error is Failure ? state.error as Failure : null;
}
