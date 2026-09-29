// Co-ownership domain entities.
//
// Domain layer — no Flutter or JSON imports. Mirrors the API's co-ownership
// contract; the data layer maps the DTOs onto these.

/// Lifecycle of a co-owner invite.
enum CoOwnershipStatus { pending, accepted, declined, cancelled }

/// A minimal, shareable identity card for another user, resolved from a
/// public user code.
class PublicUserCard {
  const PublicUserCard({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    this.hasBeenInvited = false,
  });

  final String id;
  final String userCode;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  /// True when this user already has a pending co-owner invite for the pet the
  /// lookup was scoped to (only meaningful when looked up with a petId).
  final bool hasBeenInvited;

  String get fullName => '$firstName $lastName'.trim();
}

/// A person with access to a pet — the primary owner or an accepted co-owner.
class PetOwner {
  const PetOwner({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    this.isPrimaryOwner = false,
  });

  final String id;
  final String userCode;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  /// True for the original owner; false for accepted co-owners.
  final bool isPrimaryOwner;

  String get fullName => '$firstName $lastName'.trim();
}

/// An invite the current user has sent for one of their pets (owner side).
class SentCoOwnerInvite {
  const SentCoOwnerInvite({
    required this.id,
    required this.status,
    required this.invitee,
    required this.createdAt,
  });

  final int id;
  final CoOwnershipStatus status;
  final PublicUserCard invitee;
  final DateTime createdAt;
}

/// An invite addressed to the current user (invitee side).
class IncomingCoOwnerInvite {
  const IncomingCoOwnerInvite({
    required this.id,
    required this.status,
    required this.pet,
    required this.inviter,
    required this.createdAt,
  });

  final int id;
  final CoOwnershipStatus status;
  final InvitePet pet;
  final InviteInviter inviter;
  final DateTime createdAt;
}

/// The pet referenced by an incoming invite.
class InvitePet {
  const InvitePet({
    required this.id,
    required this.name,
    required this.speciesName,
    this.breedName,
    this.avatarUrl,
  });

  final int id;
  final String name;
  final String speciesName;
  final String? breedName;
  final String? avatarUrl;
}

/// The user who sent an incoming invite.
class InviteInviter {
  const InviteInviter({
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  final String firstName;
  final String lastName;
  final String? avatarUrl;

  String get fullName => '$firstName $lastName'.trim();
}
