import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Right-aligned orange bubble for the user's message.
/// The top-end corner is sharp; all others are fully rounded.
class UserBubble extends StatelessWidget {
  const UserBubble({required this.text, required this.timeLabel, super.key});

  final String text;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.72,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(AppSpacing.xl),
              topRight: isRtl
                  ? Radius.zero
                  : const Radius.circular(AppSpacing.xl),
              bottomLeft: const Radius.circular(AppSpacing.xl),
              bottomRight: isRtl
                  ? const Radius.circular(AppSpacing.xl)
                  : const Radius.circular(AppSpacing.xl),
            ),
          ),
          child: Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
          child: Text(
            timeLabel,
            style: AppTextStyles.labelSmall,
          ),
        ),
      ],
    );
  }
}
