import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/map/map_marker_data.dart';
import '../../../../core/widgets/map/map_page.dart';
import '../../../../core/widgets/map/map_view.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../domain/entities/lost_found_report.dart';
import '../models/pet_alert.dart';
import '../providers/lost_found_providers.dart';
import '../widgets/alert_type_badge.dart';
import '../widgets/contact_owner_sheet.dart';

/// Full details for a single lost/found report, fetched by id.
///
/// Opened from a [PetAlertCard]'s "View Details" action. The tapped [alert]
/// (when present) seeds the header + Hero image immediately, while the full
/// report loads by id in the background — so the screen is never blank and the
/// photo animates in via [Hero].
class LostFoundDetailPage extends ConsumerWidget {
  const LostFoundDetailPage({
    required this.reportId,
    this.initialAlert,
    super.key,
  });

  final int reportId;
  final PetAlert? initialAlert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(reportDetailProvider(reportId));

    // Prefer the freshly-loaded report; fall back to the tapped alert's data
    // (or nulls) so the header renders instantly and on error.
    final view = _DetailView.from(async.value, initialAlert);
    final isError = async.hasError && async.value == null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // ── Hero photo header ────────────────────────────────────
                  Hero(
                    tag: lostFoundHeroTag(reportId),
                    child: AppCachedImage(
                      imageUrl: view.imageUrl,
                      height: 300,
                      width: double.infinity,
                      borderRadius: BorderRadius.zero,
                      semanticLabel: view.petName,
                    ),
                  ),
                  // The body follows in the Column, so its negative top margin
                  // makes it overlap AND paint OVER the photo above it.
                  _Body(
                    view: view,
                    isError: isError,
                    // Skeleton only when we have nothing to show yet (no seed).
                    isLoading: async.isLoading &&
                        async.value == null &&
                        initialAlert == null,
                    onRetry: () => ref.invalidate(reportDetailProvider(reportId)),
                    onViewOnMap: () => _viewOnMap(context, view),
                    onContact: () => _contactOwner(context, view),
                  ),
                ],
              ),
            ),

            // Floating back + more buttons over the photo.
            PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CircleIconButton(
                        icon: context.isRtl
                            ? FluentIcons.arrow_right_24_regular
                            : FluentIcons.arrow_left_24_regular,
                        tooltip: context.l10n.close,
                        onTap: () => context.pop(),
                      ),
                      _CircleIconButton(
                        icon: FluentIcons.more_horizontal_24_regular,
                        tooltip: context.l10n.reportProblem,
                        onTap: isError
                            ? null
                            : () => _showMoreActions(context, view),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom sheet of secondary actions (Contact owner, etc.), reached via the
  /// "⋯" button so the main screen stays focused on the report itself.
  Future<void> _showMoreActions(BuildContext context, _DetailView view) async {
    final l10n = context.l10n;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (sheetCtx) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(FluentIcons.person_call_24_regular,
                  color: AppColors.primary),
              title: Text(l10n.contactOwner, style: AppTextStyles.titleSmall),
              onTap: () {
                Navigator.of(sheetCtx).pop();
                _contactOwner(context, view);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _contactOwner(BuildContext context, _DetailView view) async {
    final l10n = context.l10n;
    final phone = view.reporterPhone?.trim();
    if (phone == null || phone.isEmpty) {
      context.showErrorSnackBar(l10n.contactNoPhone);
      return;
    }
    await ContactOwnerSheet.show(
      context,
      petName: view.petName,
      phone: phone,
      onLaunchError: () => context.showErrorSnackBar(l10n.contactLaunchError),
    );
  }

  void _viewOnMap(BuildContext context, _DetailView view) {
    final point = view.latLng;
    if (point == null) return;
    context.push(
      AppRoutes.map,
      extra: MapPageArgs(
        title: view.petName,
        center: point,
        markers: [
          MapMarkerData(
            id: '$reportId',
            point: point,
            color: view.type == AlertType.lost
                ? AppColors.error
                : AppColors.success,
            icon: FluentIcons.location_24_filled,
          ),
        ],
      ),
    );
  }
}



/// Normalized view data: the loaded report where available, else the tapped
/// alert, else nulls. Keeps the widget tree free of null-juggling.
class _DetailView {
  const _DetailView({
    required this.type,
    required this.petName,
    required this.breed,
    required this.description,
    required this.locationLabel,
    required this.hoursAgo,
    required this.imageUrl,
    required this.reward,
    required this.reporterName,
    required this.reporterPhone,
    required this.latLng,
  });

  final AlertType type;
  final String petName;
  final String breed;
  final String description;
  final String locationLabel;
  final int? hoursAgo;
  final String? imageUrl;
  final int? reward;
  final String? reporterName;
  final String? reporterPhone;
  final LatLng? latLng;

  factory _DetailView.from(LostFoundReport? report, PetAlert? alert) {
    if (report != null) {
      return _DetailView(
        type: report.type == ReportType.found
            ? AlertType.found
            : AlertType.lost,
        petName: report.petName,
        breed: report.breedOrSpecies,
        description: report.description,
        locationLabel: report.lastSeenAddress,
        hoursAgo: null,
        imageUrl: report.imageUrl,
        reward: report.reward,
        reporterName: report.reporterName,
        reporterPhone: report.reporterPhone,
        latLng: LatLng(report.latitude, report.longitude),
      );
    }
    return _DetailView(
      type: alert?.type ?? AlertType.lost,
      petName: alert?.petName ?? '',
      breed: alert?.breed ?? '',
      description: alert?.description ?? '',
      locationLabel: alert?.locationLabel ?? '',
      hoursAgo: alert?.hoursAgo,
      imageUrl: alert?.imageUrl,
      reward: alert?.reward,
      reporterName: null,
      reporterPhone: alert?.ownerPhone,
      latLng: alert?.latLng,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.view,
    required this.isError,
    required this.isLoading,
    required this.onRetry,
    required this.onViewOnMap,
    required this.onContact,
  });

  final _DetailView view;
  final bool isError;

  /// True when the report is still loading and there's no seed to show — the
  /// info card + map render as skeletons instead of empty rows.
  final bool isLoading;
  final VoidCallback onRetry;
  final VoidCallback onViewOnMap;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLost = view.type == AlertType.lost;

    return Container(
      // White sheet pulled up over the photo's bottom edge so its rounded top
      // corners overlap the image. In the Column the sheet paints AFTER the
      // photo, so the Transform pull-up lands it over the photo (not under it).
      transform: Matrix4.translationValues(0, -(AppRadius.lg + 4), 0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg + 4)),
      ),
      // Generous side margins; extra top so the badge clears the rounded edge.
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading) ...[
            const Shimmer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 84, height: 26, borderRadius: null),
                  SizedBox(height: AppSpacing.md),
                  SkeletonLine(width: 200, height: 32),
                ],
              ),
            ),
          ] else ...[
            AlertTypeBadge(
              type: view.type,
              label: isLost ? l10n.badgeLost : l10n.badgeFound,
            ),
            const SizedBox(height: AppSpacing.md),

            // Name on the left, breed pill trailing on the right.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    view.petName,
                    style: AppTextStyles.displayLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (view.breed.isNotEmpty) ...[
                  const SizedBox(width: AppSpacing.md),
                  _BreedPill(label: view.breed),
                ],
              ],
            ),
          ],

          const SizedBox(height: AppSpacing.lg),

          // Error banner (data failed and no seed) → retry.
          if (isError)
            _ErrorNotice(message: l10n.errorUnknown, onRetry: onRetry)
          else if (isLoading)
            const _DetailBodySkeleton()
          else ...[
            // Grouped info card: description / address / reporter / reward.
            _InfoCard(
              rows: [
                _InfoRow(
                  icon: FluentIcons.note_24_regular,
                  title: l10n.reportDescription,
                  value: view.description.isEmpty ? '—' : view.description,
                ),
                _InfoRow(
                  icon: FluentIcons.location_24_regular,
                  title: l10n.reportLastSeenAddress,
                  value: view.locationLabel.isEmpty ? '—' : view.locationLabel,
                ),
                if (view.reporterName != null &&
                    view.reporterName!.trim().isNotEmpty)
                  _InfoRow(
                    icon: FluentIcons.person_24_regular,
                    title: l10n.reportReporter,
                    value: view.reporterName!,
                  ),
                if (view.reward != null)
                  _InfoRow(
                    icon: FluentIcons.gift_24_regular,
                    title: l10n.reportRewardLabel,
                    value: '\$${view.reward}',
                  ),
              ],
            ),

            // Mini-map preview.
            if (view.latLng != null) ...[
              const SizedBox(height: AppSpacing.lg),
              _MiniMap(
                view: view,
                onTap: onViewOnMap,
                label: l10n.reportViewOnMap,
              ),
            ],
          ],

          const SizedBox(height: AppSpacing.xl),

          // Primary action: contact the person who posted the report.
          if (!isError && !isLoading)
            AppButton(
              label: l10n.contactOwner,
              icon: FluentIcons.person_call_24_regular,
              variant: AppButtonVariant.secondary,
              onPressed: onContact,
            ),
        ],
      ),
    );
  }
}

