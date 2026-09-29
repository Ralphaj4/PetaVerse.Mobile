import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/post_upload_queue.dart';

/// App-wide banner showing background post uploads (progress / done / failed),
/// mounted above the bottom nav so it's visible on every tab. Renders nothing
/// when the queue is empty.
class UploadProgressBanner extends ConsumerWidget {
  const UploadProgressBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(postUploadQueueProvider);
    if (jobs.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final job in jobs)
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.xs, AppSpacing.md, AppSpacing.xs),
            child: _UploadRow(job: job),
          ),
      ],
    );
  }
}

class _UploadRow extends ConsumerWidget {
  const _UploadRow({required this.job});

  final PostUploadJob job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.read(postUploadQueueProvider.notifier);
    final failed = job.status == PostUploadStatus.failed;
    final success = job.status == PostUploadStatus.success;

    final (label, accent) = switch (job.status) {
      PostUploadStatus.uploading => (
          job.isVideo ? 'Uploading video…' : 'Uploading…',
          AppColors.primary,
        ),
      PostUploadStatus.creating => ('Finishing up…', AppColors.primary),
      PostUploadStatus.success => ('Posted 🐾', AppColors.success),
      PostUploadStatus.failed => ('Upload failed', AppColors.error),
    };

    return Material(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: AppRadius.lgAll,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            _Thumbnail(file: job.draft.thumbnailFile),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(label,
                            style: AppTextStyles.labelMedium
                                .copyWith(color: accent)),
                      ),
                      if (job.status == PostUploadStatus.uploading)
                        Text('${(job.progress * 100).round()}%',
                            style: AppTextStyles.labelSmall
                                .copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: (failed || job.status == PostUploadStatus.creating)
                          ? null
                          : (success ? 1.0 : job.progress),
                      minHeight: 4,
                      backgroundColor: AppColors.divider,
                      valueColor: AlwaysStoppedAnimation(accent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Trailing action: retry (failed), or dismiss (failed/done).
            if (failed)
              _IconBtn(
                icon: FluentIcons.arrow_clockwise_24_regular,
                color: AppColors.primary,
                onTap: () => queue.retry(job.id),
              ),
            if (failed || success)
              _IconBtn(
                icon: FluentIcons.dismiss_24_regular,
                color: AppColors.textTertiary,
                onTap: () => queue.dismiss(job.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({this.file});

  final File? file;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.smAll,
      child: SizedBox(
        width: 40,
        height: 40,
        child: file != null
            ? Image.file(file!, fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const _ThumbFallback())
            : const _ThumbFallback(),
      ),
    );
  }
}

class _ThumbFallback extends StatelessWidget {
  const _ThumbFallback();

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: AppColors.primarySoft,
        child: Icon(FluentIcons.image_24_regular,
            size: 18, color: AppColors.primary),
      );
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, required this.color, required this.onTap});

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}
