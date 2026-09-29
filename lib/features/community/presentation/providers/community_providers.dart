import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/hive_service.dart';
import '../../../pets/domain/entities/pet_ref.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/community_local_datasource.dart';
import '../../data/datasources/community_remote_datasource.dart';
import '../../data/repositories/community_repository_impl.dart';
import '../../domain/repositories/community_repository.dart';

part 'community_providers.g.dart';

/// The community repository, wired to the shared [ApiClient] and Hive cache.
///
/// `myPetIds` is supplied as a callback reading [PetsNotifier], so the
/// `isMine` flag on authors always reflects the current pet set without the
/// repository holding a stale snapshot.
@Riverpod(keepAlive: true)
CommunityRepository communityRepository(Ref ref) {
  final client = ref.watch(apiClientProvider);
  final hive = ref.watch(hiveServiceProvider);
  return CommunityRepositoryImpl(
    CommunityRemoteDataSource(client),
    CommunityLocalDataSource(hive),
    () => ref
        .read(petsProvider)
        .refs
        .map((r) => r.id)
        .toSet(),
  );
}

/// The acting pet — the social identity actions are attributed to. Bound to
/// the app-wide current-pet selection ([PetsNotifier]); switching pets in the
/// PawHub switcher goes through `selectPet`, so the whole app stays in sync.
///
/// Null when the user has no pet yet (the feed then relies on the server's
/// first-pet fallback, and posting is gated in the UI).
@riverpod
PetRef? actingPet(Ref ref) {
  final pets = ref.watch(petsProvider);
  return pets.currentPet ?? (pets.refs.isEmpty ? null : pets.refs.first);
}

/// The acting pet's id, or null. Convenience for the many providers that only
/// need the id to pass as `petId` / `authorPetId` / `followerPetId`.
@riverpod
int? actingPetId(Ref ref) => ref.watch(actingPetProvider)?.id;

/// The list of pets the user can act as (the profile switcher's rows).
@riverpod
List<PetRef> switchablePets(Ref ref) => ref.watch(petsProvider).refs;
