import '../../../../core/errors/result.dart';
import '../entities/user.dart';
import '../repositories/user_repository_interface.dart';

class GetUserProfileUsecase {
  final IUserRepository _repository;

  GetUserProfileUsecase(this._repository);

  Future<Result<User>> call() => _repository.getProfile();
}
