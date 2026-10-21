import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../domain/entities/community_entities.dart';

/// A compact adoption promo card interleaved into the Discover feed. Visually
/// distinct from a post (accent border + "Adoption" ribbon) so the feed reads
/// as sponsored content, not a regular post. Tapping opens the full listing.
class AdoptionInjectionCardWidget extends StatelessWidget {
  const AdoptionInjectionCardWidget({
    required this.card,
    required this.onTap,
    super.key,
  });

  final AdoptionInjectionCard card;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasTraits = card.vaccinated || card.neutered || card.goodWithKids;

    return Semantics(
      button: true,
      label: card.petName,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _photo(context),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.petName,
                        style: AppTextStyles.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (card.speciesName != null &&
                          card.speciesName!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          card.speciesName!,
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                      if (card.locationLabel != null &&
                          card.locationLabel!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            const Icon(
                              FluentIcons.location_24_regular,
                              size: 14,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                card.locationLabel!,
                                style: AppTextStyles.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (hasTraits) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.xs,
                          children: [
                            if (card.vaccinated)
                              _TraitChip(
                                icon: FluentIcons.shield_checkmark_24_filled,
                                label: l10n.adoptionTraitVaccinated,
                              ),
                            if (card.neutered)
                              _TraitChip(
                                icon: FluentIcons.heart_24_filled,
                                label: l10n.adoptionTraitNeutered,
                              ),
                            if (card.goodWithKids)
                              _TraitChip(
                                icon: FluentIcons.people_24_filled,
                                label: l10n.adoptionTraitGoodWithKids,
                              ),
                          ],
                        ),
                      ],
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.home_heart_24_regular,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            l10n.pawhubAdoptionInjectionCta,
                            style: AppTextStyles.labelLarge
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _photo(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: (card.photoUrl != null && card.photoUrl!.isNotEmpty)
              ? AppCachedImage(
                  imageUrl: card.photoUrl,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: AppColors.primarySoft,
                  child: const Center(
                    child: Icon(
                      FluentIcons.animal_paw_print_24_filled,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                ),
        ),
        Positioned(
          top: AppSpacing.sm,
          left: AppSpacing.sm,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.home_heart_24_filled,
                  size: 13,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  context.l10n.pawhubAdoptionInjectionBadge,
                  style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TraitChip extends StatelessWidget {
  const _TraitChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.secondaryDark),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.secondaryDark),
          ),
        ],
      ),
    );
  }
}
