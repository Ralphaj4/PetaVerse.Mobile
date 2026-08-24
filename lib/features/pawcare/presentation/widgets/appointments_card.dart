import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/appointment.dart';
import 'health_section_card.dart';
import 'health_section_empty.dart';

/// Appointments section card on the pet health dashboard.
/// Shows up to 3 upcoming appointments, then a "View all" footer.
class AppointmentsCard extends StatelessWidget {
  const AppointmentsCard({
    required this.appointments,
    required this.onAdd,
    this.onOpen,
    super.key,
  });

  final List<Appointment> appointments;
  final VoidCallback onAdd;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return HealthSectionCard(
      icon: FluentIcons.calendar_ltr_24_regular,
      title: l10n.appointmentsTitle,
      onAdd: onAdd,
      addTooltip: l10n.appointmentsAdd,
      onOpen: appointments.isEmpty ? null : onOpen,
      child: appointments.isEmpty
          ? HealthSectionEmpty(
              message: l10n.appointmentsEmpty,
              actionLabel: l10n.appointmentsAdd,
              onAction: onAdd,
            )
          : Column(
              children: [
                for (var i = 0; i < appointments.length && i < 3; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, color: AppColors.divider),
                  _AppointmentRow(appt: appointments[i]),
                ],
                if (appointments.length > 3) ...[
                  const Divider(height: 1, color: AppColors.divider),
                  _ViewAllRow(onTap: onOpen),
                ],
              ],
            ),
    );
  }
}

class _AppointmentRow extends StatelessWidget {
  const _AppointmentRow({required this.appt});

  final Appointment appt;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final past = appt.isPast;
    final days = appt.daysUntil;

    final String status;
    final Color statusColor;
    if (past) {
      status = l10n.reminderOverdue;
      statusColor = AppColors.error;
    } else if (days == 0) {
      status = l10n.reminderDueToday;
      statusColor = AppColors.warning;
    } else {
      status = l10n.appointmentInDays(days);
      statusColor = AppColors.textSecondary;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: past
                  ? AppColors.error.withValues(alpha: 0.10)
                  : AppColors.secondarySoft,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              FluentIcons.calendar_ltr_24_regular,
              size: 20,
              color: past ? AppColors.error : AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appt.title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  DateFormat.yMMMd(locale).format(appt.scheduledAt),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              status,
              style: AppTextStyles.labelMedium
                  .copyWith(color: statusColor, letterSpacing: 0),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewAllRow extends StatelessWidget {
  const _ViewAllRow({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.viewAll,
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              FluentIcons.chevron_right_24_regular,
              size: 16,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
