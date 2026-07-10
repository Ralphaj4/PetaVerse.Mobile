import 'package:latlong2/latlong.dart';

import '../../../../core/errors/result.dart';
import '../../domain/entities/service_provider.dart';
import '../../domain/repositories/service_provider_repository.dart';
import '../datasources/service_provider_mock_datasource.dart';

/// Distance calculator shared with the mock repo (haversine, in meters).
const Distance _distance = Distance();

/// Mock-backed repository. Stamps each provider's distance from [center] and
/// returns them sorted nearest-first. Swapping [_mock] for a remote datasource
/// that hits the ApiClient is the only change needed for the live backend.
class ServiceProviderRepositoryImpl implements ServiceProviderRepository {
  const ServiceProviderRepositoryImpl(this._mock);

  final ServiceProviderMockDataSource _mock;

  @override
  Future<Result<List<ServiceProvider>>> getNearby({
    required LatLng center,
  }) async {
    // Simulate network latency so the shimmer loading state is exercised.
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final withDistance = _mock
        .nearby(center)
        .map(
          (p) => p.copyWithDistance(
            _distance.as(LengthUnit.Meter, center, p.location),
          ),
        )
        .toList()
      ..sort(
        (a, b) => (a.distanceMeters ?? double.infinity)
            .compareTo(b.distanceMeters ?? double.infinity),
      );

    return Result.success(withDistance);
  }
}
