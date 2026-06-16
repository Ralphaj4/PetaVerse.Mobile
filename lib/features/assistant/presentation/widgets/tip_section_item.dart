import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/chat_message.dart';

/// A single expandable tip row inside a bot response card.
/// Normal tips have a white/grey tinted background; pro-tips get a
/// warmer primary-soft tint with a "Pro-Tip:" prefix.
class TipSectionItem extends StatelessWidget {
  const TipSectionItem({required this.tip, super.key});

  final TipSection tip;

  @override
  Widget build(BuildContext context) {
    final isProTip = tip.style == TipStyle.proTip;
    final bg = isProTip ? AppColors.primarySoft : AppColors.background;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.smAll,
        border: isProTip
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.25))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: tip.iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
            child: Icon(tip.icon, size: 17, color: tip.iconColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      if (isProTip)
                        TextSpan(
                          text: 'Pro-Tip: ',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      TextSpan(
                        text: tip.title,
                        style: AppTextStyles.titleSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  tip.body,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
