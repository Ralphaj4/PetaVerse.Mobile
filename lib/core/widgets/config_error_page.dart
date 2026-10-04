import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../extensions/context_extensions.dart';
import '../network/app_config_datasource.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Shown on cold launch when [appConfigProvider] fails (network down, no
/// usable cache). The user cannot proceed until config loads - tap Retry
/// to re-attempt the fetch.
class ConfigErrorPage extends ConsumerWidget {
  const ConfigErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isLoading = ref.watch(appConfigProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.wifi_off_24_regular,
                  size: 56,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.noConnectionTitle,
                  style: AppTextStyles.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.noConnectionMessage,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
                isLoading
                    ? const CircularProgressIndicator()
                    : FilledButton(
                        onPressed: () => ref.invalidate(appConfigProvider),
                        child: Text(l10n.retry),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
