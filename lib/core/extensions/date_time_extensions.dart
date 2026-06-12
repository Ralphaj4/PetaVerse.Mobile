import 'package:intl/intl.dart';

/// Locale-aware date formatting helpers.
extension DateTimeX on DateTime {
  /// e.g. "Jun 11, 2026" in the active locale.
  String toMediumDate(String locale) =>
      DateFormat.yMMMd(locale).format(this);

  /// e.g. "8:00 AM" in the active locale.
  String toShortTime(String locale) => DateFormat.jm(locale).format(this);

  /// e.g. "Jun 11, 2026, 8:00 AM".
  String toMediumDateTime(String locale) =>
      DateFormat.yMMMd(locale).add_jm().format(this);

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Age like "2y 3m" given a birth date.
  String ageFrom(DateTime now) {
    var years = now.year - year;
    var months = now.month - month;
    if (now.day < day) months -= 1;
    if (months < 0) {
      years -= 1;
      months += 12;
    }
    if (years <= 0 && months <= 0) return '<1m';
    if (years <= 0) return '${months}m';
    return '${years}y ${months}m';
  }
}
