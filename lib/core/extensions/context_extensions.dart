import 'package:flutter/material.dart';

import '../localization/generated/app_localizations.dart';

/// Convenience accessors used across all presentation code.
extension BuildContextX on BuildContext {
  /// Localized strings: `context.l10n.addPet`.
  AppLocalizations get l10n => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
