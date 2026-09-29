import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/app_notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unread = !notification.isRead;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: unread ? AppColors.primarySoft : AppColors.surface,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryIcon(category: notification.category),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: unread
                        ? AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                        : AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.body,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _timeAgo(notification.createdAt),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (unread) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final (icon, color, bg) = switch (category) {
      'medication' => (
          FluentIcons.pill_24_filled,
          AppColors.accentCoral,
          AppColors.accentCoralSoft,
        ),
      'vaccination' => (
          FluentIcons.shield_checkmark_24_filled,
          AppColors.accentPurple,
          AppColors.accentPurpleSoft,
        ),
      'appointment' => (
          FluentIcons.calendar_24_filled,
          AppColors.secondary,
          AppColors.secondarySoft,
        ),
      'emergency' => (
          FluentIcons.warning_24_filled,
          AppColors.error,
          AppColors.background,
        ),
      'social' => (
          FluentIcons.people_community_24_filled,
          AppColors.accentPurple,
          AppColors.accentPurpleSoft,
        ),
      'marketplace' => (
          FluentIcons.cart_24_filled,
          AppColors.secondary,
          AppColors.secondarySoft,
        ),
      _ => (
          FluentIcons.alert_24_filled,
          AppColors.primary,
          AppColors.primarySoft,
        ),
    };

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
