import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../domain/entities/app_notification.dart';
import '../providers/notification_providers.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final listAsync = ref.watch(notificationListProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(l10n.pawHubNotificationsTitle,
            style: AppTextStyles.titleMedium),
        centerTitle: false,
        actions: [
          listAsync.when(
            data: (items) => items.any((n) => !n.isRead)
                ? TextButton(
                    onPressed: () =>
                        ref.read(notificationListProvider.notifier).markAllRead(),
                    child: Text(
                      l10n.pawHubMarkAllRead,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, st) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: listAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.errorTitle, style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () =>
                    ref.read(notificationListProvider.notifier).refresh(),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (items) => items.isEmpty
            ? EmptyStateWidget(
                icon: FluentIcons.alert_off_24_regular,
                title: l10n.notificationsEmptyTitle,
                message: l10n.notificationsEmptyMessage,
              )
            : _NotificationList(items: items),
      ),
    );
  }
}

class _NotificationList extends ConsumerStatefulWidget {
  const _NotificationList({required this.items});

  final List<AppNotification> items;

  @override
  ConsumerState<_NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends ConsumerState<_NotificationList> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >=
        _scroll.position.maxScrollExtent - 200) {
      ref.read(notificationListProvider.notifier).loadMore();
    }
  }

  void _handleTap(AppNotification notification) {
    ref.read(notificationListProvider.notifier).markRead(notification.id);

    final route = notification.route;
    if (route != null && route.isNotEmpty) {
      context.push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasMore = ref.watch(notificationHasMoreProvider);
    final isLoadingMore = ref.watch(notificationIsLoadingMoreProvider);

    // Group items into Today / Earlier.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final todayItems = widget.items
        .where((n) => n.createdAt.isAfter(today))
        .toList(growable: false);
    final earlierItems = widget.items
        .where((n) => !n.createdAt.isAfter(today))
        .toList(growable: false);

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(notificationListProvider.notifier).refresh(),
      child: ListView(
        controller: _scroll,
        children: [
          if (todayItems.isNotEmpty) ...[
            _SectionLabel(label: context.l10n.notificationsSectionToday),
            for (final n in todayItems) ...[
              NotificationCard(
                notification: n,
                onTap: () => _handleTap(n),
              ),
              const Divider(height: 1, color: AppColors.divider),
            ],
          ],
          if (earlierItems.isNotEmpty) ...[
            _SectionLabel(label: context.l10n.notificationsSectionEarlier),
            for (final n in earlierItems) ...[
              NotificationCard(
                notification: n,
                onTap: () => _handleTap(n),
              ),
              const Divider(height: 1, color: AppColors.divider),
            ],
          ],
          if (isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (!hasMore && !isLoadingMore && widget.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Center(
                child: Text(
                  context.l10n.notificationsAllCaughtUp,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
