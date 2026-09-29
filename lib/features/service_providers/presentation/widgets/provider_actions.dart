import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/service_provider.dart';

/// Thin wrapper over url_launcher for the provider quick actions. Returns false
/// when the intent can't be handled so the page can show a localized snackbar.
abstract final class ProviderActions {
  /// Opens the phone dialer pre-filled with the provider's number.
  static Future<bool> call(ServiceProvider provider) => dial(provider.phone);

  /// Opens the platform maps app with directions to the provider branch.
  static Future<bool> directions(ServiceProvider provider) =>
      navigateTo(provider.location, provider.name);

  /// Dials an arbitrary phone number (branch phone / emergency line).
  static Future<bool> dial(String? phone) async {
    if (phone == null || phone.isEmpty) return false;
    return launchUrl(Uri(scheme: 'tel', path: phone));
  }

  /// Opens WhatsApp chat with [phone] (digits only; `+` stripped).
  static Future<bool> whatsApp(String? phone) async {
    if (phone == null || phone.isEmpty) return false;
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return false;
    return launchUrl(
      Uri.parse('https://wa.me/$digits'),
      mode: LaunchMode.externalApplication,
    );
  }

  /// Opens an arbitrary web URL (provider website / Instagram).
  static Future<bool> openUrl(String? url) async {
    if (url == null || url.isEmpty) return false;
    final normalized =
        url.startsWith('http') ? url : 'https://$url';
    return launchUrl(
      Uri.parse(normalized),
      mode: LaunchMode.externalApplication,
    );
  }

  /// Opens an email composer to [email].
  static Future<bool> email(String? address) async {
    if (address == null || address.isEmpty) return false;
    return launchUrl(Uri(scheme: 'mailto', path: address));
  }

  /// Opens the platform maps app with directions to a coordinate. Uses a geo:
  /// URI (Android) with a Google Maps https fallback that iOS/most browsers
  /// also honor.
  static Future<bool> navigateTo(LatLng location, String label) async {
    final lat = location.latitude;
    final lng = location.longitude;
    final geo = Uri.parse('geo:$lat,$lng?q=$lat,$lng($label)');
    if (await canLaunchUrl(geo)) {
      return launchUrl(geo);
    }
    return launchUrl(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng'),
      mode: LaunchMode.externalApplication,
    );
  }
}
