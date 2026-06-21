import '../../../../core/errors/result.dart';
import '../entities/user.dart';

abstract interface class IUserRepository {
  Future<Result<User>> getProfile();
  Future<Result<User>> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
  });
}
