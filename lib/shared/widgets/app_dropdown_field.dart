import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// A [FormBuilderField] dropdown that shows a bottom-sheet picker instead of
/// the native Material dropdown. Matches the app's card language.
///
/// When [searchable] is true (default) a search bar appears at the top of the
/// sheet and filters items by their text label in real-time.
class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    required this.name,
    required this.label,
    required this.items,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.hint,
    this.searchable = true,
    super.key,
  });

  final String name;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? initialValue;
  final String? Function(T?)? validator;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final String? hint;
  final bool searchable;

  String _labelFor(T? value) {
    if (value == null) return '';
    for (final item in items) {
      if (item.value == value) {
        final child = item.child;
        if (child is Text) return child.data ?? '';
      }
    }
    return value.toString();
  }

  void _openSheet(BuildContext context, FormFieldState<T> field) {
    if (!enabled || items.isEmpty) return;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => _PickerSheet<T>(
        label: label,
        items: items,
        selected: field.value,
        searchable: searchable,
        labelFor: _labelFor,
        onSelect: (value) {
          field.didChange(value);
          onChanged?.call(value);
          Navigator.of(sheetCtx).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<T>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (field) {
        final hasValue = field.value != null;
        final hasError = field.hasError;

        return GestureDetector(
          onTap: enabled ? () => _openSheet(context, field) : null,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Label.
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: hasError ? AppColors.error : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),

              // Value row.
              Row(
                children: [
                  Expanded(
                    child: hasValue
                        ? Text(
                            _labelFor(field.value),
                            style: AppTextStyles.titleSmall.copyWith(
                              color: enabled
                                  ? AppColors.textPrimary
                                  : AppColors.textTertiary,
                            ),
                          )
                        : Text(
                            hint ?? '',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                  ),
                  Icon(
                    FluentIcons.chevron_down_24_regular,
                    size: 18,
                    color: enabled
                        ? AppColors.textSecondary
                        : AppColors.textTertiary,
                  ),
                ],
              ),

              // Error text.
              if (hasError) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  field.errorText ?? '',
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ── Bottom sheet picker ───────────────────────────────────────────────────────

class _PickerSheet<T> extends StatefulWidget {
  const _PickerSheet({
    required this.label,
    required this.items,
    required this.selected,
    required this.onSelect,
    required this.labelFor,
    required this.searchable,
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? selected;
  final ValueChanged<T> onSelect;
  final String Function(T?) labelFor;
  final bool searchable;

  @override
  State<_PickerSheet<T>> createState() => _PickerSheetState<T>();
}

class _PickerSheetState<T> extends State<_PickerSheet<T>> {
  late T? _highlighted = widget.selected;
  final _searchController = TextEditingController();
  late final ScrollController _scrollController;
  String _query = '';

  // Row height used to compute the initial scroll offset.
  static const double _rowHeight = 48.0;

  @override
  void initState() {
    super.initState();
    // Pre-scroll so the selected item is visible when the sheet opens.
    final idx = widget.selected == null
        ? 0
        : widget.items.indexWhere((i) => i.value == widget.selected);
    final selectedIndex = idx < 0 ? 0 : idx;
    // Offset by up to 2 rows above so there's context above the selection.
    final offsetIndex = (selectedIndex - 2).clamp(0, widget.items.length - 1);
    _scrollController =
        ScrollController(initialScrollOffset: offsetIndex * _rowHeight);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<T>> get _filtered {
    if (_query.isEmpty) return widget.items;
    final q = _query.toLowerCase();
    return widget.items.where((item) {
      return widget.labelFor(item.value).toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final filtered = _filtered;
    // When searching, use a plain controller so the list resets to top.
    final controller = _query.isEmpty ? _scrollController : null;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      // Use a fixed fraction of screen height so the list + search bar have
      // stable room and the keyboard doesn't clip the content.
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: Column(
        children: [
          // Handle.
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(top: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title.
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Text(widget.label, style: AppTextStyles.titleMedium),
              ],
            ),
          ),

          // Search bar.
          if (widget.searchable) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _SearchBar(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],

          const Divider(height: 1, color: AppColors.divider),

          // Options list.
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            FluentIcons.search_24_regular,
                            size: 36,
                            color: AppColors.divider,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            _query,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    controller: controller,
                    padding: EdgeInsets.only(
                      top: AppSpacing.sm,
                      bottom: AppSpacing.sm + bottomPad,
                    ),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      color: AppColors.divider,
                      indent: AppSpacing.lg,
                      endIndent: AppSpacing.lg,
                    ),
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      final isSelected = item.value == _highlighted;

                      return InkWell(
                        onTap: item.value != null
                            ? () {
                                setState(() => _highlighted = item.value);
                                widget.onSelect(item.value as T);
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DefaultTextStyle(
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                  child: item.child,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  FluentIcons.checkmark_24_filled,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Search bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          const Icon(
            FluentIcons.search_24_regular,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search…',
                hintStyle: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textTertiary),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                onChanged('');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Icon(
                  FluentIcons.dismiss_circle_24_filled,
                  size: 16,
                  color: AppColors.textTertiary,
                ),
              ),
            )
          else
            const SizedBox(width: AppSpacing.md),
        ],
      ),
    );
  }
}
