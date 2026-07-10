import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../models/pawhub_models.dart';

/// Small shared PawHub building blocks: the paw-print like glyph, the pet
/// identity chip, a verified badge, a hashtag/mention text renderer, and a
/// reusable "posting as" pet-switcher sheet.

/// A paw-print icon used for the like affordance (replaces the heart).
class PawGlyph extends StatelessWidget {
  const PawGlyph({
    required this.filled,
    this.size = 26,
    this.color,
    super.key,
  });

  final bool filled;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      filled
          ? FluentIcons.animal_paw_print_24_filled
          : FluentIcons.animal_paw_print_24_regular,
      size: size,
      color: color ?? (filled ? AppColors.primary : AppColors.textSecondary),
    );
  }
}

/// A small round verified badge (teal), shown next to verified pets.
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({this.size = 15, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        FluentIcons.checkmark_16_filled,
        size: size * 0.68,
        color: AppColors.onSecondary,
      ),
    );
  }
}

/// Pet avatar + name (+ verified) row, tappable to open the pet's profile.
class PetIdentity extends StatelessWidget {
  const PetIdentity({
    required this.pet,
    this.subtitle,
    this.avatarRadius = 20,
    this.onTap,
    super.key,
  });

  final PawPet pet;
  final String? subtitle;
  final double avatarRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(avatarRadius + 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppAvatar(
            name: pet.name,
            imageUrl: pet.avatarUrl,
            radius: avatarRadius,
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      pet.name,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (pet.isVerified) ...[
                    const SizedBox(width: AppSpacing.xs),
                    const VerifiedBadge(),
                  ],
                ],
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Renders caption/comment text with #hashtags and @mentions tinted in the
/// brand secondary color. Prototype: taps are surfaced via [onToken].
class RichCaption extends StatelessWidget {
  const RichCaption({
    required this.text,
    this.style,
    this.maxLines,
    this.onToken,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final int? maxLines;
  final void Function(String token)? onToken;

  @override
  Widget build(BuildContext context) {
    final base = style ?? AppTextStyles.bodyMedium;
    final accent = base.copyWith(
      color: AppColors.secondaryDark,
      fontWeight: FontWeight.w600,
    );
    final spans = <InlineSpan>[];
    for (final word in text.split(RegExp(r'(\s+)'))) {
      if (word.isEmpty) continue;
      final isToken = word.startsWith('#') || word.startsWith('@');
      spans.add(TextSpan(text: word, style: isToken ? accent : base));
      spans.add(const TextSpan(text: ' '));
    }
    return Text.rich(
      TextSpan(children: spans),
      style: base,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
    );
  }
}

/// A count badge (e.g. unread notifications) — a small red pill.
class CountBadge extends StatelessWidget {
  const CountBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();
    return Container(
      constraints: const BoxConstraints(minWidth: 18),
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.surface, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Opens the "Posting as / Acting as" sheet and returns the chosen pet.
/// This is the signature PawHub interaction — always let the user confirm
/// which pet persona an action is performed under.
Future<PawPet?> showPetSwitcherSheet(
  BuildContext context, {
  required List<PawPet> pets,
  required PawPet current,
  String title = 'Acting as',
}) {
  return showModalBottomSheet<PawPet>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(title, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.md),
            for (final pet in pets)
              _PetSwitcherRow(
                pet: pet,
                selected: pet.id == current.id,
                onTap: () => Navigator.of(context).pop(pet),
              ),
          ],
        ),
      ),
    ),
  );
}

class _PetSwitcherRow extends StatelessWidget {
  const _PetSwitcherRow({
    required this.pet,
    required this.selected,
    required this.onTap,
  });

  final PawPet pet;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pet.name, style: AppTextStyles.titleSmall),
                  Text(
                    pet.breedOrSpecies,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(FluentIcons.checkmark_circle_24_filled,
                  color: AppColors.primary)
            else
              const Icon(FluentIcons.circle_24_regular,
                  color: AppColors.divider),
          ],
        ),
      ),
    );
  }
}

/// The compact pet-switcher pill shown in the feed top bar / composer.
class PetSwitcherPill extends StatelessWidget {
  const PetSwitcherPill({
    required this.pet,
    required this.onTap,
    this.prefix,
    super.key,
  });

  final PawPet pet;
  final VoidCallback onTap;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primarySoft,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, AppSpacing.sm, 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 15),
              const SizedBox(width: AppSpacing.xs),
              if (prefix != null)
                Text(
                  '$prefix ',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
              Text(
                pet.name,
                style: AppTextStyles.labelLarge
                    .copyWith(color: AppColors.primaryDark),
              ),
              const SizedBox(width: 2),
              const Icon(FluentIcons.chevron_down_16_filled,
                  size: 14, color: AppColors.primaryDark),
            ],
          ),
        ),
      ),
    );
  }
}
