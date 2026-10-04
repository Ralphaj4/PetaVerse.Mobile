import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/app/tab_scroll_to_top_provider.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../shared/widgets/section_header.dart';
import '../../../activity/presentation/widgets/walk_banner.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';
import '../../../pawcare/presentation/providers/pawcare_providers.dart';
import '../../../pawcare/presentation/widgets/health_score_bits.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../../domain/entities/home_summary.dart';
import '../providers/home_providers.dart';
import '../widgets/explore_section.dart';
import '../widgets/health_reminder_card.dart';
import '../widgets/home_hero_banner.dart';
import '../widgets/pet_stat_card.dart';
import '../widgets/quick_action_button.dart';

/// Home dashboard. The greeting/pet come from the pet gate; the hero score,
/// stat cards, and the cross-pet "Upcoming" timeline are driven by
/// [homeSummaryProvider] (GET /users/me/home-summary), with the local reminder
/// cache as the offline fallback for the timeline.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    // Bottom nav bumps this when the Home tab (branch 0) is re-tapped at root.
    ref.listen(
      tabScrollToTopProvider.select((m) => m[0]),
      (_, _) => _scrollToTop(),
    );

    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final currentPet = ref.watch(petsProvider).currentPet;
    final petName = currentPet?.name ?? '';
    final user = ref.watch(userProvider).value;
    final userName = user == null
        ? ''
        : '${user.firstName} ${user.lastName}'.trim();

    final summaryAsync = ref.watch(homeSummaryProvider);
    final summary = summaryAsync.value;

    // Hero fields: real when the summary has loaded, neutral placeholders
    // while it's in flight or errored (the sheet carries the error state).
    final healthScore = summary?.healthScore ?? 0;
    final healthStatusLabel = summary == null
        ? ' - '
        : healthBandLabel(l10n, summary.healthBand);
    final nextVisit = summary?.nextVisit;
    final nextVisitLabel = nextVisit == null
        ? l10n.nextVisitNone
        : DateFormat.yMMMd(locale).format(nextVisit.scheduledAt);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            // Hit the network (writes cache) so the spinner holds for the real
            // round-trip, then re-run the provider to re-emit the fresh cache.
            final petId = ref.read(petsProvider).currentPetId;
            await ref.read(homeRepositoryProvider).getHomeSummary(petId: petId);
            ref.invalidate(homeSummaryProvider);
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                HomeHeroBanner(
                  userName: userName,
                  avatarUrl: user?.avatarUrl,
                  petName: petName,
                  petImageUrl: currentPet?.imagePath,
                  healthScore: healthScore,
                  healthStatusLabel: healthStatusLabel,
                  nextVisitLabel: nextVisitLabel,
                  onPetImageTap: (currentPet?.imagePath?.isNotEmpty ?? false)
                      ? () => context.push(
                            AppRoutes.imageViewer,
                            extra: <String, Object?>{
                              'url': currentPet!.imagePath,
                              'heroTag': HomeHeroBanner.petImageHeroTag,
                              'label': petName,
                            },
                          )
                      : null,
                  onHealthScoreTap: currentPet != null
                      ? () => context.push(
                            AppRoutes.healthScorePath(currentPet.id),
                          )
                      : null,
                ),
                // White sheet pulled up over the hero's bottom edge.
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
                      _StatsRow(l10n: l10n, summary: summary),
                      const SizedBox(height: AppSpacing.xl),
                      if (currentPet != null &&
                          currentPet.supportsActivityTracking) ...[
                        WalkBanner(
                          petId: currentPet.id,
                          petName: petName,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                      ],
                      _UpcomingSectionHeader(summary: summary),
                      const SizedBox(height: AppSpacing.sm),
                      _UpcomingSection(
                        summary: summary,
                        error: summaryAsync.hasError,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      ExploreSection(summary: summary),
                      const SizedBox(height: AppSpacing.xl),
                      SectionHeader(title: l10n.quickActions),
                      const SizedBox(height: AppSpacing.md),
                      const _QuickActionsRow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Section header for Upcoming - shows "See all" only when there are more than
/// 3 reminders. Prefers the server timeline; falls back to the cached count.
class _UpcomingSectionHeader extends ConsumerWidget {
  const _UpcomingSectionHeader({required this.summary});

  final HomeSummary? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final int count = summary?.upcoming.length ??
        ref.watch(
          upcomingHealthRemindersProvider.select(
            (a) => a.value?.length ?? 0,
          ),
        ) ??
        0;
    return SectionHeader(
      title: l10n.upcoming,
      count: count,
      onSeeAll: count > 3
          ? () => context.push(AppRoutes.upcomingReminders)
          : null,
    );
  }
}

/// The "Upcoming" section body: up to 3 reminders from the server timeline,
/// soonest first. When the summary errored (e.g. offline) it falls back to the
/// locally-cached reminders so the section still renders.
class _UpcomingSection extends ConsumerWidget {
  const _UpcomingSection({required this.summary, required this.error});

  final HomeSummary? summary;
  final bool error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<HealthReminder> reminders;
    if (summary != null) {
      reminders = summary!.upcoming;
    } else if (error) {
      // Offline / failed fetch: show whatever the cache still holds.
      reminders =
          ref.watch(upcomingHealthRemindersProvider).value ?? const [];
    } else {
      // Still loading and no data yet.
      reminders = const [];
    }

    if (reminders.isEmpty) {
      return _UpcomingEmpty();
    }

    final shown = reminders.take(3).toList(growable: false);
    return Column(
      children: [
        for (var i = 0; i < shown.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          HealthReminderCard(reminder: shown[i], index: i),
        ],
      ],
    );
  }
}

