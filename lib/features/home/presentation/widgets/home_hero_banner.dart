import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import 'health_score_card.dart';
import 'home_header.dart';
import 'next_visit_chip.dart';

/// Orange gradient hero at the top of the home dashboard: greeting,
/// headline, pet photo, health score card, and next-visit chip.
class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({
    required this.userName,
    required this.petName,
    required this.healthScore,
    required this.healthStatusLabel,
    required this.nextVisitLabel,
    this.avatarUrl,
    this.petImageUrl,
    this.onBellTap,
    super.key,
  });

  final String userName;
  final String petName;
  final int healthScore;
  final String healthStatusLabel;
  final String nextVisitLabel;
  final String? avatarUrl;
  final String? petImageUrl;
  final VoidCallback? onBellTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryLight, AppColors.primaryDark],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Decorative paw watermark, always behind, anchored to the
            // trailing-bottom of the orange hero.
            PositionedDirectional(
              end: -30,
              bottom: -20,
              child: Icon(
                FluentIcons.animal_paw_print_24_filled,
                size: 220,
                color: AppColors.onPrimary.withValues(alpha: 0.12),
              ),
            ),
            // Pet photo — a round avatar over the paw, ringed in white so it
            // reads against the gradient.
            if (petImageUrl != null && petImageUrl!.isNotEmpty)
              PositionedDirectional(
                end: AppSpacing.lg,
                bottom: AppSpacing.xxl,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.onPrimary.withValues(alpha: 0.6),
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: AppCachedImage(
                      imageUrl: petImageUrl,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.zero,
                      semanticLabel: petName,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.xxl + AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(
                    userName: userName,
                    avatarUrl: avatarUrl,
                    onBellTap: onBellTap,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Text(
                      context.l10n.petDoingGreat(petName),
                      style: AppTextStyles.displayLarge.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  HealthScoreCard(
                    score: healthScore,
                    statusLabel: healthStatusLabel,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  NextVisitChip(dateLabel: nextVisitLabel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
