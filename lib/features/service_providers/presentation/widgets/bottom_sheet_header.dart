import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/service_providers_providers.dart';
import 'provider_sort_label.dart';

/// Pinned header of the providers bottom sheet: a grab handle, the result
/// count, and the current sort — the part that stays visible while the sheet
/// is collapsed. Tapping the sort chip opens the sort menu.
class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    required this.count,
    required this.sort,
    required this.onSortTap,
    super.key,
  });

  final int count;
  final ProviderSort sort;
  final VoidCallback onSortTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Grab handle.
        Container(
          margin: const EdgeInsets.only(top: AppSpacing.sm),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.divider,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.providersNearby,
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      l10n.providerCount(count),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _SortChip(
                label: providerSortLabel(l10n, sort),
                onTap: onSortTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.providerSort,
      value: label,
      child: Material(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.xl),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.arrow_sort_24_regular,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
