import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/debouncer.dart';

/// Floating, pill-shaped search bar that sits over the map. Debounces input
/// (300ms) before reporting and shows a clear button when non-empty.
/// Premium look: white surface, soft shadow, rounded.
class ProviderSearchBar extends StatefulWidget {
  const ProviderSearchBar({
    required this.onChanged,
    super.key,
  });

  final ValueChanged<String> onChanged;

  @override
  State<ProviderSearchBar> createState() => _ProviderSearchBarState();
}

class _ProviderSearchBarState extends State<ProviderSearchBar> {
  final Debouncer _debouncer = Debouncer();
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    final has = value.isNotEmpty;
    if (has != _hasText) setState(() => _hasText = has);
    _debouncer(() => widget.onChanged(value));
  }

  void _clear() {
    _controller.clear();
    setState(() => _hasText = false);
    // Clearing should apply immediately, not after the debounce window.
    _debouncer.dispose();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSpacing.md),
          const Icon(
            FluentIcons.search_24_regular,
            size: 20,
            color: AppColors.textTertiary,
          ),
          Expanded(
            child: Semantics(
              textField: true,
              label: l10n.providerSearchHint,
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                textInputAction: TextInputAction.search,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  hintText: l10n.providerSearchHint,
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
          ),
          if (_hasText)
            IconButton(
              onPressed: _clear,
              tooltip: l10n.clear,
              iconSize: 18,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                FluentIcons.dismiss_circle_24_filled,
                color: AppColors.textTertiary,
              ),
            ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
    );
  }
}
