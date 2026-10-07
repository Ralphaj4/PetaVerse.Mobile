import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/legal.dart';
import '../providers/legal_providers.dart';

/// Blocking legal wall shown when the signed-in user owes acceptance of one or
/// more updated legal documents. The router forces the user here (after auth,
/// before home) and only lets them out once every pending document is accepted.
///
/// The single CTA accepts every pending document in one go; each is posted
/// individually and the gate adopts the refreshed status the server returns.
class LegalAcceptancePage extends ConsumerStatefulWidget {
  const LegalAcceptancePage({super.key});

  @override
  ConsumerState<LegalAcceptancePage> createState() =>
      _LegalAcceptancePageState();
}

class _LegalAcceptancePageState extends ConsumerState<LegalAcceptancePage> {
  bool _submitting = false;

  /// Resolves the version to accept for [item]: the authoritative current
  /// version from /legal/current when loaded, else the one on the status item.
  String? _versionFor(LegalStatusItem item, LegalDocuments? current) =>
      current?.forType(item.documentType)?.version ?? item.currentVersion;

  /// Opens the document for in-app reading: resolves the version to show, then
  /// presents a full-height modal that fetches and renders the markdown body
  /// from /content. No external browser - the document stays inside the app.
  void _openDocument(LegalStatusItem item) {
    final current = ref.read(legalCurrentProvider).value;
    final version = _versionFor(item, current);
    if (version == null || version.isEmpty) {
      context.showErrorSnackBar(context.l10n.legalDocumentUnavailable);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => _LegalContentSheet(
        type: item.documentType,
        version: version,
        title: _titleFor(context.l10n, item.documentType),
      ),
    );
  }

  /// The localized title for a document type (shared with the row + the sheet).
  static String _titleFor(AppLocalizations l10n, LegalDocumentType type) =>
      switch (type) {
        LegalDocumentType.privacyPolicy => l10n.legalPrivacyPolicy,
        LegalDocumentType.termsAndConditions => l10n.legalTermsAndConditions,
        LegalDocumentType.communityGuidelines => l10n.legalCommunityGuidelines,
        LegalDocumentType.unknown => l10n.legalDocument,
      };

  Future<void> _acceptAll(List<LegalStatusItem> pending) async {
    setState(() => _submitting = true);
    final repo = ref.read(legalRepositoryProvider);
    final current = ref.read(legalCurrentProvider).value;

    for (final item in pending) {
      final version = _versionFor(item, current);
      if (version == null || version.isEmpty) {
        if (!mounted) return;
        setState(() => _submitting = false);
        context.showErrorSnackBar(context.l10n.legalDocumentUnavailable);
        return;
      }

      final result =
          await repo.accept(type: item.documentType, version: version);
      if (!mounted) return;

      final failed = result.failureOrNull;
      if (failed != null) {
        setState(() => _submitting = false);
        context.showErrorSnackBar(failed.localizedMessage(context.l10n));
        return;
      }
      ref.read(legalGateProvider.notifier).markStatus(result.valueOrNull!);
    }

    if (mounted) setState(() => _submitting = false);
  }

