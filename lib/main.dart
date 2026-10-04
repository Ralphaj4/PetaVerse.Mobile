import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app/app.dart';
import 'core/app/fcm_handler.dart';
import 'core/app/notification_service.dart';
import 'core/errors/failure.dart';
import 'core/localization/culture_provider.dart';
import 'core/storage/hive_service.dart';
import 'features/activity/data/local/walk_foreground_service.dart';
import 'firebase_options.dart';

/// Top-level FCM background handler - must live outside any class.
@pragma('vm:entry-point')
Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmHandler.handleBackground(message);
}

/// Global provider retry policy (Riverpod contract: return the delay before the
/// next attempt, or null to stop retrying).
///
/// Riverpod's [ProviderContainer.defaultRetry] retries ANY thrown error up to
/// 10 times with exponential backoff. Our providers throw [Failure] objects, so
/// a deterministic 404 gets retried 10 times over several seconds - an endless
/// GET→404→GET loop that delays the error UI (e.g. opening a deleted post).
///
/// Only transient failures - no connectivity, server 5xx, rate limits - are
/// worth retrying. Every 4xx (not found, unauthorized, forbidden, validation,
/// conflict, banned/suspended) is a stable verdict retrying can't change, so we
/// stop immediately and let the UI render the error at once.
Duration? _providerRetry(int retryCount, Object error) {
  final isTransient = error is NetworkFailure ||
      error is ServerFailure ||
      error is RateLimitFailure;
  if (!isTransient) return null; // stop immediately on stable/unknown errors
  if (retryCount >= 3) return null; // cap transient retries
  return Duration(milliseconds: 300 * (retryCount + 1));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Wire crash handlers to Crashlytics.
  FlutterError.onError =
      FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Disable Crashlytics collection in debug so it doesn't pollute the dashboard.
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);

  // Register the top-level background handler before any other FCM calls.
  FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);

  await HiveService.init();
  WalkForegroundService.init();
  await NotificationService.staticInit();

  // Hydrate the saved culture before the first frame.
  final container = ProviderContainer(retry: _providerRetry);
  await container.read(cultureProvider.notifier).load();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PetaVerseApp(),
    ),
  );
}
