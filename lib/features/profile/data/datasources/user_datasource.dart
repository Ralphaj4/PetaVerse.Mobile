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
      // ignore: avoid_print
      print('[USER_DS] getProfile: calling ${ApiEndpoints.usersMe}');
      final json = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.usersMe,
      );
      // ignore: avoid_print
      print('[USER_DS] getProfile: raw json = $json');
      final dto = UserDto.fromJson(json);
      // ignore: avoid_print
      print('[USER_DS] getProfile: parsed dto OK id=${dto.id}');
      return Result.success(dto);
    } catch (e, st) {
      // ignore: avoid_print
      print('[USER_DS] getProfile: ERROR $e\n$st');
      return Result.failure(_mapException(e));
    }
  }

  @override
  Future<Result<UserDto>> updateProfile(UpdateProfileRequest request) async {
    try {
      // PUT returns only the edited fields (not a full user), so we ignore its
      // body and refetch the authoritative profile via GET /users/me.
      await _apiClient.put<Map<String, dynamic>>(
        ApiEndpoints.usersProfile,
        data: request.toJson(),
      );
      return getProfile();
    } catch (e) {
      return Result.failure(_mapException(e));
    }
  }

  Failure _mapException(dynamic e) {
    if (e is Failure) return e;
    return ServerFailure(message: e.toString());
  }
}
