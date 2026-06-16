import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FluentIcons.animal_paw_print_24_filled,
              size: 72,
              color: AppColors.onPrimary,
            ),
            SizedBox(height: AppSpacing.xl),
            SizedBox(
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
