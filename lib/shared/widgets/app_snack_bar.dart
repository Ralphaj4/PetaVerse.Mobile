import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

enum AppSnackBarVariant { info, success, error, warning }

abstract final class AppSnackBar {
  /// Shows a floating snackbar with an icon and message.
  static void show(
    BuildContext context,
    String message, {
    AppSnackBarVariant variant = AppSnackBarVariant.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(build(message, variant: variant, duration: duration));
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
  }) {
    final (bg, fg, icon) = switch (variant) {
      AppSnackBarVariant.success => (
          AppColors.success,
          AppColors.onPrimary,
          FluentIcons.checkmark_circle_24_filled,
        ),
      AppSnackBarVariant.error => (
          AppColors.error,
          AppColors.onPrimary,
          FluentIcons.dismiss_circle_24_filled,
        ),
      AppSnackBarVariant.warning => (
          AppColors.warning,
          AppColors.onPrimary,
          FluentIcons.warning_24_filled,
        ),
      AppSnackBarVariant.info => (
          AppColors.textPrimary,
          AppColors.onPrimary,
          FluentIcons.info_24_filled,
        ),
    };

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: bg,
      duration: duration,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm)),
      ),
      margin: const EdgeInsets.all(AppSpacing.lg),
      content: Row(
        children: [
          Icon(icon, color: fg, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
