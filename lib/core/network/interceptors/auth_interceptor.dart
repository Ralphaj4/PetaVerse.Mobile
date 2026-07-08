import 'package:dio/dio.dart';

import '../../storage/secure_storage_service.dart';
import '../../utils/logger_service.dart';
import '../api_endpoints.dart';
import '../auth_events.dart';

/// Attaches the bearer token to every request and transparently refreshes
/// it once on a 401 before failing the call.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required SecureStorageService secureStorage,
    required Dio refreshDio,
    required AuthEvents authEvents,
    required LoggerService logger,
  })  : _secureStorage = secureStorage,
        _refreshDio = refreshDio,
        _authEvents = authEvents,
        _logger = logger;

  final SecureStorageService _secureStorage;

  /// A bare Dio (no interceptors) used only for the refresh call, so a
  /// failing refresh can never recurse.
  final Dio _refreshDio;

  /// Emits when the session dies unrecoverably; the session gate listens and
  /// redirects to login. Without this the tokens would be cleared but the
  /// app would keep thinking it was logged in.
  final AuthEvents _authEvents;

  final LoggerService _logger;

  static const String _tag = 'AUTH';

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
      await _endSession('token refresh failed');
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
      // Refresh succeeded but the replayed request still 401'd — the new
      // access token is already dead. Treat the session as gone.
      await _endSession('retry after refresh still unauthorized');
      handler.next(retryError);
    }
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken = await _secureStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _logger.warning('No refresh token stored; cannot refresh.', tag: _tag);
      return false;
    }

    const maxRetries = 3;
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final response = await _refreshDio.post<Map<String, dynamic>>(
          ApiEndpoints.refreshToken,
          data: {'refreshToken': refreshToken},
        );
        final body = response.data;
        if (body == null) {
          _logger.error('Refresh response had an empty body.', tag: _tag);
          return false;
        }
        // Read defensively: the backend's RefreshTokenResult is PascalCase C#
        // (AccessToken/RefreshToken), typically serialized camelCase. Accept
        // both casings so a serialization-policy change can never silently
        // null the tokens and log the user out prematurely.
        final newAccess = _readToken(body, 'accessToken', 'AccessToken');
        final newRefresh = _readToken(body, 'refreshToken', 'RefreshToken');
        if (newAccess == null ||
            newAccess.isEmpty ||
            newRefresh == null ||
            newRefresh.isEmpty) {
          _logger.error(
            'Refresh response missing access/refresh token '
            '(keys: ${body.keys.toList()}).',
            tag: _tag,
          );
          return false;
        }
        // Persist the rotated pair — the backend rotates the refresh token on
        // every refresh, so saving the new one is what keeps the 7-day window
        // sliding forward instead of expiring on the original token.
        await _secureStorage.saveTokens(
          accessToken: newAccess,
          refreshToken: newRefresh,
        );
        return true;
      } on DioException catch (e) {
        // If it's the last attempt or a non-retryable error, give up
        if (attempt == maxRetries || _isNonRetryableError(e)) {
          _logger.error(
            'Token refresh failed (attempt $attempt/$maxRetries).',
            tag: _tag,
            error: e,
          );
          return false;
        }
        _logger.warning(
          'Token refresh attempt $attempt failed; retrying.',
          tag: _tag,
        );
        // Brief delay before retry
        await Future.delayed(Duration(milliseconds: 100 * attempt));
      }
    }
    return false;
  }

  /// Reads a token value under any of the given [keys] (to tolerate camelCase
  /// vs PascalCase serialization), returning the first non-null String.
  String? _readToken(Map<String, dynamic> body, String key1, String key2) {
    final value = body[key1] ?? body[key2];
    return value is String ? value : null;
  }

  /// Clears the tokens and signals the session gate. Every place that gives up
  /// on auth must go through here so the app can never end up token-less but
  /// still believing it is logged in (which strands the user with 401s and no
  /// redirect to login).
  Future<void> _endSession(String reason) async {
    _logger.warning('Session ended: $reason. Clearing tokens.', tag: _tag);
    await _secureStorage.clearTokens();
    _authEvents.notifySessionExpired();
  }

  bool _isNonRetryableError(DioException e) {
    // Don't retry on 401 (invalid refresh token) or 400 (bad request)
    final status = e.response?.statusCode;
    return status == 401 || status == 400;
  }
}
