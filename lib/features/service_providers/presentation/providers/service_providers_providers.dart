import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/location/location_service.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/service_provider_remote_datasource.dart';
import '../../data/repositories/service_provider_repository_impl.dart';
import '../../domain/entities/provider_category.dart';
import '../../domain/entities/provider_category_ref.dart';
import '../../domain/entities/provider_search.dart';
import '../../domain/entities/service_provider.dart';
import '../../domain/repositories/service_provider_repository.dart';
import '../../../../core/network/api_client.dart';

part 'service_providers_providers.g.dart';

@Riverpod(keepAlive: true)
ServiceProviderRepository serviceProviderRepository(Ref ref) =>
    ServiceProviderRepositoryImpl(
      ServiceProviderRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// The admin-configurable category list (id ↔ slug ↔ name), backing the filter
/// bar. Loaded once; widgets map each row to a client [ProviderCategory].
@riverpod
Future<List<ProviderCategoryRef>> providerCategories(Ref ref) async {
  final result = await ref.watch(serviceProviderRepositoryProvider).getCategories();
  return result.when(success: (c) => c, failure: (f) => throw f);
}

/// The device's current location, resolved once in the background. Null until
/// (or unless) it lands — the search runs against the viewport regardless, and
/// distance is simply omitted when this is null.
@Riverpod(keepAlive: true)
class ProviderUserLocation extends _$ProviderUserLocation {
  @override
  LatLng? build() {
    _resolve();
    return null;
  }

  Future<void> _resolve() async {
    try {
      final here = await ref
          .read(locationServiceProvider)
          .currentLatLng()
          .timeout(const Duration(seconds: 8));
      if (here != null) state = here;
    } catch (_) {
      // No fix / denied — distance is omitted; search still works.
    }
  }

  /// Re-attempts location resolution (e.g. the "my location" button after the
  /// user granted permission from settings).
  Future<void> refresh() => _resolve();
}

/// The visible map bounding box, updated when the camera settles after a pan.
/// Null until the map reports its first viewport; the search waits for it.
@riverpod
class ProviderViewport extends _$ProviderViewport {
  @override
  GeoBounds? build() => null;

  void set(GeoBounds bounds) => state = bounds;
}

/// Selected category filter (single-select). [ProviderCategory.all] = no filter.
@riverpod
class ProviderCategoryFilter extends _$ProviderCategoryFilter {
  @override
  ProviderCategory build() => ProviderCategory.all;

  void select(ProviderCategory category) => state = category;
}

/// Debounced search query. The text field debounces before writing here.
@riverpod
class ProviderSearchQuery extends _$ProviderSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

/// Active sort order for the search.
@riverpod
class ProviderSortOrder extends _$ProviderSortOrder {
  @override
  ProviderSort build() => ProviderSort.distance;

  void select(ProviderSort sort) => state = sort;
}

/// "Open now" toggle for the search.
@riverpod
class ProviderOpenNowFilter extends _$ProviderOpenNowFilter {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

/// Whether results are tailored to the active pet's species ("For [Pet]" vs
/// "All"). Defaults on when the user has an active pet.
@riverpod
class ProviderPetTailoring extends _$ProviderPetTailoring {
  @override
  bool build() => ref.watch(petsProvider).currentPetId != null;

  void toggle() => state = !state;
}

/// The active pet id to send for tailoring, or null when tailoring is off / no
/// pet is selected.
@riverpod
int? providerTailoringPetId(Ref ref) {
  final on = ref.watch(providerPetTailoringProvider);
  if (!on) return null;
  return ref.watch(petsProvider).currentPetId;
}

/// The currently highlighted branch pin (tapped pin or card), keyed by
/// `branchId`, or null. Drives pin highlight + the map camera fly-to. Separate
/// from the search so selecting never refetches.
@riverpod
class SelectedProvider extends _$SelectedProvider {
  @override
  int? build() => null;

  void select(int? branchId) => state = branchId;

  void toggle(int branchId) => state = state == branchId ? null : branchId;
}

/// Runs the viewport search and re-runs whenever the viewport or any filter
/// changes. Debounced so a fast pan/typing burst issues one request once things
/// settle. Returns the full result (items + paging guardrails).
@riverpod
class ServiceProvidersNotifier extends _$ServiceProvidersNotifier {
  @override
  Future<ProviderSearchResult> build() async {
    final bounds = ref.watch(providerViewportProvider);
    // No viewport yet → nothing to search; the map reports one on first idle.
    if (bounds == null) return const ProviderSearchResult.empty();

    final params = ProviderSearchParams(
      bounds: bounds,
      userLocation: ref.watch(providerUserLocationProvider),
      category: ref.watch(providerCategoryFilterProvider),
      query: ref.watch(providerSearchQueryProvider),
      petId: ref.watch(providerTailoringPetIdProvider),
      openNow: ref.watch(providerOpenNowFilterProvider),
      sort: ref.watch(providerSortOrderProvider),
    );

    // Debounce: coalesce rapid input/pan changes into a single request. If the
    // provider is rebuilt (a newer change arrived) this future is discarded.
    await _debounce();

    final result = await ref.read(serviceProviderRepositoryProvider).search(params);
    return result.when(
      success: (r) => r,
      failure: (f) => throw f,
    );
  }

  Future<void> _debounce() {
    final completer = Completer<void>();
    final timer = Timer(const Duration(milliseconds: 350), () {
      if (!completer.isCompleted) completer.complete();
    });
    ref.onDispose(() {
      timer.cancel();
      if (!completer.isCompleted) completer.complete();
    });
    return completer.future;
  }

  /// Re-fetches the current viewport (pull-to-retry after an error).
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// Caches provider pins across viewport changes. Since the API returns results
/// for the current viewport (bbox), panning can cause pins to appear/disappear.
/// This notifier keeps a union of all pins ever fetched and reconciles with new
/// API results (added/removed/updated). Prevents flickering when zooming in/out.
///
/// Reconciliation is driven by listening to [serviceProvidersProvider] rather
/// than by a derived provider writing here during its build — Riverpod forbids
/// one provider mutating another mid-build.
@riverpod
class ProviderPinCache extends _$ProviderPinCache {
  @override
  Map<int, ServiceProvider> build() {
    // Merge each new search result into the union as it lands. The listener
    // fires after this build completes, so mutating state from it is safe.
    ref.listen(serviceProvidersProvider, (_, next) {
      final items = next.value?.items;
      if (items != null && items.isNotEmpty) _reconcile(items);
    });

    // Seed from whatever the search already holds (e.g. a cached result on a
    // rebuild) so the first frame isn't empty.
    return {
      for (final p
          in ref.read(serviceProvidersProvider).value?.items ??
              const <ServiceProvider>[])
        p.branchId: p,
    };
  }

  /// Merges new API results with cached pins.
  void _reconcile(List<ServiceProvider> apiResults) {
    final cache = Map<int, ServiceProvider>.from(state);
    for (final p in apiResults) {
      cache[p.branchId] = p;
    }
    state = cache;
  }
}

/// The branch pins actually shown (map + list). A pure derivation of the pin
/// cache and the current selection — the selected pin floats to the top.
@riverpod
List<ServiceProvider> visibleProviders(Ref ref) {
  final cache = ref.watch(providerPinCacheProvider);
  final providers = cache.values.toList();

  // Sort so selected provider appears at the top
  final selectedId = ref.watch(selectedProviderProvider);
  if (selectedId != null) {
    final selectedIndex =
        providers.indexWhere((p) => p.branchId == selectedId);
    if (selectedIndex > 0) {
      final selected = providers.removeAt(selectedIndex);
      providers.insert(0, selected);
    }
  }

  return providers;
}
