import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
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

  /// Shell-branch prefixes. A route under any of these is served by a nested
  /// StatefulShellBranch navigator, not the root navigator.
  static const _shellBranchPrefixes = ['/home', '/community', '/care', '/profile'];

  void _handleTap(AppNotification notification) {
    ref.read(notificationListProvider.notifier).markRead(notification.id);

    // Email-verification notifications always open the dedicated 6-digit OTP
    // page, regardless of the backend route field (which points to /profile).
    if (notification.type == 'email_verification') {
      context.push(AppRoutes.emailVerify);
      return;
    }

    final route = notification.route;
    if (route == null || route.isEmpty) return;

    // Deep routes into a shell branch (e.g. /community/post/5) must be entered
    // with go(), not push(). This page lives on the ROOT navigator; push-ing a
    // branch-nested location makes GoRouter re-materialise the branch stack
    // (CommunityHubPage + the target) on top of a shell that already mounts the
    // branch root, producing two pages with the same pageKey - which trips the
    // Navigator's `!keyReservation.contains(key)` assertion. go() rebuilds the
    // whole stack coherently instead.
    final isShellRoute =
        _shellBranchPrefixes.any((p) => route == p || route.startsWith('$p/'));
    if (isShellRoute) {
      context.go(route);
    } else {
      context.push(route);
    }
  }

  /// Groups [items] by calendar date (device-local) and returns an ordered
  /// list of (label, notifications) pairs.
  List<(String, List<AppNotification>)> _group(
    BuildContext context,
    List<AppNotification> items,
  ) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<DateTime, List<AppNotification>> buckets = {};
    for (final n in items) {
      final local = n.createdAt.toLocal();
      final day = DateTime(local.year, local.month, local.day);
      (buckets[day] ??= []).add(n);
    }

    final sorted = buckets.keys.toList()..sort((a, b) => b.compareTo(a));

    return sorted.map((day) {
      final String label;
      if (day == today) {
        label = l10n.notificationsSectionToday;
      } else if (day == yesterday) {
        label = l10n.notificationsSectionYesterday;
      } else {
        label = DateFormat.MMMEd().format(day);
      }
      return (label, buckets[day]!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasMore = ref.watch(notificationHasMoreProvider);
    final isLoadingMore = ref.watch(notificationIsLoadingMoreProvider);
    final groups = _group(context, widget.items);

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(notificationListProvider.notifier).refresh(),
      child: ListView(
        controller: _scroll,
        children: [
          for (final (label, notifications) in groups) ...[
            _SectionLabel(label: label),
            for (final n in notifications) ...[
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
