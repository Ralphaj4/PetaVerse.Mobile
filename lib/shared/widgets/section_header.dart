import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Section title row with an optional count pill next to the title and an
/// optional trailing "See all" action, as used across the dashboard and lists.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.count,
    this.onSeeAll,
    super.key,
  });

  final String title;

  /// Optional item count shown as a small pill after the title. Hidden when
  /// null or zero.
  final int? count;

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final showCount = count != null && count! > 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(title, style: context.textTheme.titleLarge)),
            if (showCount) ...[
              const SizedBox(width: AppSpacing.sm),
              _CountPill(count: count!),
            ],
          ],
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(context.l10n.seeAll),
          ),
      ],
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        '$count',
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.primary,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
