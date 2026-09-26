import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cm;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart';

import '../../theme/app_colors.dart';
import 'latlng_bridge.dart';
import 'map_marker_data.dart';
import 'map_pin_painters.dart';
import 'marker_bitmap.dart';

/// Reusable Google Maps view that renders [MapMarkerData] pins.
///
/// Provider-agnostic on the outside: callers pass the app's latlong2 [LatLng]
/// and feature-neutral [MapMarkerData]; this widget bridges to google_maps.
/// Keeps a Google-Maps feel with marker clustering, a current-location dot with
/// a recenter button, and smooth animated camera moves. Shared between inline
/// previews and the full-screen [MapPage].
class MapView extends StatefulWidget {
  const MapView({
    required this.markers,
    required this.center,
    this.zoom = 13,
    this.interactive = true,
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

  /// Show the current-location dot and request location permission.
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

/// Cluster item adapter: wraps a [MapMarkerData] so the cluster manager can
/// group by location.
class _MarkerItem with cm.ClusterItem {
  _MarkerItem(this.data);

  final MapMarkerData data;

  @override
  gmaps.LatLng get location => data.point.toGoogle;
}

class _MapViewState extends State<MapView> {
  gmaps.GoogleMapController? _controller;
  cm.ClusterManager<_MarkerItem>? _clusterManager;

  Set<gmaps.Marker> _markers = {};
  LatLng? _myLocation;
  StreamSubscription<Position>? _positionSub;
  double _devicePixelRatio = 2;

  bool get _interactive => widget.interactive;

  @override
  void initState() {
    super.initState();
    if (widget.cluster) {
      _clusterManager = cm.ClusterManager<_MarkerItem>(
        widget.markers.map(_MarkerItem.new),
        _onClustersReady,
        markerBuilder: _clusterMarkerBuilder,
      );
    }
    if (widget.showMyLocation && _interactive) {
      _initLocation();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  @override
  void didUpdateWidget(MapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Treat [center] as a live "move here" prop: recenter when it changes (e.g.
    // the caller dropped a pin) so the camera follows.
    if (widget.center != oldWidget.center) {
      _controller?.animateCamera(
        gmaps.CameraUpdate.newLatLng(widget.center.toGoogle),
      );
    }
    // Rebuild markers when the pin set changes.
    if (!identical(widget.markers, oldWidget.markers)) {
      if (_clusterManager != null) {
        _clusterManager!.setItems(widget.markers.map(_MarkerItem.new).toList());
      } else {
        _rebuildFlatMarkers();
      }
    }
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _controller?.dispose();
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

    // Live updates so the location dot tracks the user.
    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      if (!mounted) return;
      setState(() => _myLocation = LatLng(pos.latitude, pos.longitude));
      _refreshMarkers();
    });
  }

  Future<void> _recenter() async {
    final target = _myLocation;
    if (target == null) {
      try {
        final pos = await Geolocator.getCurrentPosition();
        if (!mounted) return;
        final here = LatLng(pos.latitude, pos.longitude);
        setState(() => _myLocation = here);
        _refreshMarkers();
        unawaited(_controller?.animateCamera(
          gmaps.CameraUpdate.newLatLngZoom(here.toGoogle, 15),
        ));
      } catch (_) {
        // Location unavailable — nothing to recenter on.
      }
      return;
    }
    unawaited(_controller?.animateCamera(
      gmaps.CameraUpdate.newLatLngZoom(target.toGoogle, 15),
    ));
  }

  void _onMapCreated(gmaps.GoogleMapController controller) {
    _controller = controller;
    _clusterManager?.setMapId(controller.mapId);
    if (_clusterManager == null) _rebuildFlatMarkers();
  }

  // ── Clustering ──────────────────────────────────────────────────────────
  void _onClustersReady(Set<gmaps.Marker> markers) {
    if (!mounted) return;
    setState(() => _markers = markers);
  }

  Future<gmaps.Marker> _clusterMarkerBuilder(cm.Cluster<_MarkerItem> c) async {
    if (c.isMultiple) {
      final icon = await MarkerBitmap.fromPainter(
        cacheKey: 'cluster-${c.count}-$_devicePixelRatio',
        painter: ClusterBubblePainter(count: c.count),
        size: const Size(40, 40),
        devicePixelRatio: _devicePixelRatio,
      );
      return gmaps.Marker(
        markerId: gmaps.MarkerId(c.getId()),
        position: c.location,
        icon: icon,
        anchor: const Offset(0.5, 0.5),
        onTap: () => _controller?.animateCamera(
          gmaps.CameraUpdate.newLatLngZoom(
            c.location,
            _zoomForCluster(),
          ),
        ),
      );
    }
    return _flatMarker(c.items.single.data);
  }

  double _zoomForCluster() => 15; // Zoom in to break clusters apart on tap.

  // ── Flat (unclustered) markers ──────────────────────────────────────────
  Future<void> _rebuildFlatMarkers() async {
    final built = <gmaps.Marker>{};
    for (final data in widget.markers) {
      built.add(await _flatMarker(data));
    }
    if (!mounted) return;
    setState(() => _markers = built);
  }

  Future<gmaps.Marker> _flatMarker(MapMarkerData data) async {
    final icon = await MarkerBitmap.fromPainter(
      cacheKey: 'pin-${data.color.toARGB32()}-${data.icon?.codePoint}'
          '-$_devicePixelRatio',
      painter: CircledPinPainter(color: data.color, icon: data.icon),
      size: const Size(36, 36),
      devicePixelRatio: _devicePixelRatio,
    );
    return gmaps.Marker(
      markerId: gmaps.MarkerId(data.id),
      position: data.point.toGoogle,
      icon: icon,
      anchor: const Offset(0.5, 0.5),
      onTap: data.onTap,
      infoWindow: data.label == null
          ? gmaps.InfoWindow.noText
          : gmaps.InfoWindow(title: data.label),
    );
  }

  /// Re-derives markers after the location dot moves (cluster path repaints via
  /// the manager; flat path rebuilds directly).
  void _refreshMarkers() {
    if (_clusterManager != null) {
      _clusterManager!.updateMap();
    } else {
      _rebuildFlatMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    // The current-location dot is layered as a Flutter overlay via a marker;
    // simplest is to add it to the marker set when known.
    final allMarkers = {..._markers};

    return Stack(
      children: [
        gmaps.GoogleMap(
          initialCameraPosition: gmaps.CameraPosition(
            target: widget.center.toGoogle,
            zoom: widget.zoom,
          ),
          onMapCreated: _onMapCreated,
          markers: allMarkers,
          circles: _myLocationCircle(),
          onTap: widget.onTap == null
              ? null
              : (pos) => widget.onTap!(pos.toLatLng2),
          onCameraMove: _clusterManager == null
              ? null
              : (_) => _clusterManager!.onCameraMove,
          onCameraIdle: _clusterManager?.updateMap,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
          rotateGesturesEnabled: _interactive,
          scrollGesturesEnabled: _interactive,
          zoomGesturesEnabled: _interactive,
          tiltGesturesEnabled: _interactive,
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

  /// The current-location indicator, drawn as native circles so it never
  /// desyncs from the map during pans (no bitmap needed).
  Set<gmaps.Circle> _myLocationCircle() {
    final here = _myLocation;
    if (!widget.showMyLocation || here == null) return const {};
    return {
      gmaps.Circle(
        circleId: const gmaps.CircleId('my-location-halo'),
        center: here.toGoogle,
        radius: 30,
        fillColor: AppColors.secondary.withValues(alpha: 0.15),
        strokeColor: AppColors.secondary.withValues(alpha: 0.3),
        strokeWidth: 1,
      ),
      gmaps.Circle(
        circleId: const gmaps.CircleId('my-location-dot'),
        center: here.toGoogle,
        radius: 8,
        fillColor: AppColors.secondary,
        strokeColor: Colors.white,
        strokeWidth: 2,
      ),
    };
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
