import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../providers/pets_provider.dart';

/// First-run pet setup: shown after auth when the user has no pet.
///
/// Placeholder for the create-pet flow — the real form (which needs a breed
/// source the API doesn't yet expose) lands in a follow-up. For now it covers
/// the gate's three reachable states:
///   • loading  — the pet gate is still resolving,
///   • error    — the gate couldn't confirm emptiness (offline) → retry,
///   • empty    — confirmed no pets → the add-a-pet prompt.
class PetOnboardingPage extends ConsumerWidget {
  const PetOnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pets = ref.watch(petsProvider);

    final Widget body;
    if (!pets.ready) {
      body = _Loading(message: context.l10n.petOnboardingLoading);
    } else if (pets.unresolvedEmpty) {
      // Offline + empty cache: we can't be sure the user has no pet, so we
      // offer a retry rather than letting them create a (possibly duplicate).
      body = ErrorStateWidget(
        failure: pets.failure,
        onRetry: () => ref.read(petsProvider.notifier).retry(),
      );
    } else {
      body = const _AddFirstPet();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: body),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppSpacing.lg),
          Text(
            message,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AddFirstPet extends StatelessWidget {
  const _AddFirstPet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final width = MediaQuery.sizeOf(context).width;
    final artSize = width * 0.66;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            // ── illustration on a soft organic blob ──────────────────────
            SizedBox(
              width: artSize,
              height: artSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: artSize * 0.92,
                    height: artSize * 0.82,
                    decoration: const BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        topRight: Radius.circular(130),
                        bottomLeft: Radius.circular(120),
                        bottomRight: Radius.circular(160),
                      ),
                    ),
                  ),
                  Lottie.asset(
                    'assets/lotties/owner_dog.json',
                    width: artSize,
                    height: artSize,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── sparkle accent + two-tone headline ───────────────────────
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
                    text: '${l10n.petOnboardingTitleTop}\n',
                    style: AppTextStyles.displayLarge.copyWith(
                      fontSize: 30,
                      height: 1.15,
                    ),
                  ),
                  TextSpan(
                    text: l10n.petOnboardingTitleAccent,
                    style: AppTextStyles.displayLarge.copyWith(
                      fontSize: 30,
                      height: 1.15,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.petOnboardingSubtitle,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 2),

            // ── primary CTA ──────────────────────────────────────────────
            AppButton(
              label: l10n.petOnboardingAction,
              icon: FluentIcons.add_24_regular,
              variant: AppButtonVariant.primary,
              // Opens the create-pet form. On success it refreshes the pet
              // gate, so the router advances from onboarding to home.
              onPressed: () => context.push(AppRoutes.createPet),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
    );
  }
}
