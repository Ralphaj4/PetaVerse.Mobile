import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/community_entities.dart';
import '../../domain/entities/community_group_entities.dart';
import '../../domain/entities/community_group_enums.dart';
import 'community_dtos.dart';

part 'community_group_dtos.freezed.dart';
part 'community_group_dtos.g.dart';

/// Wire shapes for pet-led **community** (group) endpoints. Each DTO exposes a
/// `toEntity()` mapping onto the pure-Dart domain entities. Reuses
/// [PetSummaryDto] for the lead/member pet and [FeedResponseDto] for a
/// community's feed (that response is identical to any other feed page).
///
/// Category/role enums arrive as ints and go through the domain `fromWire`
/// mappers, so declaration order here never has to match the server.

/// `CommunityResponse` — a single community.
@freezed
abstract class CommunityDto with _$CommunityDto {
  const factory CommunityDto({
    required int id,
    @Default('') String name,
    String? handle,
    String? description,
    String? avatarUrl,
    String? bannerUrl,
    @Default(0) int category,
    required PetSummaryDto lead,
    @Default(0) int memberCount,
    @Default(0) int postCount,
    // Nullable so an explicit `null` from anonymous-viewer responses can't crash
    // deserialization; coalesced to false in [toEntity].
    bool? isMember,
    bool? isLead,
    DateTime? createdAt,
  }) = _CommunityDto;

  const CommunityDto._();

  factory CommunityDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityDtoFromJson(json);

  /// [mine] marks whether the lead pet belongs to the signed-in user (the wire
  /// has no `isMine`); [isLead]/[isMember] are already the acting-pet's view.
  CommunityGroup toEntity({bool leadIsMine = false}) => CommunityGroup(
        id: id,
        name: name,
        handle: handle,
        description: description,
        avatarUrl: avatarUrl,
        bannerUrl: bannerUrl,
        category: communityCategoryFromWire(category),
        lead: lead.toEntity(mine: leadIsMine),
        memberCount: memberCount,
        postCount: postCount,
        isMember: isMember ?? false,
        isLead: isLead ?? false,
        createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// `CommunityMemberResponse`.
@freezed
abstract class CommunityMemberDto with _$CommunityMemberDto {
  const factory CommunityMemberDto({
    required PetSummaryDto pet,
    @Default(1) int role,
    DateTime? joinedAt,
  }) = _CommunityMemberDto;

  const CommunityMemberDto._();

  factory CommunityMemberDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityMemberDtoFromJson(json);

  CommunityMember toEntity({bool mine = false}) => CommunityMember(
        pet: pet.toEntity(mine: mine),
        role: communityRoleFromWire(role),
        joinedAt: joinedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// `CommunityDirectoryResponse` — a page of communities.
@freezed
abstract class CommunityDirectoryResponseDto
    with _$CommunityDirectoryResponseDto {
  const factory CommunityDirectoryResponseDto({
    @Default(<CommunityDto>[]) List<CommunityDto> communities,
    int? total,
    @Default(false) bool hasMore,
    int? nextPage,
  }) = _CommunityDirectoryResponseDto;

  const CommunityDirectoryResponseDto._();

  factory CommunityDirectoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityDirectoryResponseDtoFromJson(json);

  CommunityDirectoryPage toEntity({Set<int> myPetIds = const {}}) =>
      CommunityDirectoryPage(
        communities: communities
            .map((c) => c.toEntity(leadIsMine: myPetIds.contains(c.lead.id)))
            .toList(growable: false),
        total: total,
        cursor: PageCursor(hasMore: hasMore, nextPage: nextPage),
      );
}

/// `CommunityMembersResponse` — a page of a community's members.
@freezed
abstract class CommunityMembersResponseDto with _$CommunityMembersResponseDto {
  const factory CommunityMembersResponseDto({
    @Default(<CommunityMemberDto>[]) List<CommunityMemberDto> members,
    @Default(0) int count,
    @Default(false) bool hasMore,
    int? nextPage,
  }) = _CommunityMembersResponseDto;

  const CommunityMembersResponseDto._();

  factory CommunityMembersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityMembersResponseDtoFromJson(json);

  CommunityMemberPage toEntity({Set<int> myPetIds = const {}}) =>
      CommunityMemberPage(
        members: members
            .map((m) => m.toEntity(mine: myPetIds.contains(m.pet.id)))
            .toList(growable: false),
        count: count,
        cursor: PageCursor(hasMore: hasMore, nextPage: nextPage),
      );
}

/// `CommunityListResponse` — a bare list of communities (suggested / mine).
@freezed
abstract class CommunityListResponseDto with _$CommunityListResponseDto {
  const factory CommunityListResponseDto({
    @Default(<CommunityDto>[]) List<CommunityDto> communities,
  }) = _CommunityListResponseDto;

  const CommunityListResponseDto._();

  factory CommunityListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityListResponseDtoFromJson(json);

  List<CommunityGroup> toEntities({Set<int> myPetIds = const {}}) => communities
      .map((c) => c.toEntity(leadIsMine: myPetIds.contains(c.lead.id)))
      .toList(growable: false);
}

/// `CommunityJoinResponse` — result of joining/leaving.
@freezed
abstract class CommunityJoinResponseDto with _$CommunityJoinResponseDto {
  const factory CommunityJoinResponseDto({
    required int communityId,
    @Default(false) bool isMember,
    @Default(0) int memberCount,
  }) = _CommunityJoinResponseDto;

  const CommunityJoinResponseDto._();

  factory CommunityJoinResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommunityJoinResponseDtoFromJson(json);

  JoinResult toEntity() => JoinResult(
        communityId: communityId,
        isMember: isMember,
        memberCount: memberCount,
      );
}
