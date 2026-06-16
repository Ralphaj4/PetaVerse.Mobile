import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../models/pet_alert.dart';
import 'alert_type_badge.dart';

/// Card showing a single lost/found pet alert — photo, badge, name,
/// location, time, description excerpt, and a primary action button.
class PetAlertCard extends StatelessWidget {
  const PetAlertCard({
    required this.alert,
    this.onContactOwner,
    this.onViewDetails,
    super.key,
  });

  final PetAlert alert;
  final VoidCallback? onContactOwner;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLost = alert.type == AlertType.lost;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Photo + badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
                child: AppCachedImage(
                  imageUrl: alert.imageUrl,
                  height: 180,
                  width: double.infinity,
                  borderRadius: BorderRadius.zero,
                  semanticLabel: alert.petName,
                ),
              ),
              PositionedDirectional(
                top: AppSpacing.md,
                start: AppSpacing.md,
                child: AlertTypeBadge(
                  type: alert.type,
                  label: isLost ? l10n.badgeLost : l10n.badgeFound,
                ),
              ),
              PositionedDirectional(
                top: AppSpacing.md,
                end: AppSpacing.md,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(AppSpacing.xs),
                  ),
                  child: Text(
                    l10n.timeAgo(alert.hoursAgo),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        alert.petName,
                        style: AppTextStyles.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      alert.breed,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(
                      FluentIcons.location_24_regular,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        alert.locationLabel,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  alert.description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.md),
                _ActionButton(
                  isLost: isLost,
                  lostLabel: l10n.contactOwner,
                  foundLabel: l10n.viewDetails,
                  onPressed: isLost ? onContactOwner : onViewDetails,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.isLost,
    required this.lostLabel,
    required this.foundLabel,
    this.onPressed,
  });

  final bool isLost;
  final String lostLabel;
  final String foundLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
        child: Text(
          isLost ? lostLabel : foundLabel,
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.onSecondary,
          ),
        ),
      ),
    );
  }
}
