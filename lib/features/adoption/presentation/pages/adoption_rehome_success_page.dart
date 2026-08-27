import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Arguments for the lister's post-transfer celebration, passed via `extra`.
class AdoptionRehomeSuccessArgs {
  const AdoptionRehomeSuccessArgs({
    required this.petName,
    required this.adopterName,
  });

  final String petName;
  final String adopterName;
}

/// Celebratory screen shown to the LISTER after they complete a transfer and
/// their pet moves to the adopter. (Distinct from the adopter's own welcome
/// screen for receiving a pet.) Terminal — "Done" returns to the board.
class AdoptionRehomeSuccessPage extends StatelessWidget {
  const AdoptionRehomeSuccessPage({required this.args, super.key});

  final AdoptionRehomeSuccessArgs args;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              const Spacer(),
              // Heart-home badge.
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  FluentIcons.home_heart_24_filled,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                l10n.adoptionRehomeSuccessTitle(args.petName),
                style: AppTextStyles.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.adoptionRehomeSuccessMessage(args.petName, args.adopterName),
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButton(
                label: l10n.adoptionRehomeSuccessDone,
                icon: FluentIcons.checkmark_24_regular,
                variant: AppButtonVariant.primary,
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
