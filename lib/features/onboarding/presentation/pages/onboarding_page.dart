import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/ambient_decorations.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_slide.dart';

List<OnboardingSlideData> _slides(AppLocalizations l10n) => [
      OnboardingSlideData(
        lottieAsset: 'assets/lotties/owner_dog.json',
        titleTop: l10n.onboardingTitle1a,
        titleAccent: l10n.onboardingTitle1b,
        description: l10n.onboardingDesc1,
        showBlob: false
      ),
      OnboardingSlideData(
        lottieAsset: 'assets/lotties/cat_playing.json',
        titleTop: l10n.onboardingTitle2a,
        titleAccent: l10n.onboardingTitle2b,
        description: l10n.onboardingDesc2,
        blobColor: AppColors.primarySoft,
        showBlob: true
      ),
      OnboardingSlideData(
        lottieAsset: 'assets/lotties/dog_floating.json',
        titleTop: l10n.onboardingTitle3a,
        titleAccent: l10n.onboardingTitle3b,
        description: l10n.onboardingDesc3,
        showBlob: true
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
    if (mounted) context.go(AppRoutes.login);
  }

  void _next(int current, int total) {
    if (current < total - 1) {
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
    final l10n = context.l10n;
    final slides = _slides(l10n);
    final current = ref.watch(onboardingProvider);
    final isLast = current == slides.length - 1;
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
                children: [
                  // ── skip ──────────────────────────────────────────────
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: AppSpacing.lg,
                        top: AppSpacing.sm,
                      ),
                      child: AnimatedOpacity(
                        opacity: isLast ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: TextButton(
                          onPressed: isLast ? null : _finish,
                          child: Text(
                            l10n.skip,
                            style: AppTextStyles.titleSmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── slides ────────────────────────────────────────────
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: slides.length,
                      onPageChanged: (i) =>
                          ref.read(onboardingProvider.notifier).goTo(i),
                      itemBuilder: (_, i) => OnboardingSlide(data: slides[i]),
                    ),
                  ),

                  // ── dots + continue ───────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.md,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      children: [
                        OnboardingDots(count: slides.length, current: current),
                        const SizedBox(height: AppSpacing.xl),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.onPrimary,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () => _next(current, slides.length),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isLast
                                      ? l10n.getStarted
                                      : l10n.continueButton,
                                  style: AppTextStyles.titleLarge.copyWith(
                                    color: AppColors.onPrimary,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Icon(
                                  isRtl
                                      ? FluentIcons.arrow_left_24_regular
                                      : FluentIcons.arrow_right_24_regular,
                                  size: 22,
                                ),
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
          ],
        ),
      ),
    );
  }
}
