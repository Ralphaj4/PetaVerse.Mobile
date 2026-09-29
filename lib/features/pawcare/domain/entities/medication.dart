/// An active medication schedule for a pet.
///
/// Domain layer — no Flutter or JSON imports. Mirrors
/// `GET /api/pets/{petId}/medications`.
class Medication {
  const Medication({
    required this.id,
    required this.name,
    required this.frequencyDays,
    required this.nextDueDate,
    this.lastGivenDate,
    this.startDate,
    this.endDate,
    this.isActive = true,
    this.isDueSoon = false,
    this.isOverdue = false,
    this.notes,
  });

  final int id;

  /// Medication display name (wire field `medicationName`).
  final String name;

  /// Recurrence interval in whole days.
  final int frequencyDays;

  /// When the next dose is due. Drives the "due in Nd" / "overdue" badge.
  final DateTime nextDueDate;

  /// When the last dose was recorded as given, or null if never.
  final DateTime? lastGivenDate;

  /// When the schedule started.
  final DateTime? startDate;

  /// When the schedule ends, or null for open-ended.
  final DateTime? endDate;

  final bool isActive;

  /// Server-computed flags — prefer these over recomputing on the client.
  final bool isDueSoon;
  final bool isOverdue;

  /// Optional free-text note.
  final String? notes;

  /// Whole days from [now] until [nextDueDate]. Negative when overdue.
  int daysUntilDue(DateTime now) {
    final due = DateTime(nextDueDate.year, nextDueDate.month, nextDueDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return due.difference(today).inDays;
  }
}

/// A medication due soon, carrying the owning pet so a cross-pet "upcoming"
/// list can group / label rows. Mirrors `GET /api/medications/upcoming`.
class UpcomingMedication {
  const UpcomingMedication({
    required this.medicationHistoryId,
    required this.petId,
    required this.petName,
    required this.medicationName,
    required this.nextDueDate,
    required this.daysUntilDue,
    required this.isOverdue,
  });

  final int medicationHistoryId;
  final int petId;
  final String petName;
  final String medicationName;
  final DateTime nextDueDate;
  final int daysUntilDue;
  final bool isOverdue;
}
