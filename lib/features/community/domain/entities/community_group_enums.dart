/// Wire enums for pet-led **communities** (groups), separate from the PawHub
/// social enums in `community_enums.dart`.
///
/// Like the rest of the Community API, these serialize as **integers**. Each
/// enum carries an explicit wire mapper so Dart's declaration order never has
/// to match the server's numbering.
library;

/// The theme of a community (`CommunityCategory`, request & response). Wire
/// values are fixed by the backend contract - do not renumber.
/// As of the Pages update: 0 = BreedClub (reserved), 1 = Species (the 12
/// predefined species communities). Old values 2–6 no longer exist server-side;
/// unknown values fall back to [other].
enum CommunityCategory {
  breedClub,
  species,
  other,
}

extension CommunityCategoryX on CommunityCategory {
  int get wire => switch (this) {
        CommunityCategory.breedClub => 0,
        CommunityCategory.species => 1,
        CommunityCategory.other => 6,
      };
}

/// Maps a server category string → [CommunityCategory]. Unknown values fall
/// back to [CommunityCategory.other].
CommunityCategory communityCategoryFromWire(String? value) =>
    switch (value?.toLowerCase()) {
      'breedclub' => CommunityCategory.breedClub,
      'species' => CommunityCategory.species,
      _ => CommunityCategory.other,
    };

/// A pet's role within a community (`CommunityRole`, response). Only [lead]
/// (the creator) and [member] exist in v1.
enum CommunityRole { lead, member }

extension CommunityRoleX on CommunityRole {
  int get wire => switch (this) {
        CommunityRole.lead => 0,
        CommunityRole.member => 1,
      };
}

/// Maps a server role int → [CommunityRole]. Unknown values fall back to
/// [CommunityRole.member] (the least-privileged role - never over-grants).
CommunityRole communityRoleFromWire(int? value) => switch (value) {
      0 => CommunityRole.lead,
      1 => CommunityRole.member,
      _ => CommunityRole.member,
    };

/// Ordering for the communities directory (`CommunitySort` query param).
enum CommunitySort { popular, newest, mostActive }

extension CommunitySortX on CommunitySort {
  int get wire => switch (this) {
        CommunitySort.popular => 0,
        CommunitySort.newest => 1,
        CommunitySort.mostActive => 2,
      };
}
