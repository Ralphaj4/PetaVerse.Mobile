import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// What the community FAB can create.
enum CreateChoice { post, poll, event }

/// Shows the "Create" bottom sheet with Post / Poll / Event options and returns
/// the chosen type (null if dismissed). Mirrors the add-media sheet styling.
Future<CreateChoice?> showCreateChoiceSheet(BuildContext context) {
  return showModalBottomSheet<CreateChoice>(
    context: context,
    useRootNavigator: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (ctx) => const _CreateChoiceSheet(),
  );
}

class _CreateChoiceSheet extends StatelessWidget {
  const _CreateChoiceSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.communityCreateSheetTitle,
                style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.communityCreateSheetSubtitle,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.lg),
            _ChoiceTile(
              icon: FluentIcons.image_multiple_24_regular,
              accent: AppColors.primaryDark,
              accentSoft: AppColors.primarySoft,
              title: l10n.composeNewPost,
              subtitle: l10n.composeNewPostSubtitle,
              onTap: () => Navigator.pop(context, CreateChoice.post),
            ),
            const SizedBox(height: AppSpacing.sm),
            _ChoiceTile(
              icon: FluentIcons.poll_24_regular,
              accent: AppColors.secondary,
              accentSoft: AppColors.secondarySoft,
              title: l10n.composeNewPoll,
              subtitle: l10n.composeNewPollSubtitle,
              onTap: () => Navigator.pop(context, CreateChoice.poll),
            ),
            const SizedBox(height: AppSpacing.sm),
            _ChoiceTile(
              icon: FluentIcons.calendar_ltr_24_regular,
              accent: AppColors.primary,
              accentSoft: AppColors.primarySoft,
              title: l10n.composeNewEvent,
              subtitle: l10n.composeNewEventSubtitle,
              onTap: () => Navigator.pop(context, CreateChoice.event),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.icon,
    required this.accent,
    required this.accentSoft,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color accent;
  final Color accentSoft;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accentSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent, size: 24),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleSmall),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: AppTextStyles.labelSmall
                            .copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const Icon(FluentIcons.chevron_right_24_regular,
                  size: 20, color: AppColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
