import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/location/location_service.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/lost_found_remote_datasource.dart';
import '../../data/repositories/lost_found_repository_impl.dart';
import '../../domain/entities/lost_found_dashboard.dart';
import '../../domain/entities/lost_found_report.dart';
import '../../domain/repositories/lost_found_repository.dart';

part 'lost_found_providers.g.dart';

/// Default map center when device location is unavailable (Beirut).
///
/// Aliases the app-wide [kDefaultMapCenter]; kept as a named constant so the
/// existing Lost & Found call sites read clearly.
const LatLng kLostFoundFallbackCenter = kDefaultMapCenter;

@Riverpod(keepAlive: true)
LostFoundRepository lostFoundRepository(Ref ref) => LostFoundRepositoryImpl(
      LostFoundRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// Loads a single report by id for the details screen. Auto-disposes so each
/// visit fetches fresh data; the details page seeds the UI from the tapped
/// alert while this resolves.
@riverpod
Future<LostFoundReport> reportDetail(Ref ref, int id) async {
  final result = await ref.watch(lostFoundRepositoryProvider).getReport(id);
  return result.when(
    success: (report) => report,
    failure: (f) => throw f,
  );
}

/// The active recent-alerts filter. Drives a dashboard refetch (the backend
/// filters `recentAlerts`; `mapPins` always shows all in-radius pins).
enum LostFoundFilter { all, lost, found }

@riverpod
class LostFoundFilterNotifier extends _$LostFoundFilterNotifier {
  @override
  LostFoundFilter build() => LostFoundFilter.all;

  void setFilter(LostFoundFilter filter) => state = filter;
}

/// Loads the dashboard for the device location and current filter. Re-runs
/// when the filter changes. Falls back to [kLostFoundFallbackCenter] when the
/// device location is unavailable so the screen still renders.
@riverpod
class LostFoundDashboardNotifier extends _$LostFoundDashboardNotifier {
  @override
  Future<LostFoundDashboard> build() async {
    final filter = ref.watch(lostFoundFilterProvider);
    final filterValue = switch (filter) {
      LostFoundFilter.all => null,
      LostFoundFilter.lost => 'lost',
      LostFoundFilter.found => 'found',
    };

    final here =
        await ref.read(locationServiceProvider).currentLatLng() ??
            kLostFoundFallbackCenter;

    final result = await ref.read(lostFoundRepositoryProvider).getDashboard(
          latitude: here.latitude,
          longitude: here.longitude,
          filter: filterValue,
        );
    return result.when(
      success: (dashboard) => dashboard,
      failure: (f) => throw f,
    );
  }
}

/// Volunteer join/leave actions. The AsyncValue carries the in-flight state.
///
/// `keepAlive` is REQUIRED: these methods set `state = AsyncLoading()` then
/// await the network. As an auto-dispose notifier with no listeners (the page
/// only `ref.read`s it), it would be disposed mid-await and the returned Future
/// would never complete — hanging the caller. Keeping it alive avoids that.
@Riverpod(keepAlive: true)
class VolunteerActions extends _$VolunteerActions {
  @override
  FutureOr<void> build() {}

  /// Joins the volunteers. Returns the updated [VolunteerInfo] on success
  /// (null on failure — read [state] for the error). Refreshes the dashboard
  /// so the CTA reflects the new status.
  /// Returns the updated [VolunteerInfo] on success (null on failure — read
  /// [state] for the error). The CALLER patches the dashboard (the page holds
  /// the live, watched dashboard instance), so the banner updates instantly.
  Future<VolunteerInfo?> join() async {
    state = const AsyncLoading();
    final result = await ref.read(lostFoundRepositoryProvider).joinVolunteers();
    return result.when(
      success: (info) {
        state = const AsyncData(null);
        return info;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }

  /// Leaves the volunteers. Returns true on success. The DELETE returns 204
  /// (no body); the caller derives the new status (not a volunteer, count - 1).
  Future<bool> leave() async {
    state = const AsyncLoading();
    final result =
        await ref.read(lostFoundRepositoryProvider).leaveVolunteers();
    state = result.when(
      success: (_) => const AsyncData(null),
      failure: (f) => AsyncError(f, StackTrace.current),
    );
    return state.hasValue;
  }
}

/// Creates a lost report. The AsyncValue carries loading + the last [Failure]
/// (for a spinner and a localized error); [create] returns the new report on
/// success (null on failure). On success the dashboard is invalidated so the
/// new alert appears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await (which would hang
/// the returned Future) — see [VolunteerActions].
@Riverpod(keepAlive: true)
class CreateReport extends _$CreateReport {
  @override
  FutureOr<void> build() {}

  /// The failure from the most recent attempt, or null if it succeeded.
  Failure? get lastFailure {
    final err = state.error;
    return err is Failure ? err : null;
  }

  Future<LostFoundReport?> create({
    required ReportType type,
    required String petName,
    required int speciesId,
    int? breedId,
    required String description,
    required String lastSeenAddress,
    required double latitude,
    required double longitude,
    int? petId,
    int? reward,
    String? avatarMediaAssetId,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(lostFoundRepositoryProvider).createReport(
          // Wire enum: lost = 1, found = 2.
          type: type == ReportType.found ? 2 : 1,
          petName: petName,
          speciesId: speciesId,
          breedId: breedId,
          description: description,
          lastSeenAddress: lastSeenAddress,
          latitude: latitude,
          longitude: longitude,
          petId: petId,
          // Reward only applies to Lost (server ignores it for Found).
          reward: type == ReportType.lost ? reward : null,
          // An uploaded PetReport MediaAsset (confirmed, owned by the caller).
          // Used for Found reports since the finder doesn't own the pet.
          avatarMediaAssetId: avatarMediaAssetId,
        );
    return result.when(
      success: (report) {
        state = const AsyncData(null);
        ref.invalidate(lostFoundDashboardProvider);
        return report;
      },
      failure: (f) {
        state = AsyncError(f, StackTrace.current);
        return null;
      },
    );
  }
}

/// Deletes the user's own report. Returns true on success; on success the
/// dashboard is invalidated so the deleted alert disappears.
///
/// `keepAlive` so the notifier isn't auto-disposed mid-await — see
/// [VolunteerActions].
@Riverpod(keepAlive: true)
class DeleteReport extends _$DeleteReport {
  @override
  FutureOr<void> build() {}

  Failure? get lastFailure {
    final err = state.error;
    return err is Failure ? err : null;
  }

  Future<bool> delete(int id) async {
    state = const AsyncLoading();
    final result = await ref.read(lostFoundRepositoryProvider).deleteReport(id);
    state = result.when(
      success: (_) => const AsyncData(null),
      failure: (f) => AsyncError(f, StackTrace.current),
    );
    if (state.hasValue) {
      ref.invalidate(lostFoundDashboardProvider);
      return true;
    }
    return false;
  }
}
