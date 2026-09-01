import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
import '../../../community/presentation/providers/pawhub_tab_provider.dart';
import '../../../pawcare/domain/entities/health_reminder.dart';
import '../../../pawcare/presentation/providers/pawcare_providers.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../widgets/health_reminder_card.dart';
import '../widgets/home_hero_banner.dart';
import '../widgets/pet_stat_card.dart';
import '../widgets/quick_action_button.dart';

/// Home dashboard. The active pet's name is live from the pet gate; the rest
/// is mocked until the health backend is wired.
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
    final currentPet = ref.watch(petsProvider).currentPet;
    final petName = currentPet?.name ?? '';
    final user = ref.watch(userProvider).value;
    final userName = user == null
        ? ''
        : '${user.firstName} ${user.lastName}'.trim();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HomeHeroBanner(
                userName: userName,
                avatarUrl: user?.avatarUrl,
                petName: petName,
                petImageUrl: currentPet?.imagePath,
                healthScore: 92,
                healthStatusLabel: l10n.healthExcellent,
                nextVisitLabel: 'Jun 21, 2026',
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
                    _StatsRow(l10n: l10n),
                    const SizedBox(height: AppSpacing.xl),
                    if (currentPet != null &&
                        currentPet.supportsActivityTracking) ...[
                      WalkBanner(
                        petId: currentPet.id,
                        petName: petName,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                    const _UpcomingSectionHeader(),
                    const SizedBox(height: AppSpacing.sm),
                    const _UpcomingSection(),
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
    );
  }
}

/// Section header for Upcoming — shows "See all" only when there are more
/// than 3 reminders cached.
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

/// The "Upcoming" section body: up to 3 cached health reminders, soonest first.
class _UpcomingSection extends ConsumerWidget {
  const _UpcomingSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(upcomingHealthRemindersProvider);

    final reminders = remindersAsync.value ?? const <HealthReminder>[];
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

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PetStatCard(
            icon: FluentIcons.heart_pulse_24_filled,
            color: AppColors.secondary,
            background: AppColors.secondarySoft,
            title: l10n.statHealth,
            value: l10n.statGreat,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: PetStatCard(
            icon: FluentIcons.food_24_filled,
            color: AppColors.primary,
            background: AppColors.primarySoft,
            title: l10n.statNutrition,
            value: l10n.statGood,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: PetStatCard(
            icon: FluentIcons.run_24_filled,
            color: AppColors.secondaryDark,
            background: AppColors.background,
            title: l10n.statActivity,
            value: l10n.stepsCount(7532),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: PetStatCard(
            icon: FluentIcons.shield_checkmark_24_filled,
            color: AppColors.accentPurple,
            background: AppColors.accentPurpleSoft,
            title: l10n.statVaccines,
            value: l10n.upToDate,
          ),
        ),
      ],
    );
  }
}

class _QuickActionsRow extends ConsumerWidget {
  const _QuickActionsRow();

  /// Deep-links into a PawHub hub segment: set the requested tab, then switch
  /// to the community branch (go, not push, so the bottom nav follows).
  void _openPawHubTab(BuildContext context, WidgetRef ref, int tab) {
    ref.read(pawHubRequestedTabProvider.notifier).request(tab);
    context.go(AppRoutes.community);
  }

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
            label: l10n.bookAppointment,
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
            icon: FluentIcons.location_24_regular,
            color: AppColors.secondary,
            filled: true,
            label: l10n.lostAndFound,
            onTap: () => _openPawHubTab(context, ref, 1),
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.heart_24_regular,
            color: AppColors.primary,
            label: l10n.adoptionTitle,
            onTap: () => _openPawHubTab(context, ref, 2),
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.pill_24_regular,
            color: AppColors.accentCoral,
            label: l10n.medicationsReminders,
            onTap: () {},
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.data_trending_24_regular,
            color: AppColors.accentPurple,
            label: l10n.healthTracker,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
