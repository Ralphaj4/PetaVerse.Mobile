import 'package:latlong2/latlong.dart';

import 'provider_category.dart';

/// Optional trust/quality signals shown as small pills on a provider card.
/// Kept as a set on [ServiceProvider] so new badges can be added without
/// widening the constructor.
enum ProviderBadge {
  verified,
  emergency,
  open24_7,
  mobileService;

  /// Maps a wire slug (`"verified"`, `"open24_7"`, …) to a badge, or null when
  /// the server sends one the client doesn't know about (forward-compatible).
  static ProviderBadge? fromWire(String wire) {
    for (final b in ProviderBadge.values) {
      if (b.wire == wire) return b;
    }
    return null;
  }

  /// The wire slug. Matches [name] except for [open24_7], whose enum name is
  /// mangled by the leading digit constraint.
  String get wire => switch (this) {
        ProviderBadge.verified => 'verified',
        ProviderBadge.emergency => 'emergency',
        ProviderBadge.open24_7 => 'open24_7',
        ProviderBadge.mobileService => 'mobileService',
      };
}

/// A single branch pin on the map / row in the provider list.
///
/// The search endpoint returns **one item per in-viewport branch**, so [id]
/// (the provider) can repeat across items while [branchId] uniquely identifies
/// the pin. Display keys off [branchId]; tapping opens the provider detail by
/// [id].
///
/// Pure Dart, no Flutter imports. The presentation layer derives
/// labels/icons/colors from [primaryCategory] and [badges].
class ServiceProvider {
  const ServiceProvider({
    required this.id,
    required this.branchId,
    required this.name,
    required this.categoryIds,
    required this.primaryCategory,
    required this.location,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    this.serviceIds = const [],
    this.photoUrl,
    this.distanceKm,
    this.phone,
    this.badges = const {},
    this.hoursLabel,
    this.supportedSpecies = const [],
    this.servesAllSpecies = false,
  });

  /// The provider id - stable across the provider's branches. Used to open the
  /// detail screen. Repeats across list items for a multi-branch provider.
  final int id;

  /// The specific branch this pin/row represents. Unique per item; used as the
  /// map marker + list key.
  final int branchId;

  final String name;

  /// All category ids this provider belongs to (many-to-many). Used for filter
  /// matching (a Vet+Pharmacy matches both chips).
  final List<int> categoryIds;

  /// The resolved primary category - drives pin color, card glyph, and the
  /// "kind" label. Resolved from `primaryCategoryId` via the categories lookup;
  /// falls back to [ProviderCategory.all] when the id is unknown.
  final ProviderCategory primaryCategory;

  /// Service ids offered (detail chips); opaque to the map list.
  final List<int> serviceIds;

  /// Geographic position of this branch (the map pin + distance origin).
  final LatLng location;

  /// Human-readable street address of this branch.
  final String address;

  /// Average rating in the 0–5 range.
  final double rating;
  final int reviewCount;

  /// Whether the branch is currently open (server-computed, Asia/Beirut).
  final bool isOpen;

  /// Logo or storefront photo. Null renders the branded fallback.
  final String? photoUrl;

  /// Distance from the user in kilometers (1 decimal), or null when the user's
  /// location wasn't sent / is unknown. Drives the "1.2 km" label and distance
  /// sort.
  final double? distanceKm;

  final String? phone;

  /// Trust/quality signals (verified, 24/7, …). See [ProviderBadge].
  final Set<ProviderBadge> badges;

  /// Server-localized short label for today's hours, e.g. "Open · closes
  /// 6:00 PM". Rendered as-is.
  final String? hoursLabel;

  /// Species ids this provider serves - drives the "treats X" affordance.
  final List<int> supportedSpecies;

  /// True when the provider serves every species (species filter is a no-op).
  final bool servesAllSpecies;
}
