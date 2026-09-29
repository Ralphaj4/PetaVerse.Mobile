import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/vision_profile.dart';
import 'vision_profile_repository_provider.dart';

part 'vision_profile_provider.g.dart';

@riverpod
Future<VisionProfile?> visionProfile(Ref ref, int speciesId) async {
  final repo = ref.read(visionProfileRepositoryProvider);
  final result = await repo.getBySpeciesId(speciesId);
  return result.when(
    success: (profile) => profile,
    failure: (f) => throw f,
  );
}

@riverpod
Future<VisionProfile?> visionProfileByName(Ref ref, String speciesName) async {
  final repo = ref.read(visionProfileRepositoryProvider);
  final result = await repo.getBySpeciesName(speciesName);
  return result.when(
    success: (profile) => profile,
    failure: (f) => throw f,
  );
}

@riverpod
Future<List<VisionProfile>> allVisionProfiles(Ref ref) async {
  final repo = ref.read(visionProfileRepositoryProvider);
  final result = await repo.getAll();
  return result.when(
    success: (profiles) => profiles,
    failure: (f) => throw f,
  );
}
