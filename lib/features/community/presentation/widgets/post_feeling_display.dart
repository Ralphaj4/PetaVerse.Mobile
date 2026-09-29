import 'package:flutter/widgets.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../../domain/entities/community_enums.dart';

/// Presentation-layer mapping for [PostFeeling]: the emoji glyph and the
/// localized label. Kept out of the domain layer (pure Dart — no Flutter, no
/// l10n). The emoji is keyed off the enum so it stays stable even if the server
/// relabels a feeling.
extension PostFeelingDisplay on PostFeeling {
  /// The emoji character rendered via [Text] for this feeling.
  String get emoji => switch (this) {
        PostFeeling.happy => '😄',
        PostFeeling.relaxed => '😌',
        PostFeeling.naughty => '😈',
        PostFeeling.excited => '🤩',
        PostFeeling.anxious => '😰',
        PostFeeling.playful => '🎉',
        PostFeeling.tired => '😴',
        PostFeeling.silly => '🤪',
        PostFeeling.loved => '🥰',
        PostFeeling.grumpy => '😾',
      };

  /// The localized display label.
  String label(AppLocalizations l10n) => switch (this) {
        PostFeeling.happy => l10n.pawhubFeelingHappy,
        PostFeeling.relaxed => l10n.pawhubFeelingRelaxed,
        PostFeeling.naughty => l10n.pawhubFeelingNaughty,
        PostFeeling.excited => l10n.pawhubFeelingExcited,
        PostFeeling.anxious => l10n.pawhubFeelingAnxious,
        PostFeeling.playful => l10n.pawhubFeelingPlayful,
        PostFeeling.tired => l10n.pawhubFeelingTired,
        PostFeeling.silly => l10n.pawhubFeelingSilly,
        PostFeeling.loved => l10n.pawhubFeelingLoved,
        PostFeeling.grumpy => l10n.pawhubFeelingGrumpy,
      };
}

/// Feelings in wire order (1–10) — the display order for the picker.
const List<PostFeeling> kPostFeelingsInOrder = [
  PostFeeling.happy,
  PostFeeling.relaxed,
  PostFeeling.naughty,
  PostFeeling.excited,
  PostFeeling.anxious,
  PostFeeling.playful,
  PostFeeling.tired,
  PostFeeling.silly,
  PostFeeling.loved,
  PostFeeling.grumpy,
];
