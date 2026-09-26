import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/service_provider_detail.dart';
import '../../domain/repositories/service_provider_repository.dart';
import 'service_providers_providers.dart';

part 'provider_detail_providers.g.dart';

/// Full detail for one provider, stamped with per-branch distance from the
/// user's current location when known.
@riverpod
Future<ServiceProviderDetail> providerDetail(Ref ref, int id) async {
  final here = ref.watch(providerUserLocationProvider);
  final result = await ref.watch(serviceProviderRepositoryProvider).getDetail(
        id,
        userLat: here?.latitude,
        userLng: here?.longitude,
      );
  return result.when(success: (d) => d, failure: (f) => throw f);
}

/// Submits the user's star rating for a provider and refreshes the detail on
/// success. Returns the updated aggregate for optimistic UI, or throws the
/// [Failure] for the caller to surface.
@riverpod
class ProviderRating extends _$ProviderRating {
  @override
  FutureOr<void> build() {}

  Future<ProviderRatingResult> rate(int providerId, int stars) async {
    final result =
        await ref.read(serviceProviderRepositoryProvider).rate(providerId, stars);
    // Check ref.mounted before accessing ref to guard against disposal during
    // the async gap (e.g., if the page was scrolled and rebuilt).
    if (!ref.mounted) {
      return result.when(
        success: (r) => r,
        failure: (f) => throw f,
      );
    }
    return result.when(
      success: (r) {
        ref.invalidate(providerDetailProvider(providerId));
        return r;
      },
      failure: (f) => throw f,
    );
  }
}
