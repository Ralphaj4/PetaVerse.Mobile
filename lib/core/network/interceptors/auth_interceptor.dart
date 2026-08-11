import 'package:dio/dio.dart';

import '../../storage/secure_storage_service.dart';
import '../../utils/logger_service.dart';
import '../api_endpoints.dart';
import '../auth_events.dart';

/// Outcome of a refresh attempt. Distinguishes a session the backend actually
/// killed (→ log out) from a refresh we simply couldn't complete because the
/// server never answered in time (→ keep the tokens; the session may still be
/// fine).
enum _RefreshOutcome {
  /// New token pair persisted; retry the original request.
  success,

  /// Backend rejected the refresh token (401/400) or returned an unusable body.
  /// The session is unrecoverable — clear tokens and redirect to login.
  rejected,

  /// The refresh call could not reach a verdict (timeout, connection refused,
  /// server restarting, 5xx). We do NOT know the session is dead, so tokens are
  /// left intact and the original request is allowed to fail with its network
  /// error. The next request refreshes again once the server responds. (This is
  /// also what a debugger breakpoint held past the receive timeout looks like.)
  inconclusive,
}

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

  /// In-flight refresh, shared across all concurrent 401s. The backend rotates
  /// the refresh token on every refresh, so if N requests each fired their own
  /// refresh with the same stored token, the first would rotate it and the rest
  /// would POST a now-consumed token → rejected → session wiped. Single-flight
  /// guarantees exactly one refresh runs; every other 401 awaits its result and
  /// then retries with the freshly-persisted access token.
  Future<_RefreshOutcome>? _refreshing;

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

    final outcome = await _refreshOnce();
    switch (outcome) {
      case _RefreshOutcome.rejected:
        // Backend positively rejected the refresh token — session is dead.
        await _endSession('token refresh rejected');
        handler.next(err);
        return;
      case _RefreshOutcome.inconclusive:
        // We never got a verdict (timeout / unreachable / 5xx). Do NOT clear
        // tokens — the session may still be valid. Fail this one request with
        // its original error; the next request will refresh again.
        _logger.warning(
          'Token refresh inconclusive (server unreachable); keeping tokens.',
          tag: _tag,
        );
        handler.next(err);
        return;
      case _RefreshOutcome.success:
        break;
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
      // Only a real 401 here means the freshly-issued access token is already
      // dead → session gone. If the replay merely timed out or couldn't reach
      // the server, keep the tokens (consistent with the inconclusive path) and
      // just surface the error — the refresh itself had just succeeded.
      if (retryError.response?.statusCode == 401) {
        await _endSession('retry after refresh still unauthorized');
      }
      handler.next(retryError);
    }
  }

  /// Runs the refresh at most once at a time. The first caller starts it and
  /// stores the future; concurrent callers await that same future instead of
  /// starting a competing refresh with the same (about-to-be-rotated) token.
  Future<_RefreshOutcome> _refreshOnce() {
    final inFlight = _refreshing;
    if (inFlight != null) return inFlight;

    final future = _tryRefreshToken().whenComplete(() => _refreshing = null);
    _refreshing = future;
    return future;
  }

  Future<_RefreshOutcome> _tryRefreshToken() async {
    final refreshToken = await _secureStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _logger.warning('No refresh token stored; cannot refresh.', tag: _tag);
      return _RefreshOutcome.rejected;
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
          return _RefreshOutcome.rejected;
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
          return _RefreshOutcome.rejected;
        }
        // Persist the rotated pair — the backend rotates the refresh token on
        // every refresh, so saving the new one is what keeps the 7-day window
        // sliding forward instead of expiring on the original token.
        await _secureStorage.saveTokens(
          accessToken: newAccess,
          refreshToken: newRefresh,
        );
        return _RefreshOutcome.success;
      } on DioException catch (e) {
        // A 401/400 is the backend positively rejecting the refresh token: the
        // session is dead and no retry will help. Anything else (timeout,
        // connection error, 5xx, a debugger breakpoint held past the receive
        // timeout) means we simply never got a verdict — retry, and if we run
        // out of attempts report inconclusive so the caller KEEPS the tokens.
        if (_isRejection(e)) {
          _logger.warning(
            'Refresh token rejected by backend (${e.response?.statusCode}).',
            tag: _tag,
          );
          return _RefreshOutcome.rejected;
        }
        if (attempt == maxRetries) {
          _logger.error(
            'Token refresh inconclusive after $maxRetries attempts '
            '(server unreachable / too slow).',
            tag: _tag,
            error: e,
          );
          return _RefreshOutcome.inconclusive;
        }
        _logger.warning(
          'Token refresh attempt $attempt did not complete; retrying.',
          tag: _tag,
        );
        // Brief delay before retry
        await Future.delayed(Duration(milliseconds: 100 * attempt));
      }
    }
    return _RefreshOutcome.inconclusive;
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

  /// Whether the backend positively rejected the refresh token — the only
  /// condition under which the session should be ended. A 401 means the token
  /// is invalid/expired/revoked; a 400 means it was malformed. Every other
  /// failure (timeout, connection error, 5xx) is inconclusive, not a rejection,
  /// and must never trigger a logout on its own.
  bool _isRejection(DioException e) {
    final status = e.response?.statusCode;
    return status == 401 || status == 400;
  }
}
