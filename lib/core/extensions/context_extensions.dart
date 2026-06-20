import 'package:flutter/material.dart';

import '../localization/generated/app_localizations.dart';
import '../../shared/widgets/app_snack_bar.dart';

/// Convenience accessors used across all presentation code.
extension BuildContextX on BuildContext {
  /// Localized strings: `context.l10n.addPet`.
  AppLocalizations get l10n => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  void showSnackBar(String message) =>
      AppSnackBar.show(this, message);

  void showSuccessSnackBar(String message) =>
      AppSnackBar.show(this, message, variant: AppSnackBarVariant.success);

  void showErrorSnackBar(String message) =>
      AppSnackBar.show(this, message, variant: AppSnackBarVariant.error);

  void showWarningSnackBar(String message) =>
      AppSnackBar.show(this, message, variant: AppSnackBarVariant.warning);
}
