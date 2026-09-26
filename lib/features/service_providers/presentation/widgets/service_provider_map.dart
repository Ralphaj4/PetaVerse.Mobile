import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cm;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/map/latlng_bridge.dart';
import '../../../../core/widgets/map/map_camera_controller.dart';
import '../../../../core/widgets/map/map_pin_painters.dart';
import '../../../../core/widgets/map/marker_bitmap.dart';
import '../../domain/entities/provider_search.dart';
import '../../domain/entities/service_provider.dart';
import 'provider_map_pin.dart';

/// Callbacks the map raises for the parent to drive selection / result refresh.
/// The id is the pin's `branchId`.
typedef ProviderTapped = void Function(int branchId);

/// Reports the visible map bounds once the camera settles after a pan, so the
/// parent can refetch providers for the new viewport. Emitted as the pure-Dart
/// [GeoBounds] so the page stays map-provider-free.
typedef ViewportChanged = void Function(GeoBounds bounds);

/// Full-bleed interactive Google Map of service providers.
///
/// Purpose-built for the discovery screen (vs the shared preview `MapView`):
/// the parent owns selection, so the map hands up a [MapCameraController] via
/// [controllerReady] and flies to whichever provider is [selectedId]. Pins are
/// category-colored teardrops that grow when selected; overlapping pins cluster
/// into count bubbles. Reports the visible bounds via [onCameraIdle] after the
/// user stops panning so results update to the new viewport.
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

  /// Fires once, after the first frame, with the initial viewport bounds so the
  /// first search can run without waiting for a pan.
  final ViewportChanged? onFirstViewport;

  /// Hands the camera controller to the parent so it can drive recenter /
  /// fly-to from the floating controls.
  final void Function(MapCameraController controller)? controllerReady;

  @override
  State<ServiceProviderMap> createState() => _ServiceProviderMapState();
}

/// Cluster item adapter over a [ServiceProvider] branch.
class _ProviderItem with cm.ClusterItem {
  _ProviderItem(this.provider);

  final ServiceProvider provider;

  @override
  gmaps.LatLng get location => provider.location.toGoogle;
}

class _ServiceProviderMapState extends State<ServiceProviderMap> {
  gmaps.GoogleMapController? _controller;
  late final cm.ClusterManager<_ProviderItem> _clusterManager;

  Set<gmaps.Marker> _markers = {};
  LatLng? _myLocation;
  StreamSubscription<Position>? _positionSub;
  double _devicePixelRatio = 2;

  /// Guards the once-only first-viewport report until the map has laid out.
  bool _firstViewportSent = false;

