import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'notification_prefs_provider.dart';

part 'lost_pet_radius_provider.g.dart';

/// Allowed range for the lost-pet alert radius, in kilometres. The server
/// clamps too, but the UI enforces it for a clean slider.
const double kLostPetRadiusMinKm = 1;
const double kLostPetRadiusMaxKm = 100;
const double kLostPetRadiusDefaultKm = 10;

const String _boxName = 'notification_prefs_values';
const String _radiusKey = 'lost_pet_alert_radius_km';

/// Thin Hive wrapper for non-boolean notification preference values (currently
/// just the lost-pet alert radius). Kept separate from [NotificationPrefsStore]
/// because that box is strictly `Box<bool>`.
class LostPetRadiusStore {
  const LostPetRadiusStore();

  Future<Box<double>> _box() => Hive.openBox<double>(_boxName);

  Future<double> get() async {
    final box = await _box();
    return box.get(_radiusKey, defaultValue: kLostPetRadiusDefaultKm) ??
        kLostPetRadiusDefaultKm;
  }

  Future<void> set(double km) async {
    final box = await _box();
    await box.put(_radiusKey, km);
  }
}

@Riverpod(keepAlive: true)
LostPetRadiusStore lostPetRadiusStore(Ref ref) => const LostPetRadiusStore();

/// The lost-pet alert radius (km). Reads Hive immediately so the UI shows the
/// cached value without waiting on the network, then syncs from the API in the
/// background. Edits optimistically update + persist, PUT just the radius, and
/// revert on failure.
@Riverpod(keepAlive: true)
class LostPetRadiusNotifier extends _$LostPetRadiusNotifier {
  @override
  Future<double> build() async {
    final store = ref.read(lostPetRadiusStoreProvider);
    final cached = await store.get();
    unawaited(_syncFromApi(cached));
    return cached;
  }

  Future<void> _syncFromApi(double cached) async {
    try {
      final remote = ref.read(notificationPrefsRemoteDataSourceProvider);
      final fresh = await remote.fetchRadiusKm();
      if (fresh == null) return; // Server omitted it - keep the cached value.
      final clamped = _clamp(fresh);
      await ref.read(lostPetRadiusStoreProvider).set(clamped);
      state = AsyncData(clamped);
    } catch (_) {
      // Network unavailable - the cached value stands.
    }
  }

  /// Persists [km] (clamped to range). Optimistic; reverts on API failure.
  Future<void> setRadius(double km) async {
    final store = ref.read(lostPetRadiusStoreProvider);
    final remote = ref.read(notificationPrefsRemoteDataSourceProvider);
    final previous = state.value ?? kLostPetRadiusDefaultKm;
    final next = _clamp(km);

    await store.set(next);
    state = AsyncData(next);

    try {
      final confirmed = await remote.patchRadiusKm(next);
      final effective = confirmed != null ? _clamp(confirmed) : next;
      await store.set(effective);
      state = AsyncData(effective);
    } catch (_) {
      await store.set(previous);
      state = AsyncData(previous);
    }
  }

  static double _clamp(double km) =>
      km.clamp(kLostPetRadiusMinKm, kLostPetRadiusMaxKm).toDouble();
}
