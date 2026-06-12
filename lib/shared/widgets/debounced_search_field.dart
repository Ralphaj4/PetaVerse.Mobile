import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/debouncer.dart';

/// Search input that debounces [onChanged] (300ms) so the API is never
/// called on every keystroke.
class DebouncedSearchField extends StatefulWidget {
  const DebouncedSearchField({
    required this.hint,
    required this.onChanged,
    super.key,
  });

  final String hint;
  final ValueChanged<String> onChanged;

  @override
  State<DebouncedSearchField> createState() => _DebouncedSearchFieldState();
}

class _DebouncedSearchFieldState extends State<DebouncedSearchField> {
  final Debouncer _debouncer = Debouncer();

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: widget.hint,
      child: TextField(
        onChanged: (value) => _debouncer(() => widget.onChanged(value)),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: const Icon(
            FluentIcons.search_24_regular,
            color: AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}
