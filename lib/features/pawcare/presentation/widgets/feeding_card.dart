import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/feeding_schedule.dart';
import 'feeding_grooming_l10n.dart';
import 'health_section_card.dart';
import 'health_section_empty.dart';

/// Feeding section on the pet profile: a summary of the recurring meal schedule,
/// or an empty state prompting the owner to set one up. Tapping the header (or
/// the "+") opens the feeding edit page.
class FeedingCard extends StatelessWidget {
  const FeedingCard({
    required this.schedule,
    required this.onEdit,
    super.key,
  });

  final FeedingSchedule? schedule;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final s = schedule;

    return HealthSectionCard(
      icon: FluentIcons.bowl_salad_24_regular,
      title: l10n.feedingTitle,
      accent: AppColors.accentCoral,
      accentSoft: AppColors.accentCoralSoft,
      onAdd: onEdit,
      addTooltip: s == null ? l10n.feedingSetUp : l10n.feedingEdit,
      onOpen: s == null ? null : onEdit,
      child: s == null || s.times.isEmpty
          ? HealthSectionEmpty(
              message: l10n.feedingEmpty,
              actionLabel: l10n.feedingSetUp,
              onAction: onEdit,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedingDaysLabel(l10n, s.daysOfWeek),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.sm),
                for (var i = 0; i < s.times.length; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, color: AppColors.divider),
                  _MealRow(time: s.times[i]),
                ],
              ],
            ),
    );
  }
}

class _MealRow extends StatelessWidget {
  const _MealRow({required this.time});

  final FeedingTime time;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tod = TimeOfDay(hour: time.hour, minute: time.minute);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          const Icon(FluentIcons.clock_24_regular,
              size: 18, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(tod.format(context), style: AppTextStyles.titleSmall),
          ),
          if (time.quantity != null)
            Text(
              feedAmountLabel(l10n, time.quantity!, time.unit),
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }
}
