import 'package:latlong2/latlong.dart';

import 'provider_category.dart';
import 'service_provider.dart';

/// A geographic bounding box (SW/NE corners) - the visible map viewport. A pure
/// Dart type so the domain stays Flutter-free; the map widget converts
/// flutter_map's `LatLngBounds` into this.
class GeoBounds {
  const GeoBounds({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  final double south;
  final double west;
  final double north;
  final double east;
}

/// How the visible provider list is ordered / requested. Mirrors the server's
/// `sort` param (distance|rating|reviews|openNow).
enum ProviderSort { distance, rating, openNow, mostReviewed }

extension ProviderSortWire on ProviderSort {
  /// The `sort` query value the backend expects.
  String get wire => switch (this) {
        ProviderSort.distance => 'distance',
        ProviderSort.rating => 'rating',
        ProviderSort.openNow => 'openNow',
        ProviderSort.mostReviewed => 'reviews',
      };
}

/// The parameters of a viewport provider search. Built by the presentation
/// layer from the map's visible bounds + the active filters.
class ProviderSearchParams {
  const ProviderSearchParams({
    required this.bounds,
    this.userLocation,
    this.category,
    this.query,
    this.petId,
    this.openNow,
    this.sort = ProviderSort.distance,
    this.limit = 100,
  });

  /// The visible map bounding box (SW/NE corners).
  final GeoBounds bounds;

  /// The device location, when known - enables distance stamping + distance
  /// sort. Null when denied/unavailable.
  final LatLng? userLocation;

  /// Category filter, or null / [ProviderCategory.all] for no filter.
  final ProviderCategory? category;

  final String? query;

  /// Active pet id for species tailoring; server resolves the species. Null
  /// disables tailoring ("All").
  final int? petId;

  final bool? openNow;
  final ProviderSort sort;
  final int limit;
}

/// The result of a viewport search: the branch pins plus paging guardrails.
class ProviderSearchResult {
  const ProviderSearchResult({
    required this.items,
    required this.totalInViewport,
    required this.hasMore,
    required this.tooZoomedOut,
  });

  const ProviderSearchResult.empty()
      : items = const [],
        totalInViewport = 0,
        hasMore = false,
        tooZoomedOut = false;

  final List<ServiceProvider> items;

  /// Total branch pins matching in the bbox (may exceed [items] length when
  /// capped). Drives "showing 100 of 137".
  final int totalInViewport;

  /// True when more results exist beyond the returned cap.
  final bool hasMore;

  /// True when the bbox is too large to search - [items] is empty and the UI
  /// should prompt "zoom in".
  final bool tooZoomedOut;
}
