import 'community_entities.dart';
import 'community_group_enums.dart';

/// Domain entities for pet-led **communities** (groups). Pure Dart - no
/// Flutter, no JSON. Kept separate from `community_entities.dart` so the mature
/// social types (Post/Comment/CommunityPet) stay untouched.
///
/// Ids are ints (the API uses int ids throughout). The social actor is always
/// a [CommunityPet] - communities are led and joined by pets, never accounts.

/// A community: a themed group led by one pet. Any other pet may join freely.
class CommunityGroup {
  const CommunityGroup({
    required this.id,
    required this.name,
    required this.category,
    required this.memberCount,
    required this.postCount,
    required this.createdAt,
    this.lead,
    this.handle,
    this.description,
    this.avatarUrl,
    this.bannerUrl,
    this.isMember = false,
    this.isLead = false,
    this.isSystem = false,
    this.speciesId,
  });

  final int id;
  final String name;

  /// Unique `@beach-dogs`-style handle for deep links (nullable until set).
  final String? handle;
  final String? description;
  final String? avatarUrl;
  final String? bannerUrl;
  final CommunityCategory category;

  /// The lead pet (creator). Null for system communities (the 12 predefined
  /// species communities which have no pet lead).
  final CommunityPet? lead;
  final int memberCount;
  final int postCount;

  /// Whether the *acting* pet belongs to this community.
  final bool isMember;

  /// Whether the *acting* pet is the lead (may manage/delete the community).
  final bool isLead;

  /// True for the 12 predefined species communities (auto-created by the server).
  final bool isSystem;

  /// Species this community is scoped to (non-null for system communities).
  final int? speciesId;

  final DateTime createdAt;

  /// Optimistic copy used by join/leave toggles before the server confirms.
  CommunityGroup copyWith({
    String? name,
    String? handle,
    String? description,
    String? avatarUrl,
    String? bannerUrl,
    CommunityCategory? category,
    int? memberCount,
    int? postCount,
    bool? isMember,
    bool? isLead,
  }) =>
      CommunityGroup(
        id: id,
        name: name ?? this.name,
        category: category ?? this.category,
        lead: lead,
        memberCount: memberCount ?? this.memberCount,
        postCount: postCount ?? this.postCount,
        createdAt: createdAt,
        handle: handle ?? this.handle,
        description: description ?? this.description,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        bannerUrl: bannerUrl ?? this.bannerUrl,
        isMember: isMember ?? this.isMember,
        isLead: isLead ?? this.isLead,
        isSystem: isSystem,
        speciesId: speciesId,
      );
}

/// A pet's membership in a community (`CommunityMemberResponse`).
class CommunityMember {
  const CommunityMember({
    required this.pet,
    required this.role,
    required this.joinedAt,
  });

  final CommunityPet pet;
  final CommunityRole role;
  final DateTime joinedAt;

  bool get isLead => role == CommunityRole.lead;
}

// ── Paged wrappers (mirror community_entities.dart style) ────────────────────

/// A page of communities for the directory (`CommunityDirectoryResponse`).
class CommunityDirectoryPage {
  const CommunityDirectoryPage({
    required this.communities,
    required this.cursor,
    this.total,
  });

  final List<CommunityGroup> communities;
  final PageCursor cursor;
  final int? total;
}

/// A page of a community's members (`CommunityMembersResponse`).
class CommunityMemberPage {
  const CommunityMemberPage({
    required this.members,
    required this.count,
    required this.cursor,
  });

  final List<CommunityMember> members;
  final int count;
  final PageCursor cursor;
}

// ── Small action results (mirror FollowResult/SaveResult) ────────────────────

/// Result of joining/leaving a community (`CommunityJoinResponse`).
class JoinResult {
  const JoinResult({
    required this.communityId,
    required this.isMember,
    required this.memberCount,
  });

  final int communityId;
  final bool isMember;
  final int memberCount;
}
