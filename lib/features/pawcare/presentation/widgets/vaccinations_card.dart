import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/vaccination.dart';
import 'health_section_card.dart';
import 'health_section_empty.dart';

/// Vaccinations section: a list of records with administered date and booster
/// status. Empty state when there are none.
class VaccinationsCard extends StatelessWidget {
  const VaccinationsCard({
    required this.vaccinations,
    required this.onAdd,
    this.onOpen,
    super.key,
  });

  final List<Vaccination> vaccinations;
  final VoidCallback onAdd;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();

    return HealthSectionCard(
      icon: FluentIcons.shield_checkmark_24_regular,
      title: l10n.healthVaccinationsTitle,
      onAdd: onAdd,
      addTooltip: l10n.healthVaccinationsAdd,
      onOpen: vaccinations.isEmpty ? null : onOpen,
      child: vaccinations.isEmpty
          ? HealthSectionEmpty(
              message: l10n.healthVaccinationsEmpty,
              actionLabel: l10n.healthVaccinationsAdd,
              onAction: onAdd,
            )
          : Column(
              children: [
                for (var i = 0; i < vaccinations.length && i < 3; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, color: AppColors.divider),
                  _VaccinationRow(vax: vaccinations[i], now: now),
                ],
                if (vaccinations.length > 3) ...[
                  const Divider(height: 1, color: AppColors.divider),
                  _ViewAllRow(onTap: onOpen),
                ],
              ],
            ),
    );
  }
}

class _VaccinationRow extends StatelessWidget {
  const _VaccinationRow({required this.vax, required this.now});

  final Vaccination vax;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final dateFmt = DateFormat.yMMMd(locale);
    final due = vax.isDue(now);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: due
                  ? AppColors.warning.withValues(alpha: 0.12)
                  : AppColors.secondarySoft,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              due
                  ? FluentIcons.clock_24_regular
                  : FluentIcons.syringe_24_filled,
              size: 20,
              color: due ? AppColors.warning : AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vax.name, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  l10n.healthVaccinationsGivenOn(
                    dateFmt.format(vax.administeredAt),
                  ),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          if (vax.nextDueDate != null)
            _BoosterBadge(due: due, date: dateFmt.format(vax.nextDueDate!)),
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

/// Booster status pill: "Due" when overdue, otherwise the next-due date.
class _BoosterBadge extends StatelessWidget {
  const _BoosterBadge({required this.due, required this.date});

  final bool due;
  final String date;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = due ? AppColors.warning : AppColors.textSecondary;
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
        due ? l10n.healthVaccinationsDue : l10n.healthVaccinationsNextDue(date),
        style: AppTextStyles.labelMedium.copyWith(color: color, letterSpacing: 0),
      ),
    );
  }
}
