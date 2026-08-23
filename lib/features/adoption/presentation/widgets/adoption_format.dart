import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/generated/app_localizations.dart';

/// A species glyph that is either a FluentUI [IconData] or a bundled SVG asset
/// (for species FluentUI has no icon for, e.g. birds). Render it with a
/// [SpeciesGlyphIcon] so callers don't branch on the source.
class SpeciesGlyph {
  const SpeciesGlyph.icon(this.iconData) : assetPath = null;
  const SpeciesGlyph.asset(this.assetPath) : iconData = null;

  final IconData? iconData;
  final String? assetPath;
}

/// Presentation helpers for adoption: labels and glyphs derived from the pet's
/// data (species is a free-text name from the /species lookup, not an enum).
abstract final class AdoptionFormat {
  /// A glyph keyed loosely off the species name, used as the photo-fallback
  /// and species filter chip icon. Maps each species to the closest available
  /// FluentUI animal glyph, or a bundled SVG for species FluentUI has no icon
  /// for (birds). Falls back to a generic paw for unrecognized names.
  static SpeciesGlyph speciesIcon(String? speciesName) {
    final s = speciesName?.toLowerCase() ?? '';
    if (s.contains('dog') || s.contains('puppy') || s.contains('canine')) {
      return const SpeciesGlyph.icon(FluentIcons.animal_dog_24_filled);
    }
    if (s.contains('cat') || s.contains('kitten') || s.contains('feline')) {
      return const SpeciesGlyph.icon(FluentIcons.animal_cat_24_filled);
    }
    if (s.contains('rabbit') || s.contains('bunny') || s.contains('hare')) {
      return const SpeciesGlyph.icon(FluentIcons.animal_rabbit_24_filled);
    }
    if (s.contains('turtle') ||
        s.contains('tortoise') ||
        s.contains('reptile') ||
        s.contains('lizard')) {
      return const SpeciesGlyph.icon(FluentIcons.animal_turtle_24_filled);
    }
    if (s.contains('fish') || s.contains('aquatic')) {
      return const SpeciesGlyph.icon(FluentIcons.food_fish_24_filled);
    }
    // FluentUI has no glyph for the species below, so they use bundled SVGs.
    if (s.contains('bird') ||
        s.contains('parrot') ||
        s.contains('budgie') ||
        s.contains('canary') ||
        s.contains('finch') ||
        s.contains('cockatiel') ||
        s.contains('avian')) {
      return const SpeciesGlyph.asset('assets/icons/species_bird.svg');
    }
    if (s.contains('horse') || s.contains('pony') || s.contains('equine')) {
      return const SpeciesGlyph.asset('assets/icons/species_horse.svg');
    }
    if (s.contains('snake') || s.contains('serpent')) {
      return const SpeciesGlyph.asset('assets/icons/species_snake.svg');
    }
    if (s.contains('ferret')) {
      return const SpeciesGlyph.asset('assets/icons/species_ferret.svg');
    }
    // "guinea pig" before "hamster" so the more specific name wins first.
    if (s.contains('guinea') || s.contains('cavy')) {
      return const SpeciesGlyph.asset('assets/icons/species_guinea_pig.svg');
    }
    if (s.contains('hamster') ||
        s.contains('gerbil') ||
        s.contains('mouse') ||
        s.contains('rodent')) {
      return const SpeciesGlyph.asset('assets/icons/species_hamster.svg');
    }
    return const SpeciesGlyph.icon(FluentIcons.animal_paw_print_24_filled);
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

/// Renders a [SpeciesGlyph] as either a FluentUI icon or a tinted SVG, so
/// callers can treat both glyph sources uniformly.
class SpeciesGlyphIcon extends StatelessWidget {
  const SpeciesGlyphIcon({
    required this.glyph,
    required this.size,
    required this.color,
    super.key,
  });

  final SpeciesGlyph glyph;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final asset = glyph.assetPath;
    if (asset != null) {
      return SvgPicture.asset(
        asset,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    return Icon(glyph.iconData, size: size, color: color);
  }
}
