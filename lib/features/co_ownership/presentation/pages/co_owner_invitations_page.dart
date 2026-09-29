import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../pets/presentation/providers/pet_list_provider.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../../profile/presentation/providers/user_provider.dart';
import '../../domain/entities/co_ownership.dart';
import '../providers/co_ownership_providers.dart';

/// Incoming co-owner invitations: the invitee sees pets they've been invited
/// to co-own and can accept or decline. Accepting a pet is also how a
/// pet-less user gets their first pet, so this page is reachable from the
/// pet-onboarding gate.
class CoOwnerInvitationsPage extends ConsumerStatefulWidget {
  const CoOwnerInvitationsPage({super.key});

  @override
  ConsumerState<CoOwnerInvitationsPage> createState() =>
      _CoOwnerInvitationsPageState();
}

class _CoOwnerInvitationsPageState
    extends ConsumerState<CoOwnerInvitationsPage> {
  // Id of the invite currently being accepted/declined, so only its row shows
  // a spinner (and all actions disable while one is in flight).
  int? _busyId;

  Future<void> _accept(IncomingCoOwnerInvite invite) async {
    setState(() => _busyId = invite.id);
    final result =
        await ref.read(coOwnershipRepositoryProvider).acceptInvite(invite.id);
    if (!mounted) return;
    setState(() => _busyId = null);

    await result.when(
      success: (pet) async {
        // Refresh the pet gate + list so the newly co-owned pet appears and
        // the router lets the user through. Also refresh /me so the pending
        // count drops.
        await ref.read(petsProvider.notifier).reconcile();
        ref.invalidate(petListProvider);
        ref.invalidate(userProvider);
        ref.invalidate(incomingInvitesProvider);
        if (!mounted) return;
        context.showSuccessSnackBar(context.l10n.coOwnerAccepted(pet.name));
      },
      failure: (f) async =>
          context.showErrorSnackBar(f.localizedMessage(context.l10n)),
    );
  }

  Future<void> _decline(IncomingCoOwnerInvite invite) async {
    setState(() => _busyId = invite.id);
    final result =
        await ref.read(coOwnershipRepositoryProvider).declineInvite(invite.id);
    if (!mounted) return;
    setState(() => _busyId = null);

    result.when(
      success: (_) {
        ref.invalidate(userProvider);
        ref.invalidate(incomingInvitesProvider);
        context.showSnackBar(context.l10n.coOwnerDeclined);
      },
      failure: (f) =>
          context.showErrorSnackBar(f.localizedMessage(context.l10n)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final invitesAsync = ref.watch(incomingInvitesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.popOrHome(),
          tooltip: l10n.close,
          icon: Icon(
            context.isRtl
                ? FluentIcons.arrow_right_24_regular
                : FluentIcons.arrow_left_24_regular,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          l10n.coOwnerInvitationsTitle,
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: invitesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorStateWidget(
          failure: error is Failure ? error : const UnknownFailure(),
          onRetry: () => ref.invalidate(incomingInvitesProvider),
        ),
        data: (invites) {
          if (invites.isEmpty) {
            return _EmptyState(message: l10n.coOwnerInvitationsEmpty);
          }
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(incomingInvitesProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: invites.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) {
                final invite = invites[i];
                return _InviteCard(
                  invite: invite,
                  busy: _busyId == invite.id,
                  anyBusy: _busyId != null,
                  onAccept: () => _accept(invite),
                  onDecline: () => _decline(invite),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _InviteCard extends StatelessWidget {
  const _InviteCard({
    required this.invite,
    required this.busy,
    required this.anyBusy,
    required this.onAccept,
    required this.onDecline,
  });

  final IncomingCoOwnerInvite invite;
  final bool busy;
  final bool anyBusy;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pet = invite.pet;
    final subtitle = [
      pet.speciesName,
      if (pet.breedName != null && pet.breedName!.isNotEmpty) pet.breedName!,
    ].where((s) => s.isNotEmpty).join(' · ');

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 28),
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
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 2),
                    Text(
                      l10n.coOwnerInvitedBy(invite.inviter.fullName),
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: l10n.coOwnerDecline,
                  variant: AppButtonVariant.outlined,
                  onPressed: anyBusy ? null : onDecline,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: l10n.coOwnerAccept,
                  variant: AppButtonVariant.primary,
                  isLoading: busy,
                  onPressed: anyBusy ? null : onAccept,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FluentIcons.mail_inbox_24_regular,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
