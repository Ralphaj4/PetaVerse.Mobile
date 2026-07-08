import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/map/map_marker_data.dart';
import '../../../../core/widgets/map/map_page.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../domain/entities/lost_found_dashboard.dart';
import '../../domain/entities/lost_found_report.dart';
import '../models/pet_alert.dart';
import '../providers/lost_found_providers.dart';
import '../widgets/alert_map.dart';
import '../widgets/filter_chip_row.dart';
import '../widgets/pet_alert_card.dart';

class LostAndFoundPage extends ConsumerStatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  ConsumerState<LostAndFoundPage> createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends ConsumerState<LostAndFoundPage> {
  bool _mapExpanded = true;

  /// Optimistic volunteer status after a join/leave, shown immediately while
  /// the (unchanged) dashboard keeps rendering. Cleared when a fresh dashboard
  /// loads (filter change / retry), so authoritative server data wins. Held in
  /// page state so [setState] guarantees the banner re-renders.
  VolunteerInfo? _volunteerOverride;

  // ── Filter mapping (UI AlertFilter ⇄ provider LostFoundFilter) ──────────
  AlertFilter _toUiFilter(LostFoundFilter f) => switch (f) {
        LostFoundFilter.all => AlertFilter.all,
        LostFoundFilter.lost => AlertFilter.lost,
        LostFoundFilter.found => AlertFilter.found,
      };

  LostFoundFilter _toProviderFilter(AlertFilter f) => switch (f) {
        AlertFilter.all => LostFoundFilter.all,
        AlertFilter.lost => LostFoundFilter.lost,
        AlertFilter.found => LostFoundFilter.found,
      };

  /// Markers from the dashboard's lightweight pins (all in-radius reports).
  List<MapMarkerData> _markersFromPins(List<LostFoundMapPin> pins) => pins
      .map(
        (p) => MapMarkerData(
          id: p.id.toString(),
          point: LatLng(p.latitude, p.longitude),
          color:
              p.type == ReportType.lost ? AppColors.error : AppColors.success,
        ),
      )
      .toList();

  LatLng _centerFor(List<LostFoundMapPin> pins) =>
      pins.isNotEmpty
          ? LatLng(pins.first.latitude, pins.first.longitude)
          : kLostFoundFallbackCenter;

