import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/router/app_router.dart';
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

  /// Neutral (info) toast. Optional [subtitle] adds a muted second line and
  /// [actionLabel]/[onAction] add a trailing orange action.
  void showSnackBar(
    String message, {
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
  }) =>
      AppSnackBar.show(
        this,
        message,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  void showSuccessSnackBar(
    String message, {
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
  }) =>
      AppSnackBar.show(
        this,
        message,
        variant: AppSnackBarVariant.success,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  void showErrorSnackBar(
    String message, {
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
  }) =>
      AppSnackBar.show(
        this,
        message,
        variant: AppSnackBarVariant.error,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      );

  /// Safe back navigation: pops if there is a route to pop, otherwise
  /// redirects to home. Prevents the "There is nothing to pop" GoError that
  /// occurs when a page is the root of the stack after a cold-launch from a
  /// notification deep-link.
  void popOrHome() {
    if (canPop()) {
      pop();
    } else {
      go(AppRoutes.home);
    }
  }

  void showWarningSnackBar(
    String message, {
    String? subtitle,
    String? actionLabel,
    VoidCallback? onAction,
  }) =>
      AppSnackBar.show(
        this,
        message,
        variant: AppSnackBarVariant.warning,
        subtitle: subtitle,
        actionLabel: actionLabel,
        onAction: onAction,
      );
}
