import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../../domain/entities/co_ownership.dart';
import '../providers/co_ownership_providers.dart';

/// Owner-side flow: search another user by their profile tag (userCode) and
/// send them an invitation to co-own [petId]. Also lists invitations already
/// sent for this pet, each cancellable while pending.
class InviteCoOwnerPage extends ConsumerStatefulWidget {
  const InviteCoOwnerPage({required this.petId, this.petName, super.key});

  final int petId;
  final String? petName;

  @override
  ConsumerState<InviteCoOwnerPage> createState() => _InviteCoOwnerPageState();
}

class _InviteCoOwnerPageState extends ConsumerState<InviteCoOwnerPage> {
  /// The current search: null before searching, then a loading/data/error
  /// AsyncValue for the looked-up user card.
  AsyncValue<PublicUserCard?>? _lookup;
  String _lastQuery = '';
  bool _sending = false;
  int? _cancellingId;

  /// userId of the owner currently being removed (spinner on that row).
  String? _removingUserId;

  /// A profile tag (userCode) is 8 characters; allow a little slack (8–10)
  /// before we bother the API. Shorter/longer input isn't a valid tag, so we
  /// don't call — and there's no debounce: we fire as soon as the length is in
  /// range.
  static const int _minTagLength = 8;
  static const int _maxTagLength = 10;

  Future<void> _search(String raw) async {
    final code = raw.trim();
    _lastQuery = code;
    if (code.length < _minTagLength || code.length > _maxTagLength) {
      // Not a searchable tag yet — clear any result and don't call the API.
      setState(() => _lookup = null);
      return;
    }
    setState(() => _lookup = const AsyncValue.loading());
    final result = await ref
        .read(coOwnershipRepositoryProvider)
        .lookupByCode(code, petId: widget.petId);
    if (!mounted || code != _lastQuery) return; // superseded by a newer query
    setState(() {
      _lookup = result.when(
        success: (user) => AsyncValue<PublicUserCard?>.data(user),
        // Not-found is a normal empty result, not an error banner.
        failure: (f) => f is NotFoundFailure
            ? const AsyncValue<PublicUserCard?>.data(null)
            : AsyncValue<PublicUserCard?>.error(f, StackTrace.current),
      );
    });
  }

  Future<void> _send(PublicUserCard user) async {
    setState(() => _sending = true);
    final Result<SentCoOwnerInvite> result;
    try {
      result = await ref.read(coOwnershipRepositoryProvider).sendInvite(
            petId: widget.petId,
            userCode: user.userCode,
          );
    } finally {
      // Always clear the spinner, even if the call throws unexpectedly — a
      // hung spinner is worse than an error.
      if (mounted) setState(() => _sending = false);
    }
    if (!mounted) return;
    result.when(
      success: (_) {
        ref.invalidate(sentInvitesProvider(widget.petId));
        // Flip the visible card to the "Invited" state so the send button
        // becomes a static chip (prevents a duplicate-invite tap too).
        setState(() {
          _lookup = AsyncValue.data(
            _buildInvited(user),
          );
        });
        context.showSuccessSnackBar(context.l10n.inviteCoOwnerSent);
      },
      failure: (f) =>
          context.showErrorSnackBar(f.localizedMessage(context.l10n)),
    );
  }

  /// Returns a copy of [user] marked as invited (no copyWith on the entity).
  PublicUserCard _buildInvited(PublicUserCard user) => PublicUserCard(
        id: user.id,
        userCode: user.userCode,
        firstName: user.firstName,
        lastName: user.lastName,
        avatarUrl: user.avatarUrl,
        hasBeenInvited: true,
      );

