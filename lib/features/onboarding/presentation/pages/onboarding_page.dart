import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_slide.dart';

final _slides = [
  const OnboardingSlideData(
    lottieAsset: 'assets/lotties/owner_dog.json',
    title: 'Welcome to PetaVerse',
    description:
        'Your all-in-one companion for everything your pet needs — health, care, and more.',
    accent: AppColors.primary,
  ),
  const OnboardingSlideData(
    lottieAsset: 'assets/lotties/cat_playing.json',
    title: 'Track Health & Reminders',
    description:
        'Never miss a vaccination, vet visit, or medication with smart reminders.',
    accent: AppColors.secondary,
  ),
  const OnboardingSlideData(
    lottieAsset: 'assets/lotties/dog_floating.json',
    title: 'Connect with the Community',
    description:
        'Share moments, find lost pets, and discover local services nearby.',
    accent: AppColors.primary,
  ),
];

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(onboardingProvider.notifier).complete();
    if (mounted) context.go(AppRoutes.home);
  }

  void _next(int current) {
    if (current < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(onboardingProvider);
    final isLast = current == _slides.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── skip ──────────────────────────────────────────────────────
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AnimatedOpacity(
                opacity: isLast ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: TextButton(
                  onPressed: isLast ? null : _finish,
                  child: Text(
                    context.l10n.skip,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // ── slides ────────────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) =>
                    ref.read(onboardingProvider.notifier).goTo(i),
                itemBuilder: (_, i) => OnboardingSlide(data: _slides[i]),
              ),
            ),

            // ── dots + button ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.xl,
              ),
              child: Column(
                children: [
                  OnboardingDots(count: _slides.length, current: current),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                      ),
                      onPressed: () => _next(current),
                      child: Text(
                        isLast
                            ? context.l10n.getStarted
                            : context.l10n.next,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.onPrimary,
                        ),
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