  @override
  void initState() {
    super.initState();
    _clusterManager = cm.ClusterManager<_ProviderItem>(
      widget.providers.map(_ProviderItem.new),
      _onClustersReady,
      markerBuilder: _clusterMarkerBuilder,
      // Bigger radius groups nearby branches on a dense street.
      stopClusteringZoom: 17,
    );
    _initLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  @override
  void didUpdateWidget(ServiceProviderMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refresh the cluster items when the provider set changes.
    if (!identical(widget.providers, oldWidget.providers)) {
      _clusterManager
          .setItems(widget.providers.map(_ProviderItem.new).toList());
    }
    // Re-render pins when selection changes (selected pin grows), and fly to it.
    if (widget.selectedId != oldWidget.selectedId) {
      _clusterManager.updateMap();
      final id = widget.selectedId;
      if (id != null) {
        final target = _providerByBranch(id);
        if (target != null) _flyTo(target.location);
      }
    }
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  ServiceProvider? _providerByBranch(int branchId) {
    for (final p in widget.providers) {
      if (p.branchId == branchId) return p;
    }
    return null;
  }

  Future<void> _flyTo(LatLng dest) async {
    final controller = _controller;
    if (controller == null) return;
    final zoom = await controller.getZoomLevel();
    await controller.animateCamera(
      gmaps.CameraUpdate.newLatLngZoom(
        dest.toGoogle,
        zoom.clamp(15.0, 18.0),
      ),
    );
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

  void _onMapCreated(gmaps.GoogleMapController controller) {
    _controller = controller;
    _clusterManager.setMapId(controller.mapId);
    widget.controllerReady?.call(MapCameraController(controller));
    // Report the initial viewport once the map is laid out so the first search
    // runs against what's actually on screen (not just the center).
    if (!_firstViewportSent) {
      _firstViewportSent = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _reportViewport(
            widget.onFirstViewport,
          ));
    }
  }

  /// Reports the current visible bounds to [callback] as [GeoBounds]. Google's
  /// [getVisibleRegion] returns the true on-screen rectangle (accounts for the
  /// bottom sheet overlaying part of the map too — it's the full view rect).
  Future<void> _reportViewport(ViewportChanged? callback) async {
    if (callback == null) return;
    final controller = _controller;
    if (controller == null) return;
    final region = await controller.getVisibleRegion();
    if (!mounted) return;
    callback(
      GeoBounds(
        south: region.southwest.latitude,
        west: region.southwest.longitude,
        north: region.northeast.latitude,
        east: region.northeast.longitude,
      ),
    );
  }

  /// Native camera-idle: fires once the camera settles after any gesture. This
  /// replaces the old flutter_map end-event detection + debounce — Google only
  /// fires idle when movement actually stops, so there's no continuous-fire
  /// problem to debounce against.
  void _onCameraIdle() {
    _clusterManager.updateMap();
    _reportViewport(widget.onCameraIdle);
  }

  // ── Cluster rendering ─────────────────────────────────────────────────────
  void _onClustersReady(Set<gmaps.Marker> markers) {
    if (!mounted) return;
    setState(() => _markers = markers);
  }

  Future<gmaps.Marker> _clusterMarkerBuilder(cm.Cluster<_ProviderItem> c) async {
    if (c.isMultiple) {
      final icon = await MarkerBitmap.fromPainter(
        cacheKey: 'sp-cluster-${c.count}-$_devicePixelRatio',
        painter: ClusterBubblePainter(count: c.count),
        size: const Size(46, 46),
        devicePixelRatio: _devicePixelRatio,
      );
      return gmaps.Marker(
        markerId: gmaps.MarkerId(c.getId()),
        position: c.location,
        icon: icon,
        anchor: const Offset(0.5, 0.5),
        onTap: () async {
          final controller = _controller;
          if (controller == null) return;
          final zoom = await controller.getZoomLevel();
          await controller.animateCamera(
            gmaps.CameraUpdate.newLatLngZoom(c.location, zoom + 2),
          );
        },
      );
    }
    return _providerMarker(c.items.single.provider);
  }

  Future<gmaps.Marker> _providerMarker(ServiceProvider p) async {
    final selected = p.branchId == widget.selectedId;
    final icon = await MarkerBitmap.fromPainter(
      cacheKey: 'sp-pin-${p.primaryCategory.name}-$selected-$_devicePixelRatio',
      painter: ProviderPinPainter(
        category: p.primaryCategory,
        selected: selected,
      ),
      size: selected ? const Size(60, 70) : const Size(52, 60),
      devicePixelRatio: _devicePixelRatio,
    );
    return gmaps.Marker(
      markerId: gmaps.MarkerId('branch-${p.branchId}'),
      position: p.location.toGoogle,
      icon: icon,
      // Anchor the tip of the teardrop at the coordinate.
      anchor: const Offset(0.5, 1),
      zIndexInt: selected ? 2 : 1,
      onTap: () => widget.onProviderTap(p.branchId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return gmaps.GoogleMap(
      initialCameraPosition: gmaps.CameraPosition(
        target: widget.center.toGoogle,
        zoom: 14,
      ),
      onMapCreated: _onMapCreated,
      markers: _markers,
      circles: _myLocationCircle(),
      onTap: (_) => widget.onMapTap(),
      onCameraMove: (_) => _clusterManager.onCameraMove,
      onCameraIdle: _onCameraIdle,
      minMaxZoomPreference: const gmaps.MinMaxZoomPreference(3, 18),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      rotateGesturesEnabled: false,
    );
  }

  /// Current-location indicator as native circles (stays glued to the map during
  /// pans; no bitmap needed).
  Set<gmaps.Circle> _myLocationCircle() {
    final here = _myLocation;
    if (here == null) return const {};
    return {
      gmaps.Circle(
        circleId: const gmaps.CircleId('sp-my-location-halo'),
        center: here.toGoogle,
        radius: 34,
        fillColor: AppColors.secondary.withValues(alpha: 0.15),
        strokeColor: AppColors.secondary.withValues(alpha: 0.3),
        strokeWidth: 1,
      ),
      gmaps.Circle(
        circleId: const gmaps.CircleId('sp-my-location-dot'),
        center: here.toGoogle,
        radius: 8,
        fillColor: AppColors.secondary,
        strokeColor: Colors.white,
        strokeWidth: 3,
      ),
    };
  }
}
