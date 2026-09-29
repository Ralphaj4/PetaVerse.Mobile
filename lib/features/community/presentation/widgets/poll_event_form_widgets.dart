import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Shared form building blocks for the create-poll and create-event pages, so
/// both share identical card / field / banner / submit styling.

/// A white rounded section card.
class FormCard extends StatelessWidget {
  const FormCard({required this.child, this.padding, super.key});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

/// A filled outlined text field matching the composer style.
class FormField2 extends StatelessWidget {
  const FormField2({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.maxLength,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      textCapitalization: TextCapitalization.sentences,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
        isDense: true,
        counterText: '',
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.md),
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
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }
}

/// The teal "Posting in `<community>`" banner.
class PostingInBanner extends StatelessWidget {
  const PostingInBanner({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        children: [
          const Icon(FluentIcons.people_community_24_filled,
              size: 22, color: AppColors.secondaryDark),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.communityComposerPostingIn(''),
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.secondaryDark)),
                Text(name,
                    style: AppTextStyles.titleSmall
                        .copyWith(color: AppColors.secondaryDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The solid-orange pill submit action for the app bar.
class SubmitPillButton extends StatelessWidget {
  const SubmitPillButton({
    required this.label,
    required this.enabled,
    required this.busy,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool enabled;
  final bool busy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      onPressed: enabled ? onPressed : null,
      child: busy
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          : Text(label,
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.onPrimary)),
    );
  }
}

/// Formats a [DateTime] as "medium date · time" using MaterialLocalizations.
String formatDateTimeLabel(BuildContext context, DateTime dt) {
  final local = dt.toLocal();
  final material = MaterialLocalizations.of(context);
  final date = material.formatMediumDate(local);
  final time = material.formatTimeOfDay(TimeOfDay.fromDateTime(local));
  return '$date · $time';
}
