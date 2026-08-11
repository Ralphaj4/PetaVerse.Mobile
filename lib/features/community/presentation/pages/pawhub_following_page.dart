import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/entities/community_entities.dart';
import '../providers/community_actions_providers.dart';
import '../providers/community_social_providers.dart';
import '../widgets/pawhub_common.dart';
import '../widgets/pawhub_feed_widgets.dart';

class PawHubFollowingPage extends ConsumerStatefulWidget {
  const PawHubFollowingPage({required this.petId, super.key});

  final int petId;

  @override
  ConsumerState<PawHubFollowingPage> createState() =>
      _PawHubFollowingPageState();
}

class _PawHubFollowingPageState extends ConsumerState<PawHubFollowingPage> {
  @override
  Widget build(BuildContext context) {
    final followingAsync = ref.watch(followingProvider(widget.petId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(FluentIcons.arrow_left_24_regular,
              color: AppColors.textPrimary),
        ),
        title: followingAsync.when(
          loading: () => Text('Following', style: AppTextStyles.titleLarge),
          error: (_, _) =>
              Text('Following', style: AppTextStyles.titleLarge),
          data: (page) => Text('Following (${page.count})',
              style: AppTextStyles.titleLarge),
        ),
      ),
      body: followingAsync.when(
        loading: () => _loadingState(),
        error: (_, _) => _errorState(
          () => ref.invalidate(followingProvider(widget.petId)),
        ),
        data: (page) {
          if (page.pets.isEmpty) return _emptyState();
          return _petsList(page);
        },
      ),
    );
  }

  Widget _loadingState() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, _) => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 10,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorState(VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.warning_24_regular,
                size: 40, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text('Failed to load following', style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(FluentIcons.person_add_24_regular,
                size: 32, color: AppColors.primaryDark),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Not following anyone yet', style: AppTextStyles.titleSmall),
        ],
      ),
    );
  }

  Widget _petsList(PetPage page) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: page.pets.length,
      itemBuilder: (_, i) {
        final pet = page.pets[i];
        if (i == page.pets.length - 1 && page.cursor.hasMore) {
          ref.read(followingProvider(widget.petId).notifier).loadMore();
        }
        return _PetTile(
          pet: pet,
          petId: widget.petId,
        );
      },
    );
  }
}

class _PetTile extends ConsumerWidget {
  const _PetTile({required this.pet, required this.petId});
  final CommunityPet pet;
  final int petId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
      leading: AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 22),
      title: Row(
        children: [
          Text(pet.name, style: AppTextStyles.labelLarge),
          if (pet.isVerified) ...[
            const SizedBox(width: 4),
            const VerifiedBadge(size: 13),
          ],
        ],
      ),
      subtitle: Text(pet.breedOrSpecies,
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
      trailing: !pet.isMine
          ? FollowButton(
              following: pet.isFollowing,
              onTap: () => _toggleFollow(ref),
            )
          : null,
    );
  }

  Future<void> _toggleFollow(WidgetRef ref) async {
    final actions = ref.read(communityActionsProvider);
    await actions.toggleFollow(pet);
  }
}
