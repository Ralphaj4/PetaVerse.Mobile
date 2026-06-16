import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/map/map_page.dart';
import '../models/pet_alert.dart';
import '../widgets/alert_map.dart';
import '../widgets/filter_chip_row.dart';
import '../widgets/pet_alert_card.dart';
import '../widgets/volunteer_cta_card.dart';

// ── Mock data (replaced by provider once backend exists) ────────────
const LatLng _mapCenter = LatLng(33.8938, 35.5018); // Beirut

final _mockAlerts = [
  const PetAlert(
    id: '1',
    type: AlertType.lost,
    petName: 'Luna',
    breed: 'Beagle',
    description: 'Wearing a pink collar with small daisies. Last seen near the playground.',
    location: 'Sunset District',
    locationLabel: 'Sunset District, Park Ave',
    hoursAgo: 2,
    latLng: LatLng(33.895, 35.502),
  ),
  const PetAlert(
    id: '2',
    type: AlertType.found,
    petName: 'Unknown Golden',
    breed: 'Golden Retriever',
    description: 'Found wandering without a collar. Seems well-cared-for.',
    location: 'Mission District',
    locationLabel: 'Mission District, Near Hamra',
    hoursAgo: 5,
    latLng: LatLng(33.891, 35.499),
  ),
  const PetAlert(
    id: '3',
    type: AlertType.lost,
    petName: 'Oliver',
    breed: 'Domestic Cat',
    description: 'Grey tabby cat, very cautious. Escaped from the balcony. Microchipped.',
    location: 'Mar Elias',
    locationLabel: 'Mar Elias, 2nd St.',
    hoursAgo: 24,
    latLng: LatLng(33.889, 35.505),
  ),
];

class LostAndFoundPage extends StatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  State<LostAndFoundPage> createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  bool _mapExpanded = true;
  AlertFilter _filter = AlertFilter.all;

  List<PetAlert> get _filtered => switch (_filter) {
        AlertFilter.lost => _mockAlerts
            .where((a) => a.type == AlertType.lost)
            .toList(),
        AlertFilter.found => _mockAlerts
            .where((a) => a.type == AlertType.found)
            .toList(),
        AlertFilter.all => _mockAlerts,
      };

  void _openFullMap(BuildContext context) {
    context.push(
      AppRoutes.map,
      extra: MapPageArgs(
        title: context.l10n.lostAndFound,
        markers: AlertMap.markersFor(_mockAlerts),
        center: _mapCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final alerts = _filtered;

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
                l10n.lostAndFoundSubtitle(_mockAlerts.length),
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
                onPressed: () {},
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
        body: CustomScrollView(
          slivers: [
            // ── Map toggle ─────────────────────────────────────────
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
                      expanded: _mapExpanded,
                      onToggle: () =>
                          setState(() => _mapExpanded = !_mapExpanded),
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      crossFadeState: _mapExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: SizedBox(
                          height: 220,
                          child: AlertMap(
                            alerts: _mockAlerts,
                            center: _mapCenter,
                            onExpand: () => _openFullMap(context),
                          ),
                        ),
                      ),
                      secondChild: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            // ── Section header + filter chips ──────────────────────
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
                      selected: _filter,
                      onChanged: (f) => setState(() => _filter = f),
                      allLabel: l10n.filterAll,
                      lostLabel: l10n.filterLost,
                      foundLabel: l10n.filterFound,
                    ),
                  ],
                ),
              ),
            ),

            // ── Alert cards ────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              sliver: SliverList.separated(
                itemCount: alerts.length,
                separatorBuilder: (context, i) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, i) => PetAlertCard(
                  alert: alerts[i],
                  onContactOwner: () {},
                  onViewDetails: () {},
                ),
              ),
            ),

            // ── Volunteer CTA ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xxl + AppSpacing.xl,
                ),
                child: VolunteerCtaCard(
                  title: l10n.howToHelp,
                  body: l10n.howToHelpBody,
                  buttonLabel: l10n.becomeVolunteer,
                  volunteersLabel: l10n.activeVolunteers(1203),
                  onBecome: () {},
                ),
              ),
            ),
          ],
        ),
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
