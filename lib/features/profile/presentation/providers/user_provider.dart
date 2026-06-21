import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user.dart';
import 'user_usecases_provider.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<User> build() async {
    final usecase = ref.read(getUserProfileUsecaseProvider);
    final result = await usecase();
    return result.when(
      success: (user) => user,
      failure: (failure) => throw failure,
    );
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
  }) async {
    final usecase = ref.read(updateUserProfileUsecaseProvider);
    final result = await usecase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth,
    );

    result.when(
      success: (user) {
        state = AsyncValue.data(user);
      },
      failure: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final usecase = ref.read(getUserProfileUsecaseProvider);
    final result = await usecase();

    result.when(
      success: (user) {
        state = AsyncValue.data(user);
      },
      failure: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }
}
