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
  String get petDetailPelage => 'Pelage';

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
  String viewAllPets(int count) {
    return 'Voir tous les $count animaux';
  }

  @override
  String get createPetAdditionalInfo => 'Informations supplémentaires';

  @override
  String get createPetAdditionalInfoSubtitle =>
      'Facultatif — vous pouvez compléter plus tard';

  @override
  String get createPetPelage => 'Couleur du pelage';

  @override
  String get createPetMicrochipNumber => 'Numéro de micropuce';

  @override
  String get createPetMicrochipLocation => 'Emplacement de la micropuce';

  @override
  String get createPetSterilizationStatus => 'Statut de stérilisation';

  @override
  String get sterilizationStatusIntact => 'Intact(e)';

  @override
  String get sterilizationStatusNeutered => 'Castré';

  @override
  String get sterilizationStatusSpayed => 'Stérilisée';

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
}
