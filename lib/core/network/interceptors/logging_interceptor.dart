import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/logger_service.dart';

/// Logs requests/responses through [LoggerService].
///
/// Request/response bodies are logged ONLY in debug builds — they may
/// contain tokens or personal data, so they are never emitted in release.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor(this._logger);

  final LoggerService _logger;

  static const String _tag = 'API';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('--> ${options.method} ${options.uri}', tag: _tag);
    if (kDebugMode && options.data != null) {
      _logger.debug('    body: ${_pretty(options.data)}', tag: _tag);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.debug(
      '<-- ${response.statusCode} ${response.requestOptions.uri}',
      tag: _tag,
    );
    if (kDebugMode && response.data != null) {
      _logger.debug('    response: ${_pretty(response.data)}', tag: _tag);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      '<-- ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.uri}',
      tag: _tag,
    );
    if (kDebugMode && err.response?.data != null) {
      _logger.error('    response: ${_pretty(err.response!.data)}', tag: _tag);
    }
    handler.next(err);
  }

  /// Pretty-prints maps/lists as indented JSON; falls back to toString().
  String _pretty(Object? data) {
    if (data is Map || data is List) {
      try {
        return const JsonEncoder.withIndent('  ').convert(data);
      } catch (_) {
        return data.toString();
      }
    }
    return data.toString();
  }
}