/// Circular white icon button used over the photo (back / more).
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        icon: Icon(icon, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Soft orange breed chip with a paw icon.
class _BreedPill extends StatelessWidget {
  const _BreedPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.animal_paw_print_20_filled,
              size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTextStyles.titleSmall.copyWith(color: AppColors.primaryDark),
          ),
        ],
      ),
    );
  }
}

/// White card grouping several [_InfoRow]s separated by dividers.
/// Skeleton for the detail body (info card rows + map) when the report is
/// loading and there's no seed to display.
class _DetailBodySkeleton extends StatelessWidget {
  const _DetailBodySkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xs,
            ),
            child: Column(
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0)
                    const Divider(
                        height: 1, color: AppColors.divider, indent: 52),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Row(
                      children: [
                        SkeletonBox(
                            width: 40, height: 40, shape: BoxShape.circle),
                        SizedBox(width: AppSpacing.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonLine(width: 100, height: 12),
                            SizedBox(height: 6),
                            SkeletonLine(width: 170, height: 13),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SkeletonBox(height: 160, borderRadius: AppRadius.lgAll),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});

  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Soft grey card so it reads against the white sheet behind it.
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, color: AppColors.divider, indent: 52),
            rows[i],
          ],
        ],
      ),
    );
  }
}

/// A single info line: orange icon chip + title + value.
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMap extends StatelessWidget {
  const _MiniMap({
    required this.view,
    required this.onTap,
    required this.label,
  });

  final _DetailView view;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    final center = view.latLng!;
    return ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Positioned.fill(
              child: MapView(
                center: center,
                zoom: 15,
                interactive: false,
                showMyLocation: false,
                showRecenterButton: false,
                cluster: false,
                markers: [
                  MapMarkerData(
                    id: 'detail',
                    point: center,
                    color: view.type == AlertType.lost
                        ? AppColors.error
                        : AppColors.success,
                    icon: FluentIcons.location_24_filled,
                  ),
                ],
              ),
            ),
            // Tap target + label pill (the map itself is non-interactive).
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(onTap: onTap),
              ),
            ),
            PositionedDirectional(
              end: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(FluentIcons.location_24_filled,
                        size: 14, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      label,
                      style: AppTextStyles.labelMedium
                          .copyWith(color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorNotice extends StatelessWidget {
  const _ErrorNotice({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: context.l10n.retry,
          icon: FluentIcons.arrow_clockwise_24_regular,
          variant: AppButtonVariant.outlined,
          expanded: false,
          onPressed: onRetry,
        ),
      ],
    );
  }
}
