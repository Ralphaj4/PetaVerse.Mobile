import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router/app_router.dart';
import '../notifications/notification_prefs_store.dart';
import '../utils/logger_service.dart';
import '../storage/sync_flag_store.dart';
import 'notification_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/providers/auth_repository_provider.dart';

part 'fcm_handler.g.dart';

/// Keys the backend must include in the FCM `data` map.
/// Example: { "category": "appointment", "petId": "42" }
abstract final class FcmPayloadKeys {
  static const String category = 'category';
  static const String petId = 'petId';
  static const String route = 'route';
}

const _tag = 'FCM';
const _logger = LoggerService();

/// Called from the top-level background handler in main.dart.
/// Runs in a separate isolate — no UI, no providers, no router.
class FcmHandler {
  static Future<void> handleBackground(RemoteMessage message) async {
    _logger.info('Background message: ${message.messageId}', tag: _tag);

    if (message.data[FcmPayloadKeys.category] == 'sync') {
      await _writeSyncFlag(message.data);
      return; // silent push — no UI notification needed
    }
    // Android shows the notification automatically when a `notification`
    // payload is present. No local display needed for non-silent messages.
  }

  /// Writes a per-pet dirty flag to Hive so the next health fetch forces a
  /// full remote reconciliation. Works in both the background isolate (no
  /// Riverpod container) and the foreground (same result either way).
  static Future<void> _writeSyncFlag(Map<String, dynamic> data) async {
    final petIdStr = data[FcmPayloadKeys.petId];
    final petId = petIdStr != null ? int.tryParse(petIdStr as String) : null;
    if (petId == null) return;

    // Hive must be initialised before we can open a box. In the background
    // isolate it may not be; init is idempotent so this is safe.
    await Hive.initFlutter();
    await SyncFlagStore().setSyncNeeded(petId);
    _logger.info('Sync flag set for pet $petId', tag: _tag);
  }

