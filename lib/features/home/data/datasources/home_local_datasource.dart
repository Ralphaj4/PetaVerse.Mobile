import '../../../../core/storage/hive_service.dart';
import '../dtos/home_summary_dto.dart';

/// Local cache for the home summary, in the `home_summary` Hive box.
///
/// One JSON document per selected pet (keyed by pet id, or `default` when the
/// backend picked the pet), holding the raw wire payload so re-reads are
/// lossless. Backs the offline-first home view: read cache → show → fetch →
/// update cache → refresh. Holds only the signed-in user's data; clear on
/// logout.
class HomeLocalDataSource {
  const HomeLocalDataSource(this._hive);

  final HiveService _hive;

  static const String _box = 'home_summary';

  String _key(int? petId) => petId == null ? 'default' : 'p$petId';

  /// Caches the summary wire payload for [petId] (or the default slot).
  Future<void> write(int? petId, HomeSummaryDto dto) async {
    await _hive.putJson(_box, _key(petId), dto.toJson());
  }

  /// The cached summary for [petId], or null when nothing is cached (or the
  /// stored document is unreadable).
  Future<HomeSummaryDto?> read(int? petId) async {
    final json = await _hive.getJson(_box, _key(petId));
    if (json == null) return null;
    try {
      return HomeSummaryDto.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> clear() => _hive.clearBox(_box);
}
