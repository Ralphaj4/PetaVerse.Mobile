import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class OnboardingSlideData {
  const OnboardingSlideData({
    required this.lottieAsset,
    required this.titleTop,
    required this.titleAccent,
    required this.description,
    this.blobColor = AppColors.primarySoft,
    required this.showBlob
  });

  final String lottieAsset;

  /// First headline line, rendered in the dark text color.
  final String titleTop;

  /// Second headline line, rendered in the primary accent color.
  final String titleAccent;

  final String description;

  /// Soft tint of the organic shape behind the illustration.
  final Color blobColor;

  final bool showBlob;
}

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({required this.data, super.key});

  final OnboardingSlideData data;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final artSize = width * 0.78;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),

          // ── illustration on an organic blob ─────────────────────────────
          Center(
            child: SizedBox(
              width: artSize,
              height: artSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (data.showBlob)
                    Container(
                      width: artSize * 0.92,
                      height: artSize * 0.82,
                      decoration: BoxDecoration(
                        color: data.blobColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(150),
                          topRight: Radius.circular(130),
                          bottomLeft: Radius.circular(120),
                          bottomRight: Radius.circular(160),
                        ),
                      ),
                    ),
                  Lottie.asset(
                    data.lottieAsset,
                    width: artSize,
                    height: artSize,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // ── sparkle accent + two-tone headline ──────────────────────────
          const Icon(
            FluentIcons.sparkle_20_filled,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${data.titleTop}\n',
                  style: AppTextStyles.displayLarge.copyWith(
                    fontSize: 36,
                    height: 1.15,
                  ),
                ),
                TextSpan(
                  text: data.titleAccent,
                  style: AppTextStyles.displayLarge.copyWith(
                    fontSize: 36,
                    height: 1.15,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            data.description,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
