import 'package:flutter/services.dart';

/// Maps configuration including API key.
/// Reads the Google Maps API key from native platform at runtime.
/// - Android: Reads from AndroidManifest meta-data (injected from secrets.properties)
/// - iOS: Reads from Info.plist
abstract final class MapsConfig {
  static const _platform = MethodChannel('com.petaverse.app/maps');
  static String? _cachedApiKey;

  /// Get the Google Maps API key from the native platform.
  /// Cached after first call to avoid repeated channel calls.
  static Future<String> getGoogleMapsApiKey() async {
    if (_cachedApiKey != null) return _cachedApiKey!;

    try {
      final key = await _platform.invokeMethod<String>('getGoogleMapsApiKey');
      _cachedApiKey = key ?? '';

      // For development: if key is empty, use a placeholder that shows the issue
      if (_cachedApiKey!.isEmpty) {
        _cachedApiKey = 'NO_API_KEY_CONFIGURED';
      }

      return _cachedApiKey!;
    } catch (e) {
      // Map URLs will fail gracefully with icon fallback
      _cachedApiKey = 'CHANNEL_ERROR';
      return _cachedApiKey!;
    }
  }

  /// URL for a static map thumbnail centered on a location with a marker.
  /// Must call getGoogleMapsApiKey() first to ensure key is loaded.
  static Future<String> staticMapUrl(double latitude, double longitude) async {
    final apiKey = await getGoogleMapsApiKey();
    return 'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$latitude,$longitude'
        '&zoom=16'
        '&size=200x200'
        '&markers=color:orange|$latitude,$longitude'
        '&style=feature:all|element:labels|visibility:off'
        '&style=feature:water|color:0xb3d9ff'
        '&style=feature:land|color:0xf3f3f3'
        '&key=$apiKey';
  }
}
