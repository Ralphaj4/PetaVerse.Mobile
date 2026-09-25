import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/provider_search.dart';
import '../../domain/entities/service_provider.dart';
import 'provider_map_pin.dart';

/// Callbacks the map raises for the parent to drive selection / result refresh.
/// The id is the pin's `branchId`.
typedef ProviderTapped = void Function(int branchId);

/// Reports the visible map bounds once the camera settles after a pan, so the
/// parent can refetch providers for the new viewport. Emitted as the pure-Dart
/// [GeoBounds] so the page stays flutter_map-free.
typedef ViewportChanged = void Function(GeoBounds bounds);

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
    this.onFirstViewport,
    this.controllerReady,
    super.key,
  });

  final List<ServiceProvider> providers;
  final LatLng center;

  /// The selected pin's `branchId`, or null.
  final int? selectedId;
  final ProviderTapped onProviderTap;

  /// Tapping empty map area (deselects).
  final VoidCallback onMapTap;

  /// Fires the visible bounds once the camera settles after a pan.
  final ViewportChanged? onCameraIdle;

  /// Fires once, after the very first frame, with the initial viewport bounds so
  /// the first search can run without waiting for a pan.
  final ViewportChanged? onFirstViewport;

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
    // Report the initial viewport once the map is laid out so the first search
    // runs against what's actually on screen (not just the center).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onFirstViewport
          ?.call(_toGeoBounds(_controller.mapController.camera.visibleBounds));
    });
  }

  @override
  void didUpdateWidget(ServiceProviderMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fly to a newly selected pin so it stays visible above the sheet.
    if (widget.selectedId != oldWidget.selectedId &&
        widget.selectedId != null) {
      final target = _providerByBranch(widget.selectedId!);
      if (target != null) {
        final zoom =
            _controller.mapController.camera.zoom.clamp(15.0, 18.0).toDouble();
        _controller.animateTo(dest: target.location, zoom: zoom);
      }
    }
  }

  ServiceProvider? _providerByBranch(int branchId) {
    for (final p in widget.providers) {
      if (p.branchId == branchId) return p;
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

  /// Reports the viewport only on gesture-*end* events, debounced.
  ///
  /// Using [MapOptions.onMapEvent] instead of `onPositionChanged` is deliberate:
  /// `onPositionChanged` fires continuously during a pinch/zoom, and each fire
  /// would refetch → replace the marker set → rebuild the cluster layer while
  /// the camera is still transforming. Doing that repeatedly during a fast
  /// zoom-in-out froze the map (gray screen). Ending events fire once the
  /// gesture settles, and the debounce coalesces a rapid burst into one fetch.
  void _onMapEvent(MapEvent event) {
    if (widget.onCameraIdle == null) return;
    final isEnd = event is MapEventMoveEnd ||
        event is MapEventFlingAnimationEnd ||
        event is MapEventDoubleTapZoomEnd ||
        event is MapEventScrollWheelZoom;
    if (!isEnd) return;

    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      widget.onCameraIdle!(
        _toGeoBounds(_controller.mapController.camera.visibleBounds),
      );
    });
  }

  /// Converts flutter_map's [LatLngBounds] into the pure-Dart [GeoBounds] the
  /// domain/search layer expects.
  GeoBounds _toGeoBounds(LatLngBounds b) => GeoBounds(
        south: b.south,
        west: b.west,
        north: b.north,
        east: b.east,
      );

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
        onMapEvent: _onMapEvent,
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.mapTileUrl,
          // Supply subdomains only when the URL load-balances via `{s}`.
          subdomains: AppConstants.mapTileUrl.contains('{s}')
              ? AppConstants.mapTileSubdomains
              : const [],
          userAgentPackageName: 'com.petaverse.mobile',
          // Retina only when the configured tile URL supports it ({r} → "@2x").
          retinaMode: AppConstants.mapTileUrl.contains('{r}') &&
              RetinaMode.isHighDensity(context),
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
          key: ValueKey(p.branchId),
          point: p.location,
          width: 52,
          height: 60,
          // Anchor the marker tip at the coordinate.
          alignment: Alignment.topCenter,
          child: ProviderMapPin(
            category: p.primaryCategory,
            selected: p.branchId == selectedId,
            onTap: () => widget.onProviderTap(p.branchId),
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
        // Disable the layer's own zoom/spiderfy animations: with results
        // refetching as the camera moves, its animation controller can be
        // interrupted mid-flight, which froze the whole map.
        animationsOptions: const AnimationsOptions(
          zoom: Duration.zero,
          fitBound: Duration.zero,
          spiderfy: Duration.zero,
          centerMarker: Duration.zero,
        ),
        // Zoom in to break a cluster apart on tap (Google-Maps behavior).
        zoomToBoundsOnClick: true,
        builder: (context, clusterMarkers) =>
            ClusterBubble(count: clusterMarkers.length),
      ),
    );
  }
}
