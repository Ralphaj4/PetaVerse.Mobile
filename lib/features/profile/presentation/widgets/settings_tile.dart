import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A single settings row: tinted leading icon, label, an optional status
/// pill (e.g. "On"), and a trailing chevron. Used across the profile's
/// Account Settings and Notifications & Support groups.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.statusLabel,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String label;

  /// Optional pill on the trailing side before the chevron (e.g. "On").
  final String? statusLabel;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: statusLabel == null ? label : '$label, $statusLabel',
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdAll,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    borderRadius: AppRadius.smAll,
                  ),
                  child: Icon(icon, size: 20, color: iconColor),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (statusLabel != null) ...[
                  _StatusPill(label: statusLabel!),
                  const SizedBox(width: AppSpacing.sm),
                ],
                const Icon(
                  FluentIcons.chevron_right_24_regular,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryDark,
        ),
      ),
    );
  }
}
