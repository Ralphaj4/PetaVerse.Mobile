import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/shimmer.dart';

/// First-load placeholder for a health section card: a header line and two
/// stat rows, mirroring [HealthSectionCard]'s frame.
class HealthSectionSkeleton extends StatelessWidget {
  const HealthSectionSkeleton({this.rows = 2, super.key});

  final int rows;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: SkeletonCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SkeletonBox(width: 36, height: 36),
                SizedBox(width: AppSpacing.md),
                SkeletonLine(width: 120, height: 14),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            for (var i = 0; i < rows; i++) ...[
              if (i > 0) const SizedBox(height: AppSpacing.md),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkeletonLine(width: 140, height: 12),
                  SkeletonLine(width: 56, height: 12),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
