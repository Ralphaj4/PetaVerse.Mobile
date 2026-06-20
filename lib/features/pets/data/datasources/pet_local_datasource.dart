import '../../../../core/storage/hive_service.dart';
import '../../domain/entities/pet_ref.dart';
import '../dtos/pet_dto.dart';

/// Local cache of the current user's pets, in the `pets` Hive box:
///   • `refs` — lightweight {id, name, imagePath} for the routing gate,
///   • `full` — full PetResponse records for display screens (offline-first).
///
/// The box is cleared on logout, so it only ever holds the signed-in user's
/// data.
class PetLocalDataSource {
  const PetLocalDataSource(this._hive);

  final HiveService _hive;

  static const String _box = 'pets';
  static const String _refsKey = 'refs';
  static const String _fullKey = 'full';
  static const String _currentPetKey = 'currentPetId';

  // ── Gate refs ─────────────────────────────────────────────────────────

  /// Reads the cached refs. Empty list when nothing is cached.
  Future<List<PetRef>> readRefs() async {
    final doc = await _hive.getJson(_box, _refsKey);
    final raw = doc?['refs'];
    if (raw is! List) return const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(
          (m) => PetRef(
            id: m['id'] as int,
            name: (m['name'] as String?) ?? '',
            imagePath: m['imagePath'] as String?,
          ),
        )
        .toList(growable: false);
  }

  /// Replaces the cached refs with [refs].
  Future<void> writeRefs(List<PetRef> refs) async {
    await _hive.putJson(_box, _refsKey, {
      'refs': [
        for (final r in refs)
          {'id': r.id, 'name': r.name, 'imagePath': r.imagePath},
      ],
    });
  }

  // ── Full display records ──────────────────────────────────────────────

  /// Reads the cached full pet records. Empty list when nothing is cached.
  Future<List<PetDto>> readPets() async {
    final doc = await _hive.getJson(_box, _fullKey);
    final raw = doc?['pets'];
    if (raw is! List) return const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(PetDto.fromJson)
        .toList(growable: false);
  }

  /// Replaces the cached full pet records with [pets].
  Future<void> writePets(List<PetDto> pets) async {
    await _hive.putJson(_box, _fullKey, {
      'pets': [for (final p in pets) p.toJson()],
    });
  }

  // ── Current pet selection ─────────────────────────────────────────────

  /// Reads the persisted active pet id. Returns null when nothing is stored.
  Future<int?> readCurrentPetId() async {
    final doc = await _hive.getJson(_box, _currentPetKey);
    final value = doc?['id'];
    if (value is int) return value;
    return null;
  }

  /// Persists the active pet id across cold starts.
  Future<void> writeCurrentPetId(int id) async {
    await _hive.putJson(_box, _currentPetKey, {'id': id});
  }

  /// Drops all cached pet data (refs + full). Called on logout.
  Future<void> clear() => _hive.clearBox(_box);
}
