import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';

/// Top of the profile tab: avatar, name + membership tier, and a bell.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.name,
    required this.tierLabel,
    this.avatarUrl,
    this.onBellTap,
    super.key,
  });

  final String name;
  final String tierLabel;
  final String? avatarUrl;
  final VoidCallback? onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(name: name, imageUrl: avatarUrl, radius: 26),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                tierLabel,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onBellTap,
          tooltip: context.l10n.notifications,
          icon: const Icon(
            FluentIcons.alert_24_regular,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
