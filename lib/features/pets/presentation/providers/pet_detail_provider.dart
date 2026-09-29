import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/pet.dart';
import 'pet_repository_provider.dart';

part 'pet_detail_provider.g.dart';

/// Fetches the full detail record for a single pet by id.
/// Auto-disposed — each sheet open gets a fresh fetch.
@riverpod
Future<Pet> petDetail(Ref ref, int id) async {
  final result = await ref.read(petRepositoryProvider).getPetById(id);
  return result.when(
    success: (pet) => pet,
    failure: (f) => throw f,
  );
}
