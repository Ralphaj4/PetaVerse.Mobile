import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';
import '../../../profile/data/providers/user_repository_provider.dart';

part 'user_usecases_provider.g.dart';

@riverpod
GetCachedUserProfileUsecase getCachedUserProfileUsecase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetCachedUserProfileUsecase(repository);
}

@riverpod
FetchUserProfileUsecase fetchUserProfileUsecase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return FetchUserProfileUsecase(repository);
}

@riverpod
UpdateUserProfileUsecase updateUserProfileUsecase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUserProfileUsecase(repository);
}
