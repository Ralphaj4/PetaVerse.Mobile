import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

enum AlertFilter { all, lost, found }

/// Three pill chips — All / Lost / Found — for filtering the alert list.
class FilterChipRow extends StatelessWidget {
  const FilterChipRow({
    required this.selected,
    required this.onChanged,
    required this.allLabel,
    required this.lostLabel,
    required this.foundLabel,
    super.key,
  });

  final AlertFilter selected;
  final ValueChanged<AlertFilter> onChanged;
  final String allLabel;
  final String lostLabel;
  final String foundLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Chip(
          label: allLabel,
          isSelected: selected == AlertFilter.all,
          selectedColor: AppColors.textPrimary,
          onTap: () => onChanged(AlertFilter.all),
        ),
        const SizedBox(width: AppSpacing.sm),
        _Chip(
          label: lostLabel,
          isSelected: selected == AlertFilter.lost,
          selectedColor: AppColors.error,
          onTap: () => onChanged(AlertFilter.lost),
        ),
        const SizedBox(width: AppSpacing.sm),
        _Chip(
          label: foundLabel,
          isSelected: selected == AlertFilter.found,
          selectedColor: AppColors.success,
          onTap: () => onChanged(AlertFilter.found),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withValues(alpha: 0.12)
              : AppColors.background,
          border: Border.all(
            color: isSelected ? selectedColor : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.xl),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? selectedColor : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
