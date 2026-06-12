// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PetaVerse';

  @override
  String get navHome => 'Home';

  @override
  String get navCommunity => 'PawHub';

  @override
  String get navCare => 'PawCare';

  @override
  String get navProfile => 'Profile';

  @override
  String get aiAssistant => 'AI Assistant';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get getStarted => 'Get Started';

  @override
  String get retry => 'Retry';

  @override
  String get seeAll => 'See all';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorNetwork =>
      'No internet connection. Please check your network and try again.';

  @override
  String get errorUnauthorized =>
      'Your session has expired. Please sign in again.';

  @override
  String get errorForbidden => 'You don\'t have permission to do that.';

  @override
  String get errorValidation =>
      'Some information is invalid. Please review and try again.';

  @override
  String get errorServer =>
      'Our servers are having trouble. Please try again later.';

  @override
  String get errorCache => 'Could not load saved data.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';
}
