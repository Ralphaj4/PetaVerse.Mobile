/// A vaccination record for a pet.
///
/// Domain layer — no Flutter or JSON imports. Mirrors
/// `GET /api/pets/{petId}/vaccinations`.
class Vaccination {
  const Vaccination({
    required this.id,
    required this.name,
    required this.administeredAt,
    this.nextDueDate,
    this.vetName,
    this.notes,
    this.documentUrl,
  });

  final int id;

  /// Vaccine display name (wire field `vaccineName`).
  final String name;

  /// When the vaccine was administered (wire field `dateAdministered`).
  final DateTime administeredAt;

  /// When the booster is next due, or null when it's a one-time vaccine.
  final DateTime? nextDueDate;

  /// Administering vet, if recorded.
  final String? vetName;

  /// Optional free-text note.
  final String? notes;

  /// Optional URL to an uploaded certificate / document.
  final String? documentUrl;

  /// True when a booster is due on or before [now].
  bool isDue(DateTime now) {
    final due = nextDueDate;
    if (due == null) return false;
    return !due.isAfter(now);
  }
}
