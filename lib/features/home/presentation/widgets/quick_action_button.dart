import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Circular tinted action button with a two-line label below, from the
/// "Quick Actions" section of the dashboard.
class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    required this.icon,
    required this.color,
    required this.label,
    this.onTap,
    this.filled = false,
    super.key,
  });

  final IconData icon;

  /// Accent color: tint when [filled] is false, fill when true.
  final Color color;

  final String label;
  final VoidCallback? onTap;

  /// When true the circle is solid [color] with a white icon
  /// (the "Add Record" emphasis in the design).
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: filled ? color : color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: filled ? AppColors.surface : color,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
