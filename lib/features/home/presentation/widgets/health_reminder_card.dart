import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';

/// "Upcoming" card for a cached health reminder — a medication dose or a
/// vaccination booster. Shares the [AppointmentCard] shape (date block +
/// details + trailing icon) so the section reads consistently.
class HealthReminderCard extends StatelessWidget {
  const HealthReminderCard({
    required this.reminder,
    this.index = 0,
    this.onTap,
    super.key,
  });

  final HealthReminder reminder;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final due = reminder.dueDate;
    final isVaccine = reminder.kind == HealthReminderKind.vaccination;
    final isAppointment = reminder.kind == HealthReminderKind.appointment;
    // Alternate orange/blue by position so no two adjacent cards share a color.
    final accent = index.isEven ? AppColors.primary : AppColors.secondary;

    final subtitle = isVaccine
        ? l10n.reminderVaccinationBooster(reminder.petName)
        : isAppointment
            ? l10n.reminderAppointment(reminder.petName)
            : l10n.reminderMedicationDose(reminder.petName);

    final String status;
    final Color statusColor;
    if (reminder.isOverdue) {
      status = l10n.reminderOverdue;
      statusColor = AppColors.error;
    } else if (reminder.daysUntilDue == 0) {
      status = l10n.reminderDueToday;
      statusColor = AppColors.warning;
    } else {
      status = l10n.reminderDueInDays(reminder.daysUntilDue);
      statusColor = AppColors.textSecondary;
    }

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          _DateBlock(
            monthLabel: DateFormat.MMM(locale).format(due).toUpperCase(),
            dayLabel: DateFormat.d(locale).format(due),
            accent: accent,
            overdue: reminder.isOverdue,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
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
                const SizedBox(height: 2),
                Text(
                  status,
                  style: AppTextStyles.labelMedium.copyWith(color: statusColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(
            isVaccine
                ? FluentIcons.syringe_24_regular
                : isAppointment
                    ? FluentIcons.calendar_ltr_24_regular
                    : FluentIcons.pill_24_regular,
            color: accent,
          ),
        ],
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({
    required this.monthLabel,
    required this.dayLabel,
    required this.accent,
    required this.overdue,
  });

  final String monthLabel;
  final String dayLabel;
  final Color accent;
  final bool overdue;

  @override
  Widget build(BuildContext context) {
    final bg = overdue
        ? AppColors.error.withValues(alpha: 0.10)
        : accent.withValues(alpha: 0.10);
    final fg = overdue ? AppColors.error : accent;

    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.smAll,
      ),
      child: Column(
        children: [
          Text(
            monthLabel,
            style: AppTextStyles.labelMedium.copyWith(color: fg),
          ),
          Text(
            dayLabel,
            style: AppTextStyles.headlineMedium.copyWith(color: fg),
          ),
        ],
      ),
    );
  }
}
