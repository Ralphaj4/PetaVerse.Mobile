import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/medication.dart';
import 'health_section_card.dart';
import 'health_section_empty.dart';
import 'medication_frequency.dart';

/// Medications section: a list of active meds with a due badge and a "give"
/// affordance per row. Empty state when there are none.
class MedicationsCard extends StatelessWidget {
  const MedicationsCard({
    required this.medications,
    required this.onAdd,
    required this.onMarkGiven,
    this.onOpen,
    super.key,
  });

  final List<Medication> medications;
  final VoidCallback onAdd;
  final VoidCallback? onOpen;
  final void Function(Medication) onMarkGiven;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    // Soonest-due first so overdue / imminent meds surface at the top.
    final sorted = [...medications]
      ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));

    return HealthSectionCard(
      icon: FluentIcons.pill_24_regular,
      title: l10n.healthMedicationsTitle,
      accent: AppColors.accentPurple,
      accentSoft: AppColors.accentPurpleSoft,
      onAdd: onAdd,
      addTooltip: l10n.healthMedicationsAdd,
      onOpen: medications.isEmpty ? null : onOpen,
      child: medications.isEmpty
          ? HealthSectionEmpty(
              message: l10n.healthMedicationsEmpty,
              actionLabel: l10n.healthMedicationsAdd,
              onAction: onAdd,
            )
          : Column(
              children: [
                for (var i = 0; i < sorted.length && i < 3; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, color: AppColors.divider),
                  _MedicationRow(
                    med: sorted[i],
                    now: now,
                    onMarkGiven: () => onMarkGiven(sorted[i]),
                  ),
                ],
                if (sorted.length > 3) ...[
                  const Divider(height: 1, color: AppColors.divider),
                  _ViewAllRow(onTap: onOpen),
                ],
              ],
            ),
    );
  }
}

class _MedicationRow extends StatelessWidget {
  const _MedicationRow({
    required this.med,
    required this.now,
    required this.onMarkGiven,
  });

  final Medication med;
  final DateTime now;
  final VoidCallback onMarkGiven;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med.name,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  frequencyDaysLabel(l10n, med.frequencyDays),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _DueBadge(days: med.daysUntilDue(now)),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            onPressed: onMarkGiven,
            tooltip: l10n.healthMedicationsMarkGiven,
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
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
              ),
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

/// "Overdue" / "Today" / "In Nd" pill, colored by urgency.
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
        style: AppTextStyles.labelMedium.copyWith(color: color, letterSpacing: 0),
      ),
    );
  }
}

