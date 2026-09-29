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
    _emit('--> ${options.method} ${options.uri}');
    if (kDebugMode && options.data != null) {
      _emit('    body: ${_pretty(options.data)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _emit('<-- ${response.statusCode} ${response.requestOptions.uri}');
    if (kDebugMode && response.data != null) {
      _emit('    response: ${_pretty(response.data)}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _emit(
      '<-- ERROR ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.method} ${err.requestOptions.uri}',
      isError: true,
    );
    // Response body when the server answered (4xx/5xx with a payload).
    if (kDebugMode && err.response?.data != null) {
      _emit('    response: ${_pretty(err.response!.data)}', isError: true);
    }
    // The underlying error itself — crucial when there is NO response body,
    // e.g. a JSON parse/type-cast failure or a connection error, where the
    // above line alone wouldn't tell us what actually went wrong.
    if (kDebugMode) {
      _emit('    type: ${err.type.name}', isError: true);
      if (err.message != null) _emit('    message: ${err.message}', isError: true);
      if (err.error != null) _emit('    error: ${err.error}', isError: true);
    }
    handler.next(err);
  }

  /// Emits through both the [LoggerService] (DevTools) and [debugPrint] (the
  /// `flutter run` terminal), so the line is visible wherever you're looking.
  void _emit(String message, {bool isError = false}) {
    if (isError) {
      _logger.error(message, tag: _tag);
    } else {
      _logger.debug(message, tag: _tag);
    }
    if (kDebugMode) debugPrint('[$_tag] $message');
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
