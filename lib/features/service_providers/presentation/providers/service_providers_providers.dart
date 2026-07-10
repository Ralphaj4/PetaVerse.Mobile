import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/location/location_service.dart';
import '../../data/datasources/service_provider_mock_datasource.dart';
import '../../data/repositories/service_provider_repository_impl.dart';
import '../../domain/entities/provider_category.dart';
import '../../domain/entities/service_provider.dart';
import '../../domain/repositories/service_provider_repository.dart';

part 'service_providers_providers.g.dart';

/// How the visible provider list is ordered. Extensible: adding a value only
/// requires a new branch in [_sortComparator] and a localized label.
enum ProviderSort { distance, rating, openNow, mostReviewed }

@Riverpod(keepAlive: true)
ServiceProviderRepository serviceProviderRepository(Ref ref) =>
    const ServiceProviderRepositoryImpl(ServiceProviderMockDataSource());

/// The map center used to query providers.
///
/// Synchronous by design: it starts at the app default center immediately so
/// the provider list can load without EVER waiting on location (a stalled
/// permission dialog or a device with no fix must not be able to hang the
/// list in its shimmer state). A background one-shot location read then
/// refines the center when it arrives, which re-runs the query for the user's
/// real position. Not changed as the user pans — panning re-sorts the loaded
/// set client-side (see [visibleProviders]).
@Riverpod(keepAlive: true)
class ProviderQueryCenter extends _$ProviderQueryCenter {
  @override
  LatLng build() {
    // Kick off location resolution in the background; update when/if it lands.
    _resolveLocation();
    return kDefaultMapCenter;
  }

  Future<void> _resolveLocation() async {
    try {
      final here = await ref
          .read(locationServiceProvider)
          .currentLatLng()
          .timeout(const Duration(seconds: 8));
      if (here != null) state = here;
    } catch (_) {
      // Keep the default center — the list already loaded against it.
    }
  }
}

/// Loads nearby providers for the current query center. Re-runs if the center
/// changes (e.g. once the real location resolves). Carries the full unfiltered
/// set; filtering/search/sort are applied downstream in [visibleProviders] so
/// those never trigger a refetch.
@riverpod
class ServiceProvidersNotifier extends _$ServiceProvidersNotifier {
  @override
  Future<List<ServiceProvider>> build() async {
    final center = ref.watch(providerQueryCenterProvider);
    final result =
        await ref.read(serviceProviderRepositoryProvider).getNearby(
              center: center,
            );
    return result.when(
      success: (providers) => providers,
      failure: (f) => throw f,
    );
  }

  /// Re-fetches from the current center (pull-to-retry after an error).
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// Selected category filter (single-select). [ProviderCategory.all] shows all.
@riverpod
class ProviderCategoryFilter extends _$ProviderCategoryFilter {
  @override
  ProviderCategory build() => ProviderCategory.all;

  void select(ProviderCategory category) => state = category;
}

/// Debounced search query (business name / category / address). The text field
/// debounces before writing here, so this never churns on every keystroke.
@riverpod
class ProviderSearchQuery extends _$ProviderSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

/// Active sort order for the list.
@riverpod
class ProviderSortOrder extends _$ProviderSortOrder {
  @override
  ProviderSort build() => ProviderSort.distance;

  void select(ProviderSort sort) => state = sort;
}

/// The currently highlighted provider id (tapped pin or card), or null. Drives
/// pin highlight + the map camera fly-to. Kept separate from the list so
/// selecting never rebuilds the (expensive) list computation.
@riverpod
class SelectedProvider extends _$SelectedProvider {
  @override
  String? build() => null;

  void select(String? id) => state = id;

  void toggle(String id) => state = state == id ? null : id;
}

/// The list actually shown in the sheet and as pins: the loaded set with the
/// category filter, search query, and sort order applied. Recomputes only when
/// one of those inputs changes (not on selection), so highlighting a pin is
/// cheap.
@riverpod
List<ServiceProvider> visibleProviders(Ref ref) {
  final all = ref.watch(serviceProvidersProvider).value ??
      const <ServiceProvider>[];
  final category = ref.watch(providerCategoryFilterProvider);
  final query = ref.watch(providerSearchQueryProvider).trim().toLowerCase();
  final sort = ref.watch(providerSortOrderProvider);

  Iterable<ServiceProvider> result = all;

  if (category != ProviderCategory.all) {
    result = result.where((p) => p.category == category);
  }

  if (query.isNotEmpty) {
    result = result.where(
      (p) =>
          p.name.toLowerCase().contains(query) ||
          p.address.toLowerCase().contains(query) ||
          p.category.name.toLowerCase().contains(query),
    );
  }

  final list = result.toList()..sort(_sortComparator(sort));
  return list;
}

int Function(ServiceProvider, ServiceProvider) _sortComparator(
  ProviderSort sort,
) =>
    switch (sort) {
      ProviderSort.distance => (a, b) =>
          (a.distanceMeters ?? double.infinity)
              .compareTo(b.distanceMeters ?? double.infinity),
      ProviderSort.rating => (a, b) => b.rating.compareTo(a.rating),
      ProviderSort.mostReviewed => (a, b) =>
          b.reviewCount.compareTo(a.reviewCount),
      // Open businesses first, then by distance within each group.
      ProviderSort.openNow => (a, b) {
          if (a.isOpen != b.isOpen) return a.isOpen ? -1 : 1;
          return (a.distanceMeters ?? double.infinity)
              .compareTo(b.distanceMeters ?? double.infinity);
        },
    };
