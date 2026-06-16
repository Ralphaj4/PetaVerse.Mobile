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
  String get continueButton => 'Continuer';

  @override
  String get onboardingTitle1a => 'Bienvenue sur';

  @override
  String get onboardingTitle1b => 'PetaVerse';

  @override
  String get onboardingDesc1 =>
      'Votre compagnon tout-en-un pour tous les besoins de votre animal — santé, soins et plus.';

  @override
  String get onboardingTitle2a => 'Suivi santé &';

  @override
  String get onboardingTitle2b => 'Rappels';

  @override
  String get onboardingDesc2 =>
      'Ne manquez jamais un vaccin, une visite vétérinaire ou un médicament grâce aux rappels intelligents.';

  @override
  String get onboardingTitle3a => 'Rejoignez la';

  @override
  String get onboardingTitle3b => 'Communauté';

  @override
  String get onboardingDesc3 =>
      'Partagez des moments, retrouvez les animaux perdus et découvrez les services locaux.';

  @override
  String get loginTitle1 => 'Bon retour';

  @override
  String get loginTitle2 => 'parmi nous !';

  @override
  String get loginSubtitle =>
      'Connectez-vous pour continuer à prendre soin de vos compagnons.';

  @override
  String get mobileNumber => 'Numéro de mobile';

  @override
  String get password => 'Mot de passe';

  @override
  String get logIn => 'Se connecter';

  @override
  String get noAccountPrompt => 'Pas encore de compte ?';

  @override
  String get joinTheFamily => 'Rejoignez la famille';

  @override
  String get registerTitle1 => 'Rejoignez la';

  @override
  String get registerTitle2 => 'Famille';

  @override
  String get registerSubtitle =>
      'Créez un compte et offrez à vos animaux les soins qu\'ils méritent.';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get emailOptional => 'E-mail (facultatif)';

  @override
  String get invalidEmail => 'Saisissez une adresse e-mail valide';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get haveAccountPrompt => 'Vous avez déjà un compte ?';

  @override
  String get logInLink => 'Se connecter';

  @override
  String get otpTitle1 => 'Vérifiez votre';

  @override
  String get otpTitle2 => 'Numéro';

  @override
  String otpSubtitle(String phone) {
    return 'Saisissez le code à 4 chiffres envoyé au $phone';
  }

  @override
  String get verify => 'Vérifier';

  @override
  String get resendCode => 'Renvoyer le code';

  @override
  String resendIn(int seconds) {
    return 'Renvoyer dans ${seconds}s';
  }

  @override
  String goodMorning(String name) {
    return 'Bonjour, $name 👋';
  }

  @override
  String goodAfternoon(String name) {
    return 'Bon après-midi, $name 👋';
  }

  @override
  String goodEvening(String name) {
    return 'Bonsoir, $name 👋';
  }

  @override
  String petDoingGreat(String petName) {
    return '$petName va très bien aujourd\'hui ! 🐾';
  }

  @override
  String get healthScore => 'Score Santé';

  @override
  String get healthExcellent => 'Excellent';

  @override
  String get nextVisit => 'Prochaine Visite';

  @override
  String get statHealth => 'Santé';

  @override
  String get statNutrition => 'Nutrition';

  @override
  String get statActivity => 'Activité';

  @override
  String get statVaccines => 'Vaccins';

  @override
  String get statGreat => 'Super';

  @override
  String get statGood => 'Bien';

  @override
  String stepsCount(int steps) {
    final intl.NumberFormat stepsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String stepsString = stepsNumberFormat.format(steps);

    return '$stepsString pas';
  }

  @override
  String get upToDate => 'À jour';

  @override
  String get upcoming => 'À venir';

  @override
  String get quickActions => 'Actions';

  @override
  String get bookAppointment => 'Prendre Rendez-vous';

  @override
  String get addRecord => 'Ajouter un Dossier';

  @override
  String get lostAndFound => 'Animaux Perdus';

  @override
  String get lostAndFoundDashboard => 'Tableau de Bord Animaux Perdus';

  @override
  String lostAndFoundSubtitle(int count) {
    return '$count alertes actives dans un rayon de 5 miles';
  }

  @override
  String get liveMapView => 'Carte en Direct';

  @override
  String get recentAlerts => 'Alertes Récentes';

  @override
  String get filterAll => 'Tout';

  @override
  String get filterLost => 'Perdus';

  @override
  String get filterFound => 'Trouvés';

  @override
  String get badgeLost => 'PERDU';

  @override
  String get badgeFound => 'TROUVÉ';

  @override
  String timeAgo(int n) {
    return 'il y a ${n}h';
  }

  @override
  String get contactOwner => 'Contacter le Propriétaire';

  @override
  String get viewDetails => 'Voir les Détails';

  @override
  String get reportLostPet => 'Signaler un Animal Perdu';

  @override
  String get howToHelp => 'Comment Aider';

  @override
  String get howToHelpBody =>
      'Rejoignez notre équipe de bénévoles pour être alerté quand un animal est signalé près de chez vous.';

  @override
  String get becomeVolunteer => 'Devenir Bénévole';

  @override
  String activeVolunteers(int count) {
    return '$count Bénévoles Actifs';
  }

  @override
  String get medicationsReminders => 'Médicaments & Rappels';

  @override
  String get healthTracker => 'Suivi Santé';

  @override
  String get notifications => 'Notifications';

  @override
  String get premiumMember => 'Membre Premium';

  @override
  String get petProfiles => 'Profils des Animaux';

  @override
  String get addPet => 'Ajouter';

  @override
  String get petActive => 'ACTIF';

  @override
  String petAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years ans',
      one: '$years an',
    );
    return '$_temp0';
  }

  @override
  String get accountSettings => 'Paramètres du Compte';

  @override
  String get personalInformation => 'Informations Personnelles';

  @override
  String get securityPrivacy => 'Sécurité & Confidentialité';

  @override
  String get paymentMethods => 'Moyens de Paiement';

  @override
  String get notificationsSupport => 'Notifications & Assistance';

  @override
  String get helpCenter => 'Centre d\'Aide';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get toggleOn => 'Activé';

  @override
  String get toggleOff => 'Désactivé';

  @override
  String get logOut => 'Se Déconnecter';

  @override
  String get logOutConfirmTitle => 'Se déconnecter ?';

  @override
  String get logOutConfirmMessage =>
      'Vous devrez vous reconnecter pour accéder à vos animaux et rappels.';

  @override
  String get logOutConfirm => 'Oui, déconnexion';

  @override
  String appVersion(String version, String build) {
    return 'Version $version (Build $build)';
  }

  @override
  String get aiAssistantTitle => 'Assistant PawBot';

  @override
  String get aiAskHint => 'Demandez à PawBot…';

  @override
  String get aiQuickFaqs => 'FAQ';

  @override
  String get aiQuickBreedInfo => 'Races';

  @override
  String get aiQuickSymptomChecker => 'Vérif. Symptômes';

  @override
  String get aiHealthVaultTitle => 'Coffre Santé';

  @override
  String aiHealthVaultSubtitle(String petName) {
    return 'Stockez les vaccinations et l\'historique médical de $petName.';
  }

  @override
  String get fieldRequired => 'Ce champ est requis';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get invalidPhone => 'Saisissez un numéro de mobile valide';

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
