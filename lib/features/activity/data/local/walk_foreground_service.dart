import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/walk_activity.dart';
import 'walk_database.dart';

/// Configures and manages the Android foreground service for walk tracking.
///
/// The tracking itself (ticker, GPS, SQLite progress writes, notification
/// updates) lives in [_WalkTaskHandler] — the service's own isolate — so it
/// keeps running after the app is swiped away, and the notification Stop
/// button works even when the UI is dead.
class WalkForegroundService {
  static void init() {
    // Required for TaskHandler → UI messages (tick data, stop action).
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'petaverse_walk_live',
        channelName: 'Walk Tracking',
        channelDescription: 'Active walk session',
        channelImportance: NotificationChannelImportance.DEFAULT,
        priority: NotificationPriority.DEFAULT,
        playSound: false,
        enableVibration: false,
        onlyAlertOnce: true, // per-second updates must not re-alert
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(1000),
        autoRunOnBoot: false,
        autoRunOnMyPackageReplaced: false,
        allowWakeLock: true,
        allowWifiLock: false,
      ),
    );
  }

  /// Android 13+ hides the service notification entirely unless the user
  /// grants POST_NOTIFICATIONS at runtime.
  static Future<void> _ensureNotificationPermission() async {
    final permission = await FlutterForegroundTask.checkNotificationPermission();
    if (permission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  static Future<void> start({
    required String petName,
    required String elapsed,
  }) async {
    await _ensureNotificationPermission();
    if (await FlutterForegroundTask.isRunningService) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 1001,
        notificationTitle: 'Walking with $petName',
        notificationText: elapsed,
        notificationIcon: null,
        notificationButtons: [
          const NotificationButton(id: 'stop_walk', text: 'Stop'),
        ],
        callback: _walkTaskCallback,
      );
    }
  }

  static Future<bool> get isRunning => FlutterForegroundTask.isRunningService;

  static Future<void> stop() async {
    try {
      // No-op in timer-only mode where the service was never started.
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.stopService();
      }
    } catch (_) {
      // Already stopping (e.g. handler stopped itself) — nothing to do.
    }
  }
}

/// Top-level callback — required by flutter_foreground_task (must be
/// top-level, not a closure or static method reference via an instance).
@pragma('vm:entry-point')
void _walkTaskCallback() {
  FlutterForegroundTask.setTaskHandler(_WalkTaskHandler());
}

/// Self-sufficient walk tracker running in the service isolate.
///
/// Reads the active walk from SQLite on start, then every second: updates
/// the notification, persists progress, and mirrors the stats to the UI
/// isolate (if alive) via [FlutterForegroundTask.sendDataToMain].
class _WalkTaskHandler extends TaskHandler {
  int? _rowId;
  String _petName = '';
  DateTime? _startedAt;
  bool _hasLocation = false;
  double _distanceMeters = 0;
  double _avgSpeedKmh = 0;

  StreamSubscription<Position>? _locationSub;
  LatLng? _lastPosition;
  final _distance = const Distance();
  bool _stopped = false;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    final row = await WalkDatabase.instance.getActive();
    if (row == null) {
      // Nothing to track (e.g. stale service after a reboot) — shut down.
      await FlutterForegroundTask.stopService();
      return;
    }
    _rowId = row['id'] as int;
    _petName = (row['pet_name'] as String?) ?? '';
    _startedAt = DateTime.parse(row['started_at'] as String);
    _hasLocation = (row['has_location'] as int) == 1;
    _distanceMeters = (row['distance_m'] as num?)?.toDouble() ?? 0;
    _avgSpeedKmh = (row['avg_speed'] as num?)?.toDouble() ?? 0;

    if (_hasLocation) {
      const settings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // metres — avoids GPS jitter noise
      );
      _locationSub = Geolocator.getPositionStream(locationSettings: settings)
          .listen(_onPosition);
    }
  }

  void _onPosition(Position pos) {
    final startedAt = _startedAt;
    if (startedAt == null || _stopped) return;

    final current = LatLng(pos.latitude, pos.longitude);
    if (_lastPosition != null) {
      _distanceMeters += _distance(_lastPosition!, current);
    }
    _lastPosition = current;

    final elapsedSeconds = DateTime.now().difference(startedAt).inSeconds;
    _avgSpeedKmh =
        elapsedSeconds > 0 ? (_distanceMeters / elapsedSeconds) * 3.6 : 0.0;
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    final rowId = _rowId;
    final startedAt = _startedAt;
    if (rowId == null || startedAt == null || _stopped) return;

    final elapsed = DateTime.now().difference(startedAt);

    FlutterForegroundTask.updateService(
      notificationTitle: 'Walking with $_petName',
      notificationText: _hasLocation
          ? '${_formatElapsed(elapsed)}  •  ${_formatDistance()}'
          : _formatElapsed(elapsed),
    );

    // Persist so a killed app (or killed service) resumes where it left off.
    WalkDatabase.instance.updateProgress(
      id: rowId,
      durationSeconds: elapsed.inSeconds,
      distanceMeters: _hasLocation ? _distanceMeters : null,
      avgSpeedKmh: _hasLocation ? _avgSpeedKmh : null,
    );

    // Mirror live stats to the UI isolate, if it's alive.
    FlutterForegroundTask.sendDataToMain({
      'type': 'walk_tick',
      'elapsedSeconds': elapsed.inSeconds,
      'distanceMeters': _distanceMeters,
      'avgSpeedKmh': _avgSpeedKmh,
    });
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop_walk') {
      _stopWalk();
    }
  }

  /// Finalizes the walk entirely from the service isolate — works even when
  /// the app has been swiped away. The row becomes 'pending_sync'; upload
  /// happens immediately if the UI is alive, otherwise on next app start.
  Future<void> _stopWalk() async {
    final rowId = _rowId;
    final startedAt = _startedAt;
    if (_stopped || rowId == null || startedAt == null) return;
    _stopped = true;

    final elapsed = DateTime.now().difference(startedAt);
    try {
      if (elapsed < kMinWalkDuration) {
        // Too short to record — discard instead of queuing for upload.
        await WalkDatabase.instance.deleteWalk(rowId);
      } else {
        await WalkDatabase.instance.markStopped(
          id: rowId,
          endedAt: DateTime.now(),
          durationSeconds: elapsed.inSeconds,
          distanceMeters: _hasLocation ? _distanceMeters : null,
          avgSpeedKmh: _hasLocation ? _avgSpeedKmh : null,
        );
      }
    } catch (_) {
      // DB write failed; the row (if any) is retried on next app start.
    }

    FlutterForegroundTask.sendDataToMain({'action': 'stop_walk'});
    await FlutterForegroundTask.stopService();
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    await _locationSub?.cancel();
    _locationSub = null;
  }

  @override
  void onReceiveData(Object data) {}

  String _formatElapsed(Duration elapsed) {
    final h = elapsed.inHours;
    final m = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  String _formatDistance() {
    if (_distanceMeters >= 1000) {
      return '${(_distanceMeters / 1000).toStringAsFixed(2)} km';
    }
    return '${_distanceMeters.toStringAsFixed(0)} m';
  }
}
