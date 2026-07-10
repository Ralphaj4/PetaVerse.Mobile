import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/service_provider.dart';

/// Thin wrapper over url_launcher for the provider quick actions. Returns false
/// when the intent can't be handled so the page can show a localized snackbar.
abstract final class ProviderActions {
  /// Opens the phone dialer pre-filled with the provider's number.
  static Future<bool> call(ServiceProvider provider) async {
    final phone = provider.phone;
    if (phone == null || phone.isEmpty) return false;
    return launchUrl(Uri(scheme: 'tel', path: phone));
  }

  /// Opens the platform maps app with directions to the provider. Uses a
  /// geo: URI (Android) with a Google Maps https fallback that iOS/most
  /// browsers also honor.
  static Future<bool> directions(ServiceProvider provider) async {
    final lat = provider.location.latitude;
    final lng = provider.location.longitude;
    final geo = Uri.parse('geo:$lat,$lng?q=$lat,$lng(${provider.name})');
    if (await canLaunchUrl(geo)) {
      return launchUrl(geo);
    }
    return launchUrl(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng'),
      mode: LaunchMode.externalApplication,
    );
  }
}
