import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../community/presentation/models/pawhub_models.dart';
import '../../../community/presentation/widgets/pawhub_common.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../providers/service_providers_providers.dart';

/// Pet switcher pill for the service providers map that shows all user pets.
/// Tapping opens the shared bottom-sheet picker; choosing a pet filters
/// the providers to those that serve the selected pet's species.
class ProviderPetSelector extends ConsumerWidget {
  const ProviderPetSelector({super.key});

  List<PawPet> _pawPets(WidgetRef ref) => ref
      .read(petsProvider)
      .refs
      .map((r) => PawPet(
            id: r.id.toString(),
            backendId: r.id,
            name: r.name,
            breed: '',
            species: '',
            avatarUrl: r.imagePath,
            ownerName: '',
            isMine: true,
          ))
      .toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tailoring = ref.watch(providerPetTailoringProvider);
    final tailoringPetId = ref.watch(providerTailoringPetIdProvider);

    final pets = _pawPets(ref);
    if (pets.isEmpty) return const SizedBox.shrink();

    // Find the current selected pet (either the tailored one or the first one)
    PawPet? currentPet;
    if (tailoring && tailoringPetId != null) {
      currentPet = pets.firstWhere(
        (p) => p.backendId == tailoringPetId,
        orElse: () => pets.first,
      );
    }

    // Create a synthetic "All" pet for the pill display when tailoring is off
    final displayPet = currentPet ??
        PawPet(
          id: '0',
          backendId: 0,
          name: 'All',
          breed: '',
          species: '',
          avatarUrl: '',
          ownerName: '',
          isMine: true,
        );

    return PetSwitcherPill(
      pet: displayPet,
      onTap: () async {
        final chosen = await showPetSwitcherSheet(
          context,
          pets: pets,
          current: displayPet,
          title: 'Filter by pet',
          showMyPostsLink: false,
        );
        if (chosen == null) return;

        // If choosing a pet when tailoring is off ("All"), enable tailoring
        if (currentPet == null) {
          ref.read(petsProvider.notifier).selectPet(chosen.backendId);
          ref.read(providerPetTailoringProvider.notifier).toggle();
          return;
        }

        // If choosing the same pet, turn off tailoring ("All")
        if (chosen.backendId == currentPet.backendId) {
          ref.read(providerPetTailoringProvider.notifier).toggle();
          return;
        }

        // Selecting a different pet: switch to that pet
        ref.read(petsProvider.notifier).selectPet(chosen.backendId);
      },
    );
  }
}
