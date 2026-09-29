import 'package:latlong2/latlong.dart';

/// In-memory representation of an active (running) walk session.
class WalkSession {
  const WalkSession({
    required this.petId,
    required this.startedAt,
    required this.elapsed,
    this.distanceMeters = 0.0,
    this.avgSpeedKmh = 0.0,
    this.path = const [],
    this.hasLocation = false,
  });

  final int petId;
  final DateTime startedAt;
  final Duration elapsed;
  final double distanceMeters;
  final double avgSpeedKmh;
  final List<LatLng> path;

  /// Whether GPS data is being collected (location permission granted).
  final bool hasLocation;

  WalkSession copyWith({
    Duration? elapsed,
    double? distanceMeters,
    double? avgSpeedKmh,
    List<LatLng>? path,
  }) =>
      WalkSession(
        petId: petId,
        startedAt: startedAt,
        elapsed: elapsed ?? this.elapsed,
        distanceMeters: distanceMeters ?? this.distanceMeters,
        avgSpeedKmh: avgSpeedKmh ?? this.avgSpeedKmh,
        path: path ?? this.path,
        hasLocation: hasLocation,
      );

  String get formattedElapsed {
    final h = elapsed.inHours;
    final m = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  String get formattedDistance {
    if (!hasLocation) return '--';
    if (distanceMeters >= 1000) {
      return '${(distanceMeters / 1000).toStringAsFixed(2)} km';
    }
    return '${distanceMeters.toStringAsFixed(0)} m';
  }

  String get formattedSpeed {
    if (!hasLocation) return '--';
    return '${avgSpeedKmh.toStringAsFixed(1)} km/h';
  }
}
