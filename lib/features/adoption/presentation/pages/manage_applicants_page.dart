import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../domain/entities/adoption_listing.dart';
import '../providers/adoption_providers.dart';
import '../widgets/adoption_format.dart';
import 'adoption_rehome_success_page.dart';

/// Lister-side applicant review for one of the current user's listings.
///
/// Lists everyone who has applied to adopt the pet and drives the owner half of
/// the transfer handshake per request: Approve / Reject a pending applicant,
/// then — once the adopter has accepted ("I'll take it") — the gated
/// "Complete transfer" that irreversibly hands the pet over.
class ManageApplicantsPage extends ConsumerStatefulWidget {
  const ManageApplicantsPage({
    required this.listingId,
    this.initialListing,
    super.key,
  });

  final int listingId;

  /// The listing tapped through from the detail screen, seeding the pet header
  /// so it renders instantly.
  final AdoptionListing? initialListing;

  @override
  ConsumerState<ManageApplicantsPage> createState() =>
      _ManageApplicantsPageState();
}

class _ManageApplicantsPageState extends ConsumerState<ManageApplicantsPage> {
  /// The request id currently running an action, so only its row shows a
  /// spinner and the others disable while it's in flight.
  int? _busyRequestId;

  /// Kicks off a background refresh of the board, this listing, and its
  /// applicant list. Fire-and-forget — callers don't wait on it.
  void _refreshBoard() {
    unawaited(ref.read(adoptionListingsProvider.notifier).refresh());
    ref.invalidate(adoptionListingProvider(widget.listingId));
    ref.invalidate(adoptionListingRequestsProvider(widget.listingId));
  }

  Future<void> _approve(AdoptionRequest req, String petName) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.checkmark_circle_24_regular,
      title: l10n.adoptionApproveConfirmTitle(req.requester.fullName),
      message: l10n.adoptionApproveConfirmMessage(petName),
      confirmLabel: l10n.adoptionApprove,
      cancelLabel: l10n.cancel,
    );
    if (!confirmed || !mounted) return;

    setState(() => _busyRequestId = req.id);
    final result = await ref
        .read(adoptionRepositoryProvider)
        .approveRequest(widget.listingId, req.id);
    if (!mounted) return;
    setState(() => _busyRequestId = null);

    result.when(
      success: (_) {
        _refreshBoard();
        context.showSuccessSnackBar(
          l10n.adoptionApproveSuccess(req.requester.fullName),
        );
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  Future<void> _reject(AdoptionRequest req) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.dismiss_circle_24_regular,
      title: l10n.adoptionRejectConfirmTitle(req.requester.fullName),
      message: l10n.adoptionRejectConfirmMessage,
      confirmLabel: l10n.adoptionReject,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _busyRequestId = req.id);
    final result = await ref
        .read(adoptionRepositoryProvider)
        .rejectRequest(widget.listingId, req.id);
    if (!mounted) return;
    setState(() => _busyRequestId = null);

    result.when(
      success: (_) {
        _refreshBoard();
        context.showSuccessSnackBar(l10n.adoptionRejectSuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  Future<void> _complete(AdoptionRequest req, String petName) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.home_24_regular,
      title: l10n.adoptionCompleteConfirmTitle(petName, req.requester.fullName),
      message:
          l10n.adoptionCompleteConfirmMessage(petName, req.requester.fullName),
      confirmLabel: l10n.adoptionCompleteTransfer,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _busyRequestId = req.id);
    final result = await ref
        .read(adoptionRepositoryProvider)
        .completeRequest(widget.listingId, req.id);
    if (!mounted) return;
    setState(() => _busyRequestId = null);

    result.when(
      success: (transferredPet) {
        // For a rehome, the pet has left this user's account — drop it from the
        // gate optimistically and reconcile. A shelter listing has no backing
        // pet (id null), so there's nothing local to remove.
        final transferredId = transferredPet.id;
        if (transferredId != null) {
          ref.read(petsProvider.notifier).removePet(transferredId);
        }
        ref.read(petListProvider.notifier).refresh();
        _refreshBoard();

        // Replace this screen with the celebration (no "back" into a now-empty
        // applicant list).
        context.pushReplacement(
          AppRoutes.adoptionRehomeSuccess,
          extra: AdoptionRehomeSuccessArgs(
            petName: petName,
            adopterName: req.requester.fullName,
          ),
        );
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // Pet header comes from the freshly-loaded listing, falling back to the
    // seed so it's never blank.
    final listing =
        ref.watch(adoptionListingProvider(widget.listingId)).value ??
            widget.initialListing;
    final petName = listing?.pet.name ?? '';
    final requestsAsync =
        ref.watch(adoptionListingRequestsProvider(widget.listingId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.adoptionManageTitle),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(adoptionListingRequestsProvider(widget.listingId));
          await ref.read(adoptionListingRequestsProvider(widget.listingId).future);
        },
        child: requestsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => _ErrorState(
            onRetry: () => ref.invalidate(
              adoptionListingRequestsProvider(widget.listingId),
            ),
          ),
          data: (requests) {
            if (requests.isEmpty) {
              return _EmptyState(petName: petName);
            }
            // Only one applicant can be in the transfer track at a time. Once
            // someone is approved (or the transfer completed), the other pending
            // applicants can't be approved — the lister must reject the current
            // pick first (which reopens the listing) before choosing another.
            final hasActivePick = requests.any(
              (r) =>
                  r.status == AdoptionRequestStatus.approved ||
                  r.status == AdoptionRequestStatus.completed,
            );
            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: requests.length + 1,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Text(
                      l10n.adoptionManageSubtitle(requests.length, petName),
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  );
                }
                final req = requests[i - 1];
                return _ApplicantCard(
                  request: req,
                  petName: petName,
                  busy: _busyRequestId == req.id,
                  // Lock the whole list while any action is running.
                  actionsEnabled: _busyRequestId == null,
                  // Another applicant already holds the transfer slot.
                  hasActivePick: hasActivePick,
                  onApprove: () => _approve(req, petName),
                  onReject: () => _reject(req),
                  onComplete: () => _complete(req, petName),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// ── Applicant card ──────────────────────────────────────────────────────────

class _ApplicantCard extends StatelessWidget {
  const _ApplicantCard({
    required this.request,
    required this.petName,
    required this.busy,
    required this.actionsEnabled,
    required this.hasActivePick,
    required this.onApprove,
    required this.onReject,
    required this.onComplete,
  });

  final AdoptionRequest request;
  final String petName;
  final bool busy;
  final bool actionsEnabled;

  /// True when another applicant is already approved/completed, so this pending
  /// applicant can't be approved (only one transfer track at a time).
  final bool hasActivePick;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppAvatar(
                imageUrl: request.requester.avatarUrl,
                name: request.requester.fullName,
                radius: 24,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.requester.fullName,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.adoptionApplicantApplied(
                        AdoptionFormat.postedAgo(l10n, request.requestedAt,
                            now: now),
                      ),
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              _StatusChip(status: request.status),
            ],
          ),
          ..._buildActions(context, l10n),
        ],
      ),
    );
  }

  /// The action area, driven by the owner-side handshake state.
  List<Widget> _buildActions(BuildContext context, AppLocalizations l10n) {
    // Pending → approve / reject. Approve is blocked while another applicant
    // already holds the transfer slot (only one at a time); Reject stays open.
    if (request.status == AdoptionRequestStatus.pending) {
      return [
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: l10n.adoptionReject,
                variant: AppButtonVariant.outlined,
                onPressed: actionsEnabled ? onReject : null,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: l10n.adoptionApprove,
                icon: FluentIcons.checkmark_24_regular,
                variant: AppButtonVariant.primary,
                isLoading: busy,
                onPressed:
                    (actionsEnabled && !hasActivePick) ? onApprove : null,
              ),
            ),
          ],
        ),
        if (hasActivePick) ...[
          const SizedBox(height: AppSpacing.sm),
          _HintRow(
            icon: FluentIcons.info_24_regular,
            label: l10n.adoptionOnePickHint,
          ),
        ],
      ];
    }

    // Approved: either waiting on the adopter, or ready to hand over.
    if (request.status == AdoptionRequestStatus.approved) {
      final accepted = request.adopterConfirmedAt != null;
      if (!accepted) {
        return [
          const SizedBox(height: AppSpacing.sm),
          _HintRow(
            icon: FluentIcons.hourglass_24_regular,
            label: l10n.adoptionAwaitingAdopter,
          ),
        ];
      }
      return [
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: l10n.adoptionCompleteTransfer,
          icon: FluentIcons.home_24_regular,
          variant: AppButtonVariant.primary,
          isLoading: busy,
          onPressed: actionsEnabled ? onComplete : null,
        ),
      ];
    }

    // Terminal states (rejected / cancelled / completed / expired): chip only.
    return const [];
  }
}

