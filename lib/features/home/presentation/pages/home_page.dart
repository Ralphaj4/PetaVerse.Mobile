import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../widgets/appointment_card.dart';
import '../widgets/home_hero_banner.dart';
import '../widgets/pet_stat_card.dart';
import '../widgets/quick_action_button.dart';

/// Home dashboard. The active pet's name is live from the pet gate; the rest
/// is mocked until the health backend is wired.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onBellTap: () {},
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
                    SectionHeader(title: l10n.upcoming, onSeeAll: () {}),
                    const SizedBox(height: AppSpacing.sm),
                    AppointmentCard(
                      monthLabel: 'May',
                      dayLabel: '24',
                      title: 'Vet Check-up',
                      subtitle: '10:30 AM • Dr. Sophia Williams',
                      location: 'Pet Care Center',
                      onTap: () {},
                    ),
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

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.calendar_add_24_regular,
            color: AppColors.primary,
            label: l10n.bookAppointment,
            onTap: () {},
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.location_24_regular,
            color: AppColors.secondary,
            filled: true,
            label: l10n.lostAndFound,
            onTap: () => context.push(AppRoutes.lostAndFound),
          ),
        ),
        Expanded(
          child: QuickActionButton(
            icon: FluentIcons.heart_24_regular,
            color: AppColors.primary,
            label: l10n.adoptionTitle,
            onTap: () => context.push(AppRoutes.adoptionBoard),
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