  /// Call once from [AppShell.initState] after the widget tree is ready.
  static Future<void> init(WidgetRef ref) async {
    final messaging = FirebaseMessaging.instance;

    // Resolve long-lived service references now, while the ref is mounted.
    // Storing these values avoids reading ref inside stream callbacks that may
    // fire after AppShell is unmounted (which would throw "ref is unsafe").
    final notificationService = ref.read(notificationServiceProvider);
    final router = ref.read(appRouterProvider);
    final authRepo = ref.read(authRepositoryProvider);

    // Request permission (iOS + Android 13+).
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    _logger.info(
      'FCM permission: ${settings.authorizationStatus}',
      tag: _tag,
    );

    // Register current token and refresh it whenever FCM rotates it.
    final token = await messaging.getToken();
    if (token != null) await _registerTokenDirect(authRepo, token);
    messaging.onTokenRefresh.listen((t) => _registerTokenDirect(authRepo, t));

    // Foreground: FCM suppresses the system notification — show it ourselves.
    // Silent sync pushes have no notification block; skip local display.
    FirebaseMessaging.onMessage.listen((message) {
      _logger.info('Foreground message: ${message.messageId}', tag: _tag);
      if (message.data[FcmPayloadKeys.category] == 'sync') {
        _writeSyncFlag(message.data);
        return;
      }
      _showLocalDirect(notificationService, message);
    });

    // Tap while app was backgrounded.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.info('Opened from background: ${message.messageId}', tag: _tag);
      _navigateDirect(router, message);
    });

    // Tap that cold-started the app.
    final initial = await messaging.getInitialMessage();
    if (initial != null) {
      _logger.info('Cold-start message: ${initial.messageId}', tag: _tag);
      _navigateDirect(router, initial);
    }
  }

  /// Unregisters the FCM token — call on logout so the backend stops
  /// sending push notifications to this device.
  static Future<void> unregister(WidgetRef ref) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await ref.read(authRepositoryProvider).unregisterFcmToken(token);
      }
      await FirebaseMessaging.instance.deleteToken();
    } catch (e, st) {
      _logger.error('Failed to unregister FCM token', error: e, stackTrace: st);
    }
  }

  static Future<void> _registerTokenDirect(
    AuthRepository authRepo,
    String token,
  ) async {
    _logger.info('FCM token refreshed — registering with backend', tag: _tag);
    await authRepo.registerFcmToken(token);
  }

  /// Reads a notification pref synchronously from the already-open Hive box.
  /// Defaults to `true` (enabled) if the box isn't open or the key is absent.
  static bool _isPrefEnabled(String key) {
    try {
      final box = Hive.box<bool>('notification_prefs');
      return box.get(key, defaultValue: true) ?? true;
    } catch (_) {
      return true; // box not open yet — allow through
    }
  }

  /// Maps a FCM message to the pref key that controls its visibility.
  /// Returns null for security-category messages — they are always allowed.
  static String? _prefKeyForMessage(RemoteMessage message) {
    final category = message.data[FcmPayloadKeys.category] as String?;
    final type = message.data['type'] as String?;

    // Emergency: only lost-pet is toggleable; security alerts always pass.
    if (category == 'emergency') {
      if (type == 'lost_pet_nearby') return NotifPrefKeys.lostPetNearby;
      return null; // security alerts — always allowed
    }

    // Social sub-types
    if (category == 'social') {
      return switch (type) {
        'post_liked' || 'post_commented' || 'comment_replied' =>
          NotifPrefKeys.communityInteractions,
        'new_follower' => NotifPrefKeys.newFollower,
        'mention' => NotifPrefKeys.mentions,
        'adoption_application' ||
        'adoption_approved' ||
        'adoption_rejected' ||
        'adoption_confirmed' ||
        'adoption_complete' ||
        'adoption_withdrawn' =>
          NotifPrefKeys.adoption,
        'co_ownership_invite' ||
        'co_ownership_accepted' ||
        'co_ownership_declined' =>
          NotifPrefKeys.coOwnership,
        _ => NotifPrefKeys.communityInteractions,
      };
    }

    return switch (category) {
      'medication' => NotifPrefKeys.medication,
      'vaccination' => NotifPrefKeys.vaccination,
      'appointment' => NotifPrefKeys.appointment,
      _ => null, // unknown/marketplace — always allow
    };
  }

  static void _showLocalDirect(
    NotificationService notificationService,
    RemoteMessage message,
  ) {
    final notification = message.notification;
    if (notification == null) return;

    final prefKey = _prefKeyForMessage(message);
    if (prefKey != null && !_isPrefEnabled(prefKey)) return;

    final category = NotificationCategory.fromString(
          message.data[FcmPayloadKeys.category],
        ) ??
        NotificationCategory.social;

    notificationService.show(
      id: message.hashCode,
      title: notification.title ?? '',
      body: notification.body ?? '',
      category: category,
      payload: message.data[FcmPayloadKeys.route],
    );
  }

  static void _navigateDirect(GoRouter router, RemoteMessage message) {
    // Respect the user's pref even on tap — don't navigate to a screen for a
    // category they've disabled (security alerts always navigate through).
    final prefKey = _prefKeyForMessage(message);
    if (prefKey != null && !_isPrefEnabled(prefKey)) return;

    final data = message.data;

    // Explicit route takes priority over category-based routing.
    // Shell tab routes (/home, /community, /care, /profile) must use go() so
    // the bottom nav shell is preserved. All other deep-links use push().
    final explicitRoute = data[FcmPayloadKeys.route];
    if (explicitRoute != null && explicitRoute.isNotEmpty) {
      const shellRoots = {
        AppRoutes.home,
        AppRoutes.community,
        AppRoutes.care,
        AppRoutes.profile,
      };
      if (shellRoots.contains(explicitRoute)) {
        router.go(explicitRoute);
      } else {
        router.push(explicitRoute);
      }
      return;
    }

    final category = NotificationCategory.fromString(
      data[FcmPayloadKeys.category],
    );
    final petId = int.tryParse(data[FcmPayloadKeys.petId] ?? '');

    switch (category) {
      case NotificationCategory.appointment:
        if (petId != null) router.push(AppRoutes.appointmentsPath(petId));
      case NotificationCategory.medication:
        if (petId != null) router.push(AppRoutes.medicationsPath(petId));
      case NotificationCategory.vaccination:
        if (petId != null) router.push(AppRoutes.vaccinationsPath(petId));
      case NotificationCategory.social:
        // Community is a shell tab — use go() so the shell is preserved.
        router.go(AppRoutes.community);
      case NotificationCategory.emergency:
        router.push(AppRoutes.lostAndFound);
      case NotificationCategory.marketplace:
        router.go(AppRoutes.home);
      case null:
        router.go(AppRoutes.home);
    }
  }
}

@Riverpod(keepAlive: true)
Future<void> fcmHandler(Ref ref) async {
  // Placeholder — actual init requires WidgetRef (for routing).
  // AppShell calls FcmHandler.init(ref) from initState instead.
}
