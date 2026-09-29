/// A cached, upcoming health reminder shown on the home "Upcoming" section:
/// either a medication dose that's due or a vaccination booster.
///
/// Built from the per-pet medication / vaccination lists at fetch time and
/// stored locally, so the home screen can render reminders before a dedicated
/// home endpoint exists. Reconciliation with a server feed happens later.
enum HealthReminderKind { medication, vaccination, appointment }

class HealthReminder {
  const HealthReminder({
    required this.kind,
    required this.sourceId,
    required this.petId,
    required this.petName,
    required this.title,
    required this.dueDate,
  });

  final HealthReminderKind kind;

  /// The medication-history id or vaccination id this reminder came from.
  final int sourceId;

  final int petId;
  final String petName;

  /// Medication or vaccine name.
  final String title;

  /// When the dose / booster is due (local time).
  final DateTime dueDate;

  /// Stable key for de-duplication across refreshes.
  String get key => '${kind.name}:$petId:$sourceId';

  bool get isOverdue => dueDate.isBefore(DateTime.now());

  int get daysUntilDue {
    final now = DateTime.now();
    final d = DateTime(dueDate.year, dueDate.month, dueDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return d.difference(today).inDays;
  }

  Map<String, dynamic> toJson() => {
        'kind': kind.name,
        'sourceId': sourceId,
        'petId': petId,
        'petName': petName,
        'title': title,
        'dueDate': dueDate.toUtc().toIso8601String(),
      };

  factory HealthReminder.fromJson(Map<String, dynamic> json) => HealthReminder(
        kind: HealthReminderKind.values.firstWhere(
          (k) => k.name == json['kind'],
          orElse: () => HealthReminderKind.medication,
        ),
        sourceId: (json['sourceId'] as num).toInt(),
        petId: (json['petId'] as num).toInt(),
        petName: (json['petName'] as String?) ?? '',
        title: (json['title'] as String?) ?? '',
        dueDate: DateTime.parse(json['dueDate'] as String).toLocal(),
      );
}
