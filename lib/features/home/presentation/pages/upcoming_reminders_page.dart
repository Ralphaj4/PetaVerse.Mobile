import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../pawcare/presentation/providers/pawcare_providers.dart';
import '../widgets/health_reminder_card.dart';

/// Full list of upcoming health reminders (meds, vaccines, appointments),
/// reachable from the "See all" link on the home screen Upcoming section.
class UpcomingRemindersPage extends ConsumerWidget {
  const UpcomingRemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final remindersAsync = ref.watch(upcomingHealthRemindersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.upcoming),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.popOrHome(),
        ),
      ),
      body: remindersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const SizedBox.shrink(),
        data: (reminders) {
          if (reminders.isEmpty) {
            return _Empty();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: reminders.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) => HealthReminderCard(
              reminder: reminders[i],
              index: i,
            ),
          );
        },
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.checkmark_circle_24_regular,
              size: 56,
              color: AppColors.divider,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.upcomingEmptyTitle,
              style: AppTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.upcomingEmptySubtitle,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
