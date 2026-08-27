import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/notifications/notification_prefs_provider.dart';
import '../../../../core/notifications/notification_prefs_store.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final prefsAsync = ref.watch(notificationPrefsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(l10n.notificationSettings,
            style: AppTextStyles.titleMedium),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.popOrHome(),
        ),
      ),
      body: prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const SizedBox.shrink(),
        data: (_) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: AppSpacing.xl, top: AppSpacing.sm),
              child: Text(
                l10n.notificationSettingsSubtitle,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),

            // ── Health Reminders ────────────────────────────────────────
            _GroupHeader(label: l10n.notifGroupHealth),
            _PrefTile(
              icon: FluentIcons.pill_24_regular,
              iconColor: AppColors.accentCoral,
              title: l10n.notifMedication,
              subtitle: l10n.notifMedicationDesc,
              prefKey: NotifPrefKeys.medication,
            ),
            _PrefTile(
              icon: FluentIcons.syringe_24_regular,
              iconColor: AppColors.secondary,
              title: l10n.notifVaccination,
              subtitle: l10n.notifVaccinationDesc,
              prefKey: NotifPrefKeys.vaccination,
            ),
            _PrefTile(
              icon: FluentIcons.calendar_24_regular,
              iconColor: AppColors.primary,
              title: l10n.notifAppointment,
              subtitle: l10n.notifAppointmentDesc,
              prefKey: NotifPrefKeys.appointment,
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Community ───────────────────────────────────────────────
            _GroupHeader(label: l10n.notifGroupSocial),
            _PrefTile(
              icon: FluentIcons.chat_bubbles_question_24_regular,
              iconColor: AppColors.secondary,
              title: l10n.notifCommunityInteractions,
              subtitle: l10n.notifCommunityInteractionsDesc,
              prefKey: NotifPrefKeys.communityInteractions,
            ),
            _PrefTile(
              icon: FluentIcons.person_add_24_regular,
              iconColor: AppColors.accentPurple,
              title: l10n.notifNewFollower,
              subtitle: l10n.notifNewFollowerDesc,
              prefKey: NotifPrefKeys.newFollower,
            ),
            _PrefTile(
              icon: FluentIcons.mention_24_regular,
              iconColor: AppColors.primary,
              title: l10n.notifMentions,
              subtitle: l10n.notifMentionsDesc,
              prefKey: NotifPrefKeys.mentions,
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Adoption ────────────────────────────────────────────────
            _GroupHeader(label: l10n.notifGroupAdoption),
            _PrefTile(
              icon: FluentIcons.home_heart_24_regular,
              iconColor: AppColors.primary,
              title: l10n.notifAdoption,
              subtitle: l10n.notifAdoptionDesc,
              prefKey: NotifPrefKeys.adoption,
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Co-ownership ────────────────────────────────────────────
            _GroupHeader(label: l10n.notifGroupCoOwnership),
            _PrefTile(
              icon: FluentIcons.people_team_24_regular,
              iconColor: AppColors.secondary,
              title: l10n.notifCoOwnership,
              subtitle: l10n.notifCoOwnershipDesc,
              prefKey: NotifPrefKeys.coOwnership,
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Nearby ──────────────────────────────────────────────────
            _GroupHeader(label: l10n.notifGroupNearby),
            _PrefTile(
              icon: FluentIcons.location_24_regular,
              iconColor: AppColors.accentCoral,
              title: l10n.notifLostPetNearby,
              subtitle: l10n.notifLostPetNearbyDesc,
              prefKey: NotifPrefKeys.lostPetNearby,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        label,
        style: AppTextStyles.titleSmall
            .copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}

/// A toggleable preference row.
class _PrefTile extends ConsumerWidget {
  const _PrefTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.prefKey,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String prefKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(
      notificationPrefsProvider.select(
        (async) => async.value?[prefKey] ?? true,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: AppRadius.smAll,
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Switch(
                value: enabled,
                activeThumbColor: AppColors.primary,
                onChanged: (value) => ref
                    .read(notificationPrefsProvider.notifier)
                    .toggle(prefKey, enabled: value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

