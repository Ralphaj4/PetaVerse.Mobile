import 'package:latlong2/latlong.dart';

import '../../../../core/errors/result.dart';
import '../entities/service_provider.dart';

/// Contract for fetching nearby pet businesses.
///
/// Backed by a mock datasource today; the same interface will front the real
/// API once it lands (Screen → Provider → Repository → DataSource → ApiClient),
/// so no presentation code changes when the backend is wired in.
abstract interface class ServiceProviderRepository {
  /// Providers near [center], with [distanceMeters] stamped relative to it and
  /// sorted nearest-first. [center] is the user's location (or a fallback).
  Future<Result<List<ServiceProvider>>> getNearby({required LatLng center});
}
