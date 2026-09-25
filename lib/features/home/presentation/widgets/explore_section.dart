import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../domain/entities/home_summary.dart';

/// The Home "Explore" band: two entry tiles (Lost & Found · Adoption) that push
/// the full standalone boards. Community surfaces that used to live inside the
/// PetaHub now start here. Subtitles show live counts from [summary] when the
/// backend supplies them, and fall back to a static label otherwise.
class ExploreSection extends StatelessWidget {
  const ExploreSection({required this.summary, super.key});

  final HomeSummary? summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lost = summary?.lostNearbyCount;
    final adoption = summary?.adoptionAvailableCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.exploreSectionTitle),
        const SizedBox(height: AppSpacing.md),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _ExploreTile(
                  icon: FluentIcons.location_24_filled,
                  color: AppColors.secondary,
                  title: l10n.lostAndFound,
                  subtitle: lost == null
                      ? l10n.exploreLostFoundSubtitle
                      : l10n.exploreLostNearby(lost),
                  onTap: () => context.push(AppRoutes.lostAndFound),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ExploreTile(
                  icon: FluentIcons.home_24_filled,
                  color: AppColors.primary,
                  title: l10n.adoptionTitle,
                  subtitle: adoption == null
                      ? l10n.exploreAdoptionSubtitle
                      : l10n.exploreAdoptionAvailable(adoption),
                  onTap: () => context.push(AppRoutes.adoptionBoard),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExploreTile extends StatelessWidget {
  const _ExploreTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $subtitle',
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.lgAll,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.lgAll,
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Icon(icon, size: 22, color: color),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
