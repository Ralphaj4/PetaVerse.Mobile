import '../../../../core/localization/generated/app_localizations.dart';
import '../../domain/entities/feeding_schedule.dart';

/// Human-readable label for a [FeedingSchedule.daysOfWeek] bitmask, e.g.
/// "Every day", "Weekdays", "Weekends", or "Mon, Wed, Fri".
String feedingDaysLabel(AppLocalizations l10n, int daysOfWeek) {
  const everyDay = 0x7F; // bits 0–6
  const weekdays = 0x3E; // Mon–Fri (bits 1–5)
  const weekends = 0x41; // Sun + Sat (bits 0, 6)

  final mask = daysOfWeek & everyDay;
  if (mask == everyDay) return l10n.feedingEveryDay;
  if (mask == weekdays) return l10n.feedingWeekdays;
  if (mask == weekends) return l10n.feedingWeekends;
  if (mask == 0) return l10n.feedingNoDays;

  final labels = [
    for (final d in Weekday.values)
      if (mask & (1 << d.bit) != 0) shortWeekday(l10n, d),
  ];
  return labels.join(', ');
}

/// Short localized weekday name (Sun … Sat).
String shortWeekday(AppLocalizations l10n, Weekday day) => switch (day) {
      Weekday.sunday => l10n.weekdayShortSun,
      Weekday.monday => l10n.weekdayShortMon,
      Weekday.tuesday => l10n.weekdayShortTue,
      Weekday.wednesday => l10n.weekdayShortWed,
      Weekday.thursday => l10n.weekdayShortThu,
      Weekday.friday => l10n.weekdayShortFri,
      Weekday.saturday => l10n.weekdayShortSat,
    };

/// Full localized weekday name (Sunday … Saturday), for the days picker rows.
String fullWeekday(AppLocalizations l10n, Weekday day) => switch (day) {
      Weekday.sunday => l10n.weekdaySunday,
      Weekday.monday => l10n.weekdayMonday,
      Weekday.tuesday => l10n.weekdayTuesday,
      Weekday.wednesday => l10n.weekdayWednesday,
      Weekday.thursday => l10n.weekdayThursday,
      Weekday.friday => l10n.weekdayFriday,
      Weekday.saturday => l10n.weekdaySaturday,
    };

/// Full localized unit name (Grams / Cups / Cans), for the unit picker.
String feedUnitName(AppLocalizations l10n, FeedUnit unit) => switch (unit) {
      FeedUnit.grams => l10n.feedUnitGramsName,
      FeedUnit.cups => l10n.feedUnitCupsName,
      FeedUnit.cans => l10n.feedUnitCansName,
    };

/// Formats a feeding amount + unit, e.g. "90 g", "1 cup", "2 cans".
String feedAmountLabel(AppLocalizations l10n, double quantity, FeedUnit unit) {
  final n = quantity == quantity.roundToDouble()
      ? quantity.toInt().toString()
      : quantity.toString();
  final unitLabel = switch (unit) {
    FeedUnit.grams => l10n.feedUnitGrams,
    FeedUnit.cups => l10n.feedUnitCups,
    FeedUnit.cans => l10n.feedUnitCans,
  };
  return '$n $unitLabel';
}
