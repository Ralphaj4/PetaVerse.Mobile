/// Walks shorter than this are discarded, not recorded.
const Duration kMinWalkDuration = Duration(minutes: 5);

/// Walks older than this can no longer be deleted.
const Duration kWalkDeleteWindow = Duration(days: 2);

/// A completed or in-progress walk session.
class WalkActivity {
  const WalkActivity({
    required this.id,
    required this.petId,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    this.distanceMeters,
    this.avgSpeedKmh,
  });

  final int id;
  final int petId;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationSeconds;

  /// null when location permission was not granted.
  final double? distanceMeters;

  /// null when location permission was not granted.
  final double? avgSpeedKmh;

  Duration get duration => Duration(seconds: durationSeconds);

  /// Categorize walk intensity: 'Quick' (<15m), 'Regular' (15-45m), 'Adventure' (45m+).
  String get intensity {
    final minutes = duration.inMinutes;
    if (minutes < 15) return 'Quick';
    if (minutes < 45) return 'Regular';
    return 'Adventure';
  }

  /// Deletion is only allowed within [kWalkDeleteWindow] of the walk ending.
  bool get canDelete =>
      DateTime.now().difference(endedAt) <= kWalkDeleteWindow;

  /// Formatted as HH:MM:SS.
  String get formattedDuration {
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  String get formattedDistance {
    if (distanceMeters == null) return '--';
    if (distanceMeters! >= 1000) {
      return '${(distanceMeters! / 1000).toStringAsFixed(2)} km';
    }
    return '${distanceMeters!.toStringAsFixed(0)} m';
  }

  String get formattedSpeed {
    if (avgSpeedKmh == null) return '--';
    return '${avgSpeedKmh!.toStringAsFixed(1)} km/h';
  }
}
