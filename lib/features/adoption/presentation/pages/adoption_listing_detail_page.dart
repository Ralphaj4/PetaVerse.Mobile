import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../pets/domain/entities/pet_ref.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../domain/entities/adoption_listing.dart';
import '../providers/adoption_providers.dart';
import '../widgets/adoption_card.dart';
import '../widgets/adoption_format.dart';
import '../widgets/adoption_status_badge.dart';
import 'adoption_rehome_success_page.dart';
import 'adoption_welcome_page.dart';

/// Full details for a single adoption listing, fetched by id and seeded
/// instantly from the tapped [initialListing] (so the screen is never blank and
/// the photo animates via [Hero]).
///
/// The primary action is state-adaptive: the lister sees "Manage applicants",
/// an already-applied user sees a disabled "Applied", a closed listing shows a
/// muted status, and everyone else sees "Apply to adopt" (the first half of the
/// two-sided confirm handshake).
class AdoptionListingDetailPage extends ConsumerStatefulWidget {
  const AdoptionListingDetailPage({
    required this.listingId,
    this.initialListing,
    super.key,
  });

  final int listingId;
  final AdoptionListing? initialListing;

  @override
  ConsumerState<AdoptionListingDetailPage> createState() =>
      _AdoptionListingDetailPageState();
}

