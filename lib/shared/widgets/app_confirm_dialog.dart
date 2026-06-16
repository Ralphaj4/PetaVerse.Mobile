import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// A modern confirmation dialog: a tinted icon badge, title, message, and
/// two stacked buttons (confirm + cancel).
///
/// Use [show] and await the bool? result — true if confirmed, null/false
/// if dismissed or cancelled.
class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    this.isDestructive = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  /// Tints the icon and confirm button with the error color (e.g. logout).
  final bool isDestructive;

  /// Shows the dialog and resolves to true only when the user confirms.
  static Future<bool> show(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.textPrimary.withValues(alpha: 0.45),
      builder: (_) => AppConfirmDialog(
        icon: icon,
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final accent = isDestructive ? AppColors.error : AppColors.primary;

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
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: accent),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            // Confirm
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.smAll,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text(
                  confirmLabel,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Cancel
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: Text(
                  cancelLabel,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textSecondary,
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
