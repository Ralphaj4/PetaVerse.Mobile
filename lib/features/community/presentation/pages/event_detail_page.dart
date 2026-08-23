import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/map/map_marker_data.dart';
import '../../../../core/widgets/map/map_view.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/poll_event_entities.dart';
import '../../domain/entities/poll_event_enums.dart';
import '../providers/community_providers.dart';
import '../providers/poll_event_actions_providers.dart';
import '../providers/poll_event_providers.dart';
import 'create_event_page.dart';

/// Route `extra` for the event detail page (go_router can't carry these as
/// path params). Passed by the event card's onTap.
class EventDetailArgs {
  const EventDetailArgs({
    required this.communityId,
    this.canManage = false,
    this.communityName = '',
  });

  final int communityId;
  final bool canManage;
  final String communityName;
}

/// Full-screen event detail: hero date/title, description, location, RSVP
/// controls, and an attendees preview. Reached via the event card.
class EventDetailPage extends ConsumerWidget {
  const EventDetailPage({
    required this.eventId,
    required this.communityId,
    this.canManage = false,
    this.communityName = '',
    super.key,
  });

  final int eventId;
  final int communityId;
  final bool canManage;
  final String communityName;

  Future<void> _rsvp(WidgetRef ref, BuildContext context,
      AttendeeStatus status) async {
    final petId = ref.read(actingPetIdProvider);
    if (petId == null) return;
    final result = await ref
        .read(pollEventActionsProvider)
        .rsvp(eventId: eventId, petId: petId, status: status);
    result.when(
      success: (updated) {
        ref.read(eventDetailProvider(eventId).notifier).set(updated);
        ref.read(communityEventsProvider(communityId).notifier).replace(updated);
        ref.invalidate(eventAttendeesProvider(eventId));
      },
      failure: (f) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(f.localizedMessage(context.l10n)),
          ));
      },
    );
  }

  Future<void> _edit(WidgetRef ref, BuildContext context,
      CommunityEvent event) async {
    final updated = await Navigator.of(context).push<CommunityEvent>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CreateEventPage(
          communityId: communityId,
          communityName: communityName,
          existing: event,
        ),
      ),
    );
    if (updated != null) {
      ref.read(eventDetailProvider(eventId).notifier).set(updated);
      ref.read(communityEventsProvider(communityId).notifier).replace(updated);
    }
  }

  Future<void> _delete(WidgetRef ref, BuildContext context) async {
    final l10n = context.l10n;
    final petId = ref.read(actingPetIdProvider);
    if (petId == null) return;
    final ok = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.eventDeleteTitle,
      message: l10n.eventDeleteMessage,
      confirmLabel: l10n.communityDelete,
      cancelLabel: l10n.communityCancel,
      isDestructive: true,
    );
    if (!ok) return;
    final result = await ref
        .read(pollEventRepositoryProvider)
        .deleteEvent(eventId: eventId, actingPetId: petId);
    if (!context.mounted) return;
    result.when(
      success: (_) {
        ref.read(communityEventsProvider(communityId).notifier).remove(eventId);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.eventDeletedToast)));
        if (context.canPop()) context.pop();
      },
      failure: (f) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(f.localizedMessage(l10n)),
        )),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
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
        actions: [
          if (canManage)
            PopupMenuButton<String>(
              tooltip: l10n.pawhubMoreOptions,
              icon: const Icon(FluentIcons.more_horizontal_24_regular),
              onSelected: (v) {
                final event = async.value;
                if (event == null) return;
                if (v == 'edit') _edit(ref, context, event);
                if (v == 'delete') _delete(ref, context);
              },
              itemBuilder: (_) => [
                PopupMenuItem(value: 'edit', child: Text(l10n.eventEdit)),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(l10n.communityDelete,
                      style: const TextStyle(color: AppColors.error)),
                ),
              ],
            ),
        ],
      ),
      body: async.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : null,
          onRetry: () => ref.read(eventDetailProvider(eventId).notifier).refresh(),
        ),
        data: (event) => _body(context, ref, event),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, CommunityEvent event) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final isMember = ref.watch(actingPetProvider) != null;
    final start = event.startsAt.toLocal();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Hero date banner.
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: AppRadius.lgAll,
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    DateFormat.MMM(locale).format(start).toUpperCase(),
                    style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(DateFormat.d(locale).format(start),
                      style: AppTextStyles.headlineMedium
                          .copyWith(color: AppColors.primaryDark, height: 1)),
                ],
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat.yMMMMEEEEd(locale).add_jm().format(start),
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Creator.
        Row(
          children: [
            AppAvatar(
              name: event.creator.name,
              imageUrl: event.creator.avatarUrl,
              radius: 16,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(l10n.communityLedBy(event.creator.name),
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.textSecondary)),
          ],
        ),
        if ((event.location?.displayName ?? '').isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _InfoTile(
            icon: FluentIcons.location_24_regular,
            text: event.location!.displayName,
          ),
        ],
        if (event.location?.hasCoordinates ?? false) ...[
          const SizedBox(height: AppSpacing.md),
          _LocationMap(
            point: LatLng(event.location!.lat!, event.location!.lng!),
            label: event.location!.displayName,
          ),
        ],
        if ((event.description ?? '').isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(event.description!, style: AppTextStyles.bodyMedium),
        ],
        const SizedBox(height: AppSpacing.lg),
        // RSVP.
        if (isMember && !event.isPast) ...[
          Text(l10n.eventGoing, style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _RsvpChip(
                  label: l10n.eventGoing,
                  icon: FluentIcons.checkmark_circle_24_filled,
                  color: AppColors.success,
                  selected: event.myStatus == AttendeeStatus.attending,
                  onTap: () => _rsvp(ref, context, AttendeeStatus.attending),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _RsvpChip(
                  label: l10n.eventInterested,
                  icon: FluentIcons.star_24_filled,
                  color: AppColors.secondary,
                  selected: event.myStatus == AttendeeStatus.interested,
                  onTap: () => _rsvp(ref, context, AttendeeStatus.interested),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _RsvpChip(
                  label: l10n.eventCantGo,
                  icon: FluentIcons.dismiss_circle_24_filled,
                  color: AppColors.textTertiary,
                  selected: event.myStatus == AttendeeStatus.declined,
                  onTap: () => _rsvp(ref, context, AttendeeStatus.declined),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        // Attendees summary + link.
        InkWell(
          onTap: () => context.push(
            '/community/events/$eventId/attendees',
          ),
          borderRadius: AppRadius.mdAll,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.mdAll,
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                const Icon(FluentIcons.people_24_regular,
                    color: AppColors.secondary),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.eventAttendingCount(event.attendingCount),
                          style: AppTextStyles.bodyMedium),
                      if (event.interestedCount > 0)
                        Text(l10n.eventInterestedCount(event.interestedCount),
                            style: AppTextStyles.labelSmall
                                .copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Text(l10n.eventViewAttendees,
                    style: AppTextStyles.labelMedium
                        .copyWith(color: AppColors.secondary)),
                const Icon(FluentIcons.chevron_right_24_regular,
                    size: 18, color: AppColors.textTertiary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(text,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary)),
        ),
      ],
    );
  }
}

/// A non-interactive map preview of the event's location with a pin. Tapping it
/// opens a full-screen interactive map centered on the point.
class _LocationMap extends StatelessWidget {
  const _LocationMap({required this.point, required this.label});

  final LatLng point;
  final String label;

  List<MapMarkerData> get _markers => [
        MapMarkerData(
          id: 'event',
          point: point,
          color: AppColors.primary,
          icon: FluentIcons.location_24_filled,
          label: label,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: AppRadius.lgAll,
          child: SizedBox(
            height: 160,
            child: Stack(
              children: [
                // A fixed preview: no gestures, no my-location dot/recenter —
                // just the pin. Tap the overlay to open the full-screen map.
                Positioned.fill(
                  child: MapView(
                    center: point,
                    zoom: 15,
                    markers: _markers,
                    interactive: false,
                    showMyLocation: false,
                    showRecenterButton: false,
                    cluster: false,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: Semantics(
                      button: true,
                      label: context.l10n.pawhubExpandMap,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => _FullScreenEventMap(
                              point: point,
                              label: label,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // "Expand" affordance.
                const PositionedDirectional(
                  end: AppSpacing.sm,
                  bottom: AppSpacing.sm,
                  child: _MapExpandBadge(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _DirectionsButton(point: point, label: label),
      ],
    );
  }
}

/// Opens the platform maps app with turn-by-turn directions to [point]. Uses a
/// geo: URI (Android) first, falling back to the Google Maps directions URL
/// (iOS / browsers). Mirrors the service-providers directions launcher.
Future<void> _openDirections(
  BuildContext context,
  LatLng point,
  String label,
) async {
  final lat = point.latitude;
  final lng = point.longitude;
  final encodedLabel = Uri.encodeComponent(label.isEmpty ? 'Event' : label);
  var launched = false;
  try {
    final geo = Uri.parse('geo:$lat,$lng?q=$lat,$lng($encodedLabel)');
    if (await canLaunchUrl(geo)) {
      launched = await launchUrl(geo);
    }
    if (!launched) {
      launched = await launchUrl(
        Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
        ),
        mode: LaunchMode.externalApplication,
      );
    }
  } catch (_) {
    launched = false;
  }
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.l10n.eventDirectionsFailed)),
      );
  }
}

/// An outlined "Directions" pill that opens the maps app.
class _DirectionsButton extends StatelessWidget {
  const _DirectionsButton({required this.point, required this.label});

  final LatLng point;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondarySoft,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: () => _openDirections(context, point, label),
        borderRadius: AppRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FluentIcons.directions_24_filled,
                  size: 18, color: AppColors.secondaryDark),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.l10n.eventDirections,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.secondaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapExpandBadge extends StatelessWidget {
  const _MapExpandBadge();

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: AppColors.surface,
      shape: CircleBorder(),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Icon(FluentIcons.full_screen_maximize_24_regular,
            size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Full-screen interactive map of the event location.
class _FullScreenEventMap extends StatelessWidget {
  const _FullScreenEventMap({required this.point, required this.label});

  final LatLng point;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MapView(
              center: point,
              zoom: 16,
              markers: [
                MapMarkerData(
                  id: 'event',
                  point: point,
                  color: AppColors.primary,
                  icon: FluentIcons.location_24_filled,
                  label: label,
                ),
              ],
              cluster: false,
            ),
          ),
          // Back button + address label, together in a top bar.
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Material(
                      color: AppColors.surface,
                      shape: const CircleBorder(),
                      elevation: 2,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: context.l10n.pawhubBack,
                        icon: Icon(
                          context.isRtl
                              ? FluentIcons.arrow_right_24_regular
                              : FluentIcons.arrow_left_24_regular,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (label.isNotEmpty) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: AppRadius.mdAll,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textPrimary
                                    .withValues(alpha: 0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(FluentIcons.location_24_filled,
                                  size: 18, color: AppColors.primary),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  label,
                                  style: AppTextStyles.bodyMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Directions button, bottom-start (clear of the recenter button at
          // bottom-end and the shell's center FAB).
          PositionedDirectional(
            start: AppSpacing.lg,
            bottom: AppSpacing.lg,
            child: SafeArea(
              child: Material(
                color: AppColors.secondary,
                borderRadius: AppRadius.lgAll,
                elevation: 3,
                child: InkWell(
                  onTap: () => _openDirections(context, point, label),
                  borderRadius: AppRadius.lgAll,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(FluentIcons.directions_24_filled,
                            size: 20, color: AppColors.onSecondary),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          context.l10n.eventDirections,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.onSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RsvpChip extends StatelessWidget {
  const _RsvpChip({
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
  final VoidCallback onTap;

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
            border:
                Border.all(color: selected ? color : AppColors.divider),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            children: [
              Icon(icon,
                  size: 20,
                  color: selected ? color : AppColors.textSecondary),
              const SizedBox(height: 4),
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: selected ? color : AppColors.textSecondary,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
