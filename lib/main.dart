import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app/app.dart';
import 'core/storage/hive_service.dart';
import 'core/utils/logger_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const logger = LoggerService();

  // Crash handling. Both hooks forward to Crashlytics once the Firebase
  // project is configured; until then they log centrally.
  FlutterError.onError = (details) {
    logger.error(
      'Flutter error: ${details.exceptionAsString()}',
      tag: 'CRASH',
      error: details.exception,
      stackTrace: details.stack,
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.error(
      'Uncaught platform error',
      tag: 'CRASH',
      error: error,
      stackTrace: stack,
    );
    return true;
  };

  await HiveService.init();

  runApp(const ProviderScope(child: PetaVerseApp()));
}
