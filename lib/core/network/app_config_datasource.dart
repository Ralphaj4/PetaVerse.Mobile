import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../errors/app_exception.dart';
import '../errors/failure.dart';
import '../errors/result.dart';
import '../storage/hive_service.dart';
import 'api_client.dart';
import 'api_endpoints.dart';

part 'app_config_datasource.g.dart';

// ── Value objects ────────────────────────────────────────────────────────────

class AppConfigLinks {
  const AppConfigLinks({
    required this.terms,
    required this.privacy,
    required this.help,
    required this.appStore,
    required this.playStore,
  });

  final String terms;
  final String privacy;
  final String help;
  final String appStore;
  final String playStore;

  factory AppConfigLinks.fromJson(Map<String, dynamic> j) => AppConfigLinks(
        terms: j['terms'] as String? ?? '',
        privacy: j['privacy'] as String? ?? '',
        help: j['help'] as String? ?? '',
        appStore: j['appStore'] as String? ?? '',
        playStore: j['playStore'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'terms': terms,
        'privacy': privacy,
        'help': help,
        'appStore': appStore,
        'playStore': playStore,
      };
}

class AppConfigMaintenance {
  const AppConfigMaintenance({
    required this.active,
    required this.message,
    required this.endsAt,
  });

  final bool active;
  final String message;
  final DateTime? endsAt;

