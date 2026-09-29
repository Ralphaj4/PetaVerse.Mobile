import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/service_provider.dart';

/// Row of small trust/quality pills (Verified, 24/7, Emergency, Mobile).
///
/// Order is fixed for scan-ability; only the badges present on the provider
/// render. Wraps so it never overflows on narrow cards.
class ProviderBadges extends StatelessWidget {
  const ProviderBadges({required this.badges, this.compact = false, super.key});

  final Set<ProviderBadge> badges;

  /// Icon-only pills (used on dense preview cards).
  final bool compact;

  static const List<ProviderBadge> _order = [
    ProviderBadge.emergency,
    ProviderBadge.open24_7,
    ProviderBadge.verified,
    ProviderBadge.mobileService,
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _order.where(badges.contains).toList();
    if (visible.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final badge in visible)
          _BadgePill(badge: badge, compact: compact),
      ],
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.badge, required this.compact});

  final ProviderBadge badge;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, label, color) = switch (badge) {
      ProviderBadge.verified => (
          FluentIcons.checkmark_circle_24_filled,
          l10n.badgeVerified,
          AppColors.secondary,
        ),
      ProviderBadge.emergency => (
          FluentIcons.alert_urgent_24_filled,
          l10n.badgeEmergency,
          AppColors.error,
        ),
      ProviderBadge.open24_7 => (
          FluentIcons.clock_24_filled,
          l10n.badge24_7,
          AppColors.success,
        ),
      ProviderBadge.mobileService => (
          FluentIcons.vehicle_car_profile_ltr_24_filled,
          l10n.badgeMobile,
          AppColors.accentPurple,
        ),
    };

    return Semantics(
      label: label,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 6 : 8,
          vertical: compact ? 4 : 5,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: compact ? 13 : 14, color: color),
            if (!compact) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
