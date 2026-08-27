import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger_service.dart';

part 'analytics_service.g.dart';

abstract interface class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, Object?> parameters});
  Future<void> setUserId(String? userId);
  Future<void> logScreenView(String screenName);
}

class FirebaseAnalyticsService implements AnalyticsService {
  FirebaseAnalyticsService() : _analytics = FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) =>
      _analytics.logEvent(
        name: name,
        parameters: parameters.isEmpty
            ? null
            : parameters.map((k, v) => MapEntry(k, v ?? '')),
      );

  @override
  Future<void> setUserId(String? userId) =>
      _analytics.setUserId(id: userId);

  @override
  Future<void> logScreenView(String screenName) =>
      _analytics.logScreenView(screenName: screenName);
}

class DebugAnalyticsService implements AnalyticsService {
  DebugAnalyticsService(this._logger);

  final LoggerService _logger;
  static const String _tag = 'ANALYTICS';

  @override
  Future<void> logEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) async =>
      _logger.info('event: $name $parameters', tag: _tag);

  @override
  Future<void> setUserId(String? userId) async =>
      _logger.info('setUserId: ${userId == null ? 'cleared' : 'set'}',
          tag: _tag);

  @override
  Future<void> logScreenView(String screenName) async =>
      _logger.info('screen: $screenName', tag: _tag);
}

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) => kDebugMode
    ? DebugAnalyticsService(const LoggerService())
    : FirebaseAnalyticsService();
