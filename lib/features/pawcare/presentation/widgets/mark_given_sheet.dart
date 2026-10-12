import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Shows a bottom sheet letting the user record a medication dose as given
/// either right now ("Today") or on a past date they pick from the calendar.
///
/// Returns the chosen [DateTime] (normalised to midnight local time), or null
/// if the sheet is dismissed without a selection.
Future<DateTime?> showMarkGivenSheet(BuildContext context) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => const _MarkGivenSheet(),
  );
}

class _MarkGivenSheet extends StatelessWidget {
  const _MarkGivenSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Grab handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  l10n.healthMedicationsMarkGivenTitle,
                  style: AppTextStyles.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Today option — closes the sheet immediately with today's date.
            ListTile(
              leading: const Icon(FluentIcons.calendar_today_24_regular,
                  color: AppColors.primary),
              title: Text(l10n.healthMedicationsMarkGivenToday,
                  style: AppTextStyles.bodyMedium),
              onTap: () => Navigator.of(context).pop(today),
            ),
            // Past date option — opens the system date picker; on confirm
            // pops the sheet with the chosen date.
            ListTile(
              leading: const Icon(FluentIcons.calendar_24_regular,
                  color: AppColors.textSecondary),
              title: Text(l10n.healthMedicationsMarkGivenPastDate,
                  style: AppTextStyles.bodyMedium),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: DateTime(today.year - 1, today.month, today.day),
                  lastDate: today,
                );
                if (picked == null) return;
                if (context.mounted) Navigator.of(context).pop(picked);
              },
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