class _AdoptionListingDetailPageState
    extends ConsumerState<AdoptionListingDetailPage> {
  bool _applying = false;
  bool _deleting = false;
  bool _accepting = false;
  bool _cancelling = false;
  bool _completing = false;

  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    // Force a fresh fetch every time this page is opened so the detail is
    // never stale from a previous visit or the board's list cache.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.invalidate(adoptionListingProvider(widget.listingId));
      ref.invalidate(myAdoptionRequestsProvider);
    });
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  /// Poll both the listing and the adopter's requests every 10 s so state
  /// changes made by the other party (approve, complete) surface automatically.
  /// Started when the adopter has a pending or awaitingHandover request;
  /// cancelled on transfer completion or dispose.
  void _startPolling() {
    if (_pollTimer != null) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (!mounted) return;
      ref.invalidate(adoptionListingProvider(widget.listingId));
      ref.invalidate(myAdoptionRequestsProvider);
    });
  }

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> _apply(AdoptionListing listing) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.heart_24_regular,
      title: l10n.adoptionApplyConfirmTitle(listing.pet.name),
      message: l10n.adoptionApplyConfirmMessage,
      confirmLabel: l10n.adoptionApply,
      cancelLabel: l10n.cancel,
    );
    if (!confirmed || !mounted) return;

    setState(() => _applying = true);
    final result = await ref.read(adoptionRepositoryProvider).apply(listing.id);
    if (!mounted) return;
    setState(() => _applying = false);

    result.when(
      success: (_) {
        ref.read(adoptionListingsProvider.notifier).refresh();
        ref.invalidate(myAdoptionRequestsProvider);
        ref.invalidate(adoptionListingProvider(widget.listingId));
        context.showSuccessSnackBar(l10n.adoptionApplySuccess);
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  Future<void> _accept(MyAdoptionRequest req) async {
    final l10n = context.l10n;
    setState(() => _accepting = true);
    final result = await ref.read(adoptionRepositoryProvider).acceptRequest(req.id);
    if (!mounted) return;
    setState(() => _accepting = false);

    result.when(
      success: (updated) {
        ref.invalidate(myAdoptionRequestsProvider);
        ref.invalidate(adoptionListingProvider(widget.listingId));
        if (updated.isCompleted) {
          _onTransferred(updated);
        } else {
          context.showSuccessSnackBar(l10n.adoptionAcceptSuccess);
        }
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  Future<void> _cancel(MyAdoptionRequest req) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.dismiss_circle_24_regular,
      title: l10n.adoptionCancelConfirmTitle,
      message: l10n.adoptionCancelConfirmMessage,
      confirmLabel: l10n.adoptionCancelApplication,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _cancelling = true);
    final result = await ref.read(adoptionRepositoryProvider).cancelRequest(req.id);
    if (!mounted) return;
    setState(() => _cancelling = false);

    result.when(
      success: (_) {
        ref.invalidate(myAdoptionRequestsProvider);
        ref.invalidate(adoptionListingProvider(widget.listingId));
        unawaited(ref.read(adoptionListingsProvider.notifier).refresh());
        context.showSuccessSnackBar(l10n.adoptionCancelSuccess);
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  Future<void> _complete(AdoptionListing listing, AdoptionRequest req) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.home_24_regular,
      title: l10n.adoptionCompleteConfirmTitle(
          listing.pet.name, req.requester.fullName),
      message: l10n.adoptionCompleteConfirmMessage(
          listing.pet.name, req.requester.fullName),
      confirmLabel: l10n.adoptionCompleteTransfer,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _completing = true);
    final result = await ref
        .read(adoptionRepositoryProvider)
        .completeRequest(listing.id, req.id);
    if (!mounted) return;
    setState(() => _completing = false);

    result.when(
      success: (transferredPet) {
        final transferredId = transferredPet.id;
        if (transferredId != null) {
          ref.read(petsProvider.notifier).removePet(transferredId);
        }
        ref.invalidate(petListProvider);
        ref.invalidate(myAdoptionListingsProvider);
        unawaited(ref.read(adoptionListingsProvider.notifier).refresh());
        context.pushReplacement(
          AppRoutes.adoptionRehomeSuccess,
          extra: AdoptionRehomeSuccessArgs(
            petName: listing.pet.name,
            adopterName: req.requester.fullName,
          ),
        );
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  void _onTransferred(MyAdoptionRequest req) {
    final petId = req.pet.id;
    if (petId != null) {
      ref.read(petsProvider.notifier).addCreatedPet(
            PetRef(id: petId, name: req.pet.name, imagePath: req.pet.avatarUrl),
          );
      ref.invalidate(petListProvider);
      context.push(
        AppRoutes.adoptionWelcome,
        extra: AdoptionWelcomeArgs(petId: petId, petName: req.pet.name),
      );
    }
  }

  void _manage(AdoptionListing listing) {
    context.push(AppRoutes.adoptionManagePath(listing.id), extra: listing);
  }

  Future<void> _delete(AdoptionListing listing) async {
    final l10n = context.l10n;
    final count = listing.applicantCount;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.delete_24_regular,
      title: l10n.adoptionDeleteConfirmTitle,
      message: count > 0
          ? l10n.adoptionDeleteConfirmMessageWithApplicants(
              listing.pet.name, count)
          : l10n.adoptionDeleteConfirmMessage(listing.pet.name),
      confirmLabel: l10n.adoptionDelete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _deleting = true);
    final result =
        await ref.read(adoptionRepositoryProvider).deleteListing(listing.id);
    if (!mounted) return;
    setState(() => _deleting = false);

    result.when(
      success: (_) {
        ref.read(myAdoptionListingsProvider.notifier).remove(listing.id);
        ref.read(adoptionListingsProvider.notifier).refresh();
        context.showSuccessSnackBar(l10n.adoptionDeleteSuccess);
        context.pop();
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(adoptionListingProvider(widget.listingId));
    final listing = async.value ?? widget.initialListing;
    final myRequest =
        ref.watch(myAdoptionRequestForListingProvider(widget.listingId));

    // Lister: watch for the approved+accepted request so "Complete" can surface.
    final requestsAsync = listing?.isOwnListing == true
        ? ref.watch(adoptionListingRequestsProvider(widget.listingId))
        : const AsyncData(<AdoptionRequest>[]);
    final readyToComplete = requestsAsync.value?.where((r) =>
        r.status == AdoptionRequestStatus.approved &&
        r.adopterConfirmedAt != null).firstOrNull;

    // Adopter: fire the welcome page the moment the lister completes the
    // transfer — no manual refresh required. Two-step cascade:
    //   1. Listen to the listing itself. When it flips to `adopted` while the
    //      adopter has an awaitingHandover request, invalidate their requests
    //      provider so the derived provider refreshes.
    //   2. Listen to the derived request. When it lands on `completed`, push
    //      the welcome page exactly once.
    // Poll while the adopter is waiting on the other party:
    //   pending       → waiting for lister to approve
    //   awaitingHandover → waiting for lister to complete transfer
    // Stop in all other states (no request, approved+unaccepted, completed).
    final shouldPoll = myRequest?.status == AdoptionRequestStatus.pending ||
        myRequest?.awaitingHandover == true;
    if (shouldPoll) {
      _startPolling();
    } else {
      _stopPolling();
    }

    ref.listen<AsyncValue<AdoptionListing>>(
      adoptionListingProvider(widget.listingId),
      (previous, next) {
        final became = next.value;
        if (became == null) return;
        // Listing flipped to adopted → cascade to requests so isCompleted fires.
        if (became.status == AdoptionListingStatus.adopted &&
            previous?.value?.status != AdoptionListingStatus.adopted) {
          ref.invalidate(myAdoptionRequestsProvider);
        }
      },
    );

    ref.listen<MyAdoptionRequest?>(
      myAdoptionRequestForListingProvider(widget.listingId),
      (previous, next) {
        if (next != null &&
            next.isCompleted &&
            previous?.isCompleted != true) {
          _stopPolling();
          _onTransferred(next);
        }
      },
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: listing == null
            ? _LoadingOrError(
                isError: async.hasError,
                onRetry: () =>
                    ref.invalidate(adoptionListingProvider(widget.listingId)),
              )
            : _Content(
                listing: listing,
                myRequest: myRequest,
                readyToComplete: readyToComplete,
                applying: _applying,
                accepting: _accepting,
                cancelling: _cancelling,
                completing: _completing,
                deleting: _deleting,
                onApply: () => _apply(listing),
                onAccept: myRequest != null ? () => _accept(myRequest) : null,
                onCancel: myRequest != null ? () => _cancel(myRequest) : null,
                onComplete: (listing.isOwnListing && readyToComplete != null)
                    ? () => _complete(listing, readyToComplete)
                    : null,
                onManage: () => _manage(listing),
                onDelete: () => _delete(listing),
                onRefresh: () async {
                  ref.invalidate(adoptionListingProvider(widget.listingId));
                  ref.invalidate(myAdoptionRequestsProvider);
                  await ref.read(adoptionListingProvider(widget.listingId).future);
                },
              ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.listing,
    required this.myRequest,
    required this.readyToComplete,
    required this.applying,
    required this.accepting,
    required this.cancelling,
    required this.completing,
    required this.deleting,
    required this.onApply,
    required this.onAccept,
    required this.onCancel,
    required this.onComplete,
    required this.onManage,
    required this.onDelete,
    required this.onRefresh,
  });

  final AdoptionListing listing;
  final MyAdoptionRequest? myRequest;
  final AdoptionRequest? readyToComplete;
  final bool applying;
  final bool accepting;
  final bool cancelling;
  final bool completing;
  final bool deleting;
  final VoidCallback onApply;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;
  final VoidCallback onManage;
  final VoidCallback onDelete;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          color: AppColors.primary,
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Hero(
                  tag: adoptionHeroTag(listing.id),
                  child: AppCachedImage(
                    imageUrl: listing.pet.avatarUrl,
                    height: 300,
                    width: double.infinity,
                    borderRadius: BorderRadius.zero,
                    semanticLabel: listing.pet.name,
                  ),
                ),
                _Body(
                  listing: listing,
                  myRequest: myRequest,
                  readyToComplete: readyToComplete,
                  applying: applying,
                  accepting: accepting,
                  cancelling: cancelling,
                  completing: completing,
                  deleting: deleting,
                  onApply: onApply,
                  onAccept: onAccept,
                  onCancel: onCancel,
                  onComplete: onComplete,
                  onManage: onManage,
                  onDelete: onDelete,
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: 0,
          start: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _CircleIconButton(
                icon: context.isRtl
                    ? FluentIcons.arrow_right_24_regular
                    : FluentIcons.arrow_left_24_regular,
                tooltip: context.l10n.close,
                onTap: () => context.pop(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.listing,
    required this.myRequest,
    required this.readyToComplete,
    required this.applying,
    required this.accepting,
    required this.cancelling,
    required this.completing,
    required this.deleting,
    required this.onApply,
    required this.onAccept,
    required this.onCancel,
    required this.onComplete,
    required this.onManage,
    required this.onDelete,
  });

  final AdoptionListing listing;
  final MyAdoptionRequest? myRequest;
  final AdoptionRequest? readyToComplete;
  final bool applying;
  final bool accepting;
  final bool cancelling;
  final bool completing;
  final bool deleting;
  final VoidCallback onApply;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;
  final VoidCallback onManage;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final now = DateTime.now();
    final pet = listing.pet;

    return Container(
      transform: Matrix4.translationValues(0, -(AppRadius.lg + 4), 0),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppRadius.lg + 4)),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AdoptionStatusBadge(status: listing.status),
              const Spacer(),
              Text(
                AdoptionFormat.postedAgo(l10n, listing.createdAt, now: now),
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  pet.name,
                  style: AppTextStyles.displayLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (pet.breedLabel.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.md),
                _BreedPill(label: pet.breedLabel),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Facts grid: species, age, sex ────────────────────────────────
          _FactsGrid(listing: listing, now: now),
          const SizedBox(height: AppSpacing.lg),

          // ── Trait chips ──────────────────────────────────────────────────
          if (listing.vaccinated ||
              listing.neutered ||
              listing.goodWithKids) ...[
            _TraitWrap(listing: listing),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── About ────────────────────────────────────────────────────────
          if (listing.description != null &&
              listing.description!.isNotEmpty) ...[
            Text(l10n.adoptionAboutTitle, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              listing.description!,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── Location ─────────────────────────────────────────────────────
          if (listing.locationLabel != null &&
              listing.locationLabel!.isNotEmpty) ...[
            Row(
              children: [
                const Icon(FluentIcons.location_24_regular,
                    size: 18, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(listing.locationLabel!,
                      style: AppTextStyles.bodyMedium),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // ── Lister card ──────────────────────────────────────────────────
          _ListerCard(lister: listing.lister),
          const SizedBox(height: AppSpacing.xl),

          // ── Action strip ─────────────────────────────────────────────────
          _ActionStrip(
            listing: listing,
            myRequest: myRequest,
            readyToComplete: readyToComplete,
            applying: applying,
            accepting: accepting,
            cancelling: cancelling,
            completing: completing,
            onApply: onApply,
            onAccept: onAccept,
            onCancel: onCancel,
            onComplete: onComplete,
            onManage: onManage,
          ),

          // ── Owner-only: delete (low-emphasis, destructive) ────────────────
          if (listing.isOwnListing &&
              listing.status != AdoptionListingStatus.adopted) ...[
            const SizedBox(height: AppSpacing.sm),
            _DeleteButton(deleting: deleting, onDelete: onDelete),
          ],
        ],
      ),
    );
  }
}

/// Full action strip: adapts to every combination of listing status, ownership,
/// and the current user's request state. Replaces the old single-button CTA.
class _ActionStrip extends StatelessWidget {
  const _ActionStrip({
    required this.listing,
    required this.myRequest,
    required this.readyToComplete,
    required this.applying,
    required this.accepting,
    required this.cancelling,
    required this.completing,
    required this.onApply,
    required this.onAccept,
    required this.onCancel,
    required this.onComplete,
    required this.onManage,
  });

  final AdoptionListing listing;
  final MyAdoptionRequest? myRequest;
  final AdoptionRequest? readyToComplete;
  final bool applying;
  final bool accepting;
  final bool cancelling;
  final bool completing;
  final VoidCallback onApply;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // ── Lister side ───────────────────────────────────────────────────────────
    if (listing.isOwnListing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // "Complete transfer" surfaces here once the adopter has accepted.
          if (readyToComplete != null) ...[
            AppButton(
              label: l10n.adoptionCompleteTransfer,
              icon: FluentIcons.home_24_regular,
              variant: AppButtonVariant.primary,
              isLoading: completing,
              onPressed: onComplete,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          AppButton(
            label: l10n.adoptionManageCount(listing.applicantCount),
            icon: FluentIcons.people_settings_24_regular,
            variant: readyToComplete != null
                ? AppButtonVariant.outlined
                : AppButtonVariant.primary,
            onPressed: onManage,
          ),
        ],
      );
    }

    // ── Adopter side ──────────────────────────────────────────────────────────
    final req = myRequest;

    // If the user has an existing request, always show their status and any
    // available actions — even if the listing is now closed. This covers:
    //   - approved (awaiting acceptance) → Accept button still visible
    //   - awaitingHandover → polling banner while lister completes
    //   - completed → triggers _onTransferred via ref.listen above
    if (req != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AppliedStatusBanner(request: req),
          if (req.awaitingMyAcceptance) ...[
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: l10n.adoptionAcceptCta,
              icon: FluentIcons.heart_24_regular,
              variant: AppButtonVariant.primary,
              isLoading: accepting,
              onPressed: onAccept,
            ),
            _WithdrawButton(
              label: l10n.adoptionCancelApplication,
              isLoading: cancelling,
              onPressed: onCancel,
            ),
          ] else if (req.status == AdoptionRequestStatus.pending ||
              req.awaitingHandover) ...[
            _WithdrawButton(
              label: l10n.adoptionCancelApplication,
              isLoading: cancelling,
              onPressed: req.status == AdoptionRequestStatus.pending
                  ? onCancel
                  : null, // can't withdraw once owner is awaiting handover
            ),
          ],
        ],
      );
    }

    // ── Closed listing (no involvement) ───────────────────────────────────────
    if (!listing.isAvailable) {
      return _UnavailableBanner(
          isAdopted: listing.status == AdoptionListingStatus.adopted);
    }

    // No request yet — show Apply.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          label: l10n.adoptionApply,
          icon: FluentIcons.heart_24_regular,
          variant: AppButtonVariant.secondary,
          isLoading: applying,
          onPressed: onApply,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.adoptionTransferNote,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Status banner for the current user's own request on this listing.
/// Mirrors [_UnavailableBanner] in shape; color and icon shift per state.
class _AppliedStatusBanner extends StatelessWidget {
  const _AppliedStatusBanner({required this.request});

  final MyAdoptionRequest request;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final (Color color, IconData icon, String title, String subtitle) =
        switch (request.status) {
      AdoptionRequestStatus.pending => (
          AppColors.warning,
          FluentIcons.hourglass_24_filled,
          l10n.adoptionApplied,
          l10n.adoptionAwaitingReview,
        ),
      AdoptionRequestStatus.approved when request.awaitingMyAcceptance => (
          AppColors.success,
          FluentIcons.checkmark_circle_24_filled,
          l10n.adoptionRequestStatusApproved,
          l10n.adoptionAcceptHint,
        ),
      AdoptionRequestStatus.approved => (
          AppColors.secondaryDark,
          FluentIcons.hourglass_24_filled,
          l10n.adoptionRequestStatusApproved,
          l10n.adoptionAwaitingHandover,
        ),
      AdoptionRequestStatus.rejected => (
          AppColors.error,
          FluentIcons.dismiss_circle_24_filled,
          l10n.adoptionRequestStatusRejected,
          l10n.adoptionAppliedSubtitle,
        ),
      AdoptionRequestStatus.completed => (
          AppColors.secondaryDark,
          FluentIcons.home_24_filled,
          l10n.adoptionRequestStatusCompleted,
          l10n.adoptionAppliedSubtitle,
        ),
      _ => (
          AppColors.textSecondary,
          FluentIcons.info_24_regular,
          l10n.adoptionApplied,
          l10n.adoptionAppliedSubtitle,
        ),
    };

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Semantics(
        label: title,
        container: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: AppRadius.mdAll,
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,
                        style: AppTextStyles.titleSmall.copyWith(color: color)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Low-emphasis withdraw link matching the style from [_MyApplicationsTab].
class _WithdrawButton extends StatelessWidget {
  const _WithdrawButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 1, thickness: 1, color: AppColors.divider),
          const SizedBox(height: AppSpacing.lg),
          Opacity(
            opacity: enabled ? 1 : 0.5,
            child: Material(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: AppRadius.mdAll,
              child: InkWell(
                onTap: enabled ? onPressed : null,
                borderRadius: AppRadius.mdAll,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.error,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FluentIcons.dismiss_circle_24_regular,
                              size: 18,
                              color: AppColors.error,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Flexible(
                              child: Text(
                                label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.labelLarge
                                    .copyWith(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Closed-listing banner shown when the pet has been adopted or the listing is
/// otherwise unavailable. Mirrors the shape and padding of [_AppliedConfirmation]
/// but uses a muted neutral palette so it reads as informational, not positive.
class _UnavailableBanner extends StatelessWidget {
  const _UnavailableBanner({required this.isAdopted});

  final bool isAdopted;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final (Color color, IconData icon, String label, String subtitle) =
        isAdopted
            ? (
                AppColors.secondaryDark,
                FluentIcons.home_24_filled,
                l10n.adoptionStatusAdopted,
                l10n.adoptionStatusAdoptedSubtitle,
              )
            : (
                AppColors.textSecondary,
                FluentIcons.info_24_regular,
                l10n.adoptionStatusUnavailable,
                l10n.adoptionStatusUnavailableSubtitle,
              );

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Semantics(
        label: label,
        container: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: AppRadius.mdAll,
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.titleSmall.copyWith(color: color),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Low-emphasis destructive action to permanently delete the owner's listing.
/// A full-width text button so it's reachable but visually subordinate to the
/// primary "Manage applicants" action above it.
class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.deleting, required this.onDelete});

  final bool deleting;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: deleting ? null : onDelete,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.error,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        ),
        icon: deleting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.error,
                ),
              )
            : const Icon(FluentIcons.delete_24_regular, size: 18),
        label: Text(l10n.adoptionDelete, style: AppTextStyles.labelLarge),
      ),
    );
  }
}

/// Grid of key facts (species / age / sex) — only the ones we know.
class _FactsGrid extends StatelessWidget {
  const _FactsGrid({required this.listing, required this.now});

  final AdoptionListing listing;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pet = listing.pet;
    final ageLabel = AdoptionFormat.age(l10n, pet.dateOfBirth, now: now);
    final sexLabel = AdoptionFormat.sex(l10n, pet.gender);

    final facts = <(SpeciesGlyph, String, String)>[
      if (pet.speciesName != null && pet.speciesName!.isNotEmpty)
        (
          AdoptionFormat.speciesIcon(pet.speciesName),
          l10n.adoptionFactSpecies,
          pet.speciesName!,
        ),
      if (ageLabel != null)
        (
          const SpeciesGlyph.icon(FluentIcons.calendar_24_regular),
          l10n.adoptionFactAge,
          ageLabel,
        ),
      if (sexLabel != null)
        (
          const SpeciesGlyph.icon(FluentIcons.animal_paw_print_24_regular),
          l10n.adoptionFactSex,
          sexLabel,
        ),
    ];

    if (facts.isEmpty) return const SizedBox.shrink();

    final tileWidth =
        (MediaQuery.sizeOf(context).width - AppSpacing.xl * 2 - AppSpacing.md) /
            2;

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        for (final f in facts)
          SizedBox(
            width: tileWidth,
            child: _FactTile(icon: f.$1, label: f.$2, value: f.$3),
          ),
      ],
    );
  }
}

class _FactTile extends StatelessWidget {
  const _FactTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final SpeciesGlyph icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          SpeciesGlyphIcon(glyph: icon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TraitWrap extends StatelessWidget {
  const _TraitWrap({required this.listing});

  final AdoptionListing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        if (listing.vaccinated)
          _TraitPill(
            icon: FluentIcons.shield_checkmark_24_filled,
            label: l10n.adoptionTraitVaccinated,
          ),
        if (listing.neutered)
          _TraitPill(
            icon: FluentIcons.heart_24_filled,
            label: l10n.adoptionTraitNeutered,
          ),
        if (listing.goodWithKids)
          _TraitPill(
            icon: FluentIcons.people_24_filled,
            label: l10n.adoptionTraitGoodWithKids,
          ),
      ],
    );
  }
}

class _TraitPill extends StatelessWidget {
  const _TraitPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.secondarySoft,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.secondaryDark),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.secondaryDark, letterSpacing: 0),
          ),
        ],
      ),
    );
  }
}

class _ListerCard extends StatelessWidget {
  const _ListerCard({required this.lister});

  final AdoptionUser lister;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          AppAvatar(
            imageUrl: lister.avatarUrl,
            name: lister.fullName,
            radius: 22,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.adoptionPostedBy, style: AppTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(
                  lister.fullName,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(FluentIcons.shield_checkmark_24_filled,
              size: 18, color: AppColors.secondary),
        ],
      ),
    );
  }
}

class _BreedPill extends StatelessWidget {
  const _BreedPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.animal_paw_print_20_filled,
              size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.primaryDark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        icon: Icon(icon, color: AppColors.textPrimary),
      ),
    );
  }
}

/// Shown only when there's neither a loaded listing nor a seed: a spinner while
/// loading, or a retry affordance on error.
class _LoadingOrError extends StatelessWidget {
  const _LoadingOrError({required this.isError, required this.onRetry});

  final bool isError;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (!isError) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.errorUnknown,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: l10n.retry,
              icon: FluentIcons.arrow_clockwise_24_regular,
              variant: AppButtonVariant.outlined,
              expanded: false,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
