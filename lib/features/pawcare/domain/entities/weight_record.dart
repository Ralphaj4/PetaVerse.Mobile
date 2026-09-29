/// A single weight measurement for a pet.
///
/// Domain layer — no Flutter or JSON imports. Mirrors
/// `GET /api/pets/{petId}/weight` (`{id, weight, unit, recordedDate, notes}`).
class WeightRecord {
  const WeightRecord({
    required this.id,
    required this.value,
    required this.unit,
    required this.recordedAt,
    this.notes,
  });

  final int id;

  /// The measured weight in [unit] (wire field `weight`).
  final double value;

  /// Unit the value is expressed in.
  final WeightUnit unit;

  /// When the measurement was taken (wire field `recordedDate`).
  final DateTime recordedAt;

  /// Optional free-text note.
  final String? notes;
}

/// Supported weight units. The wire value is [wire].
enum WeightUnit {
  kg('kg'),
  lbs('lbs'),
  g('g'),
  oz('oz');

  const WeightUnit(this.wire);

  /// The exact token the API expects / returns.
  final String wire;

  /// Short display suffix, e.g. "kg".
  String get suffix => wire;

  /// Parses a wire unit token, defaulting to [WeightUnit.kg].
  static WeightUnit fromWire(String? raw) {
    switch ((raw ?? '').toLowerCase()) {
      case 'lbs':
      case 'lb':
        return WeightUnit.lbs;
      case 'g':
        return WeightUnit.g;
      case 'oz':
        return WeightUnit.oz;
      default:
        return WeightUnit.kg;
    }
  }
}
