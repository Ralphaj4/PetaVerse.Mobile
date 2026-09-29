import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/shimmer.dart';

/// Shimmer placeholder list shown while providers load — mirrors the real
/// [ProviderCard] layout (photo + text lines + action row) so nothing shifts
/// when data arrives. Wrapped in a single [Shimmer] so all boxes share one
/// sweep (cheaper + coherent). Honors reduced-motion via [Shimmer].
class ProviderListSkeleton extends StatelessWidget {
  const ProviderListSkeleton({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (_, _) => const _CardSkeleton(),
      ),
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonBox(width: 84, height: 84, borderRadius: AppRadius.mdAll),
              const SizedBox(width: AppSpacing.md),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(width: 160, height: 15),
                    SizedBox(height: AppSpacing.sm),
                    SkeletonLine(width: 90, height: 12),
                    SizedBox(height: AppSpacing.sm),
                    SkeletonLine(width: 130, height: 12),
                    SizedBox(height: AppSpacing.sm),
                    SkeletonLine(width: 110, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: SkeletonBox(height: 40, borderRadius: AppRadius.smAll),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: SkeletonBox(height: 40, borderRadius: AppRadius.smAll),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