  void _openFullMap(LostFoundDashboard dashboard) {
    context.push(
      AppRoutes.map,
      extra: MapPageArgs(
        title: context.l10n.lostAndFound,
        markers: _markersFromPins(dashboard.mapPins),
        center: _centerFor(dashboard.mapPins),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dashboardAsync = ref.watch(lostFoundDashboardProvider);
    final filter = ref.watch(lostFoundFilterProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.lostAndFoundDashboard,
                  style: AppTextStyles.titleMedium),
              Text(
                l10n.lostAndFoundSubtitle(
                  dashboardAsync.value?.activeAlertCount ?? 0,
                ),
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          toolbarHeight: 64,
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
              child: FilledButton.icon(
                onPressed: () => context.push(AppRoutes.reportLostPet),
                icon: const Icon(FluentIcons.add_24_regular, size: 18),
                label: Text(l10n.reportLostPet),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: AppColors.onPrimary,
                  textStyle: AppTextStyles.labelMedium,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: dashboardAsync.when(
          skipLoadingOnRefresh: true,
          loading: () => const _DashboardSkeleton(),
          error: (error, _) => ErrorStateWidget(
            failure: error is Failure ? error : const UnknownFailure(),
            onRetry: () =>
                ref.invalidate(lostFoundDashboardProvider),
          ),
          data: (dashboard) {
            final volunteer = _volunteerOverride ?? dashboard.volunteerInfo;
            return _DashboardBody(
              dashboard: dashboard,
              volunteer: volunteer,
              filter: _toUiFilter(filter),
              mapExpanded: _mapExpanded,
              onToggleMap: () => setState(() => _mapExpanded = !_mapExpanded),
              onFilterChanged: (f) {
                // A filter change refetches the dashboard, whose volunteer
                // status is then authoritative — drop the optimistic override.
                setState(() => _volunteerOverride = null);
                ref
                    .read(lostFoundFilterProvider.notifier)
                    .setFilter(_toProviderFilter(f));
              },
              markers: _markersFromPins(dashboard.mapPins),
              center: _centerFor(dashboard.mapPins),
              onExpandMap: () => _openFullMap(dashboard),
              onBecomeVolunteer: _join,
              onLeaveVolunteer: () => _confirmLeaveVolunteer(volunteer),
              onDeleteReport: (alert) => _confirmDeleteReport(context, alert),
              onViewDetails: _openDetails,
            );
          },
        ),
      ),
    );
  }

  /// Joins the volunteers. On success stores the server-returned status as an
  /// optimistic override and [setState]s so the banner re-renders immediately.
  Future<void> _join() async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final info = await ref.read(volunteerActionsProvider.notifier).join();
    // Use the State's own `mounted` — it survives the await as long as the
    // page is on screen, unlike a transient builder `BuildContext`.
    if (!mounted) return;

    if (info == null) {
      final failure = ref.read(volunteerActionsProvider).error;
      if (failure is Failure) {
        context.showErrorSnackBar(failure.localizedMessage(l10n));
      }
      return;
    }

    setState(() => _volunteerOverride = info);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.becameVolunteer)));
  }

  /// Confirms, then leaves the volunteers. On success stores an optimistic
  /// "not a volunteer" override (count − 1, since the DELETE returns no body)
  /// and [setState]s so the banner re-renders immediately.
  Future<void> _confirmLeaveVolunteer(VolunteerInfo current) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.person_delete_24_regular,
      title: l10n.leaveVolunteerTitle,
      message: l10n.leaveVolunteerMessage,
      confirmLabel: l10n.leaveVolunteerConfirm,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final ok = await ref.read(volunteerActionsProvider.notifier).leave();
    if (!mounted) return;

    if (!ok) {
      final failure = ref.read(volunteerActionsProvider).error;
      if (failure is Failure) {
        context.showErrorSnackBar(failure.localizedMessage(l10n));
      }
      return;
    }

    final nextCount = (current.activeVolunteerCount - 1).clamp(0, 1 << 31);
    setState(() {
      _volunteerOverride =
          VolunteerInfo(isVolunteer: false, activeVolunteerCount: nextCount);
    });
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.leftVolunteer)));
  }

  /// Confirms, then deletes the user's own report. Surfaces the API error on
  /// failure and a success snackbar otherwise; the dashboard refreshes via
  /// [DeleteReport].
  Future<void> _confirmDeleteReport(BuildContext context, PetAlert alert) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.deleteReportTitle,
      message: l10n.deleteReportMessage(alert.petName),
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final ok =
        await ref.read(deleteReportProvider.notifier).delete(alert.reportId);
    if (!context.mounted) return;

    if (!ok) {
      final failure = ref.read(deleteReportProvider.notifier).lastFailure;
      if (failure != null) {
        context.showErrorSnackBar(failure.localizedMessage(l10n));
      }
      return;
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.deleteReportSuccess)));
  }

  /// Opens the report details screen, seeding it with the tapped [alert] (for
  /// the Hero image + instant header) while the full report loads by id.
  void _openDetails(PetAlert alert) {
    context.push(
      AppRoutes.lostFoundDetail.replaceFirst(':id', '${alert.reportId}'),
      extra: alert,
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({
    required this.dashboard,
    required this.volunteer,
    required this.filter,
    required this.mapExpanded,
    required this.onToggleMap,
    required this.onFilterChanged,
    required this.markers,
    required this.center,
    required this.onExpandMap,
    required this.onBecomeVolunteer,
    required this.onLeaveVolunteer,
    required this.onDeleteReport,
    required this.onViewDetails,
  });

  final LostFoundDashboard dashboard;

  /// Effective volunteer status — the optimistic override when present, else
  /// the dashboard's value. Drives the banner's shape.
  final VolunteerInfo volunteer;
  final AlertFilter filter;
  final bool mapExpanded;
  final VoidCallback onToggleMap;
  final ValueChanged<AlertFilter> onFilterChanged;
  final List<MapMarkerData> markers;
  final LatLng center;
  final VoidCallback onBecomeVolunteer;
  final VoidCallback onLeaveVolunteer;
  final VoidCallback onExpandMap;

  /// Deletes an owned report (confirm handled by the caller).
  final ValueChanged<PetAlert> onDeleteReport;

  /// Opens the report details screen.
  final ValueChanged<PetAlert> onViewDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final alerts = dashboard.recentAlerts
        .map((r) => PetAlert.fromReport(r, now: now))
        .toList();

    return CustomScrollView(
      slivers: [
        // ── Map toggle + preview ───────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              0,
            ),
            child: Column(
              children: [
                _MapToggleHeader(
                  label: l10n.liveMapView,
                  expanded: mapExpanded,
                  onToggle: onToggleMap,
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: mapExpanded
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: SizedBox(
                      height: 220,
                      child: AlertMap(
                        markers: markers,
                        center: center,
                        onExpand: onExpandMap,
                      ),
                    ),
                  ),
                  secondChild: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),

        // ── Volunteer affordance — in the header so it's ALWAYS reachable,
        // regardless of how long the alert list grows. State-adaptive:
        // an inviting banner when not a volunteer, a slim status pill once
        // joined.
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
              0,
            ),
            child: _VolunteerBanner(
              isVolunteer: volunteer.isVolunteer,
              activeCount: volunteer.activeVolunteerCount,
              onBecome: onBecomeVolunteer,
              onLeave: onLeaveVolunteer,
            ),
          ),
        ),

        // ── Section header + filter chips ──────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.recentAlerts, style: AppTextStyles.titleLarge),
                FilterChipRow(
                  selected: filter,
                  onChanged: onFilterChanged,
                  allLabel: l10n.filterAll,
                  lostLabel: l10n.filterLost,
                  foundLabel: l10n.filterFound,
                ),
              ],
            ),
          ),
        ),

        // ── Alerts: list or empty state (scrolls beneath the header; any
        // length is fine since the volunteer CTA is no longer below it). ──
        if (alerts.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.xxl + AppSpacing.xl,
              ),
              // A fixed block that sits in the lower area under the header,
              // with the message centered within it.
              child: SizedBox(
                height: 240,
                child: Center(
                  child: _EmptyAlerts(label: l10n.lostAndFoundNoAlerts),
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.xxl + AppSpacing.xl,
            ),
            sliver: SliverList.separated(
              itemCount: alerts.length,
              separatorBuilder: (context, i) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) => PetAlertCard(
                alert: alerts[i],
                onViewDetails: () => onViewDetails(alerts[i]),
                onDelete: () => onDeleteReport(alerts[i]),
              ),
            ),
          ),
      ],
    );
  }
}

