import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Polished, reusable in-sheet state block for the discovery screen's
/// non-happy paths: no results, location denied, and offline. Loading uses the
/// shimmer skeleton instead (see ProviderListSkeleton).
///
/// One widget with named constructors keeps the four states visually
/// consistent (same icon medallion, title, message, optional action) while the
/// page decides which to show.
class ProviderEmptyState extends StatelessWidget {
  const ProviderEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.tint = AppColors.primary,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: tint.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: tint),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: onAction,
                style: FilledButton.styleFrom(
                  backgroundColor: tint,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                ),
                child: Text(
                  actionLabel!,
                  style: AppTextStyles.titleSmall
                      .copyWith(color: AppColors.onPrimary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// No providers matched the current filter/search.
  factory ProviderEmptyState.noResults({
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) =>
      ProviderEmptyState(
        icon: FluentIcons.search_24_regular,
        title: title,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  /// Location permission denied — offer to open settings / retry.
  factory ProviderEmptyState.locationDenied({
    required String title,
    required String message,
    required String actionLabel,
    required VoidCallback onAction,
  }) =>
      ProviderEmptyState(
        icon: FluentIcons.location_off_24_regular,
        title: title,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
        tint: AppColors.secondary,
      );

  /// Offline / network error — offer retry.
  factory ProviderEmptyState.offline({
    required String title,
    required String message,
    required String actionLabel,
    required VoidCallback onAction,
  }) =>
      ProviderEmptyState(
        icon: FluentIcons.cloud_off_24_regular,
        title: title,
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
        tint: AppColors.error,
      );
}
