import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows the shared media-source bottom sheet and returns the chosen
/// [ImageSource] (or null if dismissed).
///
/// [title] and [subtitle] customise the header text; both fall back to the
/// generic "Add Photo" copy when omitted.
///
/// Single source of truth for the camera/gallery picker drawer — every screen
/// that lets the user attach a photo uses this so they all look identical.
Future<ImageSource?> showPhotoSourceSheet(
  BuildContext context, {
  String? title,
  String? subtitle,
}) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    useRootNavigator: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (sheetContext) => _PhotoSourceSheet(
      title: title,
      subtitle: subtitle,
    ),
  );
}

class _PhotoSourceSheet extends StatelessWidget {
  const _PhotoSourceSheet({this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final resolvedTitle = title ?? l10n.changePhoto;
    final resolvedSubtitle = subtitle ?? l10n.pawhubComposerAddToPostSubtitle;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(resolvedTitle, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              resolvedSubtitle,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: MediaSourceCard(
                    icon: FluentIcons.camera_24_regular,
                    label: l10n.camera,
                    subtitle: l10n.pawhubComposerCameraSubtitle,
                    accent: AppColors.secondary,
                    accentSoft: AppColors.secondarySoft,
                    onTap: () =>
                        Navigator.pop(context, ImageSource.camera),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: MediaSourceCard(
                    icon: FluentIcons.image_multiple_24_regular,
                    label: l10n.gallery,
                    subtitle: l10n.pawhubComposerGallerySubtitle,
                    accent: AppColors.primaryDark,
                    accentSoft: AppColors.primarySoft,
                    onTap: () =>
                        Navigator.pop(context, ImageSource.gallery),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

/// Large tappable source-option card (Camera / Gallery).
///
/// Extracted so the post composer can reuse it for its own multi-media sheet
/// (which also needs camera → single pick, gallery → multi-pick).
class MediaSourceCard extends StatelessWidget {
  const MediaSourceCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.accent,
    required this.accentSoft,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color accent;
  final Color accentSoft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: AppRadius.lgAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.lg,
            horizontal: AppSpacing.md,
          ),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accentSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accent, size: 26),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(label, style: AppTextStyles.titleSmall),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
