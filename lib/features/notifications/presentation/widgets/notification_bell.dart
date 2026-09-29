import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/notification_providers.dart';

/// Bell icon with an unread-count badge. Drop this anywhere a bell is needed.
class NotificationBell extends ConsumerWidget {
  const NotificationBell({
    super.key,
    required this.onTap,
    this.color = Colors.white,
  });

  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(notificationUnreadCountProvider);
    final count = countAsync.value ?? 0;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            count > 0
                ? FluentIcons.alert_24_filled
                : FluentIcons.alert_24_regular,
            color: color,
            size: 24,
          ),
          if (count > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
