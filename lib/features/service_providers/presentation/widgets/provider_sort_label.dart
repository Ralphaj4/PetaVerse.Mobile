import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../providers/service_providers_providers.dart';

/// Localized label for a [ProviderSort] — shared by the sheet header chip and
/// the sort selector so they never drift.
String providerSortLabel(AppLocalizations l10n, ProviderSort sort) =>
    switch (sort) {
      ProviderSort.distance => l10n.sortDistance,
      ProviderSort.rating => l10n.sortRating,
      ProviderSort.openNow => l10n.sortOpenNow,
      ProviderSort.mostReviewed => l10n.sortMostReviewed,
    };

/// Icon for a [ProviderSort], used in the sort selector rows.
IconData providerSortIcon(ProviderSort sort) => switch (sort) {
      ProviderSort.distance => FluentIcons.location_24_regular,
      ProviderSort.rating => FluentIcons.star_24_regular,
      ProviderSort.openNow => FluentIcons.clock_24_regular,
      ProviderSort.mostReviewed => FluentIcons.comment_multiple_24_regular,
    };
