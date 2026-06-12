import 'package:dio/dio.dart';

import '../../utils/logger_service.dart';

/// Logs requests/responses through [LoggerService].
///
/// Bodies and headers are intentionally NOT logged — they may contain
/// tokens or personal data.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor(this._logger);

  final LoggerService _logger;

  static const String _tag = 'API';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('--> ${options.method} ${options.uri}', tag: _tag);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.debug(
      '<-- ${response.statusCode} ${response.requestOptions.uri}',
      tag: _tag,
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      '<-- ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.uri}',
      tag: _tag,
    );
    handler.next(err);
  }
}
