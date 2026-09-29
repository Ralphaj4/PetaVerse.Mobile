import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Modal star picker. Returns the chosen 1–5 rating, or null if dismissed.
class ProviderRateSheet extends StatefulWidget {
  const ProviderRateSheet({this.current, super.key});

  /// The user's existing rating, pre-selected when reopening.
  final int? current;

  static Future<int?> show(BuildContext context, {int? current}) {
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => ProviderRateSheet(current: current),
    );
  }

  @override
  State<ProviderRateSheet> createState() => _ProviderRateSheetState();
}

class _ProviderRateSheetState extends State<ProviderRateSheet> {
  late int _stars = widget.current ?? 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.providerRateTitle, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    onPressed: () => setState(() => _stars = i),
                    icon: Icon(
                      i <= _stars
                          ? FluentIcons.star_24_filled
                          : FluentIcons.star_24_regular,
                      size: 36,
                      color: i <= _stars
                          ? AppColors.primary
                          : AppColors.textTertiary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _stars > 0
                    ? () => Navigator.of(context).pop(_stars)
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text(l10n.providerSubmitRating),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
