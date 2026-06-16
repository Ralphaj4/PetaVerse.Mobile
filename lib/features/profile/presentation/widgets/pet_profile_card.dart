import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';

/// Pet card in the profile grid: rounded photo with an optional "ACTIVE"
/// badge, then the pet's name and "breed • age" subtitle.
class PetProfileCard extends StatelessWidget {
  const PetProfileCard({
    required this.name,
    required this.breed,
    required this.ageYears,
    this.imageUrl,
    this.isActive = false,
    this.onTap,
    super.key,
  });

  final String name;
  final String breed;
  final int ageYears;
  final String? imageUrl;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      button: onTap != null,
      label: '$name, $breed, ${l10n.petAgeYears(ageYears)}',
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.lgAll,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppCachedImage(
                      imageUrl: imageUrl,
                      height: 110,
                      width: double.infinity,
                      borderRadius: AppRadius.mdAll,
                      semanticLabel: name,
                    ),
                    if (isActive)
                      PositionedDirectional(
                        top: AppSpacing.sm,
                        end: AppSpacing.sm,
                        child: _ActiveBadge(label: l10n.petActive),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpacing.xs,
                    bottom: AppSpacing.xs,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$breed • ${l10n.petAgeYears(ageYears)}',
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: AppColors.onPrimary),
      ),
    );
  }
}
