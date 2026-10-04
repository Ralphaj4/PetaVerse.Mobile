import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../domain/entities/community_enums.dart' hide PostVisibility;
import '../models/pawhub_models.dart';

/// Result of the post options sheet.
enum PostAction { save, copyLink, share, report, block, delete }

/// Result of the comment options sheet.
enum CommentAction { edit, delete, report }

/// The long-press / "⋯" options sheet for a post. Tailors items to whether the
/// viewer owns the post (edit/delete) or not (hide/report/block).
Future<PostAction?> showPostOptionsSheet(
  BuildContext context, {
  required PawPost post,
  bool forceMine = false,
}) {
  final isMine = forceMine || post.author.isMine;
  return showModalBottomSheet<PostAction>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          const _SheetHandle(),
          _OptionTile(
            icon: post.saved
                ? FluentIcons.bookmark_24_filled
                : FluentIcons.bookmark_24_regular,
            label: post.saved
                ? context.l10n.pawHubPostOptionRemoveSaved
                : context.l10n.pawHubPostOptionSave,
            onTap: () => Navigator.pop(context, PostAction.save),
          ),
          _OptionTile(
            icon: FluentIcons.link_24_regular,
            label: context.l10n.pawHubPostOptionCopyLink,
            onTap: () => Navigator.pop(context, PostAction.copyLink),
          ),
          _OptionTile(
            icon: FluentIcons.share_24_regular,
            label: context.l10n.pawHubPostOptionShareTo,
            onTap: () => Navigator.pop(context, PostAction.share),
          ),
          const Divider(height: 1, color: AppColors.divider),
          if (isMine) ...[
            _OptionTile(
              icon: FluentIcons.delete_24_regular,
              label: context.l10n.pawHubPostOptionDeletePost,
              destructive: true,
              onTap: () => Navigator.pop(context, PostAction.delete),
            ),
          ] else ...[
            _OptionTile(
              icon: FluentIcons.flag_24_regular,
              label: context.l10n.pawHubPostOptionReport,
              destructive: true,
              onTap: () => Navigator.pop(context, PostAction.report),
            ),
            _OptionTile(
              icon: FluentIcons.person_prohibited_24_regular,
              label: context.l10n.pawHubPostOptionBlock(post.author.name),
              destructive: true,
              onTap: () => Navigator.pop(context, PostAction.block),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
        ],
        ),
      ),
    ),
  );
}

/// Shows the block-confirmation dialog for [authorName].
///
/// Returns true if the user confirmed, false if they cancelled. The sheet
/// calling this has already closed - this dialog appears on the page behind it.
Future<bool> showBlockConfirmDialog(
  BuildContext context, {
  required String authorName,
}) {
  return AppConfirmDialog.show(
    context,
    icon: FluentIcons.person_prohibited_24_filled,
    title: context.l10n.pawHubBlockConfirmTitle(authorName),
    message: context.l10n.pawHubBlockConfirmMessage(authorName),
    confirmLabel: context.l10n.pawHubBlockConfirmButton,
    cancelLabel: context.l10n.cancel,
    isDestructive: true,
  );
}

/// Report reason labels shown in the sheet, localized.
List<(ReportReason, String)> _reportReasonLabels(BuildContext context) => [
  (ReportReason.inappropriate, context.l10n.pawHubReportReasonCruelty),
  (ReportReason.spam, context.l10n.pawHubReportReasonSpam),
  (ReportReason.violence, context.l10n.pawHubReportReasonNudity),
  (ReportReason.harassment, context.l10n.pawHubReportReasonHarassment),
  (ReportReason.misinformation, context.l10n.pawHubReportReasonImpersonation),
  (ReportReason.other, context.l10n.pawHubReportReasonOther),
];

/// The report-reason picker. Returns a [ReportReason] (the API enum), or null
/// if the user dismissed without choosing.
Future<ReportReason?> showReportSheet(BuildContext context) {
  return showModalBottomSheet<ReportReason>(
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
          const Center(child: _SheetHandle()),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text(context.l10n.pawHubReportTitle,
                style: AppTextStyles.titleMedium),
          ),
          for (final (reason, label) in _reportReasonLabels(context))
            _OptionTile(
              icon: FluentIcons.chevron_right_24_regular,
              label: label,
              trailingChevron: true,
              onTap: () async {
                final confirmed = await AppConfirmDialog.show(
                  context,
                  icon: FluentIcons.flag_24_regular,
                  title: context.l10n.pawHubReportConfirmTitle,
                  message: context.l10n.pawHubReportConfirmMessage(label),
                  confirmLabel: context.l10n.pawHubReportConfirmAction,
                  cancelLabel: context.l10n.cancel,
                  isDestructive: true,
                );
                if (confirmed && context.mounted) {
                  Navigator.pop(context, reason);
                }
              },
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

/// The comment options sheet for edit/delete/report.
Future<CommentAction?> showCommentOptionsSheet(
  BuildContext context, {
  required PawComment comment,
}) {
  final isMine = comment.author.isMine;
  return showModalBottomSheet<CommentAction>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMine) ...[
              _OptionTile(
                icon: FluentIcons.edit_24_regular,
                label: context.l10n.pawhubEditComment,
                onTap: () => Navigator.pop(context, CommentAction.edit),
              ),
              _OptionTile(
                icon: FluentIcons.delete_24_regular,
                label: context.l10n.pawhubCommentOptionDeleteComment,
                destructive: true,
                onTap: () => Navigator.pop(context, CommentAction.delete),
              ),
            ] else ...[
              _OptionTile(
                icon: FluentIcons.flag_24_regular,
                label: context.l10n.pawhubCommentOptionReportComment,
                destructive: true,
                onTap: () => Navigator.pop(context, CommentAction.report),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    ),
  );
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