  IconData _iconFor(LegalDocumentType type) => switch (type) {
        LegalDocumentType.privacyPolicy =>
          FluentIcons.shield_checkmark_24_regular,
        LegalDocumentType.termsAndConditions =>
          FluentIcons.document_text_24_regular,
        LegalDocumentType.communityGuidelines =>
          FluentIcons.people_community_24_regular,
        LegalDocumentType.unknown => FluentIcons.document_24_regular,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gate = ref.watch(legalGateProvider);
    final pending = gate.pending;

    return Scaffold(
      backgroundColor: AppColors.backgroundWarm,
      body: Stack(
        children: [
          // Ambient paw decorations matching the auth flow aesthetic.
          const Positioned.fill(child: _PawDecorations()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // Header icon in a warm-primary circle.
                  Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        FluentIcons.document_checkmark_24_regular,
                        size: 44,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    l10n.legalUpdatedTitle,
                    style: AppTextStyles.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.legalUpdatedMessage,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Expanded(
                    child: ListView.separated(
                      itemCount: pending.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (_, i) => _DocumentRow(
                        item: pending[i],
                        icon: _iconFor(pending[i].documentType),
                        onView: () => _openDocument(pending[i]),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton(
                    onPressed: _submitting ? null : () => _acceptAll(pending),
                    child: _submitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.onPrimary,
                            ),
                          )
                        : Text(l10n.legalAcceptAll),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Ambient paw prints scattered behind the content, matching the auth-flow
/// aesthetic but using the primary orange tint.
class _PawDecorations extends StatelessWidget {
  const _PawDecorations();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Top-left gradient blob.
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primarySoft,
                    AppColors.primarySoft.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Bottom-right gradient blob.
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primarySoft,
                    AppColors.primarySoft.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Scattered paw prints.
          const Positioned(
            top: 80,
            left: 20,
            child: _FadedPaw(size: 48, angle: -0.4),
          ),
          const Positioned(
            top: 200,
            right: 18,
            child: _FadedPaw(size: 36, angle: 0.6),
          ),
          const Positioned(
            top: 380,
            left: 30,
            child: _FadedPaw(size: 32, angle: -0.2),
          ),
          const Positioned(
            bottom: 180,
            right: 24,
            child: _FadedPaw(size: 44, angle: 0.3),
          ),
          const Positioned(
            bottom: 80,
            left: 50,
            child: _FadedPaw(size: 28, angle: 0.8),
          ),
        ],
      ),
    );
  }
}

class _FadedPaw extends StatelessWidget {
  const _FadedPaw({required this.size, required this.angle});

  final double size;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Icon(
        FluentIcons.animal_paw_print_24_filled,
        size: size,
        color: AppColors.primary.withValues(alpha: 0.10),
      ),
    );
  }
}

/// One pending document row with icon, title, subtitle, and view chevron.
class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.item,
    required this.icon,
    required this.onView,
  });

  final LegalStatusItem item;
  final IconData icon;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      onTap: onView,
      borderRadius: AppRadius.lgAll,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _LegalAcceptancePageState._titleFor(
                        l10n, item.documentType),
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.legalViewDocument,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Icon(
              context.isRtl
                  ? FluentIcons.chevron_left_24_regular
                  : FluentIcons.chevron_right_24_regular,
              size: 18,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

/// Full-height modal that fetches a document's markdown body from /content and
/// renders it in-app.
class _LegalContentSheet extends ConsumerWidget {
  const _LegalContentSheet({
    required this.type,
    required this.version,
    required this.title,
  });

  final LegalDocumentType type;
  final String version;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contentAsync = ref.watch(legalContentProvider(type, version));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(title, style: AppTextStyles.titleLarge),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: l10n.close,
                  icon: const Icon(
                    FluentIcons.dismiss_24_regular,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(
            child: contentAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) => _ContentError(
                onClose: () {
                  Navigator.of(context).pop();
                  context.showErrorSnackBar(l10n.legalDocumentUnavailable);
                },
              ),
              data: (content) => Markdown(
                controller: scrollController,
                data: content.body,
                padding: const EdgeInsets.all(AppSpacing.lg),
                styleSheet: MarkdownStyleSheet(
                  p: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  h1: AppTextStyles.headlineMedium,
                  h2: AppTextStyles.titleLarge,
                  h3: AppTextStyles.titleMedium,
                  listBullet: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  a: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.secondary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentError extends StatelessWidget {
  const _ContentError({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.document_error_24_regular,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.legalDocumentUnavailable,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            TextButton(onPressed: onClose, child: Text(l10n.close)),
          ],
        ),
      ),
    );
  }
}

/// Non-closable dialog shown when only Community Guidelines need acknowledgement,
/// triggered when the user opens the PetaHub tab. Uses [LegalAcceptanceKind.acknowledgement]
/// wording ("I understand") rather than "Accept".
class CommunityGuidelinesDialog extends ConsumerStatefulWidget {
  const CommunityGuidelinesDialog({
    required this.item,
    super.key,
  });

  final LegalStatusItem item;

  @override
  ConsumerState<CommunityGuidelinesDialog> createState() =>
      _CommunityGuidelinesDialogState();
}

class _CommunityGuidelinesDialogState
    extends ConsumerState<CommunityGuidelinesDialog> {
  bool _submitting = false;

  void _openDocument() {
    final current = ref.read(legalCurrentProvider).value;
    final version =
        current?.forType(widget.item.documentType)?.version ??
            widget.item.currentVersion;
    if (version == null || version.isEmpty) {
      context.showErrorSnackBar(context.l10n.legalDocumentUnavailable);
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => _LegalContentSheet(
        type: widget.item.documentType,
        version: version,
        title: context.l10n.legalCommunityGuidelines,
      ),
    );
  }

  Future<void> _acknowledge() async {
    setState(() => _submitting = true);
    final current = ref.read(legalCurrentProvider).value;
    final version =
        current?.forType(widget.item.documentType)?.version ??
            widget.item.currentVersion;

    if (version == null || version.isEmpty) {
      if (!mounted) return;
      setState(() => _submitting = false);
      context.showErrorSnackBar(context.l10n.legalDocumentUnavailable);
      return;
    }

    final result = await ref.read(legalRepositoryProvider).accept(
          type: widget.item.documentType,
          version: version,
        );
    if (!mounted) return;

    final failed = result.failureOrNull;
    if (failed != null) {
      setState(() => _submitting = false);
      context.showErrorSnackBar(failed.localizedMessage(context.l10n));
      return;
    }

    ref.read(legalGateProvider.notifier).markStatus(result.valueOrNull!);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PopScope(
      // Non-closable: user must acknowledge before continuing.
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
        backgroundColor: AppColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  FluentIcons.people_community_24_regular,
                  size: 32,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.legalCommunityGuidelinesTitle,
                style: AppTextStyles.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.legalCommunityGuidelinesMessage,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              InkWell(
                onTap: _openDocument,
                borderRadius: AppRadius.mdAll,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FluentIcons.document_text_24_regular,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          l10n.legalCommunityGuidelines,
                          style: AppTextStyles.titleSmall
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                      Icon(
                        context.isRtl
                            ? FluentIcons.chevron_left_20_regular
                            : FluentIcons.chevron_right_20_regular,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _submitting ? null : _acknowledge,
                  child: _submitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.onPrimary,
                          ),
                        )
                      : Text(l10n.legalIUnderstand),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows the [CommunityGuidelinesDialog] as a non-dismissible dialog.
/// Call this from the PetaHub page when only community guidelines remain.
Future<void> showCommunityGuidelinesDialog(
  BuildContext context,
  LegalStatusItem item,
) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => CommunityGuidelinesDialog(item: item),
  );
}
