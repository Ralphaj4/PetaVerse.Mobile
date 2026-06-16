import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Frosted-glass chip on the home hero showing the next vet visit date.
class NextVisitChip extends StatelessWidget {
  const NextVisitChip({required this.dateLabel, super.key});

  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.25),
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: AppColors.surface.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.3),
              borderRadius: AppRadius.smAll,
            ),
            child: const Icon(
              FluentIcons.calendar_ltr_24_regular,
              size: 18,
              color: AppColors.onPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.nextVisit,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onPrimary.withValues(alpha: 0.85),
                ),
              ),
              Text(
                dateLabel,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
