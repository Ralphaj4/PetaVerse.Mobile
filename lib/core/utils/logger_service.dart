import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Log severity, ordered.
enum LogLevel { verbose, debug, info, warning, error }

/// Central logging service.
///
/// Verbose in development, errors-only in production builds.
/// Never log passwords, tokens, or personal data.
class LoggerService {
  const LoggerService();

  static const LogLevel _minLevel =
      kReleaseMode ? LogLevel.error : LogLevel.verbose;

  void verbose(String message, {String tag = 'APP'}) =>
      _log(LogLevel.verbose, message, tag: tag);

  void debug(String message, {String tag = 'APP'}) =>
      _log(LogLevel.debug, message, tag: tag);

  void info(String message, {String tag = 'APP'}) =>
      _log(LogLevel.info, message, tag: tag);

  void warning(String message, {String tag = 'APP'}) =>
      _log(LogLevel.warning, message, tag: tag);

  void error(
    String message, {
    String tag = 'APP',
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _log(
        LogLevel.error,
        message,
        tag: tag,
        error: error,
        stackTrace: stackTrace,
      );

  void _log(
    LogLevel level,
    String message, {
    required String tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level.index < _minLevel.index) return;
    developer.log(
      message,
      name: tag,
      level: 500 + level.index * 100,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
