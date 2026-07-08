import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository_interface.dart';
import '../datasources/user_datasource.dart';
import '../datasources/user_local_datasource.dart';
import '../dtos/update_profile_request.dart';

/// User profile repository (offline-first).
///
/// The cache is warmed at login/verify time, so [cachedProfile] gives the
/// Personal Information page an instant render and [fetchProfile] reconciles
/// it in the background. Both [fetchProfile] and [updateProfile] keep the
/// local cache in step with the authoritative server record.
class UserRepository implements IUserRepository {
  final IUserDatasource _remote;
  final UserLocalDataSource _local;

  UserRepository(this._remote, this._local);

  @override
  Future<Result<User?>> cachedProfile() async {
    try {
      final dto = await _local.readUser();
      return Result.success(dto?.toEntity());
    } catch (e) {
      // A corrupt/unreadable cache is not fatal — reconcile from the network.
      return const Result.success(null);
    }
  }

  @override
  Future<Result<User>> fetchProfile() async {
    // ignore: avoid_print
    print('[USER_REPO] fetchProfile: start');
    final result = await _remote.getProfile();
    final dto = result.valueOrNull;
    // ignore: avoid_print
    print('[USER_REPO] fetchProfile: dto=${dto?.id} '
        'failure=${result.failureOrNull}');
    if (dto == null) {
      return Result.failure(result.failureOrNull ?? const UnknownFailure());
    }
    // Best-effort cache reconcile — a write failure doesn't fail the fetch.
    try {
      await _local.writeUser(dto);
      // ignore: avoid_print
      print('[USER_REPO] fetchProfile: cache write OK');
    } catch (e) {
      // ignore: avoid_print
      print('[USER_REPO] fetchProfile: cache write FAILED $e');
    }
    // ignore: avoid_print
    print('[USER_REPO] fetchProfile: returning success');
    return Result.success(dto.toEntity());
  }

  @override
  Future<Result<User>> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
    double? latitude,
    double? longitude,
    String? locationName,
  }) async {
    final request = UpdateProfileRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
    );
    final result = await _remote.updateProfile(request);
    final dto = result.valueOrNull;
    if (dto == null) {
      return Result.failure(result.failureOrNull ?? const UnknownFailure());
    }
    try {
      await _local.writeUser(dto);
    } catch (_) {}
    return Result.success(dto.toEntity());
  }

  @override
  Future<void> clearCache() => _local.clear();
}
