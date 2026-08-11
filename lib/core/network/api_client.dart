import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import '../errors/app_exception.dart';
import '../storage/secure_storage_service.dart';
import '../utils/logger_service.dart';
import '../localization/culture_provider.dart';
import 'auth_events.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/culture_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

part 'api_client.g.dart';

/// The single HTTP gateway of the app.
///
/// Every network request flows through this class — it owns auth headers,
/// token refresh, retry policy, logging, and error mapping. Data sources
/// receive this, never a raw Dio.
class ApiClient {
  ApiClient({
    required SecureStorageService secureStorage,
    required LoggerService logger,
    required String Function() cultureCode,
    required AuthEvents authEvents,
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConstants.apiBaseUrl,
                connectTimeout: AppConstants.connectTimeout,
                receiveTimeout: AppConstants.receiveTimeout,
                contentType: Headers.jsonContentType,
              ),
            ) {
    final refreshDio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        contentType: Headers.jsonContentType,
      ),
    );
    _dio.interceptors.addAll([
      CultureInterceptor(cultureCode),
      AuthInterceptor(
        secureStorage: secureStorage,
        refreshDio: refreshDio,
        authEvents: authEvents,
        logger: logger,
      ),
      RetryInterceptor(_dio),
      LoggingInterceptor(logger),
    ]);
  }

  final Dio _dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      _request(() => _dio.get<T>(path, queryParameters: queryParameters));

  Future<T> post<T>(String path, {Object? data}) =>
      _request(() => _dio.post<T>(path, data: data));

  Future<T> put<T>(String path, {Object? data}) =>
      _request(() => _dio.put<T>(path, data: data));

  Future<T> patch<T>(String path, {Object? data}) =>
      _request(() => _dio.patch<T>(path, data: data));

  Future<T> delete<T>(String path) => _request(() => _dio.delete<T>(path));

  /// DELETE with a request body. Some endpoints (e.g. PawHub unlike / unsave /
  /// unfollow / unblock) identify the acting pet in the body even on a DELETE.
  Future<T> deleteWithBody<T>(String path, {Object? data}) =>
      _request(() => _dio.delete<T>(path, data: data));

  Future<T> _request<T>(Future<Response<T>> Function() send) async {
    try {
      final response = await send();
      return response.data as T;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  /// Maps transport errors to internal [AppException]s. Repositories turn
  /// these into [Failure]s — raw Dio errors never leave this class.
  AppException _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkException(e.message ?? 'Network error');
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        final body = e.response?.data;
        final message = _extractErrorMessage(body, status);
        if (status == 401) return UnauthorizedException(message);
        if (status == 403) return ForbiddenException(message);
        if (status == 404) return NotFoundException(message);
        if (status == 400 || status == 422) {
          return ValidationException(
            message,
            fieldErrors: _extractFieldErrors(body),
          );
        }
        if (status == 429) {
          return RateLimitException(
            message,
            retryAfter: _extractRetryAfter(e.response),
          );
        }
        if (status >= 500) return ServerException(message);
        return ServerException(message);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return NetworkException(e.message ?? 'Unexpected network error');
    }
  }

  /// Extracts the server's human-facing error message from the body, or `''`
  /// when none is present. We intentionally do NOT synthesize a technical
  /// fallback (e.g. "Server error") here: an empty message lets the
  /// presentation layer ([FailureL10n.localizedMessage]) fall back to a proper
  /// localized string instead of showing a raw status line to the user.
  String _extractErrorMessage(dynamic body, int status) {
    if (body is! Map<String, dynamic>) return '';
    // RFC 7807 ProblemDetails: detail > message > title.
    return body['detail'] as String? ??
        body['message'] as String? ??
        body['title'] as String? ??
        '';
  }

  /// Parses the `Retry-After` header (delta-seconds form, per the API's 429
  /// contract). Returns null when absent or unparseable.
  Duration? _extractRetryAfter(Response<dynamic>? response) {
    final raw = response?.headers.value('retry-after');
    if (raw == null) return null;
    final seconds = int.tryParse(raw.trim());
    return seconds == null ? null : Duration(seconds: seconds);
  }

  Map<String, String> _extractFieldErrors(dynamic body) {
    if (body is! Map<String, dynamic>) return const {};
    final errors = body['errors'];
    if (errors is! Map<String, dynamic>) return const {};
    return errors.map((key, value) => MapEntry(key, value.toString()));
  }
}

/// App-wide auth event bus. The [ApiClient]'s interceptor emits on it when a
/// session dies; the session gate listens and redirects to login.
@Riverpod(keepAlive: true)
AuthEvents authEvents(Ref ref) {
  final events = AuthEvents();
  ref.onDispose(events.dispose);
  return events;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(
      secureStorage: ref.watch(secureStorageServiceProvider),
      logger: ref.watch(loggerServiceProvider),
      cultureCode: () => ref.read(cultureProvider).code,
      authEvents: ref.watch(authEventsProvider),
    );

@Riverpod(keepAlive: true)
LoggerService loggerService(Ref ref) => const LoggerService();
