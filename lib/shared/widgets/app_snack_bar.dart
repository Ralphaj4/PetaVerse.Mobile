import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

enum AppSnackBarVariant { info, success, error, warning }

/// App-wide toast. A dark-navy rounded card with a colored accent icon bubble,
/// a white message, a whisper-faint paw-print watermark, and an optional action
/// — matching the app's premium, rounded, softly-shadowed surface language
/// rather than a loud full-width colored bar.
abstract final class AppSnackBar {
  /// Deep navy surface — a touch bluer and darker than [AppColors.textPrimary],
  /// kept nearly opaque (subtle transparency, not glassy) so it reads premium
  /// without heavy blur.
  static const Color _navy = Color(0xFF171B2E);

  /// Soft red for errors — gentler than the harsh semantic [AppColors.error].
  static const Color _softRed = Color(0xFFF2686A);

  /// Shows a toast. [message] is the primary line; pass [subtitle] for a muted
  /// secondary line, and [actionLabel]/[onAction] for a trailing orange action.
  static void show(
    BuildContext context,
    String message, {
    AppSnackBarVariant variant = AppSnackBarVariant.info,
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        build(
          message,
          variant: variant,
          duration: duration,
          subtitle: subtitle,
          actionLabel: actionLabel,
          onAction: onAction,
        ),
      );
  }

  /// Pre-built SnackBar instances for use with a captured ScaffoldMessengerState
  /// (e.g. when the context may no longer be mounted after an async gap).
  static SnackBar buildSuccess(String message,
          {Duration duration = const Duration(seconds: 3)}) =>
      build(message, variant: AppSnackBarVariant.success, duration: duration);

  static SnackBar buildError(String message,
          {Duration duration = const Duration(seconds: 3)}) =>
      build(message, variant: AppSnackBarVariant.error, duration: duration);

  static SnackBar buildWarning(String message,
          {Duration duration = const Duration(seconds: 3)}) =>
      build(message, variant: AppSnackBarVariant.warning, duration: duration);

  static SnackBar buildInfo(String message,
          {Duration duration = const Duration(seconds: 3)}) =>
      build(message, variant: AppSnackBarVariant.info, duration: duration);

  static SnackBar build(
    String message, {
    required AppSnackBarVariant variant,
    required Duration duration,
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final (accent, icon) = switch (variant) {
      AppSnackBarVariant.success => (
          AppColors.secondary,
          FluentIcons.checkmark_circle_24_filled,
        ),
      AppSnackBarVariant.error => (
          _softRed,
          FluentIcons.dismiss_circle_24_filled,
        ),
      AppSnackBarVariant.warning => (
          AppColors.primary,
          FluentIcons.warning_24_filled,
        ),
      AppSnackBarVariant.info => (
          AppColors.secondary,
          FluentIcons.info_24_filled,
        ),
    };

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(AppSpacing.lg),
      content: _ToastCard(
        accent: accent,
        icon: icon,
        message: message,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
    );
  }
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({
    required this.accent,
    required this.icon,
    required this.message,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final Color accent;
  final IconData icon;
  final String message;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final hasAction = actionLabel != null && onAction != null;

    return Container(
      decoration: BoxDecoration(
        color: AppSnackBar._navy.withValues(alpha: 0.97),
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: AppSnackBar._navy.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Whisper-faint paw watermark bleeding off the trailing edge.
          PositionedDirectional(
            end: -6,
            bottom: -12,
            child: Icon(
              FluentIcons.animal_paw_print_24_filled,
              size: 68,
              color: Colors.white.withValues(alpha: 0.04),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _IconBubble(accent: accent, icon: icon),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.65),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (hasAction) ...[
                  const SizedBox(width: AppSpacing.sm),
                  _Action(label: actionLabel!, onTap: onAction!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded-square accent bubble holding the variant icon.
class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.accent, required this.icon});

  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.18),
        borderRadius: AppRadius.smAll,
      ),
      child: Icon(icon, color: accent, size: 20),
    );
  }
}

/// Trailing orange text action.
class _Action extends StatelessWidget {
  const _Action({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
      ),
      child: Text(label),
    );
  }
}
