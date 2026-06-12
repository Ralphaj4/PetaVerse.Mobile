import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger_service.dart';

part 'analytics_service.g.dart';

/// Analytics abstraction.
///
/// The app codes against this interface; the production implementation
/// forwards to Firebase Analytics once the Firebase project is configured
/// (see README). Until then a logger-backed implementation is wired in,
/// so every screen already emits the right events.
abstract interface class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, Object?> parameters});

  Future<void> setUserId(String? userId);

  Future<void> logScreenView(String screenName);
}

/// Development implementation — writes events to the log.
class DebugAnalyticsService implements AnalyticsService {
  DebugAnalyticsService(this._logger);

  final LoggerService _logger;

  static const String _tag = 'ANALYTICS';

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) async {
    _logger.info('event: $name $parameters', tag: _tag);
  }

  @override
  Future<void> setUserId(String? userId) async {
    _logger.info('setUserId: ${userId == null ? 'cleared' : 'set'}',
        tag: _tag);
  }

  @override
  Future<void> logScreenView(String screenName) async {
    _logger.info('screen: $screenName', tag: _tag);
  }
}

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) =>
    DebugAnalyticsService(const LoggerService());
