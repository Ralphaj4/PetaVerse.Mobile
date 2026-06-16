import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_marker_data.dart';

/// Reusable flutter_map view that renders [MapMarkerData] pins on
/// CartoDB Voyager tiles (English labels, free, no API key).
///
/// Shared between inline previews and the full-screen [MapPage].
class MapView extends StatelessWidget {
  const MapView({
    required this.markers,
    required this.center,
    this.zoom = 13,
    this.interactive = true,
    this.mapController,
    super.key,
  });

  final List<MapMarkerData> markers;
  final LatLng center;
  final double zoom;

  /// When false the map is fixed (used for small non-interactive previews).
  final bool interactive;

  final MapController? mapController;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: zoom,
        interactionOptions: InteractionOptions(
          flags: interactive ? InteractiveFlag.all : InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.petaverse.mobile',
        ),
        MarkerLayer(
          markers: markers
              .map(
                (m) => Marker(
                  point: m.point,
                  width: 36,
                  height: 36,
                  child: _MapPin(data: m),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.data});

  final MapMarkerData data;

  @override
  Widget build(BuildContext context) {
    final pin = Container(
      decoration: BoxDecoration(
        color: data.color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: data.color.withValues(alpha: 0.4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: data.icon == null
          ? null
          : Icon(data.icon, size: 16, color: Colors.white),
    );

    return Semantics(
      label: data.label,
      button: data.onTap != null,
      child: data.onTap == null
          ? pin
          : GestureDetector(onTap: data.onTap, child: pin),
    );
  }
}
