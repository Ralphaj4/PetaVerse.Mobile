import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/co_ownership.dart';

part 'co_ownership_dtos.freezed.dart';
part 'co_ownership_dtos.g.dart';

/// Wire values for a co-owner invite's status. The API serializes the unified
/// StatusCode enum as its integer id (globally unique per feature):
/// CoOwnershipPending=1, Accepted=2, Declined=3, Cancelled=4.
enum CoOwnershipStatusJson {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  accepted,
  @JsonValue(3)
  declined,
  @JsonValue(4)
  cancelled,
}

/// Maps the wire status onto the domain [CoOwnershipStatus].
CoOwnershipStatus _statusToDomain(CoOwnershipStatusJson status) =>
    switch (status) {
      CoOwnershipStatusJson.pending => CoOwnershipStatus.pending,
      CoOwnershipStatusJson.accepted => CoOwnershipStatus.accepted,
      CoOwnershipStatusJson.declined => CoOwnershipStatus.declined,
      CoOwnershipStatusJson.cancelled => CoOwnershipStatus.cancelled,
    };

/// Wire shape of the API's PublicUserCard (resolved from a user code).
@freezed
abstract class PublicUserCardDto with _$PublicUserCardDto {
  const factory PublicUserCardDto({
    required String id,
    required String userCode,
    @Default('') String firstName,
    @Default('') String lastName,
    String? avatarUrl,
    @Default(false) bool hasBeenInvited,
  }) = _PublicUserCardDto;

  const PublicUserCardDto._();

  factory PublicUserCardDto.fromJson(Map<String, dynamic> json) =>
      _$PublicUserCardDtoFromJson(json);

  PublicUserCard toEntity() => PublicUserCard(
        id: id,
        userCode: userCode,
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        hasBeenInvited: hasBeenInvited,
      );
}

/// Wire shape of the API's PetOwner (a pet's primary owner or a co-owner).
@freezed
abstract class PetOwnerDto with _$PetOwnerDto {
  const factory PetOwnerDto({
    required String id,
    required String userCode,
    @Default('') String firstName,
    @Default('') String lastName,
    String? avatarUrl,
    // The owners endpoint names this `isPrimary` (not `isPrimaryOwner`).
    @JsonKey(name: 'isPrimary') @Default(false) bool isPrimaryOwner,
  }) = _PetOwnerDto;

  const PetOwnerDto._();

  factory PetOwnerDto.fromJson(Map<String, dynamic> json) =>
      _$PetOwnerDtoFromJson(json);

  PetOwner toEntity() => PetOwner(
        id: id,
        userCode: userCode,
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        isPrimaryOwner: isPrimaryOwner,
      );
}

/// Wire shape of a sent invite (owner side). Also parses the create (201)
/// response, whose extra `petId` field is ignored by json_serializable.
@freezed
abstract class SentCoOwnerInviteDto with _$SentCoOwnerInviteDto {
  const factory SentCoOwnerInviteDto({
    required int id,
    @Default(CoOwnershipStatusJson.pending) CoOwnershipStatusJson status,
    required PublicUserCardDto invitee,
    DateTime? createdAt,
  }) = _SentCoOwnerInviteDto;

  const SentCoOwnerInviteDto._();

  factory SentCoOwnerInviteDto.fromJson(Map<String, dynamic> json) =>
      _$SentCoOwnerInviteDtoFromJson(json);

  SentCoOwnerInvite toEntity() => SentCoOwnerInvite(
        id: id,
        status: _statusToDomain(status),
        invitee: invitee.toEntity(),
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// Wire shape of an incoming invite (invitee side).
@freezed
abstract class IncomingCoOwnerInviteDto with _$IncomingCoOwnerInviteDto {
  const factory IncomingCoOwnerInviteDto({
    required int id,
    @Default(CoOwnershipStatusJson.pending) CoOwnershipStatusJson status,
    required InvitePetDto pet,
    required InviteInviterDto inviter,
    DateTime? createdAt,
  }) = _IncomingCoOwnerInviteDto;

  const IncomingCoOwnerInviteDto._();

  factory IncomingCoOwnerInviteDto.fromJson(Map<String, dynamic> json) =>
      _$IncomingCoOwnerInviteDtoFromJson(json);

  IncomingCoOwnerInvite toEntity() => IncomingCoOwnerInvite(
        id: id,
        status: _statusToDomain(status),
        pet: pet.toEntity(),
        inviter: inviter.toEntity(),
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// Wire shape of the pet embedded in an incoming invite.
@freezed
abstract class InvitePetDto with _$InvitePetDto {
  const factory InvitePetDto({
    required int id,
    @Default('') String name,
    @Default('') String speciesName,
    String? breedName,
    String? avatarUrl,
  }) = _InvitePetDto;

  const InvitePetDto._();

  factory InvitePetDto.fromJson(Map<String, dynamic> json) =>
      _$InvitePetDtoFromJson(json);

  InvitePet toEntity() => InvitePet(
        id: id,
        name: name,
        speciesName: speciesName,
        breedName: breedName,
        avatarUrl: avatarUrl,
      );
}

/// Wire shape of the inviter embedded in an incoming invite.
@freezed
abstract class InviteInviterDto with _$InviteInviterDto {
  const factory InviteInviterDto({
    @Default('') String firstName,
    @Default('') String lastName,
    String? avatarUrl,
  }) = _InviteInviterDto;

  const InviteInviterDto._();

  factory InviteInviterDto.fromJson(Map<String, dynamic> json) =>
      _$InviteInviterDtoFromJson(json);

  InviteInviter toEntity() => InviteInviter(
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
      );
}
