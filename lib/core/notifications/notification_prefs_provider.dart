import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/api_client.dart';
import 'notification_prefs_remote_datasource.dart';
import 'notification_prefs_store.dart';

part 'notification_prefs_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationPrefsStore notificationPrefsStore(Ref ref) =>
    const NotificationPrefsStore();

@Riverpod(keepAlive: true)
NotificationPrefsRemoteDataSource notificationPrefsRemoteDataSource(Ref ref) =>
    NotificationPrefsRemoteDataSource(ref.watch(apiClientProvider));

/// Live map of all notification preferences. keepAlive so every consumer
/// (FCM handler, notification service, settings page) shares one instance.
///
/// Build order:
///   1. Read Hive immediately → UI shows instantly with cached values.
///   2. Fetch from API in the background → overwrite Hive + state.
@Riverpod(keepAlive: true)
class NotificationPrefsNotifier extends _$NotificationPrefsNotifier {
  @override
  Future<Map<String, bool>> build() async {
    final store = ref.read(notificationPrefsStoreProvider);
    final remote = ref.read(notificationPrefsRemoteDataSourceProvider);

    // Return Hive values immediately so the UI never waits on the network.
    final cached = await store.getAll();

    // Fetch from API in the background; update Hive + state when done.
    unawaited(_syncFromApi(store, remote));

    return cached;
  }

  Future<void> _syncFromApi(
    NotificationPrefsStore store,
    NotificationPrefsRemoteDataSource remote,
  ) async {
    try {
      final fresh = await remote.fetch();
      await store.setAll(fresh);
      state = AsyncData(fresh);
    } catch (_) {
      // Network unavailable — Hive values are good enough.
    }
  }

  /// Optimistically toggles [key] to [enabled], persists to Hive, then syncs
  /// to the API. Reverts both Hive and state on API failure.
  Future<void> toggle(String key, {required bool enabled}) async {
    final store = ref.read(notificationPrefsStoreProvider);
    final remote = ref.read(notificationPrefsRemoteDataSourceProvider);
    final previous = state.value ?? {};

    // 1. Optimistic local update.
    final optimistic = {...previous, key: enabled};
    await store.set(key, enabled: enabled);
    state = AsyncData(optimistic);

    // 2. Sync single field to API; revert on failure.
    try {
      final updated = await remote.patch({key: enabled});
      await store.setAll(updated);
      state = AsyncData(updated);
    } catch (_) {
      // Revert to the state before the toggle.
      await store.set(key, enabled: previous[key] ?? true);
      state = AsyncData(previous);
    }
  }

  bool isEnabled(String key) => state.value?[key] ?? true;
}
