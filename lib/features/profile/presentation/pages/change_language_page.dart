import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/app_culture.dart';
import '../../../../core/localization/culture_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Lets the user pick the app language. The selection persists to secure
/// storage via [cultureProvider], updating the UI locale and the `X-Culture`
/// header sent on every request.
class ChangeLanguagePage extends ConsumerWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final current = ref.watch(cultureProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(l10n.changeLanguage, style: AppTextStyles.titleLarge),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.changeLanguageSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              for (final culture in AppCulture.values) ...[
                _LanguageTile(
                  culture: culture,
                  selected: culture == current,
                  onTap: () => ref
                      .read(cultureProvider.notifier)
                      .setCulture(culture),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A single selectable language row: flag, native name, and a check when
/// active.
class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.culture,
    required this.selected,
    required this.onTap,
  });

  final AppCulture culture;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: culture.nativeName,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdAll,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.mdAll,
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.divider,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: ClipOval(
                    child: SvgPicture.asset(
                      culture.flagAsset,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    culture.nativeName,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (selected)
                  const Icon(
                    FluentIcons.checkmark_circle_24_filled,
                    size: 24,
                    color: AppColors.primary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
