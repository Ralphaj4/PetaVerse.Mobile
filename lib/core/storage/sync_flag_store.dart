import 'package:hive_flutter/hive_flutter.dart';

/// Persists per-pet dirty flags written by the FCM silent-sync handler.
///
/// When a silent `category: "sync"` push arrives for a pet, [setSyncNeeded]
/// marks it dirty. The next time [PawCareRepositoryImpl] fetches health data
/// for that pet it reads [isSyncNeeded], forces a remote call (bypassing any
/// freshness guard), then calls [clearSyncFlag] after reconciliation.
class SyncFlagStore {
  static const _boxName = 'sync_flags';

  Future<Box<bool>> _box() => Hive.openBox<bool>(_boxName);

  Future<void> setSyncNeeded(int petId) async {
    final box = await _box();
    await box.put(petId.toString(), true);
  }

  Future<bool> isSyncNeeded(int petId) async {
    final box = await _box();
    return box.get(petId.toString()) ?? false;
  }

  Future<void> clearSyncFlag(int petId) async {
    final box = await _box();
    await box.delete(petId.toString());
  }
}
