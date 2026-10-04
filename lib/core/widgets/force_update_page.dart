import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/context_extensions.dart';
import '../network/app_config_datasource.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Blocking screen shown when the installed app version is below
/// [AppConfig.minAppVersion]. The user cannot proceed - the only action
/// is to open the store listing or retry (in case the admin raised the
/// min version bar and then lowered it again).
class ForceUpdatePage extends ConsumerWidget {
  const ForceUpdatePage({required this.links, super.key});

  final AppConfigLinks links;

  Future<void> _openStore(BuildContext context) async {
    // Prefer platform-specific URL; fall back to the other; if neither is set,
    // show a snack bar.
    final storeUrl = _platformStoreUrl();
    if (storeUrl.isEmpty) {
      if (context.mounted) {
        context.showErrorSnackBar(context.l10n.forceUpdateNoStoreUrl);
      }
      return;
    }
    final uri = Uri.parse(storeUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        context.showErrorSnackBar(context.l10n.forceUpdateNoStoreUrl);
      }
    }
  }

  String _platformStoreUrl() {
    // On a real device we'd use Platform.isAndroid/isIOS. Using both here
    // with a preference for Play Store is fine since only one will be set in
    // practice per build target.
    if (links.playStore.isNotEmpty) return links.playStore;
    if (links.appStore.isNotEmpty) return links.appStore;
    return '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FluentIcons.arrow_sync_circle_24_regular,
                    size: 44,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.forceUpdateTitle,
                  style: AppTextStyles.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.forceUpdateMessage,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
                FilledButton.icon(
                  onPressed: () => _openStore(context),
                  icon: const Icon(FluentIcons.arrow_download_24_regular),
                  label: Text(l10n.forceUpdateButton),
                ),
                const SizedBox(height: AppSpacing.md),
                TextButton(
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
