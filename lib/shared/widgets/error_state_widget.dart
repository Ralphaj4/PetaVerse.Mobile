import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/errors/failure.dart';
import '../../core/errors/failure_l10n.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'app_button.dart';

/// Reusable error state with a localized message per failure type and a
/// retry action. The illustration and accent colour adapt to the failure
/// so the screen feels considered rather than generic.
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
    final effective = failure ?? const UnknownFailure();
    final message = effective.localizedMessage(l10n);
    final style = _ErrorStyle.of(effective);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Soft layered illustration: a tinted rounded square with the
            // failure glyph, echoing the app's card + brand-tint language.
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: style.color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.lg + 4),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: style.color.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(style.icon, size: 30, color: style.color),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.errorTitle,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                message,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                label: l10n.retry,
                icon: FluentIcons.arrow_clockwise_24_regular,
                onPressed: onRetry,
                variant: AppButtonVariant.secondary,
                expanded: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Maps a failure type to its illustration glyph and accent colour.
class _ErrorStyle {
  const _ErrorStyle(this.icon, this.color);

  final IconData icon;
  final Color color;

  factory _ErrorStyle.of(Failure failure) => switch (failure) {
        NetworkFailure() =>
          const _ErrorStyle(FluentIcons.wifi_off_24_regular, AppColors.info),
        UnauthorizedFailure() => const _ErrorStyle(
            FluentIcons.lock_closed_24_regular,
            AppColors.warning,
          ),
        ForbiddenFailure() => const _ErrorStyle(
            FluentIcons.shield_error_24_regular,
            AppColors.warning,
          ),
        NotFoundFailure() => const _ErrorStyle(
            FluentIcons.document_error_24_regular,
            AppColors.secondary,
          ),
        ValidationFailure() => const _ErrorStyle(
            FluentIcons.warning_24_regular,
            AppColors.warning,
          ),
        ServerFailure() => const _ErrorStyle(
            FluentIcons.cloud_dismiss_24_regular,
            AppColors.error,
          ),
        RateLimitFailure() => const _ErrorStyle(
            FluentIcons.timer_24_regular,
            AppColors.warning,
          ),
        CacheFailure() => const _ErrorStyle(
            FluentIcons.cloud_off_24_regular,
            AppColors.textSecondary,
          ),
        UnknownFailure() => const _ErrorStyle(
            FluentIcons.emoji_sad_24_regular,
            AppColors.primary,
          ),
      };
}
