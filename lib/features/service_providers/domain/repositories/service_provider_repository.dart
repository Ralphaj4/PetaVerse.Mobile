import '../../../../core/errors/result.dart';
import '../entities/provider_category_ref.dart';
import '../entities/provider_search.dart';
import '../entities/service_provider_detail.dart';

/// Contract for the service-providers map feature (bbox search, categories
/// lookup, provider detail, rating). Backed by a remote datasource on the
/// ApiClient (Screen → Provider → Repository → DataSource → ApiClient).
abstract interface class ServiceProviderRepository {
  /// Branch pins within [params.bounds], with distance stamped and sorted per
  /// [params.sort]. Category ids are resolved to client categories via the
  /// categories lookup.
  Future<Result<ProviderSearchResult>> search(ProviderSearchParams params);

  /// The admin-configurable category table (id ↔ slug ↔ name), for the filter
  /// bar and for resolving search items' category ids.
  Future<Result<List<ProviderCategoryRef>>> getCategories();

  /// Full detail for one provider (all branches, hours, services, …).
  /// [userLat]/[userLng] stamp per-branch distance when supplied.
  Future<Result<ServiceProviderDetail>> getDetail(
    int id, {
    double? userLat,
    double? userLng,
  });

  /// Submits the signed-in user's star rating (1–5) and returns the updated
  /// aggregate.
  Future<Result<ProviderRatingResult>> rate(int id, int stars);
}

/// The response to a rating submission: updated aggregate + the user's stars.
class ProviderRatingResult {
  const ProviderRatingResult({
    required this.rating,
    required this.reviewCount,
    required this.myStars,
  });

  final double rating;
  final int reviewCount;
  final int myStars;
}
