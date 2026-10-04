/// A pet's feeding schedule - recurring meals on selected days of the week.
///
/// Domain layer - no Flutter or JSON imports. Mirrors
/// `GET/PUT /api/pets/{petId}/feeding-schedule`. Feeding reminders are shown by
/// device-local notifications the app schedules itself; the backend only stores
/// this config.
class FeedingSchedule {
  const FeedingSchedule({
    required this.id,
    required this.petId,
    required this.daysOfWeek,
    required this.times,
  });

  final int id;
  final int petId;

  /// Bitmask of the days a meal recurs: bit0 = Sunday … bit6 = Saturday.
  /// 127 (all bits) means every day.
  final int daysOfWeek;

  /// The meals within a day, each at a fixed time with an optional amount.
  final List<FeedingTime> times;

  bool dayEnabled(Weekday day) => daysOfWeek & (1 << day.bit) != 0;

  /// The weekdays this schedule fires on, in Sun→Sat order.
  List<Weekday> get activeDays =>
      [for (final d in Weekday.values) if (dayEnabled(d)) d];
}

/// A single meal in a [FeedingSchedule].
class FeedingTime {
  const FeedingTime({
    this.id,
    required this.hour,
    required this.minute,
    this.quantity,
    this.unit = FeedUnit.grams,
  });

  /// Server-assigned stable id. Null for a not-yet-saved time; the PUT response
  /// echoes an id we use to derive the local-notification slot.
  final int? id;

  final int hour;
  final int minute;

  /// Optional amount to serve. Null when the owner didn't specify one.
  final double? quantity;
  final FeedUnit unit;
}

/// Feeding amount unit. Wire values: 0 = Grams, 1 = Cups, 2 = Cans.
enum FeedUnit {
  grams(0),
  cups(1),
  cans(2);

  const FeedUnit(this.wire);

  final int wire;

  static FeedUnit fromWire(int? value) {
    for (final u in values) {
      if (u.wire == value) return u;
    }
    return FeedUnit.grams;
  }
}

/// Days of the week, ordered to match the [FeedingSchedule.daysOfWeek] bitmask
/// (bit0 = Sunday … bit6 = Saturday).
enum Weekday {
  sunday(0),
  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6);

  const Weekday(this.bit);

  /// Bit position in the [FeedingSchedule.daysOfWeek] mask.
  final int bit;

  /// Dart's [DateTime.weekday] value (Mon = 1 … Sun = 7), used when computing
  /// the next occurrence for weekly-recurring local notifications.
  int get dartWeekday => this == Weekday.sunday ? DateTime.sunday : bit;
}
