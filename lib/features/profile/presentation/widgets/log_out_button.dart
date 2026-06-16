import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Full-width soft-red log out button from the profile design.
class LogOutButton extends StatelessWidget {
  const LogOutButton({required this.label, this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppRadius.mdAll,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FluentIcons.sign_out_24_regular,
                  size: 20,
                  color: AppColors.error,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  label,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
