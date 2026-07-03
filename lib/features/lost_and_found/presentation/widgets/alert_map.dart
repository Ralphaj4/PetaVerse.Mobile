import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/map/map_marker_data.dart';
import '../../../../core/widgets/map/map_page.dart';
import '../../../../core/widgets/map/map_view.dart';

/// Inline Lost & Found map preview. Renders the shared [MapView] inside
/// a Hero and overlays an expand button that opens the full-screen map.
class AlertMap extends StatelessWidget {
  const AlertMap({
    required this.markers,
    required this.center,
    required this.onExpand,
    this.heroTag = kMapHeroTag,
    super.key,
  });

  final List<MapMarkerData> markers;
  final LatLng center;
  final VoidCallback onExpand;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: heroTag,
              child: MapView(
                markers: markers,
                center: center,
                // Preview is a tap-to-expand surface, not pannable.
                interactive: false,
              ),
            ),
          ),
          // Tap anywhere on the preview to expand.
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: onExpand),
            ),
          ),
          PositionedDirectional(
            top: 8,
            end: 8,
            child: _ExpandButton(onTap: onExpand),
          ),
        ],
      ),
    );
  }
}

class _ExpandButton extends StatelessWidget {
  const _ExpandButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: Icon(
            FluentIcons.full_screen_maximize_24_regular,
            size: 18,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
