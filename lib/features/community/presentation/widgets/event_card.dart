import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/entities/poll_event_enums.dart';
import '../providers/community_providers.dart';
import '../providers/poll_event_actions_providers.dart';
import '../providers/poll_event_providers.dart';

/// An inline community event card. Shows a date chip, title, location, RSVP
/// counts, and — for members — Going / Interested / Can't-go buttons. Tapping
/// the body opens the event detail page. Non-members see a "Join to RSVP" hint.
class EventCard extends ConsumerStatefulWidget {
  const EventCard({
    required this.event,
    required this.communityId,
    required this.canManage,
    required this.isMember,
    this.onTap,
    this.onDelete,
    super.key,
  });

  final CommunityEvent event;
  final int communityId;

  /// Whether the acting pet can edit/delete (creator or community lead).
  final bool canManage;

  /// Whether the acting pet is a member (may RSVP). Non-members see a
  /// "Join to RSVP" hint.
  final bool isMember;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  ConsumerState<EventCard> createState() => _EventCardState();
}

class _EventCardState extends ConsumerState<EventCard> {
  bool _busy = false;

  CommunityEvent get _event => widget.event;

  Future<void> _rsvp(AttendeeStatus status) async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null || _busy) return;

    setState(() => _busy = true);
    final result = await ref.read(pollEventActionsProvider).rsvp(
          eventId: _event.id,
          petId: petId,
          status: status,
        );
    if (!mounted) return;
    setState(() => _busy = false);

    result.when(
      success: (updated) => ref
          .read(communityEventsProvider(widget.communityId).notifier)
          .replace(updated),
      failure: (f) => _snack(f.localizedMessage(l10n)),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final isMember = widget.isMember;

    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: AppRadius.lgAll,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.lgAll,
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: creator + event badge + overflow.
              Row(
                children: [
                  AppAvatar(
                    name: _event.creator.name,
                    imageUrl: _event.creator.avatarUrl,
                    radius: 18,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_event.creator.name,
                            style: AppTextStyles.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(
                          _event.isPast ? l10n.eventPast : l10n.eventBadge,
                          style: AppTextStyles.labelSmall
                              .copyWith(color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                  ),
                  const _TypeBadge(
                    icon: FluentIcons.calendar_ltr_24_filled,
                    color: AppColors.primary,
                  ),
                  if (widget.canManage)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: context.l10n.pawhubMoreOptions,
                      icon: const Icon(FluentIcons.more_horizontal_24_regular,
                          size: 20, color: AppColors.textTertiary),
                      onPressed: widget.onDelete,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Date chip + title/location.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DateChip(date: _event.startsAt),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_event.title,
                            style: AppTextStyles.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        _InfoRow(
                          icon: FluentIcons.clock_24_regular,
                          text: DateFormat.jm(locale).format(
                            _event.startsAt.toLocal(),
                          ),
                        ),
                        if ((_event.location?.displayName ?? '').isNotEmpty)
                          _InfoRow(
                            icon: FluentIcons.location_24_regular,
                            text: _event.location!.displayName,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if ((_event.description ?? '').isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(_event.description!,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
              ],
              const SizedBox(height: AppSpacing.md),
              // Attendance summary.
              Row(
                children: [
                  const Icon(FluentIcons.people_24_regular,
                      size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    l10n.eventAttendingCount(_event.attendingCount),
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  if (_event.interestedCount > 0) ...[
                    Text(' · ',
                        style: AppTextStyles.labelMedium
                            .copyWith(color: AppColors.textTertiary)),
                    Text(
                      l10n.eventInterestedCount(_event.interestedCount),
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // RSVP row (members) or join hint (visitors).
              if (isMember && !_event.isPast)
                _RsvpRow(
                  current: _event.myStatus,
                  busy: _busy,
                  onSelect: _rsvp,
                )
              else if (!isMember)
                Text(l10n.eventJoinToRsvp,
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.textTertiary)),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Going / Interested / Can't-go segmented control.
class _RsvpRow extends StatelessWidget {
  const _RsvpRow({
    required this.current,
    required this.busy,
    required this.onSelect,
  });

  final AttendeeStatus? current;
  final bool busy;
  final ValueChanged<AttendeeStatus> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: _RsvpButton(
            label: l10n.eventGoing,
            icon: FluentIcons.checkmark_circle_24_filled,
            color: AppColors.success,
            selected: current == AttendeeStatus.attending,
            onTap: busy ? null : () => onSelect(AttendeeStatus.attending),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _RsvpButton(
            label: l10n.eventInterested,
            icon: FluentIcons.star_24_filled,
            color: AppColors.secondary,
            selected: current == AttendeeStatus.interested,
            onTap: busy ? null : () => onSelect(AttendeeStatus.interested),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _RsvpButton(
            label: l10n.eventCantGo,
            icon: FluentIcons.dismiss_circle_24_filled,
            color: AppColors.textTertiary,
            selected: current == AttendeeStatus.declined,
            onTap: busy ? null : () => onSelect(AttendeeStatus.declined),
          ),
        ),
      ],
    );
  }
}

class _RsvpButton extends StatelessWidget {
  const _RsvpButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withValues(alpha: 0.12) : Colors.transparent,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdAll,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdAll,
            border: Border.all(
              color: selected ? color : AppColors.divider,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 18,
                  color: selected ? color : AppColors.textSecondary),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelSmall.copyWith(
                  color: selected ? color : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A compact stacked month/day date chip.
class _DateChip extends StatelessWidget {
  const _DateChip({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final local = date.toLocal();
    return Container(
      width: 52,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.mdAll,
      ),
      child: Column(
        children: [
          Text(
            DateFormat.MMM(locale).format(local).toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            DateFormat.d(locale).format(local),
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primaryDark,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(text,
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

/// A small circular badge marking the card type.
class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}
