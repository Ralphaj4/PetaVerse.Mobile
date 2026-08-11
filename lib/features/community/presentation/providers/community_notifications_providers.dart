import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/community_entities.dart';
import 'community_providers.dart';

part 'community_notifications_providers.g.dart';

/// The community notifications list ("the bell"). [NotificationPage.unreadCount]
/// is the badge total. Offline-first: page 0 falls back to the Hive cache.
@riverpod
class CommunityNotifications extends _$CommunityNotifications {
  @override
  Future<NotificationPage> build() async {
    final result = await ref
        .read(communityRepositoryProvider)
        .getNotifications(actingPetId: ref.watch(actingPetIdProvider));
    return result.when(success: (p) => p, failure: (f) => throw f);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.cursor.hasMore) return;
    final result = await ref
        .read(communityRepositoryProvider)
        .getNotifications(
          actingPetId: ref.read(actingPetIdProvider),
          page: current.cursor.nextPage ?? 0,
        );
    result.when(
      success: (page) => state = AsyncData(
        NotificationPage(
          notifications: [...current.notifications, ...page.notifications],
          unreadCount: page.unreadCount,
          cursor: page.cursor,
        ),
      ),
      failure: (_) {},
    );
  }

  /// Marks one notification read (optimistic) and updates the badge.
  Future<void> markRead(int notificationId) async {
    final result = await ref
        .read(communityRepositoryProvider)
        .markNotificationRead(notificationId: notificationId);
    result.when(
      success: (r) {
        final current = state.value;
        if (current == null) return;
        state = AsyncData(
          NotificationPage(
            notifications: [
              for (final n in current.notifications)
                n.id == notificationId ? n.copyWith(isRead: true) : n,
            ],
            unreadCount: r.unreadCount,
            cursor: current.cursor,
          ),
        );
      },
      failure: (_) {},
    );
  }

  /// Marks every notification read and zeroes the badge.
  Future<void> markAllRead() async {
    final result = await ref
        .read(communityRepositoryProvider)
        .markAllNotificationsRead(actingPetId: ref.read(actingPetIdProvider));
    result.when(
      success: (_) {
        final current = state.value;
        if (current == null) return;
        state = AsyncData(
          NotificationPage(
            notifications: [
              for (final n in current.notifications) n.copyWith(isRead: true),
            ],
            unreadCount: 0,
            cursor: current.cursor,
          ),
        );
      },
      failure: (_) {},
    );
  }
}

/// The bell badge count on its own — the number of unread notifications for the
/// acting pet. Reads through the notifications page so it stays live.
@riverpod
int communityUnreadCount(Ref ref) {
  final page = ref.watch(communityNotificationsProvider).value;
  return page?.unreadCount ?? 0;
}
