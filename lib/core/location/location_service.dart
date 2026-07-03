import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

/// Thin wrapper over geolocator for one-shot position reads, with permission
/// handling. Returns null when location is unavailable or denied — callers
/// decide how to degrade (e.g. fall back to a default city center).
class LocationService {
  const LocationService();

  /// Reads the device's current position once, requesting permission if
  /// needed. Returns null when the service is off or permission is denied.
  Future<LatLng?> currentLatLng() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      // Bound the wait — on an emulator (or a device with no fix) this can
      // otherwise hang forever, which would leave callers stuck loading.
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 8),
        ),
      );
      return LatLng(pos.latitude, pos.longitude);
    } catch (_) {
      // Timeout / unavailable — caller falls back to a default center.
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => const LocationService();
