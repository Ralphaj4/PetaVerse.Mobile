import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/chat_entities.dart';
import '../providers/assistant_providers.dart';

/// Lists the user's past PetaBot conversations (`GET /ai/chat/sessions`).
///
/// Tapping a row pushes the assistant onto the stack to open that
/// conversation, so the chat gets a back button returning here rather than
/// closing. Each row can be archived (`DELETE /ai/chat/sessions/{id}`) via a
/// trailing button.
class AssistantHistoryPage extends ConsumerWidget {
  const AssistantHistoryPage({super.key});

  Future<void> _archive(
    BuildContext context,
    WidgetRef ref,
    ChatSessionSummary session,
  ) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.archive_24_regular,
      title: l10n.aiArchiveConfirmTitle,
      message: l10n.aiArchiveConfirmBody,
      confirmLabel: l10n.aiArchiveConfirmAction,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !context.mounted) return;

    final result = await ref.read(chatHistoryProvider.notifier).archive(session.id);
    if (!context.mounted) return;
    result.when(
      success: (_) {},
      failure: (_) => context.showErrorSnackBar(l10n.aiArchiveError),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final historyAsync = ref.watch(chatHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(l10n.aiHistoryTitle, style: AppTextStyles.titleMedium),
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : null,
          onRetry: () => ref.invalidate(chatHistoryProvider),
        ),
        data: (sessions) {
          if (sessions.isEmpty) {
            return EmptyStateWidget(
              icon: FluentIcons.chat_24_regular,
              title: l10n.aiHistoryEmptyTitle,
              message: l10n.aiHistoryEmptyBody,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            itemCount: sessions.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, i) => _SessionTile(
              session: sessions[i],
              onOpen: () =>
                  context.push(AppRoutes.assistant, extra: sessions[i].id),
              onArchive: () => _archive(context, ref, sessions[i]),
            ),
          );
        },
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.session,
    required this.onOpen,
    required this.onArchive,
  });

  final ChatSessionSummary session;
  final VoidCallback onOpen;
  final VoidCallback onArchive;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = (session.title?.trim().isNotEmpty ?? false)
        ? session.title!.trim()
        : l10n.aiHistoryUntitled;
    final subtitle = session.petName ?? l10n.aiGeneralChat;

    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        onTap: onOpen,
        borderRadius: AppRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: AppRadius.smAll,
                ),
                child: const Icon(
                  FluentIcons.sparkle_24_filled,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$subtitle · ${_formatDate(session.updatedAt)}',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                icon: const Icon(FluentIcons.archive_24_regular),
                iconSize: 20,
                color: AppColors.textTertiary,
                tooltip: l10n.aiArchiveTooltip,
                onPressed: onArchive,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Compact local date for the row subtitle (e.g. "Aug 31").
  String _formatDate(DateTime utc) =>
      DateFormat.MMMd().format(utc.toLocal());
}
