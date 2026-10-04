import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'open_by_default_service.dart';

/// Shows the "Open links in PetaVerse" prompt bottom sheet on Android.
///
/// Call [maybeShow] from [AppShell.initState] (post-frame). The sheet is shown
/// at most once per install - [OpenByDefaultService] tracks the flag in Hive.
/// On iOS this is a no-op (Universal Links are auto-verified without user
/// action).
abstract final class OpenByDefaultSheet {
  /// Shows the sheet if [OpenByDefaultService.shouldPrompt] returns true.
  /// Safe to call on every cold start - it self-gates.
  static Future<void> maybeShow(BuildContext context) async {
    if (!Platform.isAndroid) return;
    final should = await OpenByDefaultService.shouldPrompt();
    if (!should) return;
    await OpenByDefaultService.markPrompted();
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => const _OpenByDefaultSheet(),
    );
  }
}

class _OpenByDefaultSheet extends StatelessWidget {
  const _OpenByDefaultSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            // Icon
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.link_24_filled,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.openByDefaultSheetTitle,
              style: AppTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.openByDefaultSheetBody,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await OpenByDefaultService.openSettings();
                },
                child: Text(l10n.openByDefaultSheetEnable),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.openByDefaultSheetNotNow,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
