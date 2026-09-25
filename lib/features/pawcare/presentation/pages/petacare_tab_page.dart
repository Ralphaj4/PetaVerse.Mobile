import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/app/tab_scroll_to_top_provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../community/presentation/models/pawhub_models.dart';
import '../../../community/presentation/widgets/pawhub_common.dart';
import '../../../home/presentation/widgets/health_reminder_card.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../../core/location/location_service.dart';
import '../../../service_providers/presentation/providers/service_providers_providers.dart';
import '../providers/pawcare_providers.dart';
import '../widgets/health_dashboard.dart';
import '../widgets/health_score_card.dart';

/// The PetaCare tab — a full scrollable care dashboard.
///
/// Layout (top to bottom):
///   1. Teal gradient hero  — pet name + inline health score, "Track Health" CTA.
///   2. White content sheet — overlaps the hero with a rounded top edge.
///        a. Upcoming health reminders
///        b. "Find Care Near You" map card — embedded live map with provider
///           pins; tapping opens the full discovery screen.
///        c. Health score + dashboard (same widgets as pet detail page)
class PetaCareTabPage extends ConsumerStatefulWidget {
  const PetaCareTabPage({super.key});

  @override
  ConsumerState<PetaCareTabPage> createState() => _PetaCareTabPageState();
}

class _PetaCareTabPageState extends ConsumerState<PetaCareTabPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      tabScrollToTopProvider.select((m) => m[2]),
      (_, _) => _scrollToTop(),
    );

    final currentPet = ref.watch(petsProvider).currentPet;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // ── Orange gradient hero ─────────────────────────────────────
              _CareHero(
                pet: currentPet == null
                    ? null
                    : (id: currentPet.id, name: currentPet.name),
              ),

              // ── White content sheet (pulled up over hero) ────────────────
              Container(
                transform: Matrix4.translationValues(0, -AppRadius.lg, 0),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.lg + 4),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming reminders
                    const _UpcomingSectionHeader(),
                    const SizedBox(height: AppSpacing.sm),
                    const _UpcomingSection(),
                    const SizedBox(height: AppSpacing.xl),

                    // Find Care Near You map card
                    _FindCareSection(
                      center: ref.watch(providerUserLocationProvider) ??
                          kDefaultMapCenter,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Health score + full dashboard
                    if (currentPet != null) ...[
                      SectionHeader(title: context.l10n.petaCareHealthScore),
                      const SizedBox(height: AppSpacing.sm),
                      HealthScoreCard(
                        petId: currentPet.id,
                        petName: currentPet.name,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      HealthDashboard(petId: currentPet.id),
                    ] else
                      _NoPetHealthPlaceholder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Care hero ─────────────────────────────────────────────────────────────────

typedef _PetRef = ({int id, String name});

/// Orange gradient hero banner matching the home page's design language.
/// Shows the active pet context and a quick health-score glance.
class _CareHero extends ConsumerWidget {
  const _CareHero({required this.pet});

  final _PetRef? pet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryLight, AppColors.primaryDark],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Decorative paw watermark
            PositionedDirectional(
              end: -30,
              bottom: -20,
              child: Icon(
                FluentIcons.animal_paw_print_24_filled,
                size: 220,
                color: AppColors.onPrimary.withValues(alpha: 0.10),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.xxl + AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.navCare,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.onPrimary.withValues(alpha: 0.80),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      if (pet != null)
                        _HeroPetSwitcher(pet: pet!),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Pet name headline or no-pet state
                  Text(
                    pet != null
                        ? l10n.petaCareHeaderTitle(pet!.name)
                        : l10n.petaCareNoPetTitle,
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.petaCareHeaderSubtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.75),
                    ),
                  ),

                  if (pet != null) ...[
                    const SizedBox(height: AppSpacing.xl),
                    _HeroScorePill(petId: pet!.id),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pet switcher pill rendered inside the hero's top row.
/// Tapping opens the shared bottom-sheet picker; choosing a different pet
/// calls [petsProvider.notifier.selectPet] to update the app-wide selection.
class _HeroPetSwitcher extends ConsumerWidget {
  const _HeroPetSwitcher({required this.pet});

  final _PetRef pet;

  List<PawPet> _pawPets(WidgetRef ref) => ref
      .read(petsProvider)
      .refs
      .map((r) => PawPet(
            id: r.id.toString(),
            backendId: r.id,
            name: r.name,
            breed: '',
            species: '',
            avatarUrl: r.imagePath,
            ownerName: '',
            isMine: true,
          ))
      .toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pets = _pawPets(ref);
    final current = pets.firstWhere(
      (p) => p.backendId == pet.id,
      orElse: () => pets.first,
    );

    return PetSwitcherPill(
      pet: current,
      onTap: () async {
        if (pets.length < 2) return;
        final chosen = await showPetSwitcherSheet(
          context,
          pets: pets,
          current: current,
          title: context.l10n.aiSwitchPetTitle,
          showMyPostsLink: false,
        );
        if (chosen == null || chosen.backendId == pet.id) return;
        ref.read(petsProvider.notifier).selectPet(chosen.backendId);
      },
    );
  }
}

/// Compact health-score pill shown inside the hero — score + band label.
class _HeroScorePill extends ConsumerWidget {
  const _HeroScorePill({required this.petId});

  final int petId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scoreAsync = ref.watch(petHealthScoreProvider(petId));

    return scoreAsync.maybeWhen(
      data: (score) {
        if (!score.hasData) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () => context.push(AppRoutes.healthScorePath(petId)),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.onPrimary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: AppColors.onPrimary.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.heart_pulse_24_filled,
                  size: 16,
                  color: AppColors.onPrimary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${score.value}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '/ 100',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.70),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '·',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.50),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  context.l10n.healthScoreViewBreakdown,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Directionality.of(context) == TextDirection.rtl
                      ? FluentIcons.chevron_left_16_regular
                      : FluentIcons.chevron_right_16_regular,
                  size: 13,
                  color: AppColors.onPrimary.withValues(alpha: 0.85),
                ),
              ],
            ),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

