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
  String get communityTabFeed => 'Fil';

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
  String get goodMorning => 'Bonjour 👋';

  @override
  String get goodAfternoon => 'Bon après-midi 👋';

  @override
  String get goodEvening => 'Bonsoir 👋';

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
    return '$count alertes actives dans un rayon de 10 km';
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
  String get lostFoundDetailTitle => 'Détails du signalement';

  @override
  String get reportReporter => 'Signalé par';

  @override
  String get reportViewOnMap => 'Voir sur la carte';

  @override
  String get contactOwner => 'Contacter le Propriétaire';

  @override
  String get contactOwnerTitle => 'Contacter le propriétaire';

  @override
  String contactOwnerSubtitle(String petName) {
    return 'Prenez contact au sujet de $petName.';
  }

  @override
  String get contactCall => 'Appeler';

  @override
  String get contactCallSubtitle => 'Passer un appel téléphonique';

  @override
  String get contactWhatsApp => 'WhatsApp';

  @override
  String get contactWhatsAppSubtitle => 'Envoyer un message sur WhatsApp';

  @override
  String get contactNoPhone => 'Ce signalement n\'a pas de numéro de contact.';

  @override
  String get contactLaunchError =>
      'Impossible d\'ouvrir l\'application. Veuillez réessayer.';

  @override
  String get viewDetails => 'Voir les Détails';

  @override
  String get reportLostPet => 'Signaler un Animal Perdu';

  @override
  String get reportLostPetTitle => 'Signaler un animal perdu';

  @override
  String get reportLostPetSubtitle =>
      'Choisissez votre animal et où il a été vu pour la dernière fois.';

  @override
  String get reportSelectPet => 'Quel animal est perdu ?';

  @override
  String get reportSelectPetHint => 'Sélectionner un animal';

  @override
  String get reportNoPets =>
      'Vous n\'avez aucun animal à signaler. Ajoutez d\'abord un animal.';

  @override
  String get reportDescription => 'Description';

  @override
  String get reportDescriptionHint =>
      'Collier, signes distinctifs, comportement…';

  @override
  String get reportLastSeenAddress => 'Adresse de la dernière observation';

  @override
  String get reportLastSeenAddressHint => 'ex. Quartier Sunset, Park Ave';

  @override
  String get reportLocation => 'Dernier lieu connu';

  @override
  String get reportLocationHint => 'Touchez la carte pour placer un repère';

  @override
  String get reportLocationRequired => 'Touchez la carte pour définir le lieu';

  @override
  String get reportReward => 'Récompense (facultatif)';

  @override
  String get reportRewardLabel => 'Récompense';

  @override
  String get reportRewardHint => '0–999';

  @override
  String get reportRewardRange => 'La récompense doit être entre 0 et 999';

  @override
  String reportRewardBadge(int amount) {
    return 'Récompense : \$$amount';
  }

  @override
  String get reportSubmit => 'Continuer';

  @override
  String get reportHeaderSubtitle =>
      'Aidez à réunir les animaux avec leur famille.';

  @override
  String get reportRewardHelper =>
      'Offrir une récompense peut augmenter les chances de retrouvailles.';

  @override
  String get reportUseMyLocation => 'Utiliser ma position';

  @override
  String get reportCreatedSuccess => 'Signalement créé';

  @override
  String get deleteReportTitle => 'Supprimer le signalement ?';

  @override
  String deleteReportMessage(String petName) {
    return 'Cela retire le signalement de $petName de la carte et des annonces. Cette action est irréversible.';
  }

  @override
  String get deleteReportSuccess => 'Signalement supprimé';

  @override
  String get reportSpeciesUnresolved =>
      'Impossible de déterminer l\'espèce de votre animal. Veuillez réessayer.';

  @override
  String get reportTitle => 'Signaler un animal';

  @override
  String get reportTypeLost => 'Perdu';

  @override
  String get reportTypeFound => 'Trouvé';

  @override
  String get reportLostSubtitle =>
      'Choisissez votre animal et où il a été vu pour la dernière fois.';

  @override
  String get reportFoundSubtitle =>
      'Décrivez l\'animal que vous avez trouvé et où vous l\'avez vu.';

  @override
  String get reportFoundName => 'Nom de l\'animal';

  @override
  String get reportFoundNameHint => 'Un nom ou surnom (ex. « chat roux »)';

  @override
  String get reportFoundSpecies => 'Espèce';

  @override
  String get reportFoundBreed => 'Race';

  @override
  String get reportFoundSelectSpeciesFirst =>
      'Sélectionnez d\'abord une espèce';

  @override
  String get reportPhoto => 'Photo';

  @override
  String get reportPhotoHint => 'Ajoutez une photo nette de l\'animal';

  @override
  String get reportPhotoRemove => 'Supprimer la photo';

  @override
  String get reportPhotoRequired =>
      'Une photo est requise pour les signalements trouvés';

  @override
  String get howToHelp => 'Comment Aider';

  @override
  String get howToHelpBody =>
      'Rejoignez notre équipe de bénévoles pour être alerté quand un animal est signalé près de chez vous.';

  @override
  String get becomeVolunteer => 'Devenir Bénévole';

  @override
  String get alreadyVolunteer => 'Vous êtes bénévole';

  @override
  String get becameVolunteer => 'Vous êtes maintenant bénévole';

  @override
  String get leftVolunteer => 'Vous avez quitté les bénévoles';

  @override
  String get leaveVolunteerAction => 'Quitter';

  @override
  String get leaveVolunteerTitle => 'Quitter les bénévoles ?';

  @override
  String get leaveVolunteerMessage =>
      'Vous ne recevrez plus d\'alertes lorsqu\'un animal perdu est signalé près de chez vous.';

  @override
  String get leaveVolunteerConfirm => 'Quitter';

  @override
  String get lostAndFoundNoAlerts =>
      'Aucune alerte à proximité pour le moment.';

  @override
  String activeVolunteers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bénévoles Actifs',
      one: '1 Bénévole Actif',
    );
    return '$_temp0';
  }

  @override
  String get volunteerThankYou => 'Merci de faire la différence !';

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
  String get preferences => 'Préférences';

  @override
  String get language => 'Langue';

  @override
  String get changeLanguage => 'Langue';

  @override
  String get changeLanguageSubtitle =>
      'Choisissez la langue que vous souhaitez utiliser dans l\'application';

  @override
  String get privacySettings => 'Paramètres de Confidentialité';

  @override
  String get support => 'Assistance';

  @override
  String get contactUs => 'Nous Contacter';

  @override
  String get reportProblem => 'Signaler un Problème';

  @override
  String get termsPrivacy => 'Conditions & Confidentialité';

  @override
  String get termsConditions => 'Conditions Générales';

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
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get forgotPasswordTitle1 => 'Réinitialiser le';

  @override
  String get forgotPasswordTitle2 => 'mot de passe';

  @override
  String get forgotPasswordSubtitle =>
      'Saisissez votre numéro de mobile et nous vous enverrons un code pour réinitialiser votre mot de passe.';

  @override
  String get sendCode => 'Envoyer le code';

  @override
  String get resetPasswordTitle1 => 'Nouveau';

  @override
  String get resetPasswordTitle2 => 'mot de passe';

  @override
  String resetPasswordSubtitle(String phone) {
    return 'Saisissez le code envoyé au $phone et choisissez un nouveau mot de passe.';
  }

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get resetPasswordAction => 'Réinitialiser';

  @override
  String get passwordResetSuccess =>
      'Mot de passe réinitialisé. Connectez-vous avec votre nouveau mot de passe.';

  @override
  String get security => 'Sécurité';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get changePasswordSubtitle =>
      'Saisissez votre mot de passe actuel et choisissez-en un nouveau.';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get passwordChangedSuccess => 'Votre mot de passe a été changé.';

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
  String get confirm => 'Confirmer';

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
  String get errorRateLimit =>
      'Vous allez trop vite. Veuillez ralentir et réessayer.';

  @override
  String errorRateLimitRetry(int seconds) {
    return 'Trop de requêtes. Réessayez dans ${seconds}s.';
  }

  @override
  String get errorCache => 'Impossible de charger les données enregistrées.';

  @override
  String get errorUnknown =>
      'Une erreur inattendue est survenue. Veuillez réessayer.';

  @override
  String get errorNotFound =>
      'Nous n\'avons trouvé aucun compte avec ces informations.';

  @override
  String get errorPhoneNotRegistered =>
      'Aucun compte n\'est enregistré avec ce numéro de mobile.';

  @override
  String get petOnboardingTitleTop => 'Ajoutez votre';

  @override
  String get petOnboardingTitleAccent => 'premier animal';

  @override
  String get petOnboardingSubtitle =>
      'Parlez-nous de votre compagnon afin d\'adapter sa santé, ses rappels et ses soins.';

  @override
  String get petOnboardingAction => 'Ajouter un animal';

  @override
  String get petOnboardingLoading => 'Vérification de vos animaux…';

  @override
  String get selectPetTitle => 'Choisir un animal';

  @override
  String get selectPetSubtitle => 'De qui prenons-nous soin aujourd\'hui ?';

  @override
  String get createPetTitle => 'Ajouter un animal';

  @override
  String get createPetSubtitle => 'Parlez-nous de votre nouveau compagnon';

  @override
  String get createPetName => 'Nom de l\'animal';

  @override
  String get createPetSpecies => 'Type d\'animal';

  @override
  String get createPetBreed => 'Race';

  @override
  String get createPetSelectSpeciesFirst =>
      'Sélectionnez d\'abord un type d\'animal';

  @override
  String get createPetDateOfBirth => 'Date de naissance';

  @override
  String get createPetGender => 'Sexe';

  @override
  String get genderMale => 'Mâle';

  @override
  String get genderFemale => 'Femelle';

  @override
  String get genderUnknown => 'Inconnu';

  @override
  String get createPetSubmit => 'Enregistrer l\'animal';

  @override
  String createPetSuccess(String name) {
    return '$name a été ajouté !';
  }

  @override
  String get petDetailSetActive => 'Définir comme actif';

  @override
  String get petDetailAlreadyActive => 'Actuellement actif';

  @override
  String get petDetailGender => 'Sexe';

  @override
  String get petDetailDateOfBirth => 'Date de naissance';

  @override
  String get petDetailBreed => 'Race';

  @override
  String get petDetailSize => 'Taille';

  @override
  String get petDetailCoatColor => 'Couleur du pelage';

  @override
  String get petDetailMicrochip => 'Micropuce';

  @override
  String get petDetailMicrochipLocation => 'Emplacement';

  @override
  String get petDetailSterilization => 'Stérilisation';

  @override
  String get petDetailSterilizationDate => 'Date';

  @override
  String petDetailAge(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years ans',
      one: '1 an',
    );
    return '$_temp0';
  }

  @override
  String petDetailAgeMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months mois',
      one: '1 mois',
      zero: 'Moins d\'un mois',
    );
    return '$_temp0';
  }

  @override
  String viewAllPets(int count) {
    return 'Voir tous les $count animaux';
  }

  @override
  String get viewAll => 'Voir tout';

  @override
  String get createPetAdditionalInfo => 'Informations supplémentaires';

  @override
  String get createPetAdditionalInfoSubtitle =>
      'Facultatif — vous pouvez compléter plus tard';

  @override
  String get createPetSize => 'Taille';

  @override
  String get createPetCoatColor => 'Couleur du pelage';

  @override
  String get createPetNotSpecified => 'Non spécifié';

  @override
  String get createPetMicrochipNumber => 'Numéro de micropuce';

  @override
  String get createPetMicrochipLocation => 'Emplacement de la micropuce';

  @override
  String get createPetSterilizationStatus => 'Statut de stérilisation';

  @override
  String get sterilizationStatusNotSterilized => 'Non stérilisé';

  @override
  String get sterilizationStatusSterilized => 'Stérilisé';

  @override
  String get sterilizationStatusUnknown => 'Inconnu';

  @override
  String get createPetSterilizationDate => 'Date de stérilisation';

  @override
  String get editPetTitle => 'Modifier l\'animal';

  @override
  String get editPetSave => 'Enregistrer les modifications';

  @override
  String get deletePetTitle => 'Supprimer le profile de l\'animal';

  @override
  String deletePetMessage(String petName) {
    return 'Êtes-vous sûr de vouloir supprimer $petName ? Cette action est irréversible.';
  }

  @override
  String get deletePetConfirm => 'Supprimer';

  @override
  String get petUpdatedSuccess => 'Animal mis à jour avec succès';

  @override
  String get petDeletedSuccess => 'Animal supprimé';

  @override
  String get petDetailTabOverview => 'Aperçu';

  @override
  String get petDetailTabHealth => 'Santé';

  @override
  String get petDetailTabRecords => 'Dossiers';

  @override
  String get petDetailTabTimeline => 'Historique';

  @override
  String get petDetailActionEdit => 'Modifier';

  @override
  String get petDetailActionBook => 'Réserver';

  @override
  String get petDetailActionShare => 'Pet Vision';

  @override
  String get petDetailActionMore => 'Plus';

  @override
  String get petDetailDateAdded => 'Date d\'ajout';

  @override
  String petDetailProfileCompleteTitle(String petName) {
    return '$petName est prêt !';
  }

  @override
  String get petDetailProfileCompleteSubtitle =>
      'Le profil de votre animal est complet et à jour.';

  @override
  String get microchipCopied => 'Numéro de micropuce copié';

  @override
  String get healthWeightTitle => 'Poids';

  @override
  String get healthWeightAdd => 'Ajouter un poids';

  @override
  String get healthWeightEmpty =>
      'Aucun poids enregistré. Suivez le poids de votre animal au fil du temps.';

  @override
  String get healthWeightSteady => 'Stable';

  @override
  String healthWeightLastRecorded(String date) {
    return 'Dernier relevé le $date';
  }

  @override
  String get healthMedicationsTitle => 'Médicaments';

  @override
  String get healthMedicationsAdd => 'Ajouter un médicament';

  @override
  String get healthMedicationsEmpty =>
      'Aucun médicament actif. Ajoutez des rappels pour rester à jour.';

  @override
  String get healthMedicationsMarkGiven => 'Marquer comme administré';

  @override
  String healthMedicationsGivenConfirmed(String name) {
    return '$name marqué comme administré';
  }

  @override
  String get healthMedicationsOverdue => 'En retard';

  @override
  String get healthMedicationsDueToday => 'Aujourd\'hui';

  @override
  String healthMedicationsDueInDays(int days) {
    return 'Dans $days j';
  }

  @override
  String get healthVaccinationsTitle => 'Vaccinations';

  @override
  String get healthVaccinationsAdd => 'Ajouter une vaccination';

  @override
  String get healthVaccinationsEmpty => 'Aucune vaccination enregistrée.';

  @override
  String healthVaccinationsGivenOn(String date) {
    return 'Administré le $date';
  }

  @override
  String healthVaccinationsNextDue(String date) {
    return 'Échéance $date';
  }

  @override
  String get healthVaccinationsDue => 'À faire';

  @override
  String get healthFrequencyDaily => 'Quotidien';

  @override
  String get healthFrequencyWeekly => 'Hebdomadaire';

  @override
  String get healthFrequencyBiweekly => 'Toutes les 2 semaines';

  @override
  String get healthFrequencyMonthly => 'Mensuel';

  @override
  String get healthFrequencyQuarterly => 'Tous les 3 mois';

  @override
  String get petDetailSectionDetails => 'Détails de l\'animal';

  @override
  String get petDetailSectionHealth => 'Données de santé';

  @override
  String get healthWeightValueLabel => 'Poids';

  @override
  String get healthWeightValueHint => 'ex. 12,4';

  @override
  String get healthWeightDateLabel => 'Date d\'enregistrement';

  @override
  String get healthWeightInvalid => 'Saisissez un poids valide';

  @override
  String get healthWeightAddedSuccess => 'Poids enregistré';

  @override
  String get healthWeightAllReadings => 'Toutes les mesures';

  @override
  String get healthWeightDeleteTitle => 'Supprimer cette mesure ?';

  @override
  String get healthWeightDeleteMessage =>
      'Cette mesure de poids sera définitivement supprimée.';

  @override
  String get healthWeightDeleteSuccess => 'Mesure de poids supprimée';

  @override
  String healthFrequencyEveryNDays(int days) {
    return 'Tous les $days jours';
  }

  @override
  String get healthFrequencyCustomLabel => 'Personnalisé';

  @override
  String get healthFrequencyDaysSuffix => 'jours';

  @override
  String get searchHint => 'Rechercher';

  @override
  String get searchNoResults => 'Aucun résultat';

  @override
  String get healthNotesLabel => 'Notes (facultatif)';

  @override
  String get healthNotesHint => 'Tout ce qui mérite d\'être noté';

  @override
  String get healthMedicationsNameLabel => 'Médicament';

  @override
  String get healthMedicationsNameHint => 'ex. Apoquel';

  @override
  String get healthMedicationsNameRequired =>
      'Choisissez ou saisissez un médicament';

  @override
  String get healthMedicationsPickHint => 'Choisir un médicament';

  @override
  String get healthMedicationsUseCustom => 'Saisir un nom personnalisé';

  @override
  String get healthMedicationsUseList => 'Choisir dans la liste';

  @override
  String get healthMedicationsFrequencyLabel => 'Fréquence';

  @override
  String get healthMedicationsStartDateLabel => 'Date de début';

  @override
  String get healthMedicationsAddedSuccess => 'Médicament ajouté';

  @override
  String get healthMedicationsEditFrequency => 'Fréquence';

  @override
  String get healthMedicationsFrequencyUpdated => 'Fréquence mise à jour';

  @override
  String get healthVaccinationsNameLabel => 'Vaccin';

  @override
  String get healthVaccinationsNameRequired => 'Choisissez un vaccin';

  @override
  String get healthVaccinationsPickHint => 'Choisir un vaccin';

  @override
  String get healthVaccinationsAdministeredLabel => 'Date d\'administration';

  @override
  String get healthVaccinationsNextDueLabel => 'Prochain rappel (facultatif)';

  @override
  String get healthVaccinationsNoBooster => 'Aucun rappel prévu';

  @override
  String get healthVaccinationsVetLabel => 'Vétérinaire (facultatif)';

  @override
  String get healthVaccinationsVetHint => 'ex. Dr Smith';

  @override
  String get healthVaccinationsAddedSuccess => 'Vaccination ajoutée';

  @override
  String get healthMedicationsDeleteTitle => 'Supprimer ce médicament ?';

  @override
  String healthMedicationsDeleteMessage(String name) {
    return '$name sera définitivement supprimé.';
  }

  @override
  String get healthMedicationsDeleteSuccess => 'Médicament supprimé';

  @override
  String get healthVaccinationsDeleteTitle => 'Supprimer cette vaccination ?';

  @override
  String healthVaccinationsDeleteMessage(String name) {
    return 'L\'enregistrement de $name sera définitivement supprimé.';
  }

  @override
  String get healthVaccinationsDeleteSuccess => 'Vaccination supprimée';

  @override
  String get photoSavedToGallery => 'Photo enregistrée dans la galerie';

  @override
  String get couldNotSavePhoto => 'Impossible d\'enregistrer la photo';

  @override
  String get didYouKnow => 'Le saviez-vous?';

  @override
  String get gotIt => 'D\'accord';

  @override
  String get profile => 'Profil';

  @override
  String get dateOfBirth => 'Date de naissance';

  @override
  String get personalInformationSubtitle =>
      'Gérez vos informations personnelles et vos coordonnées';

  @override
  String get basicInformation => 'Informations de base';

  @override
  String get contactDetails => 'Coordonnées';

  @override
  String get accountDetails => 'Détails du compte';

  @override
  String get verified => 'Vérifié';

  @override
  String get unverified => 'Non vérifié';

  @override
  String get selectDate => 'Choisir une date';

  @override
  String get noEmailAdded => 'Aucun e-mail ajouté';

  @override
  String memberSince(String date) {
    return 'Membre depuis $date';
  }

  @override
  String emailPendingVerification(String email) {
    return 'En attente de vérification : $email';
  }

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get userId => 'Identifiant';

  @override
  String get userIdCopied => 'Identifiant copié';

  @override
  String get profileTagCopied => 'Étiquette de profil copiée';

  @override
  String get onboardingCoOwnTitle => 'Vous voulez co-adopter un animal ?';

  @override
  String get onboardingCoOwnBody =>
      'Faites-vous inviter avec votre étiquette de profil :';

  @override
  String get onboardingViewInvites => 'Voir les invitations';

  @override
  String onboardingViewInvitesCount(int count) {
    return 'Voir les invitations ($count)';
  }

  @override
  String get inviteCoOwnerTitle => 'Inviter un co-propriétaire';

  @override
  String inviteCoOwnerSubtitle(String petName) {
    return 'Recherchez par étiquette de profil pour inviter quelqu\'un à co-adopter $petName.';
  }

  @override
  String get inviteCoOwnerSearchHint =>
      'Saisissez une étiquette de profil (ex. a1b2c3d4)';

  @override
  String get inviteCoOwnerSearchIdle =>
      'Saisissez une étiquette de profil complète pour trouver quelqu\'un';

  @override
  String get inviteCoOwnerSearchEmpty =>
      'Aucun utilisateur trouvé avec cette étiquette.';

  @override
  String get inviteCoOwnerInvite => 'Inviter';

  @override
  String get inviteCoOwnerAlreadyInvited => 'Invité';

  @override
  String get inviteCoOwnerSent => 'Invitation envoyée';

  @override
  String get inviteCoOwnerSentTitle => 'Invitations envoyées';

  @override
  String get inviteCoOwnerNoneSent => 'Vous n\'avez encore invité personne.';

  @override
  String get inviteCoOwnerCancel => 'Annuler l\'invitation';

  @override
  String get inviteCoOwnerCancelled => 'Invitation annulée';

  @override
  String get coOwnerCurrentTitle => 'Copropriétaires actuels';

  @override
  String get coOwnerPrimaryBadge => 'Propriétaire';

  @override
  String coOwnerYou(String name) {
    return '$name (Vous)';
  }

  @override
  String get coOwnerRemoveAction => 'Retirer le copropriétaire';

  @override
  String get coOwnerLeaveAction => 'Quitter';

  @override
  String get coOwnerLeavePetAction => 'Quitter la copropriété';

  @override
  String get coOwnerRemoveTitle => 'Retirer le copropriétaire ?';

  @override
  String coOwnerRemoveMessage(String name) {
    return '$name perdra l\'accès à cet animal. Cette action est irréversible.';
  }

  @override
  String get coOwnerRemoveConfirm => 'Retirer';

  @override
  String get coOwnerRemovedSuccess => 'Copropriétaire retiré';

  @override
  String get coOwnerLeaveTitle => 'Quitter cet animal ?';

  @override
  String get coOwnerLeaveMessage =>
      'Vous perdrez l\'accès à cet animal. Le propriétaire pourra vous réinviter plus tard.';

  @override
  String get coOwnerLeaveConfirm => 'Quitter';

  @override
  String get coOwnerLeftSuccess => 'Vous avez quitté l\'animal';

  @override
  String get coOwnerInvitationsTitle => 'Invitations';

  @override
  String get coOwnerInvitationsEmpty =>
      'Vous n\'avez aucune invitation en attente.';

  @override
  String coOwnerInvitedBy(String name) {
    return 'Invité par $name';
  }

  @override
  String get coOwnerAccept => 'Accepter';

  @override
  String get coOwnerDecline => 'Refuser';

  @override
  String coOwnerAccepted(String petName) {
    return 'Vous êtes maintenant co-propriétaire de $petName';
  }

  @override
  String get coOwnerDeclined => 'Invitation refusée';

  @override
  String get statusPending => 'En attente';

  @override
  String get statusAccepted => 'Acceptée';

  @override
  String get statusDeclined => 'Refusée';

  @override
  String get statusCancelled => 'Annulée';

  @override
  String get locationName => 'Localisation';

  @override
  String get locationNameHint => 'ex. Beyrouth, Liban';

  @override
  String get locationNameTooLong =>
      'La localisation doit contenir 200 caractères ou moins';

  @override
  String get locationPickHint => 'Appuyez sur la carte pour placer un repère';

  @override
  String get locationRequired => 'Choisissez votre localisation sur la carte';

  @override
  String get locationUseMine => 'Utiliser ma position';

  @override
  String get changePhoto => 'Changer la photo';

  @override
  String get camera => 'Appareil photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get photoUpdated => 'Photo de profil mise à jour';

  @override
  String get photoUploadFailed =>
      'Impossible de mettre à jour votre photo. Veuillez réessayer.';

  @override
  String get skipForNow => 'Ignorer pour l\'instant';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get petAvatarSetupTitle => 'Ajouter une photo';

  @override
  String get petAvatarSetupSubtitle =>
      'Donnez un visage à votre animal sur son profil.';

  @override
  String get petAvatarSetupOptional => 'Facultatif — modifiable à tout moment.';

  @override
  String get petAvatarUploadHint => 'Télécharger une photo';

  @override
  String get clear => 'Effacer';

  @override
  String get providersNearby => 'Prestataires à proximité';

  @override
  String providerCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count prestataires trouvés',
      one: '1 prestataire trouvé',
      zero: 'Aucun prestataire trouvé',
    );
    return '$_temp0';
  }

  @override
  String get providerSearchHint =>
      'Rechercher vétérinaires, toilettage, magasins…';

  @override
  String get providerSort => 'Trier';

  @override
  String get providerSortBy => 'Trier par';

  @override
  String get sortDistance => 'Distance';

  @override
  String get sortRating => 'Note';

  @override
  String get sortOpenNow => 'Ouvert';

  @override
  String get sortMostReviewed => 'Plus d\'avis';

  @override
  String get providerShowList => 'Afficher la liste';

  @override
  String get providerShowMap => 'Afficher la carte';

  @override
  String get providerMyLocation => 'Ma position';

  @override
  String get providerOpen => 'Ouvert';

  @override
  String get providerClosed => 'Fermé';

  @override
  String get providerCall => 'Appeler';

  @override
  String get providerDirections => 'Itinéraire';

  @override
  String get providerCallFailed =>
      'Impossible de lancer l\'appel. Aucun numéro disponible.';

  @override
  String get providerDirectionsFailed => 'Impossible d\'ouvrir l\'itinéraire.';

  @override
  String get providerNoResultsTitle => 'Aucun prestataire trouvé';

  @override
  String get providerNoResultsNearby =>
      'Nous n\'avons trouvé aucune entreprise pour animaux près de vous pour l\'instant.';

  @override
  String get providerNoResultsFiltered =>
      'Aucun prestataire ne correspond à vos filtres. Essayez d\'ajuster votre recherche ou la catégorie.';

  @override
  String get providerClearFilters => 'Effacer les filtres';

  @override
  String get providerOfflineTitle => 'Vous êtes hors ligne';

  @override
  String get providerOfflineMessage =>
      'Vérifiez votre connexion et réessayez pour voir les prestataires à proximité.';

  @override
  String get providerErrorTitle => 'Une erreur est survenue';

  @override
  String get providerErrorMessage =>
      'Impossible de charger les prestataires pour le moment. Veuillez réessayer.';

  @override
  String get providerLocationDeniedTitle => 'Localisation désactivée';

  @override
  String get providerLocationDeniedMessage =>
      'Activez la localisation pour découvrir les services pour animaux autour de vous.';

  @override
  String get providerEnableLocation => 'Activer la localisation';

  @override
  String distanceMeters(int meters) {
    return '$meters m';
  }

  @override
  String distanceKm(String km) {
    return '$km km';
  }

  @override
  String ratingLabel(String rating) {
    return 'Noté $rating';
  }

  @override
  String ratingWithReviews(String rating, int count) {
    return 'Noté $rating sur $count avis';
  }

  @override
  String reviewCountShort(int count) {
    return '($count)';
  }

  @override
  String get badgeVerified => 'Vérifié';

  @override
  String get badgeEmergency => 'Urgence';

  @override
  String get badge24_7 => '24/7';

  @override
  String get badgeMobile => 'Mobile';

  @override
  String get categoryAll => 'Tous';

  @override
  String get categoryVeterinary => 'Vétérinaire';

  @override
  String get categoryGrooming => 'Toilettage';

  @override
  String get categoryPetShop => 'Animaleries';

  @override
  String get categoryBoarding => 'Pension';

  @override
  String get categoryTraining => 'Dressage';

  @override
  String get categoryPetSitting => 'Garde';

  @override
  String get categoryWalking => 'Promenade';

  @override
  String get categoryAdoption => 'Adoption';

  @override
  String get categoryShelter => 'Refuges';

  @override
  String get categoryEmergency => 'Urgence';

  @override
  String get categoryPharmacy => 'Pharmacie';

  @override
  String get adoptionTitle => 'Adoption';

  @override
  String adoptionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count animaux cherchent un foyer',
      one: '1 animal cherche un foyer',
      zero: 'Aucun animal disponible',
    );
    return '$_temp0';
  }

  @override
  String get adoptionListAPet => 'Proposer';

  @override
  String get adoptionSearchHint => 'Rechercher par nom, race ou zone';

  @override
  String get adoptionFilterAll => 'Tous';

  @override
  String get adoptionSpeciesDog => 'Chien';

  @override
  String get adoptionSpeciesCat => 'Chat';

  @override
  String get adoptionSpeciesBird => 'Oiseau';

  @override
  String get adoptionSpeciesRabbit => 'Lapin';

  @override
  String get adoptionSpeciesOther => 'Autre';

  @override
  String get adoptionSexMale => 'Mâle';

  @override
  String get adoptionSexFemale => 'Femelle';

  @override
  String adoptionAgeMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months mois',
      one: '1 mois',
      zero: 'Nouveau-né',
    );
    return '$_temp0';
  }

  @override
  String adoptionAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years ans',
      one: '1 an',
    );
    return '$_temp0';
  }

  @override
  String get adoptionStatusAvailable => 'Disponible';

  @override
  String get adoptionStatusPending => 'En attente';

  @override
  String get adoptionStatusAdopted => 'Adopté';

  @override
  String get adoptionStatusUnavailable => 'Indisponible';

  @override
  String adoptionPostedDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Il y a $days jours',
      one: 'Il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String adoptionPostedHoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Il y a $hours heures',
      one: 'Il y a 1 heure',
      zero: 'À l\'instant',
    );
    return '$_temp0';
  }

  @override
  String get adoptionTraitVaccinated => 'Vacciné';

  @override
  String get adoptionTraitNeutered => 'Stérilisé';

  @override
  String get adoptionTraitGoodWithKids => 'Aime les enfants';

  @override
  String get adoptionApply => 'Demander à adopter';

  @override
  String get adoptionApplied => 'Demande envoyée';

  @override
  String adoptionManageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gérer · $count candidats',
      one: 'Gérer · 1 candidat',
      zero: 'Gérer l\'annonce',
    );
    return '$_temp0';
  }

  @override
  String get adoptionManageTitle => 'Candidats';

  @override
  String adoptionManageSubtitle(int count, String petName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personnes souhaitent adopter $petName',
      one: '1 personne souhaite adopter $petName',
      zero: 'Aucun candidat pour l\'instant',
    );
    return '$_temp0';
  }

  @override
  String get adoptionManageEmptyTitle => 'Aucun candidat pour l\'instant';

  @override
  String adoptionManageEmptyMessage(String petName) {
    return 'Lorsqu\'une personne postule pour adopter $petName, elle apparaîtra ici.';
  }

  @override
  String adoptionApplicantApplied(String ago) {
    return 'Candidature $ago';
  }

  @override
  String get adoptionApprove => 'Approuver';

  @override
  String get adoptionReject => 'Refuser';

  @override
  String get adoptionRequestStatusPending => 'En attente';

  @override
  String get adoptionRequestStatusApproved => 'Approuvé';

  @override
  String get adoptionRequestStatusRejected => 'Refusé';

  @override
  String get adoptionRequestStatusCancelled => 'Retiré';

  @override
  String get adoptionRequestStatusCompleted => 'Adopté';

  @override
  String get adoptionRequestStatusExpired => 'Expiré';

  @override
  String get adoptionAwaitingAdopter => 'En attente de sa confirmation';

  @override
  String get adoptionOnePickHint =>
      'Vous avez déjà choisi un candidat. Refusez-le pour en choisir un autre.';

  @override
  String get adoptionReadyToComplete => 'Prêt pour la remise';

  @override
  String get adoptionCompleteTransfer => 'Finaliser le transfert';

  @override
  String adoptionApproveConfirmTitle(String name) {
    return 'Approuver $name ?';
  }

  @override
  String adoptionApproveConfirmMessage(String petName) {
    return 'Il lui sera demandé de confirmer qu\'elle souhaite $petName. La propriété n\'est transférée qu\'après votre double confirmation.';
  }

  @override
  String adoptionRejectConfirmTitle(String name) {
    return 'Refuser $name ?';
  }

  @override
  String get adoptionRejectConfirmMessage =>
      'Elle sera informée que sa candidature n\'a pas été retenue. Cette action est irréversible.';

  @override
  String adoptionCompleteConfirmTitle(String petName, String name) {
    return 'Donner $petName à $name ?';
  }

  @override
  String adoptionCompleteConfirmMessage(String petName, String name) {
    return 'Ceci transfère la propriété de façon permanente et irréversible. $petName et tous ses dossiers seront transférés à $name.';
  }

  @override
  String adoptionApproveSuccess(String name) {
    return '$name a été approuvé.';
  }

  @override
  String get adoptionRejectSuccess => 'Candidature refusée.';

  @override
  String get adoptionDelete => 'Supprimer l\'annonce';

  @override
  String get adoptionDeleteConfirmTitle => 'Supprimer cette annonce ?';

  @override
  String adoptionDeleteConfirmMessage(String petName) {
    return 'L\'annonce de $petName sera définitivement supprimée. Cette action est irréversible.';
  }

  @override
  String adoptionDeleteConfirmMessageWithApplicants(String petName, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# candidatures',
      one: '# candidature',
    );
    return 'L\'annonce de $petName et $_temp0 seront définitivement supprimées. Cette action est irréversible.';
  }

  @override
  String get adoptionDeleteSuccess => 'Annonce supprimée.';

  @override
  String adoptionRehomeSuccessTitle(String petName) {
    return '$petName a un nouveau foyer !';
  }

  @override
  String adoptionRehomeSuccessMessage(String petName, String name) {
    return '$petName est désormais avec $name, avec tous ses dossiers. Merci de lui avoir offert un nouveau foyer aimant.';
  }

  @override
  String get adoptionRehomeSuccessDone => 'Terminé';

  @override
  String get adoptionEmptyTitle => 'Aucun animal à adopter';

  @override
  String get adoptionEmptyNearby =>
      'Aucune annonce près de chez vous pour le moment. Revenez bientôt.';

  @override
  String get adoptionEmptyFiltered =>
      'Aucune annonce ne correspond à vos filtres. Élargissez votre recherche.';

  @override
  String get adoptionClearFilters => 'Effacer les filtres';

  @override
  String get adoptionAboutTitle => 'À propos';

  @override
  String get adoptionPostedBy => 'Publié par';

  @override
  String get adoptionFactSpecies => 'Espèce';

  @override
  String get adoptionFactSex => 'Sexe';

  @override
  String get adoptionFactAge => 'Âge';

  @override
  String get adoptionFactSize => 'Taille';

  @override
  String adoptionApplyConfirmTitle(String petName) {
    return 'Demander à adopter $petName ?';
  }

  @override
  String get adoptionApplyConfirmMessage =>
      'Le propriétaire examinera votre demande. S\'il accepte, vous confirmez tous les deux avant le transfert de propriété.';

  @override
  String get adoptionApplySuccess =>
      'Votre demande a été envoyée au propriétaire.';

  @override
  String get adoptionTransferNote =>
      'Vous confirmerez tous les deux avant le transfert — rien ne change sans votre accord.';

  @override
  String get adoptionListTitle => 'Proposer un animal';

  @override
  String get adoptionListSubtitle =>
      'Trouvez un nouveau foyer aimant à votre animal.';

  @override
  String get adoptionListWhichPet => 'Quel animal ?';

  @override
  String get adoptionListSelectPet => 'Sélectionner un animal';

  @override
  String get adoptionListSelectPetHint => 'Choisissez l\'un de vos animaux';

  @override
  String get adoptionListNoPets =>
      'Vous n\'avez encore aucun animal à proposer.';

  @override
  String get adoptionListDescriptionHint =>
      'Parlez aux adoptants de son caractère, de ses besoins et de la raison du placement.';

  @override
  String get adoptionListTraits => 'Caractéristiques';

  @override
  String get adoptionListLocation => 'Lieu de remise';

  @override
  String get adoptionListTransferNote =>
      'Lorsqu\'une personne postule, vous l\'examinez et l\'approuvez. La propriété n\'est transférée qu\'après confirmation des deux parties — les dossiers suivent votre animal.';

  @override
  String get adoptionListSubmit => 'Publier l\'annonce';

  @override
  String get adoptionListingCreated =>
      'Votre animal est maintenant proposé à l\'adoption.';

  @override
  String get adoptionModeMyPet => 'Mon animal';

  @override
  String get adoptionModeShelter => 'Refuge / errant';

  @override
  String get adoptionShelterAnimalDetails => 'Détails de l\'animal';

  @override
  String get adoptionShelterName => 'Nom';

  @override
  String get adoptionShelterTransferNote =>
      'Aucune fiche animal requise. Lors de l\'adoption, un nouveau profil est créé pour l\'adoptant avec cette photo et ces détails.';

  @override
  String get adoptionShelterBadge => 'Refuge';

  @override
  String get adoptionMyTitle => 'Mes adoptions';

  @override
  String get adoptionMyTooltip => 'Mes adoptions';

  @override
  String get adoptionMyRowHint => 'Vos annonces et candidatures';

  @override
  String get adoptionMyTabListings => 'Mes annonces';

  @override
  String get adoptionMyTabApplications => 'Mes candidatures';

  @override
  String get adoptionMyListingsEmptyTitle => 'Aucune annonce';

  @override
  String get adoptionMyListingsEmptyMessage =>
      'Les animaux que vous proposez à l\'adoption apparaîtront ici.';

  @override
  String get adoptionMyApplicationsEmptyTitle => 'Aucune candidature';

  @override
  String get adoptionMyApplicationsEmptyMessage =>
      'Les animaux que vous demandez à adopter apparaîtront ici.';

  @override
  String adoptionApplicationFrom(String name) {
    return 'De $name';
  }

  @override
  String get adoptionAcceptCta => 'Je le prends';

  @override
  String get adoptionAcceptHint =>
      'Vous êtes approuvé ! Confirmez l\'adoption, puis le propriétaire finalise la remise.';

  @override
  String get adoptionAwaitingHandover =>
      'En attente de la remise par le propriétaire';

  @override
  String get adoptionAwaitingReview =>
      'En attente de l\'examen de votre candidature';

  @override
  String get adoptionCancelApplication => 'Retirer la candidature';

  @override
  String get adoptionCancelConfirmTitle => 'Retirer votre candidature ?';

  @override
  String get adoptionCancelConfirmMessage =>
      'Vous pourrez postuler à nouveau tant que l\'annonce est ouverte.';

  @override
  String get adoptionAcceptSuccess =>
      'C\'est confirmé. Le propriétaire finalisera la remise.';

  @override
  String get adoptionCancelSuccess => 'Votre candidature a été retirée.';

  @override
  String adoptionWelcomeTitle(String petName) {
    return '$petName est à vous !';
  }

  @override
  String adoptionWelcomeMessage(String petName) {
    return 'Bienvenue à $petName dans la famille. Son profil complet et ses dossiers sont déjà dans votre compte.';
  }

  @override
  String adoptionWelcomeViewPet(String petName) {
    return 'Voir le profil de $petName';
  }

  @override
  String get adoptionWelcomeDone => 'Terminé';

  @override
  String get onboardingAdoptPrompt => 'Vous cherchez à adopter ?';

  @override
  String get walkStartTitle => 'Commencer une promenade';

  @override
  String walkStartSubtitle(String petName) {
    return 'Suivre l\'activité de $petName';
  }

  @override
  String get walkStartButton => 'Démarrer';

  @override
  String walkActiveTitle(String petName) {
    return 'Promenade avec $petName';
  }

  @override
  String get walkStopButton => 'Arrêter';

  @override
  String get walkStatDuration => 'Durée';

  @override
  String get walkStatDistance => 'Distance';

  @override
  String get walkStatSpeed => 'Vitesse moy.';

  @override
  String get walkNoLocation =>
      'Localisation indisponible — minuterie uniquement';

  @override
  String get walkHistoryTitle => 'Historique des promenades';

  @override
  String get walkHistoryEmpty =>
      'Aucune promenade enregistrée.\nCommencez depuis l\'accueil.';

  @override
  String get walkDeleteTitle => 'Supprimer cette promenade ?';

  @override
  String get walkDeleteMessage =>
      'Cet enregistrement sera définitivement supprimé.';

  @override
  String get walkDeleteSuccess => 'Promenade supprimée';

  @override
  String get walkDeleteTooOld =>
      'Les promenades de plus de 2 jours ne peuvent pas être supprimées';

  @override
  String reminderMedicationDose(Object petName) {
    return 'Médicament · $petName';
  }

  @override
  String reminderVaccinationBooster(Object petName) {
    return 'Rappel de vaccin · $petName';
  }

  @override
  String get reminderDueToday => 'À faire aujourd\'hui';

  @override
  String get reminderOverdue => 'En retard';

  @override
  String reminderDueInDays(Object days) {
    return 'Dans ${days}j';
  }

  @override
  String get dateToday => 'Aujourd\'hui';

  @override
  String get dateYesterday => 'Hier';

  @override
  String get pawHubSearchHint => 'Rechercher animaux, publications, #tags';

  @override
  String get pawHubFeedTabFollowing => 'Abonnements';

  @override
  String get pawHubFeedTabDiscover => 'Découvrir';

  @override
  String get pawHubNewPosts => 'Nouvelles publications';

  @override
  String get pawHubFeedEmptyTitle => 'Votre fil est un peu calme';

  @override
  String get pawHubFeedEmptyDescription =>
      'Suivez des animaux et leurs moments apparaîtront ici 🐾';

  @override
  String get pawHubDiscoverPets => 'Découvrir des animaux';

  @override
  String get pawHubSuggestedPets => 'Animaux que vous pourriez aimer';

  @override
  String get pawHubLostPetNearby => 'ANIMAL PERDU À PROXIMITÉ';

  @override
  String get pawHubViewOnMap => 'Voir sur la carte';

  @override
  String get pawHubFollow => 'Suivre';

  @override
  String get pawHubFollowing => 'Abonné';

  @override
  String get pawHubCouldNotLoadFeed => 'Impossible de charger le fil';

  @override
  String get pawHubPostSaved => 'Enregistré';

  @override
  String get pawHubPostRemovedFromSaved => 'Retiré des enregistrements';

  @override
  String get pawHubLinkCopied => 'Lien copié';

  @override
  String get pawHubPostHidden => 'Publication masquée';

  @override
  String get pawHubPostReported => 'Signalé. Merci.';

  @override
  String pawHubBlockedUser(String name) {
    return '$name bloqué(e)';
  }

  @override
  String get pawHubPostDeleted => 'Publication supprimée';

  @override
  String get pawHubEditCaption => 'Modifier la légende';

  @override
  String get pawHubCaptionUpdated => 'Légende mise à jour';

  @override
  String pawHubFollowingPet(String name) {
    return 'Vous suivez $name';
  }

  @override
  String pawHubUnfollowedPet(String name) {
    return 'Vous ne suivez plus $name';
  }

  @override
  String get pawHubAddPetFirstToPost =>
      'Ajoutez d\'abord un animal pour publier';

  @override
  String pawHubPostedAs(String name) {
    return 'Publié en tant que $name 🐾';
  }

  @override
  String get pawHubPostOptionSave => 'Enregistrer';

  @override
  String get pawHubPostOptionRemoveSaved => 'Retirer des enregistrements';

  @override
  String get pawHubPostOptionCopyLink => 'Copier le lien';

  @override
  String get pawHubPostOptionShareTo => 'Partager vers…';

  @override
  String get pawHubPostOptionEditPost => 'Modifier la publication';

  @override
  String get pawHubPostOptionDeletePost => 'Supprimer la publication';

  @override
  String get pawHubPostOptionHidePost => 'Masquer cette publication';

  @override
  String get pawHubPostOptionReport => 'Signaler';

  @override
  String pawHubPostOptionBlock(String name) {
    return 'Bloquer $name';
  }

  @override
  String get pawHubReportTitle => 'Pourquoi signalez-vous ceci ?';

  @override
  String get pawHubReportReasonCruelty => 'Cruauté envers les animaux';

  @override
  String get pawHubReportReasonSpam => 'Spam ou arnaque';

  @override
  String get pawHubReportReasonNudity => 'Nudité ou contenu sexuel';

  @override
  String get pawHubReportReasonHarassment => 'Harcèlement ou intimidation';

  @override
  String get pawHubReportReasonImpersonation =>
      'Pas un vrai animal / usurpation';

  @override
  String get pawHubReportReasonOther => 'Autre chose';

  @override
  String get pawHubCommentsTitle => 'Commentaires';

  @override
  String get pawHubCommentAs => 'Commenter en tant que';

  @override
  String pawHubCommentHint(String name) {
    return 'Ajouter un commentaire en tant que $name…';
  }

  @override
  String pawHubReplyingTo(String name) {
    return 'Réponse à $name';
  }

  @override
  String get pawHubSortTop => 'Populaires';

  @override
  String get pawHubSortNewest => 'Récents';

  @override
  String get pawHubCommentReply => 'Répondre';

  @override
  String get pawHubNoCommentsYet => 'Pas encore de commentaires';

  @override
  String get pawHubFirstCommentEncouragement =>
      'Soyez le premier à dire quelque chose 🐾';

  @override
  String get pawHubNotificationsTitle => 'Notifications';

  @override
  String get pawHubMarkAllRead => 'Tout marquer comme lu';

  @override
  String get pawHubPostLike => 'J\'aime';

  @override
  String get pawHubPostComment => 'Commenter';

  @override
  String get pawHubPostShare => 'Partager';

  @override
  String get pawHubPostSaveAction => 'Enregistrer';

  @override
  String get pawHubLikesCountPaw => 'patte';

  @override
  String get pawHubLikesCountPaws => 'pattes';

  @override
  String pawHubTaggedWith(String names) {
    return 'avec $names';
  }

  @override
  String get pawHubPostEdited => ' · Modifié';

  @override
  String pawHubViewAllComments(int count) {
    return 'Voir les $count commentaires';
  }

  @override
  String get pawHubNewPostTitle => 'Nouvelle publication';

  @override
  String get pawHubShare => 'Partager';

  @override
  String get pawHubPostingAs => 'Publier en tant que';

  @override
  String get pawHubCaptionHint =>
      'Écrire une légende… ajoutez #hashtags et @mentions';

  @override
  String get pawHubTagPets => 'Taguer des animaux';

  @override
  String get pawHubAddLocation => 'Ajouter un lieu';

  @override
  String get pawHubVisibility => 'Visibilité';

  @override
  String get pawHubAddMedia => 'Ajouter';

  @override
  String get pawHubCoverPhoto => 'Couverture';

  @override
  String get pawHubDone => 'Terminé';

  @override
  String get pawHubAddPhotoRequired => 'Ajoutez au moins une photo';

  @override
  String get pawHubProfilePosts => 'Publications';

  @override
  String get pawHubProfileFollowers => 'Abonnés';

  @override
  String get pawHubProfileFollowing => 'Abonnements';

  @override
  String get pawHubProfileManagePet => 'Gérer l\'animal';

  @override
  String pawHubProfileSiblings(String name) {
    return 'Frères et sœurs de $name';
  }

  @override
  String pawHubProfileCaredForBy(String owner) {
    return 'soigné par $owner';
  }

  @override
  String get communitiesTitle => 'Communautés';

  @override
  String get communitiesEntryButton => 'Communautés';

  @override
  String get communitiesSearchHint => 'Rechercher des communautés';

  @override
  String get communitiesMyCommunities => 'Mes communautés';

  @override
  String get communitiesTabDiscover => 'Découvrir';

  @override
  String get communitiesTabMine => 'Mes communautés';

  @override
  String get communitiesMineEmptyTitle =>
      'Vous n\'avez rejoint aucune communauté';

  @override
  String get communitiesMineEmptyDescription =>
      'Explorez les communautés et rejoignez celles qui correspondent à votre animal 🐾';

  @override
  String get communitiesDiscoverRailTitle => 'Communautés à rejoindre';

  @override
  String get communitiesSeeAll => 'Voir tout';

  @override
  String get communitiesEmptyTitle => 'Aucune communauté pour l’instant';

  @override
  String get communitiesEmptyDescription =>
      'Soyez le premier à en créer une pour votre meute 🐾';

  @override
  String communitiesSearchEmpty(String query) {
    return 'Aucune communauté ne correspond à « $query »';
  }

  @override
  String get communitiesCouldNotLoad => 'Impossible de charger les communautés';

  @override
  String get communitiesRetry => 'Réessayer';

  @override
  String get communitySortPopular => 'Populaires';

  @override
  String get communitySortNewest => 'Récentes';

  @override
  String get communitySortMostActive => 'Les plus actives';

  @override
  String get communityCategoryAll => 'Toutes';

  @override
  String get communityCategoryBreedClub => 'Club de race';

  @override
  String get communityCategoryShelterRescues => 'Refuges et sauvetages';

  @override
  String get communityCategoryBreeding => 'Élevage';

  @override
  String get communityCategorySpecialNeeds => 'Besoins spéciaux';

  @override
  String get communityCategoryActivity => 'Activité';

  @override
  String get communityCategoryHealth => 'Santé';

  @override
  String get communityCategoryOther => 'Autre';

  @override
  String get communityJoin => 'Rejoindre';

  @override
  String get communityJoined => 'Rejoint';

  @override
  String get communityLeave => 'Quitter';

  @override
  String get communityManage => 'Gérer';

  @override
  String get communityEditAvatar => 'Changer la photo de profil';

  @override
  String get communityEditBanner => 'Changer la photo de couverture';

  @override
  String get communityImagesUpdating => 'Mise à jour…';

  @override
  String get communityImagesUpdated => 'Photo mise à jour';

  @override
  String get communityImagesUpdateFailed =>
      'Impossible de mettre à jour la photo. Réessayez.';

  @override
  String get communityLeadBadge => 'Chef';

  @override
  String communityMembersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membres',
      one: '1 membre',
      zero: 'Aucun membre',
    );
    return '$_temp0';
  }

  @override
  String communityPostsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count publications',
      one: '1 publication',
      zero: 'Aucune publication',
    );
    return '$_temp0';
  }

  @override
  String communityLedBy(String name) {
    return 'Dirigée par $name';
  }

  @override
  String communityJoinedToast(String name) {
    return 'Vous avez rejoint $name';
  }

  @override
  String communityLeftToast(String name) {
    return 'Vous avez quitté $name';
  }

  @override
  String get communityDetailAbout => 'À propos';

  @override
  String get communityDetailMembers => 'Membres';

  @override
  String get communityStatPosts => 'Publications';

  @override
  String get communityLeaderLabel => 'Chef';

  @override
  String get communityDetailFeedEmptyTitle => 'Aucune publication';

  @override
  String get communityCreateFirstPost => 'Créer la première publication';

  @override
  String get communityDetailViewMembers => 'Voir tous les membres';

  @override
  String get communityDetailFeedEmpty =>
      'Aucune publication — soyez le premier à partager';

  @override
  String get communityDetailJoinToPost => 'Rejoignez pour publier ici';

  @override
  String get communityLeaveConfirmTitle => 'Quitter la communauté ?';

  @override
  String communityLeaveConfirmMessage(String name) {
    return 'Vous ne verrez plus les publications de $name.';
  }

  @override
  String get communityDeleteConfirmTitle => 'Supprimer la communauté ?';

  @override
  String communityDeleteConfirmMessage(String name) {
    return 'Cela supprime définitivement $name et toutes ses publications. Action irréversible.';
  }

  @override
  String get communityDelete => 'Supprimer';

  @override
  String get communityDeletedToast => 'Communauté supprimée';

  @override
  String get communityCancel => 'Annuler';

  @override
  String get communityCreateTitle => 'Nouvelle communauté';

  @override
  String get communityCreateNameLabel => 'Nom';

  @override
  String get communityCreateNameHint => 'ex. Club des Golden Retriever';

  @override
  String get communityCreateHandleLabel => 'Identifiant';

  @override
  String get communityCreateHandleHint => 'golden-club';

  @override
  String get communityHandleChecking => 'Vérification de la disponibilité…';

  @override
  String get communityHandleAvailable => 'Identifiant disponible';

  @override
  String get communityHandleTaken => 'Cet identifiant est déjà pris';

  @override
  String get communityHandleInvalid =>
      'Utilisez uniquement minuscules, chiffres et tirets';

  @override
  String get communityCreateDescriptionLabel => 'Description';

  @override
  String get communityCreateDescriptionHint =>
      'De quoi parle cette communauté ?';

  @override
  String get communityCreateCategoryLabel => 'Catégorie';

  @override
  String get communityCreateBannerLabel => 'Ajouter une photo de couverture';

  @override
  String get communityCreateSubmit => 'Créer la communauté';

  @override
  String get communityCreateNameRequired => 'Veuillez saisir un nom';

  @override
  String get communityCreateCategoryRequired =>
      'Veuillez choisir une catégorie';

  @override
  String get communityCreatedToast => 'Communauté créée 🎉';

  @override
  String get communityCreateFailed =>
      'Impossible de créer la communauté. Réessayez.';

  @override
  String get communityCreateAddPetFirst =>
      'Ajoutez d’abord un animal pour diriger une communauté';

  @override
  String get communityMembersTitle => 'Membres';

  @override
  String get communityMemberRemove => 'Retirer';

  @override
  String get communityMemberRemoveConfirmTitle => 'Retirer le membre ?';

  @override
  String communityMemberRemoveConfirmMessage(String name) {
    return 'Retirer $name de cette communauté ?';
  }

  @override
  String get communityMemberRemovedToast => 'Membre retiré';

  @override
  String communityComposerPostingIn(String name) {
    return 'Publication dans $name';
  }
}
