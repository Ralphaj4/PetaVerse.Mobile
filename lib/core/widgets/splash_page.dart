import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Neutral launch screen shown while the app resolves which destination
/// to open (onboarding vs. login vs. home). It never flashes a real
/// screen: the router parks here until the onboarding + session gates
/// have loaded, then redirects to the correct route.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo on a white badge so its teal mark reads on the orange bg.
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logo.png',
                width: 96,
                height: 96,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
