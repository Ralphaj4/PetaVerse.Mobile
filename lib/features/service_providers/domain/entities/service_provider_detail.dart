import 'package:latlong2/latlong.dart';

import 'provider_category.dart';
import 'service_provider.dart';

/// Full provider record shown on the tap-a-pin detail screen
/// (`GET /service-providers/{id}`): all branches, categories, services,
/// supported species, specializations, weekly hours, and aggregate rating.
class ServiceProviderDetail {
  const ServiceProviderDetail({
    required this.id,
    required this.name,
    required this.categoryIds,
    required this.primaryCategory,
    required this.isVerified,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    required this.branches,
    this.description,
    this.photoUrl,
    this.services = const [],
    this.supportedSpecies = const [],
    this.servesAllSpecies = false,
    this.specializations = const [],
    this.hours = const [],
    this.hoursLabel,
    this.badges = const {},
    this.myStars,
  });

  final int id;
  final String name;
  final String? description;
  final String? photoUrl;

  final List<int> categoryIds;
  final ProviderCategory primaryCategory;

  final bool isVerified;
  final double rating;
  final int reviewCount;

  final List<ProviderService> services;
  final List<ProviderSpecies> supportedSpecies;
  final bool servesAllSpecies;

  final List<ProviderSpecialization> specializations;
  final List<ProviderBranch> branches;

  /// Weekly opening hours (dayOfWeek 0 = Sunday). May span multiple rows/day.
  final List<ProviderHours> hours;

  /// Whether the provider is currently open (server-computed, Asia/Beirut).
  final bool isOpen;

  /// Server-localized short label for today's hours.
  final String? hoursLabel;

  final Set<ProviderBadge> badges;

  /// The signed-in user's own rating (1–5), or null if they haven't rated.
  final int? myStars;
}

/// One physical location of a provider.
class ProviderBranch {
  const ProviderBranch({
    required this.id,
    required this.address,
    required this.location,
    this.phone,
    this.whatsApp,
    this.emergency,
    this.website,
    this.instagram,
    this.email,
    this.storefrontImageUrl,
    this.distanceKm,
  });

  final int id;
  final String address;
  final LatLng location;
  final String? phone;
  final String? whatsApp;
  final String? emergency;
  final String? website;
  final String? instagram;
  final String? email;
  final String? storefrontImageUrl;

  /// Distance from the user in km (1 decimal), or null when no origin was sent.
  final double? distanceKm;
}

/// One weekly opening-hours row. [dayOfWeek] 0 = Sunday. Times are "HH:mm".
class ProviderHours {
  const ProviderHours({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  final int dayOfWeek;
  final String startTime;
  final String endTime;
}

/// A provider specialization (e.g. "Surgery"). [otherName] is the free-text
/// value when the specialization is an "Other" entry.
class ProviderSpecialization {
  const ProviderSpecialization({
    required this.id,
    required this.name,
    this.otherName,
  });

  final int id;
  final String name;
  final String? otherName;

  /// The label to render: the free-text override when present, else [name].
  String get label => (otherName != null && otherName!.isNotEmpty)
      ? otherName!
      : name;
}

/// A service offered by the provider (e.g. "Vaccination", "Grooming").
class ProviderService {
  const ProviderService({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}

/// A species the provider supports (e.g. "Dog", "Cat").
class ProviderSpecies {
  const ProviderSpecies({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;
}
