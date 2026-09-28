import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/grooming_schedule.dart';
import 'health_section_card.dart';
import 'health_section_empty.dart';

/// Grooming section on the pet profile: shows the interval + next-due date with a
/// due badge and a "mark groomed" affordance, or an empty state. Reminders are
/// server-pushed; this card only reflects the schedule.
class GroomingCard extends StatelessWidget {
  const GroomingCard({
    required this.schedule,
    required this.onEdit,
    required this.onMarkGroomed,
    super.key,
  });

  final GroomingSchedule? schedule;
  final VoidCallback onEdit;
  final VoidCallback onMarkGroomed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final s = schedule;

    return HealthSectionCard(
      icon: FluentIcons.cut_24_regular,
      title: l10n.groomingTitle,
      accent: AppColors.secondary,
      accentSoft: AppColors.secondarySoft,
      onAdd: onEdit,
      addTooltip: s == null ? l10n.groomingSetUp : l10n.groomingEdit,
      onOpen: s == null ? null : onEdit,
      child: s == null
          ? HealthSectionEmpty(
              message: l10n.groomingEmpty,
              actionLabel: l10n.groomingSetUp,
              onAction: onEdit,
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.groomingEveryDays(s.intervalDays),
                        style: AppTextStyles.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.groomingNextDue(
                          DateFormat.yMMMMd(locale).format(s.nextDueDate),
                        ),
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _DueBadge(days: s.daysUntilDue(now)),
                const SizedBox(width: AppSpacing.xs),
                IconButton(
                  onPressed: onMarkGroomed,
                  tooltip: l10n.groomingMarkGroomed,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    FluentIcons.checkmark_circle_24_regular,
                    size: 24,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
    );
  }
}

/// "Overdue" / "Today" / "In Nd" pill, colored by urgency. Mirrors the
/// medications due badge.
class _DueBadge extends StatelessWidget {
  const _DueBadge({required this.days});

  final int days;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (Color color, String label) = switch (days) {
      < 0 => (AppColors.error, l10n.healthMedicationsOverdue),
      0 => (AppColors.warning, l10n.healthMedicationsDueToday),
      _ => (AppColors.textSecondary, l10n.healthMedicationsDueInDays(days)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style:
            AppTextStyles.labelMedium.copyWith(color: color, letterSpacing: 0),
      ),
    );
  }
}
