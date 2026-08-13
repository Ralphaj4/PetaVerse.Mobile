import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../models/pawhub_models.dart';
import '../providers/community_notifications_providers.dart';

/// The notifications sheet: grouped rows, safety alerts styled distinctly,
/// tap-to-mark-read. Prototype state lives locally.
class NotificationsSheet extends ConsumerStatefulWidget {
  const NotificationsSheet({required this.items, super.key});

  final List<PawNotif> items;

  @override
  ConsumerState<NotificationsSheet> createState() => _NotificationsSheetState();
}

class _NotificationsSheetState extends ConsumerState<NotificationsSheet> {
  Future<void> _markNotificationRead(PawNotif notif) async {
    if (notif.isRead) return;
    setState(() => notif.isRead = true);
    await ref.read(communityNotificationsProvider.notifier).markRead(notif.id);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Text(context.l10n.pawHubNotificationsTitle,
                      style: AppTextStyles.titleMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setState(() {
                      for (final n in widget.items) {
                        n.isRead = true;
                      }
                    }),
                    child: Text(context.l10n.pawHubMarkAllRead),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.items.length,
                itemBuilder: (_, i) => _NotifRow(
                  notif: widget.items[i],
                  onTap: () {
                    _markNotificationRead(widget.items[i]);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Container(
              height: AppSpacing.xl,
              color: AppColors.surface,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifRow extends StatelessWidget {
  const _NotifRow({required this.notif, required this.onTap});

  final PawNotif notif;
  final VoidCallback onTap;

  bool get _isAlert => notif.type == PawNotifType.alert;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: notif.isRead
            ? Colors.transparent
            : (_isAlert
                ? AppColors.error.withValues(alpha: 0.06)
                : AppColors.primarySoft.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            _leading(),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notif.text,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(notif.timeAgo,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textTertiary)),
                ],
              ),
            ),
            if (notif.thumbnailUrl != null) ...[
              const SizedBox(width: AppSpacing.md),
              ClipRRect(
                borderRadius: AppRadius.smAll,
                child: AppCachedImage(
                  imageUrl: notif.thumbnailUrl,
                  width: 44,
                  height: 44,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _leading() {
    if (_isAlert) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: const Icon(FluentIcons.alert_urgent_24_filled,
            color: AppColors.error),
      );
    }
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        AppAvatar(
            name: notif.actor.name, imageUrl: notif.actor.avatarUrl, radius: 22),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: _iconColor,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 1.5),
          ),
          child: Icon(_icon, size: 10, color: Colors.white),
        ),
      ],
    );
  }

  IconData get _icon => switch (notif.type) {
        PawNotifType.like => FluentIcons.animal_paw_print_16_filled,
        PawNotifType.comment => FluentIcons.comment_16_filled,
        PawNotifType.reply => FluentIcons.arrow_reply_16_filled,
        PawNotifType.follow => FluentIcons.person_add_16_filled,
        PawNotifType.mention => FluentIcons.mention_16_filled,
        PawNotifType.tagged => FluentIcons.tag_16_filled,
        PawNotifType.alert => FluentIcons.alert_urgent_16_filled,
      };

  Color get _iconColor => switch (notif.type) {
        PawNotifType.like => AppColors.primary,
        PawNotifType.follow => AppColors.secondary,
        PawNotifType.alert => AppColors.error,
        _ => AppColors.accentPurple,
      };
}