  Future<void> _cancel(SentCoOwnerInvite invite) async {
    setState(() => _cancellingId = invite.id);
    final result = await ref.read(coOwnershipRepositoryProvider).cancelInvite(
          petId: widget.petId,
          id: invite.id,
        );
    if (!mounted) return;
    setState(() => _cancellingId = null);
    result.when(
      success: (_) {
        ref.invalidate(sentInvitesProvider(widget.petId));
        // If the search card is still showing the user we just un-invited,
        // flip it back to the "Invite" state so the button reappears.
        final shown = _lookup?.value;
        if (shown != null && shown.userCode == invite.invitee.userCode) {
          setState(() => _lookup = AsyncValue.data(_buildUninvited(shown)));
        }
        context.showSnackBar(context.l10n.inviteCoOwnerCancelled);
      },
      failure: (f) =>
          context.showErrorSnackBar(f.localizedMessage(context.l10n)),
    );
  }

  /// Returns a copy of [user] marked as not invited (used after a cancel).
  PublicUserCard _buildUninvited(PublicUserCard user) => PublicUserCard(
        id: user.id,
        userCode: user.userCode,
        firstName: user.firstName,
        lastName: user.lastName,
        avatarUrl: user.avatarUrl,
        hasBeenInvited: false,
      );

  /// Removes a co-owner (primary owner action) or leaves the pet (co-owner
  /// removing themselves). [leaving] tailors the confirm copy + snackbar.
  Future<void> _removeOwner(PetOwner owner, {required bool leaving}) async {
    final l10n = context.l10n;
    final confirmed = await AppConfirmDialog.show(
      context,
      icon: leaving
          ? FluentIcons.sign_out_24_regular
          : FluentIcons.person_delete_24_regular,
      title: leaving ? l10n.coOwnerLeaveTitle : l10n.coOwnerRemoveTitle,
      message: leaving
          ? l10n.coOwnerLeaveMessage
          : l10n.coOwnerRemoveMessage(owner.fullName),
      confirmLabel: leaving ? l10n.coOwnerLeaveConfirm : l10n.coOwnerRemoveConfirm,
      cancelLabel: l10n.cancel,
      isDestructive: true,
    );
    if (!confirmed || !mounted) return;

    setState(() => _removingUserId = owner.id);
    final result = await ref.read(coOwnershipRepositoryProvider).removeOwner(
          petId: widget.petId,
          userId: owner.id,
        );
    if (!mounted) return;
    setState(() => _removingUserId = null);
    result.when(
      success: (_) {
        ref.invalidate(petOwnersProvider(widget.petId));
        if (leaving) {
          // The user just gave up access — leave the page; the pet gate will
          // reconcile on next fetch.
          ref.read(petsProvider.notifier).reconcile();
          context.pop();
          context.showSnackBar(l10n.coOwnerLeftSuccess);
        } else {
          context.showSnackBar(l10n.coOwnerRemovedSuccess);
        }
      },
      failure: (f) => context.showErrorSnackBar(f.localizedMessage(l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          tooltip: l10n.close,
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(l10n.inviteCoOwnerTitle, style: AppTextStyles.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Fixed top block: subtitle + search + result ──────────────
            if (widget.petName != null && widget.petName!.isNotEmpty) ...[
              Text(
                l10n.inviteCoOwnerSubtitle(widget.petName!),
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            _SearchField(
              hint: l10n.inviteCoOwnerSearchHint,
              onChanged: _search,
            ),
            const SizedBox(height: AppSpacing.lg),
            // Reserve a constant height so 'Invitations sent' never shifts
            // when the result appears/disappears.
            SizedBox(
              height: 88,
              child: _LookupResult(
                lookup: _lookup,
                sending: _sending,
                emptyLabel: l10n.inviteCoOwnerSearchEmpty,
                idleHint: l10n.inviteCoOwnerSearchIdle,
                onSend: _send,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ── Current co-owners (fixed) ────────────────────────────────
            _CurrentOwnersSection(
              petId: widget.petId,
              removingUserId: _removingUserId,
              onRemove: (o) => _removeOwner(o, leaving: false),
              onLeave: (o) => _removeOwner(o, leaving: true),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ── Sent invitations fill the rest, so the empty state can be
            // vertically centered in the space below the header ──────────
            Expanded(
              child: _SentInvitesSection(
                petId: widget.petId,
                cancellingId: _cancellingId,
                onCancel: _cancel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders the current search state: nothing, a spinner, a not-found note, an
/// error, or the found user with a Send button.
class _LookupResult extends StatelessWidget {
  const _LookupResult({
    required this.lookup,
    required this.sending,
    required this.emptyLabel,
    required this.idleHint,
    required this.onSend,
  });

  final AsyncValue<PublicUserCard?>? lookup;
  final bool sending;
  final String emptyLabel;

  /// Shown before a valid-length tag has been entered.
  final String idleHint;
  final ValueChanged<PublicUserCard> onSend;

  @override
  Widget build(BuildContext context) {
    final lookup = this.lookup;
    // Idle (no query yet / too short) — a subtle centered hint.
    if (lookup == null) {
      return Center(
        child: Text(
          idleHint,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (lookup.isLoading) {
      return const _OwnerRowSkeleton();
    }
    if (lookup.hasError) {
      final e = lookup.error;
      return Text(
        (e is Failure ? e : const UnknownFailure())
            .localizedMessage(context.l10n),
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
      );
    }
    final user = lookup.value;
    if (user == null) {
      return Row(
        children: [
          const Icon(FluentIcons.person_question_mark_24_regular,
              size: 18, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              emptyLabel,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      );
    }
    return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.lgAll,
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppAvatar(
                name: user.fullName,
                imageUrl: user.avatarUrl,
                radius: 24,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '#${user.userCode}',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Already invited for this pet → a static "Invited" chip;
              // otherwise a labeled "Invite" button. It uses MainAxisSize.min
              // so it never demands unbounded intrinsic width as a non-flex Row
              // child (a full-width button there collapses the card to zero).
              if (user.hasBeenInvited)
                const _InvitedChip()
              else
                _InviteButton(
                  busy: sending,
                  onTap: sending ? null : () => onSend(user),
                ),
            ],
          ),
        );
  }
}

/// Static "Invited" chip shown in place of the send button when the looked-up
/// user already has a pending invite for this pet.
class _InvitedChip extends StatelessWidget {
  const _InvitedChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.12),
        borderRadius: AppRadius.mdAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FluentIcons.checkmark_circle_16_filled,
              size: 14, color: AppColors.success),
          const SizedBox(width: AppSpacing.xs),
          Text(
            context.l10n.inviteCoOwnerAlreadyInvited,
            style: AppTextStyles.labelMedium.copyWith(color: AppColors.success),
          ),
        ],
      ),
    );
  }
}

/// Labeled "Invite" button used in the lookup result. Sized to its content
/// (MainAxisSize.min) so it never demands unbounded intrinsic width as a
/// non-flex Row child — a full-width button there collapses the card.
class _InviteButton extends StatelessWidget {
  const _InviteButton({required this.busy, required this.onTap});

  final bool busy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      button: true,
      enabled: onTap != null,
      label: l10n.inviteCoOwnerInvite,
      child: Material(
        color: AppColors.primary,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (busy)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.onPrimary,
                    ),
                  )
                else
                  const Icon(
                    FluentIcons.person_add_24_filled,
                    size: 16,
                    color: AppColors.onPrimary,
                  ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  l10n.inviteCoOwnerInvite,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "Current co-owners" section: the pet's primary owner + accepted co-owners.
/// The primary owner may remove co-owners; a co-owner may remove themselves.
class _CurrentOwnersSection extends ConsumerWidget {
  const _CurrentOwnersSection({
    required this.petId,
    required this.removingUserId,
    required this.onRemove,
    required this.onLeave,
  });

  final int petId;
  final String? removingUserId;
  final ValueChanged<PetOwner> onRemove;
  final ValueChanged<PetOwner> onLeave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final ownersAsync = ref.watch(petOwnersProvider(petId));
    // The signed-in user's id, to decide "you"/leave vs remove.
    final myId = ref.watch(userProvider).value?.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.coOwnerCurrentTitle, style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.md),
        ownersAsync.when(
          loading: () => const _OwnerListSkeleton(rows: 2),
          error: (e, _) => Text(
            (e is Failure ? e : const UnknownFailure()).localizedMessage(l10n),
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
          data: (owners) {
            // Whether the signed-in user is the primary owner (may remove).
            final iAmPrimary = owners.any(
              (o) => o.isPrimaryOwner && o.id == myId,
            );
            return Column(
              children: [
                for (final owner in owners)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _OwnerTile(
                      owner: owner,
                      isMe: owner.id == myId,
                      canRemove: iAmPrimary && !owner.isPrimaryOwner,
                      busy: removingUserId == owner.id,
                      onRemove: () => onRemove(owner),
                      onLeave: () => onLeave(owner),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// A single owner row: avatar, name, tag, an "Owner" badge for the primary
/// owner, and a remove/leave action where permitted.
class _OwnerTile extends StatelessWidget {
  const _OwnerTile({
    required this.owner,
    required this.isMe,
    required this.canRemove,
    required this.busy,
    required this.onRemove,
    required this.onLeave,
  });

  final PetOwner owner;
  final bool isMe;
  final bool canRemove;
  final bool busy;
  final VoidCallback onRemove;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // A co-owner viewing their own row may leave; the primary owner may remove
    // other co-owners. The primary owner's own row has no action.
    final showLeave = isMe && !owner.isPrimaryOwner;
    final showRemove = canRemove && !isMe;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          AppAvatar(
            name: owner.fullName,
            imageUrl: owner.avatarUrl,
            radius: 20,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        isMe ? l10n.coOwnerYou(owner.fullName) : owner.fullName,
                        style: AppTextStyles.bodyMedium
                            .copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (owner.isPrimaryOwner) ...[
                      const SizedBox(width: AppSpacing.sm),
                      const _OwnerBadge(),
                    ],
                  ],
                ),
                Text(
                  '#${owner.userCode}',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          if (busy)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else if (showLeave)
            TextButton(
              onPressed: onLeave,
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: Text(l10n.coOwnerLeaveAction),
            )
          else if (showRemove)
            IconButton(
              onPressed: onRemove,
              tooltip: l10n.coOwnerRemoveAction,
              icon: const Icon(
                FluentIcons.dismiss_24_regular,
                color: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }
}

/// Small "Owner" pill marking the primary owner.
class _OwnerBadge extends StatelessWidget {
  const _OwnerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        context.l10n.coOwnerPrimaryBadge,
        style: AppTextStyles.labelSmall.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}

/// "Invitations sent" section: pending invites the owner sent for this pet.
class _SentInvitesSection extends ConsumerWidget {
  const _SentInvitesSection({
    required this.petId,
    required this.cancellingId,
    required this.onCancel,
  });

  final int petId;
  final int? cancellingId;
  final ValueChanged<SentCoOwnerInvite> onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final sentAsync = ref.watch(sentInvitesProvider(petId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.inviteCoOwnerSentTitle, style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.md),
        // Take the remaining height so the empty state centers vertically and
        // a populated list can scroll independently.
        Expanded(
          child: sentAsync.when(
            loading: () => const _OwnerListSkeleton(rows: 2),
            error: (e, _) => Text(
              (e is Failure ? e : const UnknownFailure())
                  .localizedMessage(l10n),
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
            ),
            data: (sent) {
              if (sent.isEmpty) {
                return _SentEmptyState(message: l10n.inviteCoOwnerNoneSent);
              }
              return ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: sent.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (_, i) {
                  final invite = sent[i];
                  return _SentInviteTile(
                    invite: invite,
                    cancelling: cancellingId == invite.id,
                    onCancel: () => onCancel(invite),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Plain search field (no debounce) — fires [onChanged] on every keystroke;
/// the page decides when the input is a searchable tag (8–10 chars).
/// Shimmer placeholder shaped like an owner/invite tile (avatar + two lines +
/// a trailing action block). Standalone — carries its own [Shimmer].
class _OwnerRowSkeleton extends StatelessWidget {
  const _OwnerRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Shimmer(child: _OwnerRowSkeletonBody());
  }
}

/// The static skeleton content — reused inside a shared [Shimmer] by the
/// multi-row list so the whole list sweeps as one.
class _OwnerRowSkeletonBody extends StatelessWidget {
  const _OwnerRowSkeletonBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: const Row(
        children: [
          SkeletonBox(width: 40, height: 40, shape: BoxShape.circle),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SkeletonLine(width: 120, height: 13),
                SizedBox(height: AppSpacing.xs),
                SkeletonLine(width: 70, height: 11),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          SkeletonBox(width: 28, height: 28, shape: BoxShape.circle),
        ],
      ),
    );
  }
}

/// [rows] owner-row skeletons under a single [Shimmer] (shared sweep).
class _OwnerListSkeleton extends StatelessWidget {
  const _OwnerListSkeleton({required this.rows});

  final int rows;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          for (var i = 0; i < rows; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.sm),
            const _OwnerRowSkeletonBody(),
          ],
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint, required this.onChanged});

  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: hint,
      child: TextField(
        onChanged: onChanged,
        autocorrect: false,
        textInputAction: TextInputAction.search,
        maxLength: 10,
        decoration: InputDecoration(
          hintText: hint,
          counterText: '',
          prefixIcon: const Icon(
            FluentIcons.search_24_regular,
            color: AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}

/// Centered empty state for the "Invitations sent" list: an icon and a
/// larger, centered message.
class _SentEmptyState extends StatelessWidget {
  const _SentEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.secondarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                FluentIcons.mail_24_regular,
                size: 36,
                color: AppColors.secondaryDark,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTextStyles.titleSmall
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SentInviteTile extends StatelessWidget {
  const _SentInviteTile({
    required this.invite,
    required this.cancelling,
    required this.onCancel,
  });

  final SentCoOwnerInvite invite;
  final bool cancelling;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pending = invite.status == CoOwnershipStatus.pending;
    final statusLabel = switch (invite.status) {
      CoOwnershipStatus.pending => l10n.statusPending,
      CoOwnershipStatus.accepted => l10n.statusAccepted,
      CoOwnershipStatus.declined => l10n.statusDeclined,
      CoOwnershipStatus.cancelled => l10n.statusCancelled,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          AppAvatar(
            name: invite.invitee.fullName,
            imageUrl: invite.invitee.avatarUrl,
            radius: 20,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invite.invitee.fullName,
                  style: AppTextStyles.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  statusLabel,
                  style: AppTextStyles.bodySmall
                      .copyWith(color: _statusColor(invite.status)),
                ),
              ],
            ),
          ),
          if (pending)
            cancelling
                ? const Padding(
                    padding: EdgeInsets.all(AppSpacing.sm),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    onPressed: onCancel,
                    tooltip: l10n.inviteCoOwnerCancel,
                    icon: const Icon(
                      FluentIcons.dismiss_circle_24_regular,
                      color: AppColors.textSecondary,
                    ),
                  ),
        ],
      ),
    );
  }

  Color _statusColor(CoOwnershipStatus status) => switch (status) {
        CoOwnershipStatus.pending => AppColors.warning,
        CoOwnershipStatus.accepted => AppColors.success,
        CoOwnershipStatus.declined => AppColors.error,
        CoOwnershipStatus.cancelled => AppColors.textTertiary,
      };
}
