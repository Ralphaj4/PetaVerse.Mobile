import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/adoption_listing.dart';

/// Small pill overlaid on a listing photo indicating its lifecycle state.
/// Green "Available" for open listings, amber "Pending", grey for the rest.
class AdoptionStatusBadge extends StatelessWidget {
  const AdoptionStatusBadge({required this.status, super.key});

  final AdoptionListingStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (label, color, icon) = switch (status) {
      AdoptionListingStatus.available => (
          l10n.adoptionStatusAvailable,
          AppColors.success,
          FluentIcons.heart_24_filled,
        ),
      AdoptionListingStatus.pendingTransfer => (
          l10n.adoptionStatusPending,
          AppColors.warning,
          FluentIcons.hourglass_24_filled,
        ),
      AdoptionListingStatus.adopted => (
          l10n.adoptionStatusAdopted,
          AppColors.secondaryDark,
          FluentIcons.home_24_filled,
        ),
      AdoptionListingStatus.withdrawn => (
          l10n.adoptionStatusUnavailable,
          AppColors.textSecondary,
          FluentIcons.dismiss_circle_24_filled,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.onPrimary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.onPrimary),
          ),
        ],
      ),
    );
  }
}