/// The volunteer affordance, lifted out of the scrolling list so it's reachable
/// no matter how many alerts there are.
///
/// Not a volunteer → an inviting orange banner with a join button and the live
/// count. Already a volunteer → a slim confirmation pill (no dead button).
class _VolunteerBanner extends StatelessWidget {
  const _VolunteerBanner({
    required this.isVolunteer,
    required this.activeCount,
    required this.onBecome,
    required this.onLeave,
  });

  final bool isVolunteer;
  final int activeCount;
  final VoidCallback onBecome;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (isVolunteer) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.secondarySoft,
          borderRadius: AppRadius.lgAll,
        ),
        child: Row(
          children: [
            // Icon medallion with a green check badge. The badge stays INSIDE
            // the 56px box (no negative offsets / Clip.none) so it can't paint
            // out of bounds inside a sliver.
            SizedBox(
              width: 56,
              height: 56,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        FluentIcons.hand_wave_24_filled,
                        size: 26,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                      ),
                      child: const Icon(
                        FluentIcons.checkmark_24_filled,
                        size: 9,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Text block.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.alreadyVolunteer,
                    style: AppTextStyles.titleSmall
                        .copyWith(color: AppColors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.volunteerThankYou,
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FluentIcons.people_24_filled,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(
                          l10n.activeVolunteers(activeCount),
                          style: AppTextStyles.labelSmall
                              .copyWith(color: AppColors.secondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Leave button — compact, icon over label, so it never forces the
            // row to overflow on narrow screens.
            _LeaveButton(label: l10n.leaveVolunteerAction, onTap: onLeave),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppRadius.smAll,
            ),
            child: const Icon(
              FluentIcons.people_community_24_regular,
              size: 22,
              color: AppColors.onPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.howToHelp, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  l10n.activeVolunteers(activeCount),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          FilledButton(
            onPressed: onBecome,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            ),
            child: Text(
              l10n.becomeVolunteer,
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact outlined-red Leave button (icon over label) sized so it never forces
/// the volunteer row to overflow.
class _LeaveButton extends StatelessWidget {
  const _LeaveButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: StadiumBorder(
        side: BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FluentIcons.sign_out_24_regular,
                  size: 16, color: AppColors.error),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.error,
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

class _EmptyAlerts extends StatelessWidget {
  const _EmptyAlerts({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            FluentIcons.search_24_regular,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            label,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textTertiary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MapToggleHeader extends StatelessWidget {
  const _MapToggleHeader({
    required this.label,
    required this.expanded,
    required this.onToggle,
  });

  final String label;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.map_24_regular,
              size: 16,
              color: AppColors.secondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AnimatedRotation(
              turns: expanded ? 0 : 0.5,
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                FluentIcons.chevron_up_24_regular,
                size: 14,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// First-load skeleton for the dashboard: a map block + a few alert cards,
/// matching the real layout so nothing shifts when data arrives.
class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        children: [
          // Map preview.
          SkeletonBox(
            height: 200,
            borderRadius: AppRadius.lgAll,
          ),
          const SizedBox(height: AppSpacing.lg),
          // Section header line.
          const SkeletonLine(width: 160, height: 16),
          const SizedBox(height: AppSpacing.md),
          // A few alert cards.
          for (var i = 0; i < 3; i++) ...[
            const _AlertCardSkeleton(),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _AlertCardSkeleton extends StatelessWidget {
  const _AlertCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.
          const SkeletonBox(
            height: 160,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppRadius.lg),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLine(width: 140, height: 16),
                const SizedBox(height: AppSpacing.sm),
                const SkeletonLine(width: 200, height: 12),
                const SizedBox(height: AppSpacing.xs),
                const SkeletonLine(width: 120, height: 12),
                const SizedBox(height: AppSpacing.md),
                SkeletonBox(height: 44, borderRadius: AppRadius.smAll),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
