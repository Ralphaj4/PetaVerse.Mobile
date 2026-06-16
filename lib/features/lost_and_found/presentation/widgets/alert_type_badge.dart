import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/pet_alert.dart';

/// Red "LOST" or green "FOUND" pill badge.
class AlertTypeBadge extends StatelessWidget {
  const AlertTypeBadge({required this.type, required this.label, super.key});

  final AlertType type;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isLost = type == AlertType.lost;
    final color = isLost ? AppColors.error : AppColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.xs),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.surface,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
