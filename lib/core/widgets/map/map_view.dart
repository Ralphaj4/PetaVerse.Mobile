import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../theme/app_colors.dart';
import 'map_marker_data.dart';

/// Reusable flutter_map view that renders [MapMarkerData] pins on CartoDB
/// Voyager tiles (English labels, free, no API key).
///
/// Aims for a Google-Maps-like feel: retina tiles, marker clustering, a
/// current-location blue dot with a recenter button, and smooth animated
/// camera moves. Shared between inline previews and the full-screen [MapPage].
class MapView extends StatefulWidget {
  const MapView({
    required this.markers,
    required this.center,
    this.zoom = 13,
    this.interactive = true,
    this.mapController,
    this.showMyLocation = true,
    this.showRecenterButton = true,
    this.cluster = true,
    this.onTap,
    super.key,
  });

  final List<MapMarkerData> markers;
  final LatLng center;
  final double zoom;

  /// When false the map is fixed (used for small non-interactive previews).
  final bool interactive;

  /// Optional externally-supplied controller. When provided, the view does NOT
  /// animate it (the owner drives it); otherwise the view manages its own
  /// animated controller.
  final MapController? mapController;

  /// Show the current-location blue dot and request location permission.
  final bool showMyLocation;

  /// Show the floating "recenter on me" button.
  final bool showRecenterButton;

  /// Collapse overlapping pins into count bubbles that expand on zoom.
  final bool cluster;

  /// Called with the tapped coordinate when the user taps the map. Used by the
  /// location picker to drop/move a pin.
  final void Function(LatLng point)? onTap;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  /// Animated controller used when the caller doesn't supply its own.
  AnimatedMapController? _animatedController;

  /// Resolved controller actually passed to [FlutterMap].
  late MapController _controller;

  LatLng? _myLocation;
  StreamSubscription<Position>? _positionSub;

  bool get _interactive => widget.interactive;

  @override
  void initState() {
    super.initState();
    if (widget.mapController != null) {
      _controller = widget.mapController!;
    } else {
      _animatedController = AnimatedMapController(vsync: this);
      _controller = _animatedController!.mapController;
    }
    if (widget.showMyLocation && _interactive) {
      _initLocation();
    }
  }

  @override
  void didUpdateWidget(MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Treat [center] as a live "move here" prop: when it changes (e.g. the
    // caller dropped a pin), recenter the camera. flutter_map's initialCenter
    // only applies on first build, so without this the map wouldn't follow.
    if (widget.center != oldWidget.center) {
      _moveTo(widget.center, _controller.camera.zoom);
    }
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _animatedController?.dispose();
    super.dispose();
  }

  Future<void> _initLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    // Live updates so the blue dot tracks the user.
    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      if (!mounted) return;
      setState(() => _myLocation = LatLng(pos.latitude, pos.longitude));
    });
  }

  /// Flies the camera to the user's location (or just centers if not animated).
  Future<void> _recenter() async {
    final target = _myLocation;
    if (target == null) {
      // No fix yet — try a one-shot read.
      try {
        final pos = await Geolocator.getCurrentPosition();
        if (!mounted) return;
        final here = LatLng(pos.latitude, pos.longitude);
        setState(() => _myLocation = here);
        _moveTo(here, 15);
      } catch (_) {
        // Location unavailable — nothing to recenter on.
      }
      return;
    }
    _moveTo(target, 15);
  }

  void _moveTo(LatLng target, double zoom) {
    final animated = _animatedController;
    if (animated != null) {
      animated.animateTo(dest: target, zoom: zoom);
    } else {
      _controller.move(target, zoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _controller,
          options: MapOptions(
            initialCenter: widget.center,
            initialZoom: widget.zoom,
            interactionOptions: InteractionOptions(
              flags: _interactive ? InteractiveFlag.all : InteractiveFlag.none,
            ),
            onTap: widget.onTap == null
                ? null
                : (_, point) => widget.onTap!(point),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
              subdomains: const ['a', 'b', 'c', 'd'],
              userAgentPackageName: 'com.petaverse.mobile',
              // Crisper tiles on high-DPI screens ({r} → "@2x").
              retinaMode: RetinaMode.isHighDensity(context),
            ),
            _buildMarkerLayer(),
            if (widget.showMyLocation && _myLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _myLocation!,
                    width: 24,
                    height: 24,
                    child: const _MyLocationDot(),
                  ),
                ],
              ),
          ],
        ),
        if (_interactive && widget.showRecenterButton)
          PositionedDirectional(
            end: 16,
            bottom: 16,
            child: SafeArea(
              child: _RecenterButton(onTap: _recenter),
            ),
          ),
      ],
    );
  }

  Widget _buildMarkerLayer() {
    final markers = widget.markers
        .map(
          (m) => Marker(
            point: m.point,
            width: 36,
            height: 36,
            child: _MapPin(data: m),
          ),
        )
        .toList();

    if (!widget.cluster || markers.length < 2) {
      return MarkerLayer(markers: markers);
    }

    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        markers: markers,
        maxClusterRadius: 48,
        size: const Size(40, 40),
        padding: const EdgeInsets.all(50),
        builder: (context, clusterMarkers) => _ClusterBubble(
          count: clusterMarkers.length,
        ),
      ),
    );
  }
}

/// Count bubble shown in place of overlapping pins.
class _ClusterBubble extends StatelessWidget {
  const _ClusterBubble({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

/// Pulsing blue dot marking the user's current location.
class _MyLocationDot extends StatelessWidget {
  const _MyLocationDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.5),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating recenter-on-me button.
class _RecenterButton extends StatelessWidget {
  const _RecenterButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 48,
          height: 48,
          child: Icon(
            FluentIcons.my_location_24_regular,
            color: AppColors.secondary,
          ),
        ),
      ),
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
