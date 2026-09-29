import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app/app.dart';
import 'core/app/fcm_handler.dart';
import 'core/app/notification_service.dart';
import 'core/localization/culture_provider.dart';
import 'core/storage/hive_service.dart';
import 'features/activity/data/local/walk_foreground_service.dart';
import 'firebase_options.dart';

/// Top-level FCM background handler — must live outside any class.
@pragma('vm:entry-point')
Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmHandler.handleBackground(message);
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
  final container = ProviderContainer();
  await container.read(cultureProvider.notifier).load();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const PetaVerseApp(),
    ),
  );
}
