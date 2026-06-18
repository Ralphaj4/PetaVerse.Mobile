import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import '../errors/app_exception.dart';
import '../storage/secure_storage_service.dart';
import '../utils/logger_service.dart';
import 'interceptors/auth_interceptor.dart';
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
      AuthInterceptor(secureStorage: secureStorage, refreshDio: refreshDio),
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
        // The backend returns RFC 7807 ProblemDetails: the human-readable
        // text is in `detail` (legacy `message` kept as a fallback).
        final message = body is Map<String, dynamic>
            ? (body['detail'] as String? ??
                body['message'] as String? ??
                body['title'] as String? ??
                'Request failed')
            : 'Request failed with status $status';
        if (status == 401) return UnauthorizedException(message);
        if (status == 403) return ForbiddenException(message);
        if (status == 404) return NotFoundException(message);
        if (status == 400 || status == 422) {
          return ValidationException(
            message,
            fieldErrors: _extractFieldErrors(body),
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

  Map<String, String> _extractFieldErrors(dynamic body) {
    if (body is! Map<String, dynamic>) return const {};
    final errors = body['errors'];
    if (errors is! Map<String, dynamic>) return const {};
    return errors.map((key, value) => MapEntry(key, value.toString()));
  }
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(
      secureStorage: ref.watch(secureStorageServiceProvider),
      logger: ref.watch(loggerServiceProvider),
    );

@Riverpod(keepAlive: true)
LoggerService loggerService(Ref ref) => const LoggerService();
