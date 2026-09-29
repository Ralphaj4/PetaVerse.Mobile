import '../../../../core/localization/generated/app_localizations.dart';
import '../../domain/entities/community_group_enums.dart';

/// Localized label helpers shared by the community widgets/pages, so the
/// enum→string mapping lives in one place.
extension CommunityCategoryLabel on CommunityCategory {
  String label(AppLocalizations l10n) => switch (this) {
        CommunityCategory.breedClub => l10n.communityCategoryBreedClub,
        CommunityCategory.shelterAndRescues =>
          l10n.communityCategoryShelterRescues,
        CommunityCategory.breeding => l10n.communityCategoryBreeding,
        CommunityCategory.specialNeeds => l10n.communityCategorySpecialNeeds,
        CommunityCategory.activity => l10n.communityCategoryActivity,
        CommunityCategory.health => l10n.communityCategoryHealth,
        CommunityCategory.other => l10n.communityCategoryOther,
      };
}
