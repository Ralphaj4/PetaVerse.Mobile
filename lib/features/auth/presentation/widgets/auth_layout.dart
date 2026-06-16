import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/ambient_decorations.dart';

/// Shared scaffold for the auth flow: warm gradient, ambient paw/sparkle
/// decorations, optional back button, and the two-tone headline used
/// across onboarding and auth.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.titleTop,
    required this.titleAccent,
    required this.subtitle,
    required this.child,
    this.showBack = false,
    super.key,
  });

  final String titleTop;
  final String titleAccent;
  final String subtitle;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundWarm, AppColors.surface],
          ),
        ),
        child: Stack(
          children: [
            const AmbientDecorations(),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showBack)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: AppSpacing.sm,
                        top: AppSpacing.sm,
                      ),
                      child: IconButton(
                        onPressed: () => context.pop(),
                        tooltip: context.l10n.close,
                        icon: Icon(
                          isRtl
                              ? FluentIcons.arrow_right_24_regular
                              : FluentIcons.arrow_left_24_regular,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: AppSpacing.xxl),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.lg),
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
                                  text: '$titleTop\n',
                                  style: AppTextStyles.displayLarge.copyWith(
                                    fontSize: 36,
                                    height: 1.15,
                                  ),
                                ),
                                TextSpan(
                                  text: titleAccent,
                                  style: AppTextStyles.displayLarge.copyWith(
                                    fontSize: 36,
                                    height: 1.15,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            subtitle,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          child,
                          const SizedBox(height: AppSpacing.xl),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
