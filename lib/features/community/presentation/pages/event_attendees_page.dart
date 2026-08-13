import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/entities/poll_event_enums.dart';
import '../providers/poll_event_providers.dart';

/// Lists an event's attendees, grouped into Going / Interested / Declined tabs.
class EventAttendeesPage extends ConsumerWidget {
  const EventAttendeesPage({required this.eventId, super.key});

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(eventAttendeesProvider(eventId));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            tooltip: l10n.pawhubBack,
            icon: Icon(context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular),
            onPressed: () => context.canPop() ? context.pop() : null,
          ),
          title: Text(l10n.eventAttendeesTitle),
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: l10n.eventTabAttending),
              Tab(text: l10n.eventTabInterested),
              Tab(text: l10n.eventTabDeclined),
            ],
          ),
        ),
        body: async.when(
          loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => ErrorStateWidget(
            failure: e is Failure ? e : null,
            onRetry: () => ref.invalidate(eventAttendeesProvider(eventId)),
          ),
          data: (page) => TabBarView(
            children: [
              _AttendeeList(
                attendees: _filter(page, AttendeeStatus.attending),
              ),
              _AttendeeList(
                attendees: _filter(page, AttendeeStatus.interested),
              ),
              _AttendeeList(
                attendees: _filter(page, AttendeeStatus.declined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<EventAttendee> _filter(EventAttendeePage page, AttendeeStatus status) =>
      page.attendees.where((a) => a.status == status).toList(growable: false);
}

class _AttendeeList extends StatelessWidget {
  const _AttendeeList({required this.attendees});

  final List<EventAttendee> attendees;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (attendees.isEmpty) {
      return Center(
        child: Text(l10n.eventNoAttendees,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: attendees.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, i) {
        final a = attendees[i];
        return Row(
          children: [
            AppAvatar(
              name: a.pet.name,
              imageUrl: a.pet.avatarUrl,
              radius: 22,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(a.pet.name, style: AppTextStyles.titleSmall),
                  if (a.pet.breedOrSpecies.isNotEmpty)
                    Text(a.pet.breedOrSpecies,
                        style: AppTextStyles.labelSmall
                            .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