/// Shown when there are no cached health reminders yet.
class _UpcomingEmpty extends StatelessWidget {
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
                Text(l10n.upcomingEmptyTitle,
                    style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(l10n.upcomingEmptySubtitle,
                    style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The four stat cards - Health, Activity, Vaccines, Weight - driven by the
/// home summary. Values fall back to a neutral dash while the summary loads.
class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.l10n, required this.summary});

  final AppLocalizations l10n;
  final HomeSummary? summary;

  String get _healthValue {
    final s = summary;
    if (s == null) return l10n.statNoData;
    return healthBandLabel(l10n, s.healthBand);
  }

  String get _activityValue {
    final a = summary?.activity;
    if (a == null) return l10n.statNoData;
    return l10n.statActivityMinutes(a.minutes);
  }

  String get _activitySub {
    final a = summary?.activity;
    if (a == null) return '';
    return l10n.statActiveDays(a.activeDays);
  }

  String get _vaccinesValue {
    final s = summary;
    if (s == null) return l10n.statNoData;
    return l10n.statVaccinesUpcoming(s.vaccinesUpcomingCount);
  }

  String get _weightValue {
    final w = summary?.weight;
    if (w == null) return l10n.statNoData;
    final v = w.value % 1 == 0
        ? w.value.toStringAsFixed(0)
        : w.value.toStringAsFixed(1);
    return l10n.statWeightValue(v, w.unit.suffix);
  }

  String get _weightSub {
    final trend = summary?.weight?.trend;
    return switch (trend) {
      WeightTrend.stable => l10n.weightTrendStable,
      WeightTrend.rising => l10n.weightTrendRising,
      WeightTrend.dropping => l10n.weightTrendDropping,
      null => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight + stretch makes every card match the tallest one, so the
    // subtitle on Activity/Weight never leaves the others looking clipped.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PetStatCard(
              icon: FluentIcons.heart_pulse_24_filled,
              color: AppColors.secondary,
              background: AppColors.secondarySoft,
              title: l10n.statHealth,
              value: _healthValue,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: PetStatCard(
              icon: FluentIcons.run_24_filled,
              color: AppColors.secondaryDark,
              background: AppColors.background,
              title: l10n.statActivity,
              value: _activityValue,
              subtitle: _activitySub.isEmpty ? null : _activitySub,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: PetStatCard(
              icon: FluentIcons.shield_checkmark_24_filled,
              color: AppColors.accentPurple,
              background: AppColors.accentPurpleSoft,
              title: l10n.statVaccines,
              value: _vaccinesValue,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: PetStatCard(
              icon: FluentIcons.scales_24_filled,
              color: AppColors.primary,
              background: AppColors.primarySoft,
              title: l10n.statWeight,
              value: _weightValue,
              subtitle: _weightSub.isEmpty ? null : _weightSub,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends ConsumerWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.calendar_add_24_regular,
            color: AppColors.primary,
            label: l10n.quickAccessAddAppointment,
            onTap: () {
              final pet = ref.read(petsProvider).currentPet;
              if (pet != null) {
                context.push(AppRoutes.appointmentsPath(pet.id));
              }
            },
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.map_24_regular,
            color: AppColors.secondary,
            label: l10n.quickAccessCareMap,
            // Opens the PawCare service-providers map on the root navigator, so
            // it overlays Home without switching the bottom-nav tab.
            onTap: () => context.push(AppRoutes.careMap),
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.eye_24_regular,
            color: AppColors.accentPurple,
            label: l10n.quickAccessPetVision,
            onTap: () => context.push(AppRoutes.petVision),
          ),
        ),
      ],
    );
  }
}
