import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Dashed-border card linking to the Pet Health Vault — shown once in
/// the chat as a contextual CTA.
class HealthVaultCard extends StatelessWidget {
  const HealthVaultCard({
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.accentPurpleSoft,
          borderRadius: AppRadius.lgAll,
          border: Border.all(
            color: AppColors.accentPurple.withValues(alpha: 0.4),
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accentPurple.withValues(alpha: 0.15),
                borderRadius: AppRadius.smAll,
              ),
              child: const Icon(
                FluentIcons.database_24_regular,
                size: 22,
                color: AppColors.accentPurple,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.accentPurple,
                borderRadius: AppRadius.smAll,
              ),
              child: const Icon(
                FluentIcons.arrow_right_24_regular,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
