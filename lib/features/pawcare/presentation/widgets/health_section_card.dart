import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// White rounded card with a titled header (leading icon chip + title + optional
/// "add" action) used by every PawCare health section, so weight, medications,
/// and vaccinations share one visual frame.
class HealthSectionCard extends StatelessWidget {
  const HealthSectionCard({
    required this.icon,
    required this.title,
    required this.child,
    this.accent = AppColors.primary,
    this.accentSoft = AppColors.primarySoft,
    this.onAdd,
    this.addTooltip,
    this.onOpen,
    super.key,
  });

  final IconData icon;
  final String title;
  final Widget child;

  /// Icon / accent color for the leading chip.
  final Color accent;
  final Color accentSoft;

  /// Shown as a "+" affordance in the header when non-null.
  final VoidCallback? onAdd;
  final String? addTooltip;

  /// When non-null the title becomes tappable (with a trailing chevron) and
  /// opens the section's full history/list page.
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accentSoft,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, size: 18, color: accent),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: onOpen == null
                      ? Text(title, style: AppTextStyles.titleMedium)
                      : InkWell(
                          onTap: onOpen,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(title,
                                      style: AppTextStyles.titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Icon(
                                  Directionality.of(context) ==
                                          TextDirection.rtl
                                      ? FluentIcons.chevron_left_24_regular
                                      : FluentIcons.chevron_right_24_regular,
                                  size: 16,
                                  color: AppColors.textTertiary,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                if (onAdd != null)
                  IconButton(
                    onPressed: onAdd,
                    tooltip: addTooltip,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      FluentIcons.add_circle_24_regular,
                      size: 24,
                      color: accent,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
