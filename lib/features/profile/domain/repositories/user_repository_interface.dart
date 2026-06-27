import '../../../../core/errors/result.dart';
import '../entities/user.dart';

abstract interface class IUserRepository {
  /// Reads the locally cached profile. Returns null (success) when nothing
  /// is cached — never hits the network.
  Future<Result<User?>> cachedProfile();

  /// Fetches the authoritative profile from `/users/me` and reconciles the
  /// local cache with it.
  Future<Result<User>> fetchProfile();

  Future<Result<User>> updateProfile({
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dateOfBirth,
  });

  /// Drops the cached profile. Called on logout.
  Future<void> clearCache();
}
