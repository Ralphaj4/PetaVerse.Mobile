import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows the AI chatbot disclaimer modal on the first ever open.
///
/// Returns `true` when the user checks the box and taps "I Understand",
/// `false` / null if they dismiss without consenting.
Future<bool> showAiDisclaimerDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.textPrimary.withValues(alpha: 0.55),
    builder: (_) => const _AiDisclaimerDialog(),
  );
  return result ?? false;
}

class _AiDisclaimerDialog extends StatefulWidget {
  const _AiDisclaimerDialog();

  @override
  State<_AiDisclaimerDialog> createState() => _AiDisclaimerDialogState();
}

class _AiDisclaimerDialogState extends State<_AiDisclaimerDialog> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon badge
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.bot_24_filled,
                size: 30,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.aiDisclaimerTitle,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.aiDisclaimerBody,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            // Consent checkbox row
            InkWell(
              onTap: () => setState(() => _accepted = !_accepted),
              borderRadius: AppRadius.smAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _accepted,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (v) =>
                            setState(() => _accepted = v ?? false),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        l10n.aiDisclaimerConsent,
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Confirm button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _accepted
                    ? () => Navigator.of(context).pop(true)
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor:
                      AppColors.primary.withValues(alpha: 0.35),
                  foregroundColor: AppColors.onPrimary,
                  disabledForegroundColor:
                      AppColors.onPrimary.withValues(alpha: 0.55),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.smAll,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text(
                  l10n.aiDisclaimerAction,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
