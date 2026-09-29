import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/community_group_remote_datasource.dart';
import '../../data/repositories/community_group_repository_impl.dart';
import '../../domain/repositories/community_group_repository.dart';

part 'community_group_providers.g.dart';

/// The community (group) repository, wired to the shared [ApiClient].
///
/// `myPetIds` is a callback reading [PetsNotifier] so the `isMine` flag on
/// lead/member pets always reflects the current pet set without holding a
/// stale snapshot — same pattern as `communityRepository`.
@Riverpod(keepAlive: true)
CommunityGroupRepository communityGroupRepository(Ref ref) {
  return CommunityGroupRepositoryImpl(
    CommunityGroupRemoteDataSource(ref.watch(apiClientProvider)),
    () => ref.read(petsProvider).refs.map((r) => r.id).toSet(),
  );
}
