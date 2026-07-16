import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/adoption_remote_datasource.dart';
import '../../data/repositories/adoption_repository_impl.dart';
import '../../domain/entities/adoption_listing.dart';
import '../../domain/repositories/adoption_repository.dart';

part 'adoption_providers.g.dart';

/// Haversine distance calculator for client-side distance stamping.
const Distance _distance = Distance();

@Riverpod(keepAlive: true)
AdoptionRepository adoptionRepository(Ref ref) => AdoptionRepositoryImpl(
      AdoptionRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// The map center used to scope the board query. Starts at the app default
/// center immediately (so the list never waits on location) and refines in the
/// background when a fix arrives — same pattern as the providers board.
@Riverpod(keepAlive: true)
class AdoptionQueryCenter extends _$AdoptionQueryCenter {
  @override
  LatLng build() {
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

/// Selected species filter as a species id, or null for "All". Populated from
/// the shared `/species` lookup (see the create-pet form's speciesListProvider).
@riverpod
class AdoptionSpeciesFilter extends _$AdoptionSpeciesFilter {
  @override
  int? build() => null;

  void select(int? speciesId) => state = speciesId;
}

/// Debounced search query. The text field debounces before writing here, so
/// this never churns on every keystroke.
@riverpod
class AdoptionSearchQuery extends _$AdoptionSearchQuery {
  @override
  String build() => '';

  void set(String query) => state = query;
}

/// The board: Available listings for the current center, species filter, and
/// search query. The server does the filtering (speciesId + q), so changing a
/// filter re-runs this query. Distance is stamped client-side against the
/// center and the list is sorted nearest-first.
@riverpod
class AdoptionListingsNotifier extends _$AdoptionListingsNotifier {
  @override
  Future<List<AdoptionListing>> build() async {
    final center = ref.watch(adoptionQueryCenterProvider);
    final speciesId = ref.watch(adoptionSpeciesFilterProvider);
    final query = ref.watch(adoptionSearchQueryProvider).trim();

    final result = await ref.read(adoptionRepositoryProvider).getListings(
          speciesId: speciesId,
          query: query.isEmpty ? null : query,
          lat: center.latitude,
          lng: center.longitude,
        );
    final listings = result.when(
      success: (l) => l,
      failure: (f) => throw f,
    );

    // Stamp distance from the query center and sort nearest-first.
    final withDistance = listings
        .map(
          (l) => l.location == null
              ? l
              : l.copyWithDistance(
                  _distance.as(LengthUnit.Meter, center, l.location!),
                ),
        )
        .toList()
      ..sort(
        (a, b) => (a.distanceMeters ?? double.infinity)
            .compareTo(b.distanceMeters ?? double.infinity),
      );
    return withDistance;
  }

  /// Re-fetches for the current query (retry after an error / pull-to-refresh).
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// A single listing by id, for the detail screen. Seeded instantly from the
/// already-loaded board list when present (so the detail opens with no spinner),
/// otherwise fetched by id.
@riverpod
Future<AdoptionListing> adoptionListing(Ref ref, int id) async {
  final loaded = ref.watch(adoptionListingsProvider).value;
  final seeded = loaded?.where((l) => l.id == id);
  if (seeded != null && seeded.isNotEmpty) return seeded.first;

  final result = await ref.read(adoptionRepositoryProvider).getListing(id);
  return result.when(
    success: (listing) => listing,
    failure: (f) => throw f,
  );
}

/// The current user's adoption applications (adopter side).
@riverpod
class MyAdoptionRequestsNotifier extends _$MyAdoptionRequestsNotifier {
  @override
  Future<List<MyAdoptionRequest>> build() async {
    final result = await ref.read(adoptionRepositoryProvider).getMyRequests();
    return result.when(
      success: (r) => r,
      failure: (f) => throw f,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// The current user's own listings (lister side), all statuses — so a listing
/// stays findable after it leaves the public board (PendingTransfer/Adopted/
/// Withdrawn).
@riverpod
class MyAdoptionListingsNotifier extends _$MyAdoptionListingsNotifier {
  @override
  Future<List<AdoptionListing>> build() async {
    final result = await ref.read(adoptionRepositoryProvider).getMyListings();
    return result.when(
      success: (l) => l,
      failure: (f) => throw f,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  /// Optimistically drop a listing from the cached list (e.g. right after a
  /// successful delete) so the UI updates before the next server refresh.
  void remove(int id) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.where((l) => l.id != id).toList());
  }
}

/// Applicants on a specific listing the current user owns (lister side).
@riverpod
Future<List<AdoptionRequest>> adoptionListingRequests(
  Ref ref,
  int listingId,
) async {
  final result =
      await ref.read(adoptionRepositoryProvider).getListingRequests(listingId);
  return result.when(
    success: (r) => r,
    failure: (f) => throw f,
  );
}

/// Creates an adoption listing for one of the current user's pets.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future).
@Riverpod(keepAlive: true)
class CreateAdoptionListing extends _$CreateAdoptionListing {
  @override
  FutureOr<void> build() {}

  /// The failure from the most recent attempt, or null if it succeeded.
  Failure? get lastFailure {
    final err = state.error;
    return err is Failure ? err : null;
  }

  Future<AdoptionListing?> create({
    required int petId,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    bool vaccinated = false,
    bool neutered = false,
    bool goodWithKids = false,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(adoptionRepositoryProvider).createListing(
          petId: petId,
          description: description,
          locationLabel: locationLabel,
          latitude: latitude,
          longitude: longitude,
          vaccinated: vaccinated,
          neutered: neutered,
          goodWithKids: goodWithKids,
        );
    return result.when(
      success: (listing) {
        state = const AsyncData(null);
        // Refresh the board so the new listing shows up.
        ref.read(adoptionListingsProvider.notifier).refresh();
        return listing;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }

  /// Creates a shelter/stray listing (no backing pet) with the animal's
  /// details supplied inline. [photoAssetId] is the confirmed
  /// AdoptionListingPhoto asset, uploaded before this call.
  Future<AdoptionListing?> createShelter({
    required String petName,
    required int speciesId,
    required String gender,
    int? breedId,
    DateTime? dateOfBirth,
    int? sizeId,
    int? coatColorId,
    String? photoAssetId,
    String? description,
    String? locationLabel,
    double? latitude,
    double? longitude,
    bool vaccinated = false,
    bool neutered = false,
    bool goodWithKids = false,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(adoptionRepositoryProvider).createShelterListing(
          petName: petName,
          speciesId: speciesId,
          gender: gender,
          breedId: breedId,
          dateOfBirth: dateOfBirth,
          sizeId: sizeId,
          coatColorId: coatColorId,
          photoAssetId: photoAssetId,
          description: description,
          locationLabel: locationLabel,
          latitude: latitude,
          longitude: longitude,
          vaccinated: vaccinated,
          neutered: neutered,
          goodWithKids: goodWithKids,
        );
    return result.when(
      success: (listing) {
        state = const AsyncData(null);
        ref.read(adoptionListingsProvider.notifier).refresh();
        return listing;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }
}
