import 'package:dio/dio.dart';

/// Retries idempotent (GET) requests that failed with a transient network
/// error, with exponential backoff.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio, {this.maxRetries = 2});

  final Dio _dio;
  final int maxRetries;

  static const _retriableTypes = {
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.connectionError,
  };

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;
    final isIdempotent = err.requestOptions.method.toUpperCase() == 'GET';
    final isTransient = _retriableTypes.contains(err.type);

    if (!isIdempotent || !isTransient || attempt >= maxRetries) {
      handler.next(err);
      return;
    }

    await Future<void>.delayed(Duration(milliseconds: 300 * (attempt + 1)));
    try {
      final options = err.requestOptions
        ..extra['retry_attempt'] = attempt + 1;
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
