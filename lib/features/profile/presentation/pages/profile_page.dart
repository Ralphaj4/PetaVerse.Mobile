import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/app_shell.dart';
import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/session_provider.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../pets/presentation/widgets/pet_card_grid.dart';
import '../providers/user_provider.dart';
import '../widgets/log_out_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

/// Profile tab. Data is mocked until the user/pets backend is wired;
/// the layout and widgets are final.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(userProvider).value;
    final userName = user == null
        ? ''
        : '${user.firstName} ${user.lastName}'.trim();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxl + floatingNavBarClearance(context) / 1.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                name: userName,
                avatarUrl: user?.avatarUrl,
                tierLabel: l10n.premiumMember,
                onBellTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Pet Profiles ─────────────────────────────────────────
              _PetSectionHeader(
                title: l10n.petProfiles,
                actionLabel: l10n.addPet,
                onAdd: () async {
                  await context.push(AppRoutes.createPet);
                  // Reconcile the list after returning — the create provider
                  // invalidates petListProvider on success, but if the
                  // provider was disposed while off-screen we need a fresh
                  // fetch here too.
                  if (context.mounted) {
                    unawaited(ref.read(petListProvider.notifier).refresh());
                  }
                },
              ),
              const SizedBox(height: AppSpacing.md),
              const _PetGrid(),
              const SizedBox(height: AppSpacing.xl),

              // ── Account Settings ─────────────────────────────────────
              _GroupTitle(title: l10n.accountSettings),
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: FluentIcons.person_24_regular,
                iconColor: AppColors.secondary,
                label: l10n.personalInformation,
                onTap: () => context.push(AppRoutes.personalInformation),
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.wallet_24_regular,
                iconColor: AppColors.primary,
                label: l10n.paymentMethods,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Preferences ──────────────────────────────────────────
              _GroupTitle(title: l10n.preferences),
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: FluentIcons.alert_24_regular,
                iconColor: AppColors.secondary,
                label: l10n.notifications,
                statusLabel: l10n.toggleOn,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.local_language_24_regular,
                iconColor: AppColors.primary,
                label: l10n.language,
                onTap: () => context.push(AppRoutes.changeLanguage),
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Security & Privacy ───────────────────────────────────
              _GroupTitle(title: l10n.securityPrivacy),
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: FluentIcons.lock_closed_24_regular,
                iconColor: AppColors.accentPurple,
                label: l10n.changePassword,
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.shield_24_regular,
                iconColor: AppColors.secondary,
                label: l10n.privacySettings,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Support ──────────────────────────────────────────────
              _GroupTitle(title: l10n.support),
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: FluentIcons.question_circle_24_regular,
                iconColor: AppColors.accentPurple,
                label: l10n.helpCenter,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.mail_24_regular,
                iconColor: AppColors.secondary,
                label: l10n.contactUs,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.warning_24_regular,
                iconColor: AppColors.accentCoral,
                label: l10n.reportProblem,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Terms & Privacy ──────────────────────────────────────
              _GroupTitle(title: l10n.termsPrivacy),
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: FluentIcons.document_24_regular,
                iconColor: AppColors.primary,
                label: l10n.privacyPolicy,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.document_bullet_list_24_regular,
                iconColor: AppColors.accentPurple,
                label: l10n.termsConditions,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xxl),

              // ── Log out + version ────────────────────────────────────
              LogOutButton(
                label: l10n.logOut,
                onPressed: () async {
                  final confirmed = await AppConfirmDialog.show(
                    context,
                    icon: FluentIcons.sign_out_24_regular,
                    title: l10n.logOutConfirmTitle,
                    message: l10n.logOutConfirmMessage,
                    confirmLabel: l10n.logOutConfirm,
                    cancelLabel: l10n.cancel,
                    isDestructive: true,
                  );
                  if (!confirmed) return;
                  // Read providers up front (stable ref) before any await.
                  final petsNotifier = ref.read(petsProvider.notifier);
                  final authNotifier = ref.read(authProvider.notifier);
                  final sessionNotifier = ref.read(sessionProvider.notifier);
                  // 1) Flip the session gate FIRST — this is synchronous and
                  // sends the router straight to /login (the auth gate wins
                  // regardless of pet-gate readiness). Clearing pets first
                  // would set pets.ready=false while still logged in, which
                  // bounces the router to the splash and strands it there.
                  sessionNotifier.setLoggedIn(false);
                  // 2) Then AWAIT the destructive local clears so nothing
                  // survives if the app is killed right after logout:
                  //   • tokens + user cache (login isn't skipped next launch),
                  //   • pet cache + gate (no previous user's pets on relaunch).
                  await authNotifier.logout();
                  await petsNotifier.reset();
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: Text(
                  l10n.appVersion('2.4.1', '108'),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PetSectionHeader extends StatelessWidget {
  const _PetSectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAdd,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.titleLarge),
        InkWell(
          onTap: onAdd,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Row(
              children: [
                const Icon(
                  FluentIcons.add_circle_24_regular,
                  size: 18,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  actionLabel,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.titleLarge);
  }
}

/// The user's pets, offline-first via [petListProvider]. Tapping a
/// card makes that pet the active one (live "ACTIVE" badge).
class _PetGrid extends ConsumerWidget {
  const _PetGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsAsync = ref.watch(petListProvider);
    final currentPetId = ref.watch(petsProvider).currentPetId;

    return petsAsync.when(
      skipLoadingOnRefresh: true,
      loading: () => const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => _PetGridError(
        message: (e is Failure ? e : const UnknownFailure())
            .localizedMessage(context.l10n),
        onRetry: () => ref.invalidate(petListProvider),
      ),
      data: (pets) {
        if (pets.isEmpty) return const SizedBox.shrink();
        const preview = 2;
        // Active pet always first in the preview.
        final sorted = currentPetId == null
            ? pets
            : [
                ...pets.where((p) => p.id == currentPetId),
                ...pets.where((p) => p.id != currentPetId),
              ];
        final shown = sorted.length > preview ? sorted.sublist(0, preview) : sorted;
        final hasMore = pets.length > preview;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PetCardGrid(
              pets: shown,
              activePetId: currentPetId,
            ),
            if (hasMore) ...[
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.petList),
                icon: const Icon(FluentIcons.animal_paw_print_24_regular,
                    size: 18),
                label: Text(context.l10n.viewAllPets(pets.length)),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _PetGridError extends StatelessWidget {
  const _PetGridError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
      ),
      child: Column(
        children: [
          Text(
            message,
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(onPressed: onRetry, child: Text(context.l10n.retry)),
        ],
      ),
    );
  }
}

