import 'package:dio/dio.dart';

import '../../storage/secure_storage_service.dart';
import '../api_endpoints.dart';

/// Attaches the bearer token to every request and transparently refreshes
/// it once on a 401 before failing the call.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required SecureStorageService secureStorage,
    required Dio refreshDio,
  })  : _secureStorage = secureStorage,
        _refreshDio = refreshDio;

  final SecureStorageService _secureStorage;

  /// A bare Dio (no interceptors) used only for the refresh call, so a
  /// failing refresh can never recurse.
  final Dio _refreshDio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['auth_retried'] == true;
    if (!isUnauthorized || alreadyRetried) {
      handler.next(err);
      return;
    }

    final refreshed = await _tryRefreshToken();
    if (!refreshed) {
      await _secureStorage.clearTokens();
      handler.next(err);
      return;
    }

    try {
      // Mark as retried so we don't loop infinitely
      final options = err.requestOptions..extra['auth_retried'] = true;
      final token = await _secureStorage.readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await _refreshDio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryError) {
      await _secureStorage.clearTokens();
      handler.next(retryError);
    }
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken = await _secureStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return false;

    const maxRetries = 3;
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await _refreshDio.post<Map<String, dynamic>>(
          ApiEndpoints.refreshToken,
          data: {'refreshToken': refreshToken},
        );
        final data = response.data;
        final newAccess = data?['accessToken'] as String?;
        final newRefresh = data?['refreshToken'] as String?;
        if (newAccess == null || newRefresh == null) return false;
        await _secureStorage.saveTokens(
          accessToken: newAccess,
          refreshToken: newRefresh,
        );
        return true;
      } on DioException catch (e) {
        // If it's the last attempt or a non-retryable error, give up
        if (attempt == maxRetries || _isNonRetryableError(e)) {
          return false;
        }
        // Brief delay before retry
        await Future.delayed(Duration(milliseconds: 100 * attempt));
      }
    }
    return false;
  }

  bool _isNonRetryableError(DioException e) {
    // Don't retry on 401 (invalid refresh token) or 400 (bad request)
    final status = e.response?.statusCode;
    return status == 401 || status == 400;
  }
}
