import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../notifications/presentation/widgets/notification_bell.dart';

/// Greeting row at the top of the home hero: time-aware greeting,
/// notification bell (with badge), and the user's avatar.
class HomeHeader extends ConsumerWidget {
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
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }

  /// The user's first name only (falls back to the full string if it's blank).
  String get _firstName {
    final trimmed = userName.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${_greeting(context)}, $_firstName',
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.onPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        NotificationBell(
          onTap: onBellTap ?? () => context.push(AppRoutes.notifications),
          color: AppColors.onPrimary,
        ),
        const SizedBox(width: AppSpacing.sm),
        // Tap the avatar → personal information. (Debug: long-press opens the
        // sandbox.)
        GestureDetector(
          onTap: () => context.push(AppRoutes.personalInformation),
          onLongPress:
              kDebugMode ? () => context.push(AppRoutes.sandbox) : null,
          child: AppAvatar(name: userName, imageUrl: avatarUrl, radius: 20),
        ),
      ],
    );
  }
}
