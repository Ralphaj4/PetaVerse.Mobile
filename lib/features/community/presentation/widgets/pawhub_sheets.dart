import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/pawhub_models.dart';

/// Result of the post options sheet.
enum PostAction { save, copyLink, share, hide, report, block, edit, delete }

/// The long-press / "⋯" options sheet for a post. Tailors items to whether the
/// viewer owns the post (edit/delete) or not (hide/report/block).
Future<PostAction?> showPostOptionsSheet(
  BuildContext context, {
  required PawPost post,
}) {
  final isMine = post.author.isMine;
  return showModalBottomSheet<PostAction>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _SheetHandle(),
          _OptionTile(
            icon: post.saved
                ? FluentIcons.bookmark_24_filled
                : FluentIcons.bookmark_24_regular,
            label: post.saved ? 'Remove from saved' : 'Save',
            onTap: () => Navigator.pop(context, PostAction.save),
          ),
          _OptionTile(
            icon: FluentIcons.link_24_regular,
            label: 'Copy link',
            onTap: () => Navigator.pop(context, PostAction.copyLink),
          ),
          _OptionTile(
            icon: FluentIcons.share_24_regular,
            label: 'Share to…',
            onTap: () => Navigator.pop(context, PostAction.share),
          ),
          const Divider(height: 1, color: AppColors.divider),
          if (isMine) ...[
            _OptionTile(
              icon: FluentIcons.edit_24_regular,
              label: 'Edit post',
              onTap: () => Navigator.pop(context, PostAction.edit),
            ),
            _OptionTile(
              icon: FluentIcons.delete_24_regular,
              label: 'Delete post',
              destructive: true,
              onTap: () => Navigator.pop(context, PostAction.delete),
            ),
          ] else ...[
            _OptionTile(
              icon: FluentIcons.eye_off_24_regular,
              label: 'Hide this post',
              onTap: () => Navigator.pop(context, PostAction.hide),
            ),
            _OptionTile(
              icon: FluentIcons.flag_24_regular,
              label: 'Report',
              destructive: true,
              onTap: () => Navigator.pop(context, PostAction.report),
            ),
            _OptionTile(
              icon: FluentIcons.person_prohibited_24_regular,
              label: 'Block ${post.author.ownerName}',
              destructive: true,
              onTap: () => Navigator.pop(context, PostAction.block),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    ),
  );
}

/// Report reasons — pet-app specific (cruelty & scams are the real risks).
const _reportReasons = <String>[
  'Animal cruelty or harm',
  'Spam or a scam',
  'Nudity or sexual content',
  'Harassment or bullying',
  'Not a real pet / impersonation',
  'Something else',
];

/// The report-reason picker. Returns the chosen reason string, or null.
Future<String?> showReportSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SheetHandle(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text('Why are you reporting this?',
                style: AppTextStyles.titleMedium),
          ),
          for (final reason in _reportReasons)
            _OptionTile(
              icon: FluentIcons.chevron_right_24_regular,
              label: reason,
              trailingChevron: true,
              onTap: () => Navigator.pop(context, reason),
            ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    ),
  );
}

/// The visibility picker used in the composer.
Future<PostVisibility?> showVisibilitySheet(
  BuildContext context, {
  required PostVisibility current,
}) {
  IconData iconFor(PostVisibility v) => switch (v) {
        PostVisibility.public => FluentIcons.globe_24_regular,
        PostVisibility.followers => FluentIcons.people_24_regular,
        PostVisibility.private => FluentIcons.lock_closed_24_regular,
      };
  return showModalBottomSheet<PostVisibility>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _SheetHandle(),
          for (final v in PostVisibility.values)
            _OptionTile(
              icon: iconFor(v),
              label: v.label,
              selected: v == current,
              onTap: () => Navigator.pop(context, v),
            ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    ),
  );
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
    this.selected = false,
    this.trailingChevron = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;
  final bool selected;
  final bool trailingChevron;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.error : AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: AppTextStyles.bodyMedium.copyWith(color: color)),
      trailing: selected
          ? const Icon(FluentIcons.checkmark_24_filled,
              color: AppColors.primary)
          : (trailingChevron
              ? const Icon(FluentIcons.chevron_right_24_regular,
                  size: 18, color: AppColors.textTertiary)
              : null),
      onTap: onTap,
    );
  }
}
