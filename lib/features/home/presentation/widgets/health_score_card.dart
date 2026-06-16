import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Floating white card showing the pet's overall health score, with a
/// small heart badge overlapping the corner — from the home hero design.
class HealthScoreCard extends StatelessWidget {
  const HealthScoreCard({
    required this.score,
    required this.statusLabel,
    super.key,
  });

  final int score;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${context.l10n.healthScore}: $score, $statusLabel',
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.lgAll,
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  context.l10n.healthScore,
                  style: AppTextStyles.labelMedium,
                ),
                Text(
                  '$score',
                  style: AppTextStyles.displayLarge.copyWith(fontSize: 40),
                ),
                Text(
                  statusLabel,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: -10,
            end: -6,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: const Icon(
                FluentIcons.heart_24_filled,
                size: 16,
                color: AppColors.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
