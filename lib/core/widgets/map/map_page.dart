import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../extensions/context_extensions.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import 'map_marker_data.dart';
import 'map_view.dart';

/// Tag shared between an inline map preview and the full-screen page so
/// the Hero transition animates the map expanding into place.
const String kMapHeroTag = 'shared-map-hero';

/// Arguments passed to [MapPage] via GoRouter `extra`.
///
/// Any feature with a map (Lost & Found, Service Providers, …) builds
/// this with its own markers and opens the shared full-screen page.
class MapPageArgs {
  const MapPageArgs({
    required this.title,
    required this.markers,
    required this.center,
    this.zoom = 13,
    this.heroTag = kMapHeroTag,
  });

  final String title;
  final List<MapMarkerData> markers;
  final LatLng center;
  final double zoom;
  final Object heroTag;
}

/// Shared full-screen map. Opened by any feature with a [MapPageArgs].
class MapPage extends StatelessWidget {
  const MapPage({required this.args, super.key});

  final MapPageArgs args;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: args.heroTag,
                child: MapView(
                  markers: args.markers,
                  center: args.center,
                  zoom: args.zoom,
                ),
              ),
            ),
            // Floating back/title bar over the map.
            PositionedDirectional(
              top: 0,
              start: 0,
              end: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      _CircleButton(
                        icon: context.isRtl
                            ? FluentIcons.arrow_right_24_regular
                            : FluentIcons.arrow_left_24_regular,
                        onTap: () => context.pop(),
                        tooltip: context.l10n.close,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.md),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textPrimary
                                    .withValues(alpha: 0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            args.title,
                            style: AppTextStyles.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

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
