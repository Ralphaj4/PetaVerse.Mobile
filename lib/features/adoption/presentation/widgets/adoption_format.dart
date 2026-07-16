import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/localization/generated/app_localizations.dart';

/// Presentation helpers for adoption: labels and glyphs derived from the pet's
/// data (species is a free-text name from the /species lookup, not an enum).
abstract final class AdoptionFormat {
  /// A paw glyph keyed loosely off the species name, used as the photo-fallback
  /// and species chip icon. Falls back to a generic paw for unknown names.
  static IconData speciesIcon(String? speciesName) {
    final s = speciesName?.toLowerCase() ?? '';
    if (s.contains('dog')) return FluentIcons.animal_dog_24_filled;
    if (s.contains('cat')) return FluentIcons.animal_cat_24_filled;
    if (s.contains('rabbit')) return FluentIcons.animal_rabbit_24_filled;
    return FluentIcons.animal_paw_print_24_filled;
  }

  /// Localized sex label from the pet's free-text gender, or null when unknown
  /// (so it can be omitted).
  static String? sex(AppLocalizations l10n, String? gender) {
    final g = gender?.toLowerCase() ?? '';
    if (g.startsWith('m')) return l10n.adoptionSexMale;
    if (g.startsWith('f')) return l10n.adoptionSexFemale;
    return null;
  }

  /// Coarse age label computed from [dateOfBirth] relative to [now]. Returns
  /// null when the birth date is unknown.
  static String? age(
    AppLocalizations l10n,
    DateTime? dateOfBirth, {
    required DateTime now,
  }) {
    if (dateOfBirth == null) return null;
    var months = (now.year - dateOfBirth.year) * 12 +
        (now.month - dateOfBirth.month);
    if (now.day < dateOfBirth.day) months -= 1;
    if (months < 0) months = 0;
    if (months < 12) return l10n.adoptionAgeMonths(months);
    return l10n.adoptionAgeYears(months ~/ 12);
  }

  /// Localized "posted N ago" using days when ≥1 day old, else hours.
  static String postedAgo(
    AppLocalizations l10n,
    DateTime postedAt, {
    required DateTime now,
  }) {
    final diff = now.difference(postedAt);
    final days = diff.inDays;
    if (days >= 1) return l10n.adoptionPostedDaysAgo(days);
    final hours = diff.inHours < 0 ? 0 : diff.inHours;
    return l10n.adoptionPostedHoursAgo(hours);
  }
}
