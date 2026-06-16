import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';

/// Greeting row at the top of the home hero: time-aware greeting,
/// notification bell, and the user's avatar.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.userName,
    this.avatarUrl,
    this.onBellTap,
    super.key,
  });

  final String userName;
  final String? avatarUrl;
  final VoidCallback? onBellTap;

  String _greeting(BuildContext context) {
    final hour = DateTime.now().hour;
    final l10n = context.l10n;
    if (hour < 12) return l10n.goodMorning(userName);
    if (hour < 17) return l10n.goodAfternoon(userName);
    return l10n.goodEvening(userName);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _greeting(context),
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        IconButton(
          onPressed: onBellTap,
          tooltip: context.l10n.notifications,
          icon: const Icon(
            FluentIcons.alert_24_regular,
            color: AppColors.onPrimary,
          ),
        ),
        // In debug builds, long-pressing the avatar opens the sandbox.
        GestureDetector(
          onLongPress:
              kDebugMode ? () => context.push(AppRoutes.sandbox) : null,
          child: AppAvatar(name: userName, imageUrl: avatarUrl, radius: 20),
        ),
      ],
    );
  }
}
