import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dtos/update_profile_request.dart';
import '../dtos/user_dto.dart';

abstract interface class IUserDatasource {
  Future<Result<UserDto>> getProfile();
  Future<Result<UserDto>> updateProfile(UpdateProfileRequest request);
}

class UserDatasource implements IUserDatasource {
  final ApiClient _apiClient;

  UserDatasource(this._apiClient);

  @override
  Future<Result<UserDto>> getProfile() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.usersMe);
      final dto = UserDto.fromJson(response.data as Map<String, dynamic>);
      return Result.success(dto);
    } catch (e) {
      return Result.failure(_mapException(e));
    }
  }

  @override
  Future<Result<UserDto>> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoints.usersProfile,
        data: request,
      );
      final dto = UserDto.fromJson(response.data as Map<String, dynamic>);
      return Result.success(dto);
    } catch (e) {
      return Result.failure(_mapException(e));
    }
  }

  Failure _mapException(dynamic e) {
    if (e is Failure) return e;
    return ServerFailure(message: e.toString());
  }
}
