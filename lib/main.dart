import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app/app.dart';
import 'core/localization/culture_provider.dart';
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

  // Hydrate the saved culture before the first frame so the locale and the
  // `X-Culture` request header are correct from the start (no flicker).
  final container = ProviderContainer();
  await container.read(cultureProvider.notifier).load();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PetaVerseApp(),
    ),
  );
}
