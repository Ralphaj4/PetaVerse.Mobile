import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/chat_message.dart';
import 'tip_section_item.dart';

/// Left-aligned white card for PawBot's response. Includes the bot
/// avatar + label header, the main text, structured tip sections,
/// and an optional inline footer with a teal action link.
class BotBubble extends StatelessWidget {
  const BotBubble({
    required this.message,
    required this.botLabel,
    super.key,
  });

  final ChatMessage message;
  final String botLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BotAvatar(),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                botLabel,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSpacing.xs),
                    topRight: Radius.circular(AppSpacing.xl),
                    bottomLeft: Radius.circular(AppSpacing.xl),
                    bottomRight: Radius.circular(AppSpacing.xl),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main text
                    Text(message.text, style: AppTextStyles.bodyMedium),

                    // Tip sections
                    if (message.tips.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      ...message.tips.map(
                        (tip) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: TipSectionItem(tip: tip),
                        ),
                      ),
                    ],

                    // Footer
                    if (message.footerText != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              message.footerText!,
                              style: AppTextStyles.bodySmall,
                            ),
                          ),
                          if (message.footerActionLabel != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                message.footerActionLabel!,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        FluentIcons.sparkle_24_filled,
        size: 18,
        color: AppColors.onPrimary,
      ),
    );
  }
}
