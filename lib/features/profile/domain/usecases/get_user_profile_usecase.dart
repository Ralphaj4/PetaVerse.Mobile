import '../../../../core/errors/result.dart';
import '../entities/user.dart';
import '../repositories/user_repository_interface.dart';

/// Reads the locally cached profile (offline-first, no network). Returns
/// null when nothing is cached yet.
class GetCachedUserProfileUsecase {
  final IUserRepository _repository;

  GetCachedUserProfileUsecase(this._repository);

  Future<Result<User?>> call() => _repository.cachedProfile();
}

/// Fetches the authoritative profile from the server and reconciles the
/// local cache.
class FetchUserProfileUsecase {
  final IUserRepository _repository;

  FetchUserProfileUsecase(this._repository);

  Future<Result<User>> call() => _repository.fetchProfile();
}
