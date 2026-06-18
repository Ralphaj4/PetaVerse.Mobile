import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/failure_l10n.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'app_button.dart';

/// Reusable error state with a localized message per failure type and a
/// retry action.
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    this.failure,
    this.onRetry,
    super.key,
  });

  final Failure? failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // Delegate to the shared mapper so failure→message stays in one place.
    final message = (failure ?? const UnknownFailure()).localizedMessage(l10n);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.error_circle_24_regular,
                size: 48,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.errorTitle,
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: l10n.retry,
                onPressed: onRetry,
                variant: AppButtonVariant.outlined,
                expanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
