import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/api_client.dart';
import '../../data/local/walk_database.dart';
import '../../data/local/walk_foreground_service.dart';
import '../../data/repositories/activity_repository_impl.dart';
import '../../domain/entities/walk_activity.dart';
import '../../domain/entities/walk_session.dart';
import '../../domain/repositories/activity_repository.dart';

part 'walk_session_provider.g.dart';

// ── Repository provider ───────────────────────────────────────────────────────

@riverpod
ActivityRepository activityRepository(Ref ref) =>
    ActivityRepositoryImpl(ref.read(apiClientProvider));

// ── Active session notifier ───────────────────────────────────────────────────

/// null = no active walk.
///
/// GPS walks are tracked by the foreground service's own isolate (see
/// `_WalkTaskHandler`) so they survive the app being swiped away; this
/// notifier just mirrors its per-second ticks into UI state. Timer-only
/// walks (location denied → no service allowed) tick locally instead.
@riverpod
class WalkSessionNotifier extends _$WalkSessionNotifier {
  Timer? _ticker;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  int? _activeRowId;
  bool _syncing = false;

  @override
  WalkSession? build() {
    // Live stats + stop events coming from the service isolate.
    FlutterForegroundTask.addTaskDataCallback(_onTaskData);
    // Flush unsynced walks whenever connectivity comes back.
    _connectivitySub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online) unawaited(_syncPending());
    });
    ref.onDispose(() {
      FlutterForegroundTask.removeTaskDataCallback(_onTaskData);
      _connectivitySub?.cancel();
      _connectivitySub = null;
      _ticker?.cancel();
      _ticker = null;
    });
    _restoreIfNeeded();
    return null;
  }

  // ── Public API ──────────────────────────────────────────────────────────────

  Future<void> startWalk(int petId, String petName) async {
    if (state != null) return;

    // Permission must be resolved BEFORE the foreground service starts:
    // Android 14+ refuses a location-typed FGS unless fine/coarse location
    // is already granted. Denied → timer-only walk, no service.
    final hasLocation = await _requestLocation();
    final now = DateTime.now();

    _activeRowId = await WalkDatabase.instance.insertActive(
      petId: petId,
      petName: petName,
      startedAt: now,
      hasLocation: hasLocation,
    );

    state = WalkSession(
      petId: petId,
      startedAt: now,
      elapsed: Duration.zero,
      hasLocation: hasLocation,
    );

    if (hasLocation) {
      // The service isolate does all tracking; we only mirror its ticks.
      await WalkForegroundService.start(petName: petName, elapsed: '00:00');
    } else {
      _startLocalTicker();
    }

    // Opportunistic flush of older unsynced walks.
    unawaited(_syncPending());
  }

  Future<void> stopWalk() async {
    final session = state;
    final rowId = _activeRowId;
    if (session == null || rowId == null) return;

    _ticker?.cancel();
    _ticker = null;
    await WalkForegroundService.stop();

    // Walks under the minimum aren't worth recording — discard the row.
    if (session.elapsed < kMinWalkDuration) {
      await WalkDatabase.instance.deleteWalk(rowId);
      _activeRowId = null;
      state = null;
      return;
    }

    await WalkDatabase.instance.markStopped(
      id: rowId,
      endedAt: DateTime.now(),
      durationSeconds: session.elapsed.inSeconds,
      distanceMeters: session.hasLocation ? session.distanceMeters : null,
      avgSpeedKmh: session.hasLocation ? session.avgSpeedKmh : null,
    );

    _activeRowId = null;
    state = null;

    // Try to upload now; rows that fail stay pending for the next sweep.
    await _syncPending();
  }

  // ── Service isolate events ──────────────────────────────────────────────────

  void _onTaskData(Object data) {
    if (data is! Map) return;

    if (data['type'] == 'walk_tick') {
      final s = state;
      if (s == null) return;
      state = s.copyWith(
        elapsed: Duration(seconds: (data['elapsedSeconds'] as num).toInt()),
        distanceMeters: (data['distanceMeters'] as num?)?.toDouble(),
        avgSpeedKmh: (data['avgSpeedKmh'] as num?)?.toDouble(),
      );
    } else if (data['action'] == 'stop_walk') {
      // Notification Stop button: the service isolate already marked the
      // row 'pending_sync' and stopped itself — just finalize UI + sync.
      _ticker?.cancel();
      _ticker = null;
      _activeRowId = null;
      state = null;
      unawaited(_syncPending());
    }
  }

  // ── Internal ────────────────────────────────────────────────────────────────

  /// Timer-only mode (no foreground service): tick and persist locally.
  void _startLocalTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final s = state;
      final rowId = _activeRowId;
      if (s == null || rowId == null) return;
      final updated = s.copyWith(
        elapsed: DateTime.now().difference(s.startedAt),
      );
      state = updated;
      // Persist live progress so a killed app resumes where it left off.
      unawaited(
        WalkDatabase.instance.updateProgress(
          id: rowId,
          durationSeconds: updated.elapsed.inSeconds,
        ),
      );
    });
  }

  Future<bool> _requestLocation({bool request = true}) async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return false;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied && request) {
        permission = await Geolocator.requestPermission();
      }
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (_) {
      return false;
    }
  }

  /// On cold start: resume a walk that was active when the app was killed,
  /// then sweep any stopped-but-unsynced walks.
  Future<void> _restoreIfNeeded() async {
    final row = await WalkDatabase.instance.getActive();
    if (row != null) {
      final petId = row['pet_id'] as int;
      final petName = (row['pet_name'] as String?) ?? '';
      final startedAt = DateTime.parse(row['started_at'] as String);
      // Re-check (without prompting) — permission may have been revoked
      // while the app was dead, and the location-typed FGS needs it.
      final hasLocation = (row['has_location'] as int) == 1 &&
          await _requestLocation(request: false);

      _activeRowId = row['id'] as int;
      final session = WalkSession(
        petId: petId,
        startedAt: startedAt,
        elapsed: DateTime.now().difference(startedAt),
        distanceMeters: (row['distance_m'] as num?)?.toDouble() ?? 0.0,
        avgSpeedKmh: (row['avg_speed'] as num?)?.toDouble() ?? 0.0,
        hasLocation: hasLocation,
      );
      state = session;

      if (hasLocation) {
        // If the service outlived the app (swipe-up), just re-attach to its
        // ticks; otherwise (reboot, crash) restart it to resume tracking.
        if (!await WalkForegroundService.isRunning) {
          await WalkForegroundService.start(
            petName: petName,
            elapsed: session.formattedElapsed,
          );
        }
      } else {
        _startLocalTicker();
      }
    }

    unawaited(_syncPending());
  }

  /// Uploads every 'pending_sync' row; each row is deleted only after its
  /// POST succeeds. A network failure aborts the sweep (the rest would fail
  /// too); any other failure skips just that row so it can't block the queue.
  Future<void> _syncPending() async {
    if (_syncing) return;
    _syncing = true;
    try {
      final rows = await WalkDatabase.instance.getPendingSync();
      if (rows.isEmpty) return;

      final repo = ref.read(activityRepositoryProvider);
      final syncedPetIds = <int>{};

      for (final row in rows) {
        final petId = row['pet_id'] as int;
        final result = await repo.saveActivity(
          petId: petId,
          startedAt: DateTime.parse(row['started_at'] as String),
          endedAt: DateTime.parse(row['ended_at'] as String),
          durationSeconds: row['duration_s'] as int,
          distanceMeters: (row['distance_m'] as num?)?.toDouble(),
          avgSpeedKmh: (row['avg_speed'] as num?)?.toDouble(),
        );

        var synced = false;
        var offline = false;
        result.when(
          success: (_) => synced = true,
          failure: (f) => offline = f is NetworkFailure,
        );
        if (synced) {
          await WalkDatabase.instance.deleteWalk(row['id'] as int);
          syncedPetIds.add(petId);
        }
        if (offline) break;
      }

      for (final petId in syncedPetIds) {
        ref.invalidate(walkHistoryProvider(petId));
      }
    } finally {
      _syncing = false;
    }
  }
}

// ── History provider ──────────────────────────────────────────────────────────

@riverpod
Future<List<WalkActivity>> walkHistory(Ref ref, int petId) async {
  final repo = ref.read(activityRepositoryProvider);
  final result = await repo.getActivities(petId);
  return result.when(
    success: (list) => list,
    failure: (f) => throw f,
  );
}
