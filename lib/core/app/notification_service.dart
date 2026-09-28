import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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
  feeding('feeding', 'Feeding'),
  grooming('grooming', 'Grooming'),
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

  /// Feeding local-notification id band: `40_000_000 + timeId * 10 + weekday`.
  /// The whole [start, end) range is swept on reconcile (server reassigns time
  /// ids on each full-replace) and when the Feeding pref is switched off.
  static const int feedingIdStart = 40000000;
  static const int feedingIdEnd = 50000000;

  static const _logger = LoggerService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Whether the OS granted exact-alarm scheduling (Android 12+ gates it behind
  /// SCHEDULE_EXACT_ALARM / USE_EXACT_ALARM). Reminders are time-sensitive, so we
  /// use an exact alarm when allowed and fall back to inexact otherwise.
  bool _canScheduleExact = true;

  /// Called once from main() before runApp — initializes channels and
  /// requests Android 13+ permission.
  static Future<void> staticInit() => _instance._init();

  Future<void> _init() async {
    if (_initialized) return;
    try {
      tz_data.initializeTimeZones();
      // Bind tz.local to the device timezone. Without this, tz.local defaults to
      // UTC and every scheduled reminder fires at the wrong wall-clock time for
      // non-UTC users (e.g. a 6pm meal reminder arms for 6pm UTC = 9pm in UTC+3).
      await _configureLocalTimeZone();
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      );
      await _plugin.initialize(settings: settings);
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();
      // Ask for exact-alarm scheduling; remember whether it's granted so we can
      // fall back to inexact (which Doze can defer) when it isn't.
      final exactGranted = await android?.requestExactAlarmsPermission();
      if (exactGranted != null) _canScheduleExact = exactGranted;
      _initialized = true;
    } catch (e, st) {
      _logger.error('Notification init failed', error: e, stackTrace: st);
    }
  }

  /// Resolves the device's IANA timezone and binds it to [tz.local] so
  /// [tz.TZDateTime.from] interprets scheduled times as local wall-clock. Falls
  /// back to leaving [tz.local] as-is (UTC) only if the platform can't report a
  /// zone or the identifier is unknown to the tz database.
  Future<void> _configureLocalTimeZone() async {
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (e, st) {
      _logger.error('Failed to set local timezone', error: e, stackTrace: st);
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
  ///
  /// Pass [matchDateTimeComponents] to make the notification recur: e.g.
  /// [DateTimeComponents.time] for a daily reminder or
  /// [DateTimeComponents.dayOfWeekAndTime] for a weekly one. When recurring,
  /// [when] is the first fire time (its time-of-day / weekday is the anchor)
  /// and the past-date guard is skipped so the next matching slot still arms.
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
    required NotificationCategory category,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    if (!_initialized) return;
    if (matchDateTimeComponents == null && when.isBefore(DateTime.now())) return;
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
        androidScheduleMode: _canScheduleExact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: matchDateTimeComponents,
      );
    } catch (e, st) {
      _logger.error('Failed to schedule notification $id',
          error: e, stackTrace: st);
    }
  }

  Future<void> cancel(int id) => _plugin.cancel(id: id);

  /// Cancels every pending notification whose id falls in [start, endExclusive).
  /// Used to reconcile schedules whose slot ids are server-assigned and change
  /// on each full-replace (e.g. feeding times) — we can't cancel by known id, so
  /// we sweep the reserved id band before rescheduling the fresh set.
  Future<void> cancelInRange(int start, int endExclusive) async {
    if (!_initialized) return;
    try {
      final pending = await _plugin.pendingNotificationRequests();
      for (final req in pending) {
        if (req.id >= start && req.id < endExclusive) {
          await _plugin.cancel(id: req.id);
        }
      }
    } catch (e, st) {
      _logger.error('Failed to cancel notifications in [$start,$endExclusive)',
          error: e, stackTrace: st);
    }
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => _instance;
