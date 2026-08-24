/// A pet appointment (vet, groomer, etc.) stored in the backend.
///
/// Domain layer — no Flutter or JSON imports.
class Appointment {
  const Appointment({
    required this.id,
    required this.petId,
    required this.title,
    required this.scheduledAt,
    this.location,
    this.notes,
  });

  /// Server-assigned id.
  final int id;

  final int petId;

  /// Short label, e.g. "Annual Check-up" or "Grooming".
  final String title;

  /// Date and time of the appointment (local time).
  final DateTime scheduledAt;

  /// Optional clinic / service name or address.
  final String? location;

  final String? notes;

  bool get isPast => scheduledAt.isBefore(DateTime.now());

  /// Whole days from today until [scheduledAt]. Negative when past.
  int get daysUntil {
    final at = DateTime(scheduledAt.year, scheduledAt.month, scheduledAt.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return at.difference(today).inDays;
  }
}
