import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_colors.dart';

/// The kind of pet business a provider offers. Ordered as they appear in the
/// horizontal filter bar (with [all] first as the reset chip).
///
/// New categories can be appended without touching call sites: the filter bar,
/// pins, and cards all derive their label/icon/color from this enum, so adding
/// a value is the only change required.
enum ProviderCategory {
  all,
  veterinary,
  grooming,
  petShop,
  boarding,
  training,
  petSitting,
  walking,
  adoption,
  shelter,
  emergency,
  pharmacy,
}

/// Presentation metadata for a [ProviderCategory] — the glyph shown on pins and
/// chips, and the accent color used to tint them. Kept on the enum (not in the
/// widgets) so every surface stays consistent and a new category is one edit.
extension ProviderCategoryX on ProviderCategory {
  /// Regular (outline) icon — used for unselected chips.
  IconData get icon => switch (this) {
        ProviderCategory.all => FluentIcons.grid_24_regular,
        ProviderCategory.veterinary => FluentIcons.stethoscope_24_regular,
        ProviderCategory.grooming => FluentIcons.sparkle_24_regular,
        ProviderCategory.petShop => FluentIcons.store_microsoft_24_regular,
        ProviderCategory.boarding => FluentIcons.home_24_regular,
        ProviderCategory.training => FluentIcons.ribbon_24_regular,
        ProviderCategory.petSitting => FluentIcons.person_heart_24_regular,
        ProviderCategory.walking => FluentIcons.person_walking_24_regular,
        ProviderCategory.adoption => FluentIcons.heart_24_regular,
        ProviderCategory.shelter => FluentIcons.home_heart_24_regular,
        ProviderCategory.emergency => FluentIcons.vehicle_car_24_regular,
        ProviderCategory.pharmacy => FluentIcons.pill_24_regular,
      };

  /// Filled variant — used on selected chips and map pins.
  IconData get filledIcon => switch (this) {
        ProviderCategory.all => FluentIcons.grid_24_filled,
        ProviderCategory.veterinary => FluentIcons.stethoscope_24_filled,
        ProviderCategory.grooming => FluentIcons.sparkle_24_filled,
        ProviderCategory.petShop => FluentIcons.store_microsoft_24_filled,
        ProviderCategory.boarding => FluentIcons.home_24_filled,
        ProviderCategory.training => FluentIcons.ribbon_24_filled,
        ProviderCategory.petSitting => FluentIcons.person_heart_24_filled,
        ProviderCategory.walking => FluentIcons.person_walking_24_filled,
        ProviderCategory.adoption => FluentIcons.heart_24_filled,
        ProviderCategory.shelter => FluentIcons.home_heart_24_filled,
        ProviderCategory.emergency => FluentIcons.vehicle_car_24_filled,
        ProviderCategory.pharmacy => FluentIcons.pill_24_filled,
      };

  /// Accent color for pins and chips. Emergency is red to read as urgent;
  /// everything else uses the brand palette so the map stays on-brand.
  Color get color => switch (this) {
        ProviderCategory.all => AppColors.textPrimary,
        ProviderCategory.veterinary => AppColors.secondary,
        ProviderCategory.grooming => AppColors.accentPurple,
        ProviderCategory.petShop => AppColors.primary,
        ProviderCategory.boarding => AppColors.info,
        ProviderCategory.training => AppColors.primaryDark,
        ProviderCategory.petSitting => AppColors.accentCoral,
        ProviderCategory.walking => AppColors.success,
        ProviderCategory.adoption => AppColors.accentCoral,
        ProviderCategory.shelter => AppColors.secondaryDark,
        ProviderCategory.emergency => AppColors.error,
        ProviderCategory.pharmacy => AppColors.info,
      };
}
