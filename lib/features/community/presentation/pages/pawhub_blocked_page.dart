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

class PawHubBlockedPage extends ConsumerStatefulWidget {
  const PawHubBlockedPage({super.key});

  @override
  ConsumerState<PawHubBlockedPage> createState() => _PawHubBlockedPageState();
}

class _PawHubBlockedPageState extends ConsumerState<PawHubBlockedPage> {
  @override
  Widget build(BuildContext context) {
    final blockedAsync = ref.watch(blockedPetsProvider);

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
        title: Text('Blocked Pets', style: AppTextStyles.titleLarge),
      ),
      body: blockedAsync.when(
        loading: () => _loadingState(),
        error: (_, _) => _errorState(
          () => ref.invalidate(blockedPetsProvider),
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
            Text('Failed to load blocked pets',
                style: AppTextStyles.titleSmall),
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
            child: const Icon(FluentIcons.person_prohibited_24_regular,
                size: 32, color: AppColors.primaryDark),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('No blocked pets', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
                'Pets you block won\'t appear in your feed',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _petsList(PetPage page) {
    return RefreshIndicator(
      onRefresh: () => ref.read(blockedPetsProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        itemCount: page.pets.length,
        itemBuilder: (_, i) {
          final pet = page.pets[i];
          return _PetTile(pet: pet);
        },
      ),
    );
  }
}

class _PetTile extends ConsumerWidget {
  const _PetTile({required this.pet});
  final CommunityPet pet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
      leading: AppAvatar(name: pet.name, imageUrl: pet.avatarUrl, radius: 22),
      title: Text(pet.name, style: AppTextStyles.labelLarge),
      subtitle: Text(pet.breedOrSpecies,
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
      trailing: TextButton(
        onPressed: () => _unblock(context, ref),
        child: const Text('Unblock'),
      ),
    );
  }

  Future<void> _unblock(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Unblock ${pet.name}?'),
        content: const Text('They\'ll be able to see your posts again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Unblock'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final actions = ref.read(communityActionsProvider);
      await actions.block(pet.id);
      if (context.mounted) {
        await ref.read(blockedPetsProvider.notifier).refresh();
      }
    }
  }
}
