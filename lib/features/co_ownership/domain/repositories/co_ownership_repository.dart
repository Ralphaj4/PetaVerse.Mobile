import '../../../../core/errors/result.dart';
import '../../../pets/domain/entities/pet.dart';
import '../entities/co_ownership.dart';

/// Contract for co-ownership invitations, both owner (sent) and invitee
/// (incoming) sides. Every method returns a [Result] — failures never throw.
abstract interface class CoOwnershipRepository {
  /// Resolves a public user code to a shareable identity card. When [petId] is
  /// given, the card's `hasBeenInvited` reflects a pending invite for that pet.
  Future<Result<PublicUserCard>> lookupByCode(String code, {int? petId});

  /// Sends a co-owner invite for one of the current user's pets.
  Future<Result<SentCoOwnerInvite>> sendInvite({
    required int petId,
    required String userCode,
  });

  /// Invites addressed to the current user.
  Future<Result<List<IncomingCoOwnerInvite>>> getIncoming();

  /// Accepts an incoming invite, returning the now co-owned pet.
  Future<Result<Pet>> acceptInvite(int id);

  /// Declines an incoming invite.
  Future<Result<void>> declineInvite(int id);

  /// Invites the current user has sent for the given pet.
  Future<Result<List<SentCoOwnerInvite>>> getSent(int petId);

  /// Cancels a pending invite the current user sent for the given pet.
  Future<Result<void>> cancelInvite({required int petId, required int id});

  /// The pet's current owners: the primary owner plus accepted co-owners.
  Future<Result<List<PetOwner>>> getOwners(int petId);

  /// Removes an owner from the pet (primary owner removing a co-owner, or a
  /// co-owner removing themselves).
  Future<Result<void>> removeOwner({
    required int petId,
    required String userId,
  });
}
