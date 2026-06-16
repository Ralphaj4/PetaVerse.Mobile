import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

/// Upcoming appointment card: date block, details, and a trailing
/// calendar icon — from the "Upcoming" section of the dashboard.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    required this.monthLabel,
    required this.dayLabel,
    required this.title,
    required this.subtitle,
    required this.location,
    this.onTap,
    super.key,
  });

  final String monthLabel;
  final String dayLabel;
  final String title;
  final String subtitle;
  final String location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          _DateBlock(monthLabel: monthLabel, dayLabel: dayLabel),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(
            FluentIcons.calendar_ltr_24_regular,
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({required this.monthLabel, required this.dayLabel});

  final String monthLabel;
  final String dayLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.smAll,
      ),
      child: Column(
        children: [
          Text(monthLabel, style: AppTextStyles.labelMedium),
          Text(dayLabel, style: AppTextStyles.headlineMedium),
        ],
      ),
    );
  }
}