// ── Upcoming reminders ────────────────────────────────────────────────────────

class _UpcomingSectionHeader extends ConsumerWidget {
  const _UpcomingSectionHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final count = ref.watch(
      upcomingHealthRemindersProvider.select((a) => a.value?.length ?? 0),
    );
    return SectionHeader(
      title: l10n.upcoming,
      onSeeAll: count > 3
          ? () => context.push(AppRoutes.upcomingReminders)
          : null,
    );
  }
}

class _UpcomingSection extends ConsumerWidget {
  const _UpcomingSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(upcomingHealthRemindersProvider);

    return remindersAsync.when(
      loading: () => const SizedBox(
        height: 64,
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (e, _) => ErrorStateWidget(
        failure: e is Failure ? e : null,
        onRetry: () => ref.invalidate(upcomingHealthRemindersProvider),
      ),
      data: (reminders) {
        if (reminders.isEmpty) return const _RemindersEmpty();
        final shown = reminders.take(3).toList(growable: false);
        return Column(
          children: [
            for (var i = 0; i < shown.length; i++) ...[
              if (i > 0) const SizedBox(height: AppSpacing.sm),
              HealthReminderCard(reminder: shown[i], index: i),
            ],
          ],
        );
      },
    );
  }
}

class _RemindersEmpty extends StatelessWidget {
  const _RemindersEmpty();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(
            FluentIcons.checkmark_circle_24_regular,
            color: AppColors.secondary,
            size: 28,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.upcomingEmptyTitle, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(l10n.upcomingEmptySubtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Find Care Near You ────────────────────────────────────────────────────────

/// A full-width section with a large map preview card and a label above it.
/// The embedded map shows real provider pins but is non-interactive (no drag/zoom).
/// Tapping anywhere opens the full discovery screen.
class _FindCareSection extends StatelessWidget {
  const _FindCareSection({
    required this.center,
  });

  /// Teaser map center — the user's location, or the app default. Providers
  /// aren't preloaded here; they load in the full map screen on tap.
  final LatLng center;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: l10n.petaCareFindCare,
          onSeeAll: () => context.push(AppRoutes.careMap),
        ),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: () => context.push(AppRoutes.careMap),
          child: Hero(
            tag: 'care-provider-map',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: SizedBox(
                height: 220,
                child: Stack(
                fit: StackFit.expand,
                children: [
                  // Live map tile — no interaction flags so it's a pure visual
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: center,
                      initialZoom: 14,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: AppConstants.mapTileUrl,
                        subdomains: AppConstants.mapTileUrl.contains('{s}')
                            ? AppConstants.mapTileSubdomains
                            : const [],
                        userAgentPackageName: 'com.petaverse.mobile',
                        retinaMode: AppConstants.mapTileUrl.contains('{r}') &&
                            RetinaMode.isHighDensity(context),
                      ),
                    ],
                  ),

                  // Bottom gradient so the CTA reads over tiles
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.textPrimary.withValues(alpha: 0),
                            AppColors.textPrimary.withValues(alpha: 0.62),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // "Find nearby" chip — top-left
                  PositionedDirectional(
                    top: AppSpacing.md,
                    start: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textPrimary.withValues(alpha: 0.12),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            FluentIcons.building_24_regular,
                            size: 14,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.providersNearby,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.textPrimary,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // "Open Map" CTA — bottom-left
                  PositionedDirectional(
                    start: AppSpacing.md,
                    bottom: AppSpacing.md,
                    end: AppSpacing.md,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.petaCareFindCare,
                                style: AppTextStyles.titleSmall.copyWith(
                                  color: AppColors.onPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                l10n.petaCareMapSubtitle,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.onPrimary
                                      .withValues(alpha: 0.80),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l10n.petaCareOpenMap,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.onSecondary,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Icon(
                                Directionality.of(context) == TextDirection.rtl
                                    ? FluentIcons.arrow_left_16_regular
                                    : FluentIcons.arrow_right_16_regular,
                                size: 14,
                                color: AppColors.onSecondary,
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
          ),
          ),  // Hero
        ),
      ],
    );
  }
}

// ── No-pet health placeholder ─────────────────────────────────────────────────

class _NoPetHealthPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FluentIcons.animal_paw_print_24_regular,
              color: AppColors.secondary,
              size: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.petaCareNoPetTitle,
            style: AppTextStyles.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.petaCareNoPetSubtitle,
            style:
                AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
