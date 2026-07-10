import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Compact star + rating value, optionally with the review count.
class RatingPill extends StatelessWidget {
  const RatingPill({
    required this.rating,
    this.reviewCount,
    this.size = 14,
    super.key,
  });

  final double rating;
  final int? reviewCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final count = reviewCount;
    return Semantics(
      label: count == null
          ? context.l10n.ratingLabel(rating.toStringAsFixed(1))
          : context.l10n.ratingWithReviews(rating.toStringAsFixed(1), count),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.star_24_filled, size: size, color: AppColors.primary),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 3),
            Text(
              context.l10n.reviewCountShort(count),
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Open / Closed status dot + label.
class OpenStatusPill extends StatelessWidget {
  const OpenStatusPill({required this.isOpen, this.hoursLabel, super.key});

  final bool isOpen;
  final String? hoursLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = isOpen ? AppColors.success : AppColors.error;
    final label = isOpen ? l10n.providerOpen : l10n.providerClosed;

    return Semantics(
      label: hoursLabel == null ? label : '$label, $hoursLabel',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
          if (hoursLabel != null) ...[
            Text(
              ' · ',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            Flexible(
              child: Text(
                hoursLabel!,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
