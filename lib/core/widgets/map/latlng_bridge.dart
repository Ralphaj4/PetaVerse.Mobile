import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as ll;

/// Bridges the app's domain [ll.LatLng] (latlong2 — used across entities, the
/// location service, and every feature) to Google Maps' own [gmaps.LatLng].
///
/// Keeping the whole app on latlong2 means the domain/feature layers never
/// depend on the map provider; only the two map widgets do this conversion.
extension LatLngToGoogle on ll.LatLng {
  gmaps.LatLng get toGoogle => gmaps.LatLng(latitude, longitude);
}

extension LatLngFromGoogle on gmaps.LatLng {
  ll.LatLng get toLatLng2 => ll.LatLng(latitude, longitude);
}
