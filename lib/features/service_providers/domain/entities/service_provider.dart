import 'package:latlong2/latlong.dart';

import 'provider_category.dart';

/// Optional trust/quality signals shown as small pills on a provider card.
/// Kept as a set on [ServiceProvider] so new badges can be added without
/// widening the constructor.
enum ProviderBadge {
  verified,
  emergency,
  open24_7,
  mobileService,
}

/// A single pet business shown on the map and in the provider list.
///
/// This is the domain entity: pure Dart, no Flutter imports. The presentation
/// layer derives labels/icons/colors from [category] and [badges]; distance is
/// computed against the user's location at query time (see the repository).
class ServiceProvider {
  const ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    this.photoUrl,
    this.distanceMeters,
    this.phone,
    this.badges = const {},
    this.hoursLabel,
  });

  final String id;
  final String name;
  final ProviderCategory category;

  /// Geographic position, used for the map pin and distance.
  final LatLng location;

  /// Human-readable street address.
  final String address;

  /// Average rating in the 0–5 range.
  final double rating;
  final int reviewCount;

  /// Whether the business is currently open (derived server-side / from hours).
  final bool isOpen;

  /// Logo or storefront photo. Null renders the branded fallback.
  final String? photoUrl;

  /// Distance from the user in meters, or null when location is unknown. Set by
  /// the repository once the user's position is available; drives the "1.2 km"
  /// label and distance sorting.
  final double? distanceMeters;

  final String? phone;

  /// Trust/quality signals (verified, 24/7, …). See [ProviderBadge].
  final Set<ProviderBadge> badges;

  /// Short label for today's hours, e.g. "Closes 6 PM" / "Opens 9 AM".
  final String? hoursLabel;

  /// Copy with a resolved [distanceMeters] — used by the repository to stamp
  /// distance once the user's location is known without rebuilding the object.
  ServiceProvider copyWithDistance(double? meters) => ServiceProvider(
        id: id,
        name: name,
        category: category,
        location: location,
        address: address,
        rating: rating,
        reviewCount: reviewCount,
        isOpen: isOpen,
        photoUrl: photoUrl,
        distanceMeters: meters,
        phone: phone,
        badges: badges,
        hoursLabel: hoursLabel,
      );
}
