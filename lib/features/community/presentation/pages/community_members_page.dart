import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_confirm_dialog.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/community_group_entities.dart';
import '../providers/community_group_actions_providers.dart';
import '../providers/community_group_feed_providers.dart';

/// A community's members list, with the lead badged and (for the lead) a remove
/// action on each member. Reached via `/community/communities/:id/members`.
class CommunityMembersPage extends ConsumerWidget {
  const CommunityMembersPage({required this.communityId, super.key});

  final int communityId;

  Future<void> _confirmRemove(
    BuildContext context,
    WidgetRef ref,
    CommunityMember member,
  ) async {
    final l10n = context.l10n;
    final ok = await AppConfirmDialog.show(
      context,
      icon: FluentIcons.person_delete_24_regular,
      title: l10n.communityMemberRemoveConfirmTitle,
      message: l10n.communityMemberRemoveConfirmMessage(member.pet.name),
      confirmLabel: l10n.communityMemberRemove,
      cancelLabel: l10n.communityCancel,
      isDestructive: true,
    );
    if (ok) {
      final removed = await ref.read(communityGroupActionsProvider).removeMember(
            communityId: communityId,
            petId: member.pet.id,
          );
      if (removed && context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
              SnackBar(content: Text(l10n.communityMemberRemovedToast)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    // The acting pet is the lead iff the loaded detail says so.
    final viewerIsLead =
        ref.watch(communityDetailProvider(communityId)).value?.isLead ??
            false;
    final state = ref.watch(communityMembersProvider(communityId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(l10n.communityMembersTitle),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorStateWidget(
          failure: e is Failure ? e : null,
          onRetry: () =>
              ref.invalidate(communityMembersProvider(communityId)),
        ),
        data: (page) => ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          itemCount: page.members.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final m = page.members[i];
            return ListTile(
              leading: AppAvatar(
                name: m.pet.name,
                imageUrl: m.pet.avatarUrl,
                radius: 22,
              ),
              title: Row(
                children: [
                  Flexible(
                    child: Text(m.pet.name,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  if (m.isLead) ...[
                    const SizedBox(width: AppSpacing.xs),
                    _LeadPill(label: l10n.communityLeadBadge),
                  ],
                ],
              ),
              subtitle: m.pet.breedOrSpecies.isNotEmpty
                  ? Text(m.pet.breedOrSpecies,
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary))
                  : null,
              trailing: (viewerIsLead && !m.isLead)
                  ? IconButton(
                      icon: const Icon(FluentIcons.person_delete_24_regular,
                          color: AppColors.error),
                      tooltip: l10n.communityMemberRemove,
                      onPressed: () => _confirmRemove(context, ref, m),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}

class _LeadPill extends StatelessWidget {
  const _LeadPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}
