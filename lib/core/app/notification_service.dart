import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../utils/logger_service.dart';

part 'notification_service.g.dart';

/// Notification categories — each gets its own Android channel so users
/// can control them independently in system settings.
enum NotificationCategory {
  medication('medication', 'Medication'),
  vaccination('vaccination', 'Vaccination'),
  appointment('appointment', 'Appointment'),
  emergency('emergency', 'Emergency'),
  social('social', 'Social'),
  marketplace('marketplace', 'Marketplace');

  const NotificationCategory(this.channelId, this.channelName);

  final String channelId;
  final String channelName;

  static NotificationCategory? fromString(String? value) {
    if (value == null) return null;
    for (final c in values) {
      if (c.channelId == value) return c;
    }
    return null;
  }
}

// Module-level singleton so main.dart can call init() before the provider
// container exists, and the provider shares the same instance.
final _instance = NotificationService._();

/// Handles both scheduled local notifications (reminders) and immediate
/// display of incoming FCM push messages while the app is in the foreground.
class NotificationService {
  NotificationService._();

  static const _logger = LoggerService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Called once from main() before runApp — initializes channels and
  /// requests Android 13+ permission.
  static Future<void> staticInit() => _instance._init();

  Future<void> _init() async {
    if (_initialized) return;
    try {
      tz_data.initializeTimeZones();
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      );
      await _plugin.initialize(settings: settings);
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      _initialized = true;
    } catch (e, st) {
      _logger.error('Notification init failed', error: e, stackTrace: st);
    }
  }

  /// Shows an immediate notification — used for FCM foreground messages.
  Future<void> show({
    required int id,
    required String title,
    required String body,
    required NotificationCategory category,
    String? payload,
  }) async {
    if (!_initialized) return;
    try {
      await _plugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            category.channelId,
            category.channelName,
            importance: category == NotificationCategory.emergency
                ? Importance.max
                : Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: payload,
      );
    } catch (e, st) {
      _logger.error('Failed to show notification $id', error: e, stackTrace: st);
    }
  }

  /// Schedules a future local notification. No-ops silently if [when] is
  /// already in the past — safe to call without a date guard at the call site.
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
    required NotificationCategory category,
  }) async {
    if (!_initialized || when.isBefore(DateTime.now())) return;
    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(when, tz.local),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            category.channelId,
            category.channelName,
            importance: category == NotificationCategory.emergency
                ? Importance.max
                : Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e, st) {
      _logger.error('Failed to schedule notification $id',
          error: e, stackTrace: st);
    }
  }

  Future<void> cancel(int id) => _plugin.cancel(id: id);
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => _instance;
