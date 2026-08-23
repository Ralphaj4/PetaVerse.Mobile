import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../pets/domain/entities/species.dart';
import 'adoption_format.dart';

/// Horizontal, single-select species chips at the top of the adoption board.
/// The first chip is "All" (id == null); the rest come from the shared
/// `/species` lookup. The selected chip fills with the brand accent and the row
/// keeps the selection in view.
class AdoptionSpeciesFilterRow extends StatefulWidget {
  const AdoptionSpeciesFilterRow({
    required this.species,
    required this.selectedId,
    required this.allLabel,
    required this.onSelected,
    super.key,
  });

  /// Species from the lookup (not including the synthetic "All" entry).
  final List<Species> species;

  /// The selected species id, or null for "All".
  final int? selectedId;
  final String allLabel;
  final ValueChanged<int?> onSelected;

  @override
  State<AdoptionSpeciesFilterRow> createState() =>
      _AdoptionSpeciesFilterRowState();
}

class _AdoptionSpeciesFilterRowState extends State<AdoptionSpeciesFilterRow> {
  final ScrollController _controller = ScrollController();
  final Map<int?, GlobalKey> _keys = {};

  GlobalKey _keyFor(int? id) => _keys.putIfAbsent(id, GlobalKey.new);

  @override
  void didUpdateWidget(AdoptionSpeciesFilterRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedId != widget.selectedId) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
    }
  }

  void _scrollToSelected() {
    final ctx = _keys[widget.selectedId]?.currentContext;
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
    // "All" first, then one chip per species.
    final entries = <({int? id, String label})>[
      (id: null, label: widget.allLabel),
      for (final s in widget.species) (id: s.id, label: s.name),
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: entries.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          final e = entries[i];
          return _SpeciesChip(
            key: _keyFor(e.id),
            label: e.label,
            glyph: e.id == null
                ? const SpeciesGlyph.icon(FluentIcons.animal_paw_print_24_filled)
                : AdoptionFormat.speciesIcon(e.label),
            isSelected: e.id == widget.selectedId,
            onTap: () => widget.onSelected(e.id),
          );
        },
      ),
    );
  }
}

class _SpeciesChip extends StatelessWidget {
  const _SpeciesChip({
    required this.label,
    required this.glyph,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final SpeciesGlyph glyph;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const accent = AppColors.primary;

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
              SpeciesGlyphIcon(
                glyph: glyph,
                size: 17,
                color: isSelected ? AppColors.onPrimary : accent,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected
                      ? AppColors.onPrimary
                      : AppColors.textSecondary,
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
