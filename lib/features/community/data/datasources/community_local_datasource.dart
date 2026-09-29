import '../../../../core/storage/hive_service.dart';
import '../dtos/community_dtos.dart';

/// Offline cache for PawHub, in the `community` Hive box.
///
/// We cache only the read-mostly surfaces that matter offline — the **first
/// page** of the following feed and the notifications list — as raw DTO JSON.
/// Deeper pages, discover, search and interactions are always live. The box is
/// cleared on logout so it only holds the signed-in user's data.
class CommunityLocalDataSource {
  const CommunityLocalDataSource(this._hive);

  final HiveService _hive;

  static const String _box = 'community';
  static const String _feedKey = 'following_feed_p0';
  static const String _notificationsKey = 'notifications_p0';

  /// Caches the first page of the following feed.
  Future<void> writeFollowingFeed(FeedResponseDto dto) =>
      _hive.putJson(_box, _feedKey, dto.toJson());

  /// Reads the cached following feed, or null when nothing is cached.
  Future<FeedResponseDto?> readFollowingFeed() async {
    final json = await _hive.getJson(_box, _feedKey);
    return json == null ? null : FeedResponseDto.fromJson(json);
  }

  /// Caches the first page of notifications (badge count included).
  Future<void> writeNotifications(NotificationsResponseDto dto) =>
      _hive.putJson(_box, _notificationsKey, dto.toJson());

  /// Reads the cached notifications page, or null when nothing is cached.
  Future<NotificationsResponseDto?> readNotifications() async {
    final json = await _hive.getJson(_box, _notificationsKey);
    return json == null ? null : NotificationsResponseDto.fromJson(json);
  }

  /// Drops all cached community data. Called on logout.
  Future<void> clear() => _hive.clearBox(_box);
}
