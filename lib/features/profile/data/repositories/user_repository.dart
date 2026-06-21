import '../../../../core/errors/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository_interface.dart';
import '../dtos/update_profile_request.dart';
import '../datasources/user_datasource.dart';

class UserRepository implements IUserRepository {
  final IUserDatasource _datasource;

  UserRepository(this._datasource);

  @override
  Future<Result<User>> getProfile() async {
    final result = await _datasource.getProfile();
    return result.when(
      success: (dto) => Result.success(dto.toEntity()),
      failure: (f) => Result.failure(f),
    );
  }

  @override
  Future<Result<User>> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
  }) async {
    final request = UpdateProfileRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth,
    );
    final result = await _datasource.updateProfile(request);
    return result.when(
      success: (dto) => Result.success(dto.toEntity()),
      failure: (f) => Result.failure(f),
    );
  }
}
