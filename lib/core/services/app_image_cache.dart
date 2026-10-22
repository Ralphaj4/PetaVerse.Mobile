import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// App-wide image cache policy for [cached_network_image].
///
/// The `cached_network_image` default manager keeps up to 200 objects for a
/// 30-day stale period - too few objects for an image-heavy feed, and a 30-day
/// retention that lets media we'll never re-view hoard disk. This manager
/// tightens retention to [_stalePeriod] and raises the object cap so scrolling
/// back up still hits cache. Eviction is LRU within the window.
class AppImageCacheManager {
  AppImageCacheManager._();

  static const _key = 'petaverse_image_cache';

  /// Evict cached images older than this. A social feed goes stale fast; you
  /// rarely re-view a week-old post, so a week keeps the device footprint low
  /// without hurting the common re-scroll case.
  static const _stalePeriod = Duration(days: 7);

  /// Headroom for an image-heavy feed so re-scrolling still hits cache.
  static const _maxCacheObjects = 1000;

  static final CacheManager instance = CacheManager(
    Config(
      _key,
      stalePeriod: _stalePeriod,
      maxNrOfCacheObjects: _maxCacheObjects,
    ),
  );
}
