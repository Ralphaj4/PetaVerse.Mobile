import 'dart:async';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_cached_image.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../pets/domain/entities/pet_ref.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../domain/entities/adoption_listing.dart';
import '../providers/adoption_providers.dart';
import '../widgets/adoption_card.dart';
import '../widgets/adoption_format.dart';
import 'adoption_welcome_page.dart';

/// The user's "My adoptions" hub: two segments — listings they created (owner)
/// and applications they submitted (adopter). Closes the loop so a listing
/// stays reachable after it leaves the public board, and gives the adopter a
/// place to accept ("I'll take them") and land the completed pet.
///
/// The switcher is a segmented pill (not a Material TabBar) with a gliding
/// highlight and live count badges, kept in sync with a swipeable [PageView].
class MyAdoptionsPage extends ConsumerStatefulWidget {
  const MyAdoptionsPage({super.key});

  @override
  ConsumerState<MyAdoptionsPage> createState() => _MyAdoptionsPageState();
}

class _MyAdoptionsPageState extends ConsumerState<MyAdoptionsPage> {
  late final PageController _pageController = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (index == _index) return;
    setState(() => _index = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // Counts drive the segment badges; null while loading so no badge shows.
    final listingsCount = ref.watch(myAdoptionListingsProvider).value?.length;
    final applicationsCount =
        ref.watch(myAdoptionRequestsProvider).value?.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.adoptionMyTitle),
        leading: IconButton(
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
            child: FilledButton.icon(
              onPressed: () => context.push(AppRoutes.listPetForAdoption),
              icon: const Icon(FluentIcons.add_24_regular, size: 18),
              label: Text(l10n.adoptionListAPet),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                textStyle: AppTextStyles.labelMedium,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xs,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: _SegmentedSwitcher(
              index: _index,
              segments: [
                _SegmentData(
                  label: l10n.adoptionMyTabListings,
                  icon: FluentIcons.animal_paw_print_24_regular,
                  count: listingsCount,
                ),
                _SegmentData(
                  label: l10n.adoptionMyTabApplications,
                  icon: FluentIcons.heart_24_regular,
                  count: applicationsCount,
                ),
              ],
              onSelected: _select,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _index = i),
              children: const [
                _MyListingsTab(),
                _MyApplicationsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Segmented pill switcher ─────────────────────────────────────────────────

class _SegmentData {
  const _SegmentData({
    required this.label,
    required this.icon,
    required this.count,
  });

  final String label;
  final IconData icon;
  final int? count;
}

/// A rounded pill with a gliding highlight behind the active segment. Uses a
/// [LayoutBuilder] so the moving indicator is measured to exact segment width,
/// keeping the animation crisp for any number of segments and RTL layouts.
class _SegmentedSwitcher extends StatelessWidget {
  const _SegmentedSwitcher({
    required this.index,
    required this.segments,
    required this.onSelected,
  });

  final int index;
  final List<_SegmentData> segments;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    const trackPadding = 4.0;
    return Container(
      padding: const EdgeInsets.all(trackPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.divider),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final segmentWidth = constraints.maxWidth / segments.length;
          // Align the highlight by fractional position: 0 → start, 1 → end.
          final t =
              segments.length > 1 ? index / (segments.length - 1) : 0.0;
          return Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                alignment: AlignmentDirectional(-1 + 2 * t, 0),
                child: Container(
                  width: segmentWidth,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.28),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < segments.length; i++)
                    Expanded(
                      child: _Segment(
                        data: segments[i],
                        selected: i == index,
                        onTap: () => onSelected(i),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _SegmentData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.onPrimary : AppColors.textSecondary;
    return Semantics(
      button: true,
      selected: selected,
      label: data.count != null
          ? '${data.label}, ${data.count}'
          : data.label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data.icon, size: 16, color: color),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelMedium.copyWith(color: color),
                ),
              ),
              if (data.count != null && data.count! > 0) ...[
                const SizedBox(width: AppSpacing.xs),
                _CountBadge(count: data.count!, selected: selected),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count, required this.selected});

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 18),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.onPrimary.withValues(alpha: 0.24)
            : AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        '$count',
        textAlign: TextAlign.center,
        style: AppTextStyles.labelSmall.copyWith(
          color: selected ? AppColors.onPrimary : AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── My listings tab ─────────────────────────────────────────────────────────

class _MyListingsTab extends ConsumerWidget {
  const _MyListingsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(myAdoptionListingsProvider);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorStateWidget(
        failure: e is Failure ? e : const UnknownFailure(),
        onRetry: () =>
            ref.read(myAdoptionListingsProvider.notifier).refresh(),
      ),
      data: (listings) {
        if (listings.isEmpty) {
          return _EmptyTab(
            icon: FluentIcons.animal_paw_print_24_regular,
            title: l10n.adoptionMyListingsEmptyTitle,
            message: l10n.adoptionMyListingsEmptyMessage,
          );
        }
        final now = DateTime.now();
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () =>
              ref.read(myAdoptionListingsProvider.notifier).refresh(),
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: listings.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, i) {
              final listing = listings[i];
              // Owner listings always route into the applicant-management flow
              // via the detail screen (its CTA is state-adaptive to "Manage").
              return AdoptionCard(
                listing: listing,
                now: now,
                onTap: () => context.push(
                  AppRoutes.adoptionDetailPath(listing.id),
                  extra: listing,
                ),
                onManage: () => context.push(
                  AppRoutes.adoptionManagePath(listing.id),
                  extra: listing,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ── My applications tab ───────────────────────────────────────────────────

class _MyApplicationsTab extends ConsumerStatefulWidget {
  const _MyApplicationsTab();

  @override
  ConsumerState<_MyApplicationsTab> createState() =>
      _MyApplicationsTabState();
}

class _MyApplicationsTabState extends ConsumerState<_MyApplicationsTab> {
  /// The request id running an action, so only its row shows a spinner.
  int? _busyId;

  void _refresh() {
    unawaited(ref.read(myAdoptionRequestsProvider.notifier).refresh());
  }

  Future<void> _accept(MyAdoptionRequest req) async {
    final l10n = context.l10n;
    setState(() => _busyId = req.id);
    final result =
        await ref.read(adoptionRepositoryProvider).acceptRequest(req.id);
    if (!mounted) return;
    setState(() => _busyId = null);

    result.when(
      success: (updated) {
        _refresh();
        // Completion can't happen here (that's the owner's step); acceptance
        // just records consent. If the backend returns a completed request
        // (owner already handed over), land the pet + celebrate.
        if (updated.isCompleted) {
          _onTransferred(updated);
        } else {
          context.showSuccessSnackBar(l10n.adoptionAcceptSuccess);
        }
      },
      failure: (f) => context.showErrorSnackBar(
        f.localizedMessage(l10n),
      ),
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

    setState(() => _busyId = req.id);
    final result =
        await ref.read(adoptionRepositoryProvider).cancelRequest(req.id);
    if (!mounted) return;
    setState(() => _busyId = null);

    result.when(
      success: (_) {
        _refresh();
        context.showSuccessSnackBar(l10n.adoptionCancelSuccess);
      },
      failure: (f) => context.showErrorSnackBar(
        f.localizedMessage(l10n),
      ),
    );
  }

  /// The transfer completed and [req]'s pet is now in the adopter's account:
  /// drop it into the gate (graduating a pet-less adopter off onboarding) and
  /// show the celebratory welcome.
  void _onTransferred(MyAdoptionRequest req) {
    final petId = req.pet.id;
    if (petId != null) {
      ref.read(petsProvider.notifier).addCreatedPet(
            PetRef(id: petId, name: req.pet.name, imagePath: req.pet.avatarUrl),
          );
      ref.read(petListProvider.notifier).refresh();
      context.push(
        AppRoutes.adoptionWelcome,
        extra: AdoptionWelcomeArgs(petId: petId, petName: req.pet.name),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final async = ref.watch(myAdoptionRequestsProvider);

    // A newly-completed request that we haven't celebrated yet lands the pet.
    ref.listen(myAdoptionRequestsProvider, (prev, next) {
      final prevList = prev?.value ?? const <MyAdoptionRequest>[];
      final nextList = next.value ?? const <MyAdoptionRequest>[];
      for (final r in nextList) {
        final was = prevList.where((p) => p.id == r.id).firstOrNull;
        if (r.isCompleted && (was == null || !was.isCompleted)) {
          _onTransferred(r);
          break;
        }
      }
    });

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorStateWidget(
        failure: e is Failure ? e : const UnknownFailure(),
        onRetry: () =>
            ref.read(myAdoptionRequestsProvider.notifier).refresh(),
      ),
      data: (requests) {
        if (requests.isEmpty) {
          return _EmptyTab(
            icon: FluentIcons.heart_24_regular,
            title: l10n.adoptionMyApplicationsEmptyTitle,
            message: l10n.adoptionMyApplicationsEmptyMessage,
          );
        }
        final now = DateTime.now();
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () =>
              ref.read(myAdoptionRequestsProvider.notifier).refresh(),
          child: ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: requests.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, i) {
              final req = requests[i];
              return _ApplicationCard(
                request: req,
                now: now,
                busy: _busyId == req.id,
                actionsEnabled: _busyId == null,
                onTap: () => context.push(
                  AppRoutes.adoptionDetailPath(req.listingId),
                ),
                onAccept: () => _accept(req),
                onCancel: () => _cancel(req),
              );
            },
          ),
        );
      },
    );
  }
}

/// Visual identity for a request status: label, accent color, and icon. Shared
/// by the top-right chip and the status strip so they always agree.
({String label, Color color, IconData icon}) _statusStyle(
  AppLocalizations l10n,
  AdoptionRequestStatus status,
) =>
    switch (status) {
      AdoptionRequestStatus.pending => (
          label: l10n.adoptionRequestStatusPending,
          color: AppColors.warning,
          icon: FluentIcons.hourglass_24_filled,
        ),
      AdoptionRequestStatus.approved => (
          label: l10n.adoptionRequestStatusApproved,
          color: AppColors.success,
          icon: FluentIcons.checkmark_circle_24_filled,
        ),
      AdoptionRequestStatus.rejected => (
          label: l10n.adoptionRequestStatusRejected,
          color: AppColors.error,
          icon: FluentIcons.dismiss_circle_24_filled,
        ),
      AdoptionRequestStatus.cancelled => (
          label: l10n.adoptionRequestStatusCancelled,
          color: AppColors.textSecondary,
          icon: FluentIcons.dismiss_circle_24_filled,
        ),
      AdoptionRequestStatus.completed => (
          label: l10n.adoptionRequestStatusCompleted,
          color: AppColors.secondaryDark,
          icon: FluentIcons.home_24_filled,
        ),
      AdoptionRequestStatus.expired => (
          label: l10n.adoptionRequestStatusExpired,
          color: AppColors.textSecondary,
          icon: FluentIcons.clock_dismiss_24_filled,
        ),
    };

/// A single submitted application, styled as a sibling of the board
/// [AdoptionCard]: a soft-shadowed rounded card with a hero pet thumbnail, a
/// name + meta line, a status chip, a tinted status strip explaining the next
/// step, and any state-adaptive actions. Tapping opens the listing.
class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({
    required this.request,
    required this.now,
    required this.busy,
    required this.actionsEnabled,
    required this.onTap,
    required this.onAccept,
    required this.onCancel,
  });

  final MyAdoptionRequest request;
  final DateTime now;
  final bool busy;
  final bool actionsEnabled;
  final VoidCallback onTap;
  final VoidCallback onAccept;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = _statusStyle(l10n, request.status);

    return Semantics(
      button: true,
      label: '${request.pet.name}, ${status.label}',
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.lgAll,
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(request: request, now: now, status: status),
                  ..._buildBody(context, l10n, status),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// The status strip + any state-adaptive actions below the header.
  List<Widget> _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    ({String label, Color color, IconData icon}) status,
  ) {
    // Approved but not yet accepted → the adopter's turn to opt in.
    if (request.awaitingMyAcceptance) {
      return [
        const SizedBox(height: AppSpacing.md),
        _StatusStrip(
          color: AppColors.success,
          icon: FluentIcons.checkmark_circle_24_filled,
          text: l10n.adoptionAcceptHint,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: l10n.adoptionAcceptCta,
          icon: FluentIcons.heart_24_regular,
          variant: AppButtonVariant.primary,
          isLoading: busy,
          onPressed: actionsEnabled ? onAccept : null,
        ),
        _WithdrawFooter(
          label: l10n.adoptionCancelApplication,
          onPressed: actionsEnabled ? onCancel : null,
        ),
      ];
    }

    // Accepted, waiting for the owner to hand over.
    if (request.awaitingHandover) {
      return [
        const SizedBox(height: AppSpacing.md),
        _StatusStrip(
          color: AppColors.secondaryDark,
          icon: FluentIcons.hourglass_24_filled,
          text: l10n.adoptionAwaitingHandover,
        ),
      ];
    }

    // Still pending owner review → can withdraw.
    if (request.status == AdoptionRequestStatus.pending) {
      return [
        const SizedBox(height: AppSpacing.md),
        _StatusStrip(
          color: AppColors.warning,
          icon: FluentIcons.hourglass_24_filled,
          text: l10n.adoptionAwaitingReview,
        ),
        _WithdrawFooter(
          label: l10n.adoptionCancelApplication,
          onPressed: actionsEnabled ? onCancel : null,
        ),
      ];
    }

    // Terminal (rejected / cancelled / completed / expired): a status strip
    // that restates the outcome, so the card never ends abruptly on the header.
    return [
      const SizedBox(height: AppSpacing.md),
      _StatusStrip(
        color: status.color,
        icon: status.icon,
        text: status.label,
      ),
    ];
  }
}

/// Pet thumbnail + name/meta + status chip.
class _Header extends StatelessWidget {
  const _Header({
    required this.request,
    required this.now,
    required this.status,
  });

  final MyAdoptionRequest request;
  final DateTime now;
  final ({String label, Color color, IconData icon}) status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pet = request.pet;
    final meta = <String>[
      ?pet.speciesName,
      ?AdoptionFormat.sex(l10n, pet.gender),
      ?AdoptionFormat.age(l10n, pet.dateOfBirth, now: now),
    ].join('  ·  ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: AppRadius.mdAll,
          child: Hero(
            tag: adoptionHeroTag(request.listingId),
            child: AppCachedImage(
              imageUrl: pet.avatarUrl,
              width: 60,
              height: 60,
              borderRadius: BorderRadius.zero,
              semanticLabel: pet.name,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.name,
                style: AppTextStyles.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (meta.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  meta,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryDark,
                    letterSpacing: 0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 2),
              Text(
                l10n.adoptionApplicationFrom(request.lister.fullName),
                style: AppTextStyles.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _StatusChip(label: status.label, color: status.color),
      ],
    );
  }
}

/// A soft-tinted band with an icon + text explaining where the application is
/// in its journey. Replaces the old bare hint row so every state reads as a
/// deliberate status, not leftover text.
class _StatusStrip extends StatelessWidget {
  const _StatusStrip({
    required this.color,
    required this.icon,
    required this.text,
  });

  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    // A plain icon + muted text line (no tinted pill) so it doesn't compete
    // with the withdraw button below or duplicate the status chip in the
    // header — the color lives in the icon, the message stays quiet.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
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

/// Card footer for the withdraw action: a divider separating it from the card
/// body, then a full-width soft-red pill button — tinted like the status strip
/// so it reads as an intentional destructive action, not leftover text.
class _WithdrawFooter extends StatelessWidget {
  const _WithdrawFooter({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.lg),
        const Divider(height: 1, thickness: 1, color: AppColors.divider),
        const SizedBox(height: AppSpacing.lg),
        Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Material(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: AppRadius.mdAll,
            child: InkWell(
              onTap: onPressed,
              borderRadius: AppRadius.mdAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Row(
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
    );
  }
}

// ── Shared empty state ────────────────────────────────────────────────────

class _EmptyTab extends StatelessWidget {
  const _EmptyTab({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 56, color: AppColors.divider),
                  const SizedBox(height: AppSpacing.lg),
                  Text(title,
                      style: AppTextStyles.titleMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
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
