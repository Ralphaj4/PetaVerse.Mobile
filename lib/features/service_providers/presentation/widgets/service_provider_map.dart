import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/service_provider.dart';
import 'provider_map_pin.dart';

/// Callbacks the map raises for the parent to drive selection / result refresh.
typedef ProviderTapped = void Function(String id);

/// Full-bleed interactive map of service providers.
///
/// Purpose-built for the discovery screen (vs the shared preview [MapView]):
/// the parent owns selection, so the map exposes an [AnimatedMapController] via
/// callbacks and flies to whichever provider is [selectedId]. Pins are
/// category-colored teardrops that grow + bounce when selected; overlapping
/// pins cluster into count bubbles. Reports [onCameraIdle] after the user stops
/// panning so results can update to the new viewport.
class ServiceProviderMap extends StatefulWidget {
  const ServiceProviderMap({
    required this.providers,
    required this.center,
    required this.selectedId,
    required this.onProviderTap,
    required this.onMapTap,
    this.onCameraIdle,
    this.controllerReady,
    super.key,
  });

  final List<ServiceProvider> providers;
  final LatLng center;
  final String? selectedId;
  final ProviderTapped onProviderTap;

  /// Tapping empty map area (deselects).
  final VoidCallback onMapTap;

  /// Fires the visible center + radius once the camera settles after a pan.
  final void Function(LatLng center, double zoom)? onCameraIdle;

  /// Hands the animated controller to the parent so it can drive recenter /
  /// fly-to from the floating controls.
  final void Function(AnimatedMapController controller)? controllerReady;

  @override
  State<ServiceProviderMap> createState() => _ServiceProviderMapState();
}

class _ServiceProviderMapState extends State<ServiceProviderMap>
    with TickerProviderStateMixin {
  late final AnimatedMapController _controller =
      AnimatedMapController(vsync: this);

  LatLng? _myLocation;
  StreamSubscription<Position>? _positionSub;
  Timer? _idleTimer;

  @override
  void initState() {
    super.initState();
    widget.controllerReady?.call(_controller);
    _initLocation();
  }

  @override
  void didUpdateWidget(ServiceProviderMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fly to a newly selected provider so it stays visible above the sheet.
    if (widget.selectedId != oldWidget.selectedId &&
        widget.selectedId != null) {
      final target = _providerById(widget.selectedId!);
      if (target != null) {
        final zoom =
            _controller.mapController.camera.zoom.clamp(15.0, 18.0).toDouble();
        _controller.animateTo(dest: target.location, zoom: zoom);
      }
    }
  }

  ServiceProvider? _providerById(String id) {
    for (final p in widget.providers) {
      if (p.id == id) return p;
    }
    return null;
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
    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 15,
      ),
    ).listen((pos) {
      if (!mounted) return;
      setState(() => _myLocation = LatLng(pos.latitude, pos.longitude));
    });
  }

  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    if (!hasGesture || widget.onCameraIdle == null) return;
    // Debounce the idle callback so we only report once panning settles.
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      widget.onCameraIdle!(camera.center, camera.zoom);
    });
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _positionSub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _controller.mapController,
      options: MapOptions(
        initialCenter: widget.center,
        initialZoom: 14,
        minZoom: 3,
        maxZoom: 18,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onTap: (_, _) => widget.onMapTap(),
        onPositionChanged: _onPositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.petaverse.mobile',
          retinaMode: RetinaMode.isHighDensity(context),
        ),
        _buildMarkerLayer(),
        if (_myLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _myLocation!,
                width: 26,
                height: 26,
                child: const MyLocationDot(),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMarkerLayer() {
    final selectedId = widget.selectedId;
    final markers = [
      for (final p in widget.providers)
        Marker(
          key: ValueKey(p.id),
          point: p.location,
          width: 52,
          height: 60,
          // Anchor the marker tip at the coordinate.
          alignment: Alignment.topCenter,
          child: ProviderMapPin(
            category: p.category,
            selected: p.id == selectedId,
            onTap: () => widget.onProviderTap(p.id),
          ),
        ),
    ];

    if (markers.length < 2) return MarkerLayer(markers: markers);

    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        markers: markers,
        maxClusterRadius: 46,
        size: const Size(46, 46),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(50),
        // Zoom in to break a cluster apart on tap (Google-Maps behavior).
        zoomToBoundsOnClick: true,
        builder: (context, clusterMarkers) =>
            ClusterBubble(count: clusterMarkers.length),
      ),
    );
  }
}
