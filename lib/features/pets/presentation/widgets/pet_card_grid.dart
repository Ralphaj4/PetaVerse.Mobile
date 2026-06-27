import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../profile/presentation/widgets/pet_profile_card.dart';
import '../../domain/entities/pet.dart';

/// Two-per-row grid of [PetProfileCard]s. Set [enableHero] to true only when
/// navigating from the full listing page so the Hero fires exactly once
/// (listing → detail), not on the profile tab preview.
class PetCardGrid extends StatelessWidget {
  const PetCardGrid({
    required this.pets,
    this.activePetId,
    this.enableHero = false,
    super.key,
  });

  final List<Pet> pets;

  /// Pet to mark with the "active" badge, if any.
  final int? activePetId;

  /// Whether to wrap each card image in a Hero for the listing → detail
  /// transition. Leave false (the default) for profile-tab previews.
  final bool enableHero;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < pets.length; i += 2) {
      final left = pets[i];
      final right = i + 1 < pets.length ? pets[i + 1] : null;
      if (rows.isNotEmpty) rows.add(const SizedBox(height: AppSpacing.md));
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _card(context, left)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: right == null
                  ? const SizedBox()
                  : _card(context, right),
            ),
          ],
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _card(BuildContext context, Pet pet) => PetProfileCard(
        petId: pet.id,
        name: pet.name,
        breed: pet.breedOrSpecies,
        ageYears: pet.ageInYears,
        imageUrl: pet.avatarUrl,
        isActive: pet.id == activePetId,
        enableHero: enableHero,
        onTap: () => context.push(AppRoutes.petDetailPath(pet.id)),
      );
}
