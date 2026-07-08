import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../../profile/presentation/widgets/pet_profile_card.dart';
import '../../domain/entities/pet.dart';
import '../providers/pet_list_provider.dart';
import '../providers/pets_provider.dart';
import '../providers/species_provider.dart';

/// Post-login pet picker — shown when the user has 2+ pets and none is chosen.
/// Tapping a card selects that pet and advances directly to home (no detail
/// page — this is a one-time decision flow, not a browser).
class SelectPetPage extends ConsumerWidget {
  const SelectPetPage({super.key});

  void _select(BuildContext context, WidgetRef ref, Pet pet) {
    ref.read(petsProvider.notifier).selectPet(pet.id);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final petsAsync = ref.watch(petListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.selectPetTitle,
                      style: AppTextStyles.headlineLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.selectPetSubtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: petsAsync.when(
                loading: () => const _SelectGridSkeleton(),
                error: (e, _) => ErrorStateWidget(
                  failure: asFailure(e),
                  onRetry: () => ref.invalidate(petListProvider),
                ),
                data: (pets) => SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  child: _SelectGrid(
                    pets: pets,
                    onSelect: (pet) => _select(context, ref, pet),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A 2×2 grid of pet-card skeletons shown while the pet list loads.
class _SelectGridSkeleton extends StatelessWidget {
  const _SelectGridSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: GridView.count(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.82,
        children: const [
          _SelectCardSkeleton(),
          _SelectCardSkeleton(),
          _SelectCardSkeleton(),
          _SelectCardSkeleton(),
        ],
      ),
    );
  }
}

class _SelectCardSkeleton extends StatelessWidget {
  const _SelectCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SkeletonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SkeletonBox(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadius.lg),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(width: 80, height: 14),
                SizedBox(height: AppSpacing.sm),
                SkeletonLine(width: 55, height: 11),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectGrid extends StatelessWidget {
  const _SelectGrid({required this.pets, required this.onSelect});

  final List<Pet> pets;
  final ValueChanged<Pet> onSelect;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < pets.length; i += 2) {
      final left = pets[i];
      final right = i + 1 < pets.length ? pets[i + 1] : null;
      if (rows.isNotEmpty) rows.add(const SizedBox(height: AppSpacing.md));
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _card(left)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
              child: right == null ? const SizedBox() : _card(right)),
        ],
      ));
    }
    return Column(children: rows);
  }

  Widget _card(Pet pet) => PetProfileCard(
        petId: pet.id,
        name: pet.name,
        breed: pet.breedOrSpecies,
        ageYears: pet.ageInYears,
        imageUrl: pet.avatarUrl,
        onTap: () => onSelect(pet),
      );
}
