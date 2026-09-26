import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart';

import 'latlng_bridge.dart';

/// Thin animate-camera wrapper handed from a map widget up to its parent, so the
/// parent can drive fly-to / recenter without depending on google_maps directly.
///
/// Mirrors the small surface the old flutter_map `AnimatedMapController` exposed
/// to call sites (`animateTo(dest:, zoom:)`), so the migration touches those
/// call sites minimally.
class MapCameraController {
  MapCameraController(this._controller);

  final gmaps.GoogleMapController _controller;

  /// Animates the camera to [dest], optionally changing [zoom].
  Future<void> animateTo({required LatLng dest, double? zoom}) {
    final update = zoom == null
        ? gmaps.CameraUpdate.newLatLng(dest.toGoogle)
        : gmaps.CameraUpdate.newLatLngZoom(dest.toGoogle, zoom);
    return _controller.animateCamera(update);
  }
}
