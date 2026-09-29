import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'secure_storage_service.g.dart';

/// Wrapper around [FlutterSecureStorage].
///
/// Access and refresh tokens live ONLY here — never in Hive or
/// SharedPreferences.
class SecureStorageService {
  SecureStorageService([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _cultureKey = 'culture';
  static const String _deviceIdKey = 'device_id';

  Future<String?> readCulture() => _storage.read(key: _cultureKey);

  Future<void> saveCulture(String culture) =>
      _storage.write(key: _cultureKey, value: culture);

  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  /// Returns the stable device identifier for this app installation, creating
  /// and persisting one (UUID v4) on first call. Survives app updates but not
  /// reinstalls (secure storage is cleared on uninstall on most platforms).
  Future<String> getOrCreateDeviceId() async {
    final existing = await _storage.read(key: _deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final id = const Uuid().v4();
    await _storage.write(key: _deviceIdKey, value: id);
    return id;
  }

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);
}

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) => SecureStorageService();
