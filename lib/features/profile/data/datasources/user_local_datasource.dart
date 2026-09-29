import '../../../../core/storage/hive_service.dart';
import '../dtos/user_dto.dart';

/// Local cache of the signed-in user's profile, in the `user` Hive box
/// under the single `me` key.
///
/// Warmed at login/verify time (a blocking `/me` fetch) so the Personal
/// Information page can render instantly offline-first and reconcile in the
/// background. The box is cleared on logout, so it only ever holds the
/// currently signed-in user's data.
class UserLocalDataSource {
  const UserLocalDataSource(this._hive);

  final HiveService _hive;

  static const String _box = 'user';
  static const String _meKey = 'me';

  /// Reads the cached profile. Returns null when nothing is cached.
  Future<UserDto?> readUser() async {
    final json = await _hive.getJson(_box, _meKey);
    if (json == null) return null;
    return UserDto.fromJson(json);
  }

  /// Replaces the cached profile with [user].
  Future<void> writeUser(UserDto user) async {
    await _hive.putJson(_box, _meKey, user.toJson());
  }

  /// Drops the cached profile. Called on logout.
  Future<void> clear() => _hive.clearBox(_box);
}
