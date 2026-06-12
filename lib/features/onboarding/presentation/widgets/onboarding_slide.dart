import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class OnboardingSlideData {
  const OnboardingSlideData({
    required this.lottieAsset,
    required this.title,
    required this.description,
    required this.accent,
  });

  final String lottieAsset;
  final String title;
  final String description;
  final Color accent;
}

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({required this.data, super.key});

  final OnboardingSlideData data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            data.lottieAsset,
            width: size.width * 0.72,
            height: size.width * 0.72,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            data.title,
            style: AppTextStyles.headlineLarge.copyWith(color: data.accent),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            data.description,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
