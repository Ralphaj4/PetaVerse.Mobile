import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// One tinted stat card from the dashboard summary row
/// (Health / Nutrition / Activity / Vaccines).
class PetStatCard extends StatelessWidget {
  const PetStatCard({
    required this.icon,
    required this.color,
    required this.background,
    required this.title,
    required this.value,
    this.subtitle,
    super.key,
  });

  final IconData icon;

  /// Accent used for the icon and the value text.
  final Color color;

  /// Soft tint behind the whole card.
  final Color background;

  final String title;
  final String value;

  /// Optional secondary line under [value] (e.g. "3 active days", "Stable").
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          subtitle == null ? '$title: $value' : '$title: $value, $subtitle',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: AppRadius.mdAll,
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: AppRadius.smAll,
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: AppTextStyles.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: AppTextStyles.labelMedium.copyWith(color: color),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle!,
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textTertiary),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
