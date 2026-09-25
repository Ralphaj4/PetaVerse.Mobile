import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/provider_category.dart';
import '../../domain/entities/provider_category_ref.dart';
import '../../domain/entities/provider_search.dart';
import '../../domain/entities/service_provider_detail.dart';
import '../../domain/repositories/service_provider_repository.dart';
import '../datasources/service_provider_remote_datasource.dart';

/// Remote-backed repository for the service-providers map.
///
/// Owns the categories lookup: it's fetched once and memoized, then used both
/// to resolve search/detail items' numeric `primaryCategoryId` into a client
/// [ProviderCategory] (for pins/cards) and to map a selected client category
/// back to the server id for the `categoryId` query param.
class ServiceProviderRepositoryImpl implements ServiceProviderRepository {
  ServiceProviderRepositoryImpl(this._remote);

  final ServiceProviderRemoteDataSource _remote;

  /// Memoized category rows (id ↔ slug ↔ name). Fetched lazily on first need.
  List<ProviderCategoryRef>? _categories;

  /// id → client category, for resolving search/detail items.
  final Map<int, ProviderCategory> _byId = {};

  /// client category → server id, for the search `categoryId` param.
  final Map<ProviderCategory, int> _byCategory = {};

  Future<List<ProviderCategoryRef>> _ensureCategories() async {
    final cached = _categories;
    if (cached != null) return cached;
    final dtos = await _remote.getCategories();
    final refs = dtos.map((e) => e.toEntity()).toList();
    _categories = refs;
    _byId.clear();
    _byCategory.clear();
    for (final ref in refs) {
      final category = ref.category;
      if (category != null) {
        _byId[ref.id] = category;
        _byCategory[category] = ref.id;
      }
    }
    return refs;
  }

  /// Resolves a numeric category id to a client category, defaulting to
  /// [ProviderCategory.all] (the safe "other" bucket) when unknown.
  ProviderCategory _resolve(int id) => _byId[id] ?? ProviderCategory.all;

  @override
  Future<Result<ProviderSearchResult>> search(
    ProviderSearchParams params,
  ) async {
    try {
      // Ensure the category map is loaded so items resolve + the filter maps.
      await _ensureCategories();

      final category = params.category;
      final categoryId = (category != null && category != ProviderCategory.all)
          ? _byCategory[category]
          : null;

      final dto = await _remote.search(params, categoryId: categoryId);
      return Result.success(dto.toEntity(_resolve));
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<List<ProviderCategoryRef>>> getCategories() async {
    try {
      return Result.success(await _ensureCategories());
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<ServiceProviderDetail>> getDetail(
    int id, {
    double? userLat,
    double? userLng,
  }) async {
    try {
      await _ensureCategories();
      final dto = await _remote.getDetail(
        id,
        userLat: userLat,
        userLng: userLng,
      );
      return Result.success(dto.toEntity(_resolve));
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  @override
  Future<Result<ProviderRatingResult>> rate(int id, int stars) async {
    try {
      final dto = await _remote.rate(id, stars);
      return Result.success(
        ProviderRatingResult(
          rating: dto.rating,
          reviewCount: dto.reviewCount,
          myStars: dto.myStars,
        ),
      );
    } on AppException catch (e) {
      return Result.failure(_mapFailure(e));
    }
  }

  Failure _mapFailure(AppException e) => switch (e) {
        NetworkException() => NetworkFailure(message: e.message),
        UnauthorizedException() => UnauthorizedFailure(message: e.message),
        SuspendedException() => SuspendedFailure(
            message: e.message,
            suspendedUntil: e.suspendedUntil,
          ),
        BannedException() => BannedFailure(message: e.message),
        ForbiddenException() => ForbiddenFailure(message: e.message),
        NotFoundException() => NotFoundFailure(message: e.message),
        ValidationException() => ValidationFailure(
            message: e.message,
            fieldErrors: e.fieldErrors,
          ),
        RateLimitException() => RateLimitFailure(
            message: e.message,
            retryAfter: e.retryAfter,
          ),
        ConflictException() => ConflictFailure(message: e.message),
        ServerException() => ServerFailure(message: e.message),
        CacheException() => CacheFailure(message: e.message),
      };
}
