import '../../../../core/errors/result.dart';
import '../entities/user.dart';
import '../repositories/user_repository_interface.dart';

class UpdateUserProfileUsecase {
  final IUserRepository _repository;

  UpdateUserProfileUsecase(this._repository);

  Future<Result<User>> call({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
  }) =>
      _repository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        dateOfBirth: dateOfBirth,
      );
}