  factory AppConfigMaintenance.fromJson(Map<String, dynamic> j) =>
      AppConfigMaintenance(
        active: j['active'] as bool? ?? false,
        message: j['message'] as String? ?? '',
        endsAt: j['endsAt'] == null
            ? null
            : DateTime.tryParse(j['endsAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'message': message,
        'endsAt': endsAt?.toIso8601String(),
      };
}

class AppConfigFeatures {
  const AppConfigFeatures({
    required this.adoption,
    required this.aiChat,
    required this.lostFound,
  });

  final bool adoption;
  final bool aiChat;
  final bool lostFound;

  factory AppConfigFeatures.fromJson(Map<String, dynamic> j) =>
      AppConfigFeatures(
        adoption: j['adoption'] as bool? ?? true,
        aiChat: j['aiChat'] as bool? ?? true,
        lostFound: j['lostFound'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'adoption': adoption,
        'aiChat': aiChat,
        'lostFound': lostFound,
      };
}

class AppConfigMap {
  const AppConfigMap({
    required this.defaultLat,
    required this.defaultLng,
    required this.defaultRadiusKm,
  });

  final double defaultLat;
  final double defaultLng;
  final int defaultRadiusKm;

  factory AppConfigMap.fromJson(Map<String, dynamic> j) => AppConfigMap(
        defaultLat: (j['defaultLat'] as num?)?.toDouble() ?? 33.8938,
        defaultLng: (j['defaultLng'] as num?)?.toDouble() ?? 35.5018,
        defaultRadiusKm: (j['defaultRadiusKm'] as num?)?.toInt() ?? 10,
      );

  Map<String, dynamic> toJson() => {
        'defaultLat': defaultLat,
        'defaultLng': defaultLng,
        'defaultRadiusKm': defaultRadiusKm,
      };
}

class AppConfig {
  const AppConfig({
    required this.supportEmail,
    required this.supportPhone,
    required this.adoptionContactEmail,
    required this.baseUrl,
    required this.minAppVersion,
    required this.latestAppVersion,
    required this.links,
    required this.maintenance,
    required this.features,
    required this.map,
    this.fromCache = false,
  });

  final String supportEmail;
  final String supportPhone;
  final String adoptionContactEmail;
  final String baseUrl;
  final String minAppVersion;
  final String latestAppVersion;
  final AppConfigLinks links;
  final AppConfigMaintenance maintenance;
  final AppConfigFeatures features;
  final AppConfigMap map;

  /// True when this value was loaded from the local Hive cache (offline boot).
  final bool fromCache;

  factory AppConfig.fromJson(Map<String, dynamic> j, {bool fromCache = false}) =>
      AppConfig(
        supportEmail: j['supportEmail'] as String? ?? '',
        supportPhone: j['supportPhone'] as String? ?? '',
        adoptionContactEmail: j['adoptionContactEmail'] as String? ?? '',
        baseUrl: j['baseUrl'] as String? ?? '',
        minAppVersion: j['minAppVersion'] as String? ?? '1.0.0',
        latestAppVersion: j['latestAppVersion'] as String? ?? '1.0.0',
        links: AppConfigLinks.fromJson(
            j['links'] as Map<String, dynamic>? ?? {}),
        maintenance: AppConfigMaintenance.fromJson(
            j['maintenance'] as Map<String, dynamic>? ?? {}),
        features: AppConfigFeatures.fromJson(
            j['features'] as Map<String, dynamic>? ?? {}),
        map: AppConfigMap.fromJson(
            j['map'] as Map<String, dynamic>? ?? {}),
        fromCache: fromCache,
      );

  Map<String, dynamic> toJson() => {
        'supportEmail': supportEmail,
        'supportPhone': supportPhone,
        'adoptionContactEmail': adoptionContactEmail,
        'baseUrl': baseUrl,
        'minAppVersion': minAppVersion,
        'latestAppVersion': latestAppVersion,
        'links': links.toJson(),
        'maintenance': maintenance.toJson(),
        'features': features.toJson(),
        'map': map.toJson(),
      };
}

// ── Datasource ───────────────────────────────────────────────────────────────

const _kBox = 'app_config';
const _kConfigKey = 'config';
const _kCachedAtKey = 'cached_at';
const _kCacheTtl = Duration(minutes: 10);

class AppConfigDatasource {
  const AppConfigDatasource(this._client, this._hive);

  final ApiClient _client;
  final HiveService _hive;

  /// Fetches live config from the server.
  ///
  /// On success: persists to Hive (overwrites any prior cache).
  /// On failure: falls back to the cached value if it exists and is < 24 h old.
  /// If both fail: returns a [Failure].
  Future<Result<AppConfig>> getConfig() async {
    try {
      final data = await _client.get<Map<String, dynamic>>(
        ApiEndpoints.appConfig,
      );
      final config = AppConfig.fromJson(data);
      await _persist(config);
      return Result.success(config);
    } on AppException catch (e) {
      return _fallbackOrFailure(_map(e));
    } catch (e) {
      return _fallbackOrFailure(NetworkFailure(message: e.toString()));
    }
  }

  Future<void> _persist(AppConfig config) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await Future.wait([
      _hive.putJson(_kBox, _kConfigKey, config.toJson()),
      _hive.putJson(_kBox, _kCachedAtKey, {'ts': now}),
    ]);
  }

  Future<Result<AppConfig>> _fallbackOrFailure(Failure networkFailure) async {
    try {
      final cached = await _hive.getJson(_kBox, _kConfigKey);
      final tsJson = await _hive.getJson(_kBox, _kCachedAtKey);
      if (cached == null || tsJson == null) return Result.failure(networkFailure);

      final cachedAt = DateTime.fromMillisecondsSinceEpoch(
        tsJson['ts'] as int,
      );
      if (DateTime.now().difference(cachedAt) > _kCacheTtl) {
        return Result.failure(networkFailure);
      }

      return Result.success(AppConfig.fromJson(cached, fromCache: true));
    } catch (_) {
      return Result.failure(networkFailure);
    }
  }

  Failure _map(AppException e) => switch (e) {
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

// ── Providers ────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
AppConfigDatasource appConfigDatasource(Ref ref) => AppConfigDatasource(
      ref.watch(apiClientProvider),
      ref.watch(hiveServiceProvider),
    );

/// Fetches (or cache-falls-back) the app config once per process lifetime.
/// The result is a [Result<AppConfig>] so the router can handle failure
/// explicitly - it never throws.
@Riverpod(keepAlive: true)
Future<Result<AppConfig>> appConfig(Ref ref) =>
    ref.watch(appConfigDatasourceProvider).getConfig();
