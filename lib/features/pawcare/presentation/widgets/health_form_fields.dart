import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A muted field label used above inputs on the PawCare add-forms.
class HealthFieldLabel extends StatelessWidget {
  const HealthFieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary),
      );
}

/// A tappable date field showing the formatted date with a calendar icon,
/// styled to match the app's card language. Optional trailing clear affordance.
class HealthDateField extends StatelessWidget {
  const HealthDateField({
    required this.label,
    required this.onTap,
    this.onClear,
    this.placeholder = false,
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  /// When non-null a clear (×) button is shown — used for optional dates.
  final VoidCallback? onClear;

  /// Renders [label] in the muted placeholder color when true.
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdAll,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdAll,
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              const Icon(FluentIcons.calendar_24_regular,
                  size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.titleSmall.copyWith(
                    color:
                        placeholder ? AppColors.textTertiary : AppColors.textPrimary,
                  ),
                ),
              ),
              if (onClear != null)
                InkWell(
                  onTap: onClear,
                  borderRadius: BorderRadius.circular(50),
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(FluentIcons.dismiss_circle_24_regular,
                        size: 18, color: AppColors.textSecondary),
                  ),
                )
              else
                const Icon(FluentIcons.chevron_down_24_regular,
                    size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

/// A bordered card surface for hosting a borderless field (e.g. an
/// [AppDropdownField], which draws no frame of its own).
class HealthCard extends StatelessWidget {
  const HealthCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

/// A tappable field that opens a picker (frequency, lookup, …), showing the
/// current value with a leading icon and a trailing chevron.
class HealthPickerField extends StatelessWidget {
  const HealthPickerField({
    required this.icon,
    required this.label,
    required this.onTap,
    this.placeholder = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.mdAll,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppRadius.mdAll,
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: placeholder
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              const Icon(FluentIcons.chevron_down_24_regular,
                  size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

/// A plain text input styled for the PawCare add-forms.
class HealthTextField extends StatelessWidget {
  const HealthTextField({
    required this.controller,
    this.hint,
    this.autofocus = false,
    this.keyboardType,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
    super.key,
  });

  final TextEditingController controller;
  final String? hint;
  final bool autofocus;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: AppTextStyles.titleSmall,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
