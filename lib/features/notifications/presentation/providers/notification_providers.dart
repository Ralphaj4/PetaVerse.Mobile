import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';

part 'notification_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) =>
    NotificationRepositoryImpl(
      NotificationRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// Badge count for the bell icon. Kept alive so it persists across tabs.
/// Invalidate after markRead / markAllRead.
@Riverpod(keepAlive: true)
Future<int> notificationUnreadCount(Ref ref) async {
  final result = await ref.watch(notificationRepositoryProvider).getUnreadCount();
  return result.when(success: (v) => v, failure: (_) => 0);
}

/// Paginated notification list. Managed by [NotificationListNotifier] so
/// the page can append items and optimistically flip isRead flags.
@riverpod
class NotificationList extends _$NotificationList {
  static const _pageSize = 20;

  @override
  Future<List<AppNotification>> build() async {
    final result = await ref
        .watch(notificationRepositoryProvider)
        .getNotifications(page: 1, pageSize: _pageSize);
    return result.when(
      success: (page) {
        _hasMore = page.hasMore;
        _currentPage = 1;
        return page.items;
      },
      failure: (f) => throw f,
    );
  }

  int _currentPage = 1;
  bool _hasMore = false;
  bool _isLoadingMore = false;

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    final current = state.value;
    if (current == null) return;

    _isLoadingMore = true;
    final nextPage = _currentPage + 1;

    final result = await ref
        .read(notificationRepositoryProvider)
        .getNotifications(page: nextPage, pageSize: _pageSize);

    result.when(
      success: (page) {
        _currentPage = nextPage;
        _hasMore = page.hasMore;
        state = AsyncData([...current, ...page.items]);
      },
      failure: (_) {},
    );
    _isLoadingMore = false;
  }

  Future<void> markRead(int id) async {
    final current = state.value;
    if (current == null) return;

    // Optimistic update.
    state = AsyncData([
      for (final n in current)
        if (n.id == id) n.copyWith(isRead: true) else n,
    ]);

    await ref.read(notificationRepositoryProvider).markRead(id);
    ref.invalidate(notificationUnreadCountProvider);
  }

  Future<void> markAllRead() async {
    final current = state.value;
    if (current == null) return;

    state = AsyncData([for (final n in current) n.copyWith(isRead: true)]);

    await ref.read(notificationRepositoryProvider).markAllRead();
    ref.invalidate(notificationUnreadCountProvider);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }
}

/// Convenience selector — true while more pages are available.
@riverpod
bool notificationHasMore(Ref ref) =>
    ref.watch(notificationListProvider.notifier).hasMore;

/// Convenience selector — true while a page is being fetched.
@riverpod
bool notificationIsLoadingMore(Ref ref) =>
    ref.watch(notificationListProvider.notifier).isLoadingMore;
