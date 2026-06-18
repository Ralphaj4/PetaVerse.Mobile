import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/session_provider.dart';
import '../widgets/log_out_button.dart';
import '../widgets/pet_profile_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

/// Profile tab. Data is mocked until the user/pets backend is wired;
/// the layout and widgets are final.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                name: 'Sarah Mitchell',
                tierLabel: l10n.premiumMember,
                onBellTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Pet Profiles ─────────────────────────────────────────
              _PetSectionHeader(
                title: l10n.petProfiles,
                actionLabel: l10n.addPet,
                onAdd: () {},
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
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.shield_24_regular,
                iconColor: AppColors.accentPurple,
                label: l10n.securityPrivacy,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.wallet_24_regular,
                iconColor: AppColors.primary,
                label: l10n.paymentMethods,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Security ─────────────────────────────────────────────
              _GroupTitle(title: l10n.security),
              const SizedBox(height: AppSpacing.md),
              SettingsTile(
                icon: FluentIcons.lock_closed_24_regular,
                iconColor: AppColors.accentPurple,
                label: l10n.changePassword,
                onTap: () => context.push(AppRoutes.changePassword),
              ),
              const SizedBox(height: AppSpacing.xl),

              // ── Notifications & Support ──────────────────────────────
              _GroupTitle(title: l10n.notificationsSupport),
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
                icon: FluentIcons.question_circle_24_regular,
                iconColor: AppColors.accentPurple,
                label: l10n.helpCenter,
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsTile(
                icon: FluentIcons.document_24_regular,
                iconColor: AppColors.primary,
                label: l10n.privacyPolicy,
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
                  // Flip the session gate FIRST, from this page's stable ref
                  // (not the auto-disposed AuthNotifier, whose ref may be gone
                  // after an await). The router's redirect reacts to the gate
                  // change and sends us to /login, replacing the stack.
                  ref.read(sessionProvider.notifier).setLoggedIn(false);
                  // Best-effort token clear + server revoke; not awaited
                  // (navigation is already driven by the gate flip above).
                  unawaited(ref.read(authProvider.notifier).logout());
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

class _PetGrid extends StatelessWidget {
  const _PetGrid();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PetProfileCard(
            name: 'Oreo',
            breed: 'Golden Retriever',
            ageYears: 2,
            isActive: true,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: PetProfileCard(
            name: 'Luna',
            breed: 'Domestic Shorthair',
            ageYears: 4,
          ),
        ),
      ],
    );
  }
}
