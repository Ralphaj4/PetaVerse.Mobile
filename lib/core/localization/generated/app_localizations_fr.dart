// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PetaVerse';

  @override
  String get navHome => 'Accueil';

  @override
  String get navCommunity => 'Communauté';

  @override
  String get navCare => 'PawCare';

  @override
  String get navProfile => 'Profil';

  @override
  String get aiAssistant => 'Assistant IA';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get getStarted => 'Commencer';

  @override
  String get retry => 'Réessayer';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get delete => 'Supprimer';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get errorTitle => 'Une erreur est survenue';

  @override
  String get errorNetwork =>
      'Pas de connexion Internet. Vérifiez votre réseau et réessayez.';

  @override
  String get errorUnauthorized =>
      'Votre session a expiré. Veuillez vous reconnecter.';

  @override
  String get errorForbidden => 'Vous n\'avez pas la permission de faire cela.';

  @override
  String get errorValidation =>
      'Certaines informations sont invalides. Veuillez vérifier et réessayer.';

  @override
  String get errorServer =>
      'Nos serveurs rencontrent un problème. Veuillez réessayer plus tard.';

  @override
  String get errorCache => 'Impossible de charger les données enregistrées.';

  @override
  String get errorUnknown =>
      'Une erreur inattendue est survenue. Veuillez réessayer.';
}
