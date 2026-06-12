import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../utils/logger_service.dart';

part 'notification_service.g.dart';

/// Notification categories — each gets its own channel so users can
/// control them independently (never one channel for everything).
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
}

/// Schedules and cancels local notifications (reminders).
///
/// Push notifications will additionally arrive through Firebase Messaging
/// once the Firebase project is configured.
class NotificationService {
  NotificationService(this._logger);

  final LoggerService _logger;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
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
NotificationService notificationService(Ref ref) =>
    NotificationService(const LoggerService());
