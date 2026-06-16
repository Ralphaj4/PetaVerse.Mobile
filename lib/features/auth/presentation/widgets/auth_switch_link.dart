import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// "Don't have an account? Join the family" style footer link, with the
/// action part highlighted in the primary color.
class AuthSwitchLink extends StatelessWidget {
  const AuthSwitchLink({
    required this.prompt,
    required this.action,
    required this.onTap,
    super.key,
  });

  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            prompt,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Semantics(
          button: true,
          label: action,
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              action,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
