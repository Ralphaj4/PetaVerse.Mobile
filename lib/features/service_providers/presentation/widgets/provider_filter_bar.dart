import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/provider_category.dart';
import 'provider_format.dart';

/// Horizontal, single-select category chips shown at the top of the map.
///
/// Data-driven off [ProviderCategory.values], so a new category appears here
/// automatically. The selected chip fills with the category accent color and
/// animates smoothly; the row scrolls and keeps the selection in view.
class ProviderFilterBar extends StatefulWidget {
  const ProviderFilterBar({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ProviderCategory selected;
  final ValueChanged<ProviderCategory> onSelected;

  @override
  State<ProviderFilterBar> createState() => _ProviderFilterBarState();
}

class _ProviderFilterBarState extends State<ProviderFilterBar> {
  final ScrollController _controller = ScrollController();
  final Map<ProviderCategory, GlobalKey> _keys = {
    for (final c in ProviderCategory.values) c: GlobalKey(),
  };

  @override
  void didUpdateWidget(ProviderFilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      // Keep the freshly selected chip on screen.
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
    }
  }

  void _scrollToSelected() {
    final ctx = _keys[widget.selected]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      alignment: 0.5,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: ProviderCategory.values.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final category = ProviderCategory.values[i];
          return _CategoryChip(
            key: _keys[category],
            category: category,
            isSelected: category == widget.selected,
            onTap: () => widget.onSelected(category),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final ProviderCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = category.color;
    final label = ProviderFormat.category(context.l10n, category);

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? accent : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.xl),
            border: Border.all(
              color: isSelected ? accent : AppColors.divider,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? accent.withValues(alpha: 0.35)
                    : AppColors.textPrimary.withValues(alpha: 0.06),
                blurRadius: isSelected ? 12 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? category.filledIcon : category.icon,
                size: 17,
                color: isSelected ? AppColors.onPrimary : accent,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color:
                      isSelected ? AppColors.onPrimary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
