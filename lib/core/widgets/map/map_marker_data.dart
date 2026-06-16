import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../theme/app_colors.dart';

/// Feature-agnostic description of a single map marker.
///
/// Features (Lost & Found, Service Providers, …) map their own domain
/// objects onto this so the shared [MapView]/[MapPage] never need to
/// know about feature-specific types.
class MapMarkerData {
  const MapMarkerData({
    required this.id,
    required this.point,
    this.color = AppColors.primary,
    this.icon,
    this.label,
    this.onTap,
  });

  final String id;
  final LatLng point;

  /// Pin color (e.g. red for lost, green for found).
  final Color color;

  /// Optional glyph rendered inside the pin. When null a solid dot is shown.
  final IconData? icon;

  /// Optional short label used for accessibility / future callouts.
  final String? label;

  final VoidCallback? onTap;
}
