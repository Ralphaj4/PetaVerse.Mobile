import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/datasources/co_ownership_remote_datasource.dart';
import '../../data/repositories/co_ownership_repository_impl.dart';
import '../../domain/entities/co_ownership.dart';
import '../../domain/repositories/co_ownership_repository.dart';

part 'co_ownership_providers.g.dart';

@Riverpod(keepAlive: true)
CoOwnershipRepository coOwnershipRepository(Ref ref) =>
    CoOwnershipRepositoryImpl(
      remote: CoOwnershipRemoteDataSource(ref.watch(apiClientProvider)),
    );

/// Invites addressed to the current user (invitee side).
@Riverpod(keepAlive: true)
class IncomingInvitesNotifier extends _$IncomingInvitesNotifier {
  @override
  Future<List<IncomingCoOwnerInvite>> build() async {
    final result = await ref.watch(coOwnershipRepositoryProvider).getIncoming();
    return result.when(
      success: (value) => value,
      failure: (f) => throw f,
    );
  }
}

/// Invites the current user has sent for a given pet (owner side).
@Riverpod(keepAlive: true)
class SentInvitesNotifier extends _$SentInvitesNotifier {
  @override
  Future<List<SentCoOwnerInvite>> build(int petId) async {
    final result =
        await ref.watch(coOwnershipRepositoryProvider).getSent(petId);
    return result.when(
      success: (value) => value,
      failure: (f) => throw f,
    );
  }
}

/// A pet's current owners (primary owner + accepted co-owners).
@Riverpod(keepAlive: true)
class PetOwnersNotifier extends _$PetOwnersNotifier {
  @override
  Future<List<PetOwner>> build(int petId) async {
    final result =
        await ref.watch(coOwnershipRepositoryProvider).getOwners(petId);
    return result.when(
      success: (value) => value,
      failure: (f) => throw f,
    );
  }
}
