import '../../../../core/storage/hive_service.dart';
import '../../domain/entities/health_reminder.dart';

/// Local cache of upcoming health reminders (medication doses + vaccination
/// boosters), in the `health_reminders` Hive box.
///
/// One JSON document per (pet, kind), keyed `p{petId}:{kind}`, holding that
/// slice's reminders as a list. Medications and vaccinations for the same pet
/// live under separate keys so caching one never clobbers the other, and a
/// re-fetch of one slice never disturbs the rest. Reading merges everything.
///
/// The box holds only the signed-in user's data; clear it on logout.
class HealthReminderLocalDataSource {
  const HealthReminderLocalDataSource(this._hive);

  final HiveService _hive;

  static const String _box = 'health_reminders';

  String _key(int petId, HealthReminderKind kind) => 'p$petId:${kind.name}';

  /// Replaces the cached reminders for [petId] + [kind]. Passing an empty list
  /// clears that slice (e.g. the pet no longer has any due doses / boosters).
  Future<void> writeForPet(
    int petId,
    HealthReminderKind kind,
    List<HealthReminder> reminders,
  ) async {
    if (reminders.isEmpty) {
      await _hive.delete(_box, _key(petId, kind));
      return;
    }
    await _hive.putJson(_box, _key(petId, kind), {
      'reminders': [for (final r in reminders) r.toJson()],
    });
  }

  /// All cached reminders across every pet, unsorted.
  Future<List<HealthReminder>> readAll() async {
    final docs = await _hive.getAllJson(_box);
    final out = <HealthReminder>[];
    for (final doc in docs) {
      final raw = doc['reminders'];
      if (raw is! List) continue;
      for (final e in raw) {
        if (e is Map<String, dynamic>) {
          out.add(HealthReminder.fromJson(e));
        }
      }
    }
    return out;
  }

  Future<void> clear() => _hive.clearBox(_box);
}