class _HintRow extends StatelessWidget {
  const _HintRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

/// A small pill for the applicant's request status.
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final AdoptionRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (label, color) = switch (status) {
      AdoptionRequestStatus.pending => (
          l10n.adoptionRequestStatusPending,
          AppColors.warning,
        ),
      AdoptionRequestStatus.approved => (
          l10n.adoptionRequestStatusApproved,
          AppColors.success,
        ),
      AdoptionRequestStatus.rejected => (
          l10n.adoptionRequestStatusRejected,
          AppColors.error,
        ),
      AdoptionRequestStatus.cancelled => (
          l10n.adoptionRequestStatusCancelled,
          AppColors.textSecondary,
        ),
      AdoptionRequestStatus.completed => (
          l10n.adoptionRequestStatusCompleted,
          AppColors.secondaryDark,
        ),
      AdoptionRequestStatus.expired => (
          l10n.adoptionRequestStatusExpired,
          AppColors.textSecondary,
        ),
    };

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: color),
      ),
    );
  }
}

// ── Empty / error states ──────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.petName});

  final String petName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // A viewport-filling scrollable so the content centers vertically while
    // pull-to-refresh still works when empty.
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    FluentIcons.people_team_24_regular,
                    size: 56,
                    color: AppColors.divider,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.adoptionManageEmptyTitle,
                    style: AppTextStyles.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.adoptionManageEmptyMessage(petName),
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Text(
          l10n.errorUnknown,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: l10n.retry,
          icon: FluentIcons.arrow_clockwise_24_regular,
          variant: AppButtonVariant.outlined,
          expanded: false,
          onPressed: onRetry,
        ),
      ],
    );
  }
}
