/// A pet's grooming schedule — a recurring interval with a next-due anchor.
///
/// Domain layer — no Flutter or JSON imports. Mirrors
/// `GET/PUT /api/pets/{petId}/grooming-schedule`. Grooming reminders arrive as
/// FCM server pushes (due-soon + overdue); the app does not schedule them
/// locally. Marking groomed advances [nextDueDate] server-side.
class GroomingSchedule {
  const GroomingSchedule({
    required this.id,
    required this.petId,
    required this.intervalDays,
    required this.nextDueDate,
    this.lastGroomedDate,
  });

  final int id;
  final int petId;

  /// Recurrence interval in whole days (1–3650).
  final int intervalDays;

  /// When grooming is next due. The reminder anchor; may be today or future.
  final DateTime nextDueDate;

  /// When the pet was last groomed, or null if never recorded.
  final DateTime? lastGroomedDate;

  /// Whole days from [now] until [nextDueDate]. Negative when overdue.
  int daysUntilDue(DateTime now) {
    final due = DateTime(nextDueDate.year, nextDueDate.month, nextDueDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return due.difference(today).inDays;
  }

  bool isOverdue(DateTime now) => daysUntilDue(now) < 0;
}
