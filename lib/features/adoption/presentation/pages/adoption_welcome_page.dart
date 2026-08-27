import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

/// Arguments for the adopter's post-transfer celebration, passed via `extra`.
class AdoptionWelcomeArgs {
  const AdoptionWelcomeArgs({required this.petId, required this.petName});

  final int petId;
  final String petName;
}

/// Celebratory screen shown to the ADOPTER once a transfer completes and the
/// pet lands in their account. (Distinct from the lister's rehome-success
/// screen.) The pet already has a full profile + records — this links straight
/// to it. Terminal: "Done" returns to My adoptions.
class AdoptionWelcomePage extends StatelessWidget {
  const AdoptionWelcomePage({required this.args, super.key});

  final AdoptionWelcomeArgs args;

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
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  FluentIcons.animal_paw_print_24_filled,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                l10n.adoptionWelcomeTitle(args.petName),
                style: AppTextStyles.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.adoptionWelcomeMessage(args.petName),
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButton(
                label: l10n.adoptionWelcomeViewPet(args.petName),
                icon: FluentIcons.animal_paw_print_24_regular,
                variant: AppButtonVariant.primary,
                // Replace so "back" doesn't return to this terminal screen.
                onPressed: () =>
                    context.pushReplacement(AppRoutes.petDetailPath(args.petId)),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: l10n.adoptionWelcomeDone,
                variant: AppButtonVariant.text,
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
