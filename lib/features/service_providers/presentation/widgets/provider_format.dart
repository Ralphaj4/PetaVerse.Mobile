import '../../../../core/localization/generated/app_localizations.dart';
import '../../domain/entities/provider_category.dart';

/// Presentation-layer formatting/labeling helpers for providers. Kept in one
/// place so cards, pins, and the sheet header all read distances and category
/// names identically (and localized).
abstract final class ProviderFormat {
  /// "320 m" / "1.2 km" / "" when distance is unknown. Input is kilometers
  /// (the search/detail API returns `distanceKm`).
  static String distance(AppLocalizations l10n, double? km) {
    if (km == null) return '';
    if (km < 1) return l10n.distanceMeters((km * 1000).round());
    return l10n.distanceKm(km.toStringAsFixed(km >= 10 ? 0 : 1));
  }

  /// Localized display name for a category (used by chips and cards).
  static String category(AppLocalizations l10n, ProviderCategory category) =>
      switch (category) {
        ProviderCategory.all => l10n.categoryAll,
        ProviderCategory.veterinary => l10n.categoryVeterinary,
        ProviderCategory.grooming => l10n.categoryGrooming,
        ProviderCategory.petShop => l10n.categoryPetShop,
        ProviderCategory.boarding => l10n.categoryBoarding,
        ProviderCategory.training => l10n.categoryTraining,
        ProviderCategory.petSitting => l10n.categoryPetSitting,
        ProviderCategory.walking => l10n.categoryWalking,
        ProviderCategory.adoption => l10n.categoryAdoption,
        ProviderCategory.shelter => l10n.categoryShelter,
        ProviderCategory.pharmacy => l10n.categoryPharmacy,
      };
}
