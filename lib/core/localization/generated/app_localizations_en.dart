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
  String get communityTabFeed => 'Feed';

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
  String get continueButton => 'Continue';

  @override
  String get onboardingTitle1a => 'Welcome to';

  @override
  String get onboardingTitle1b => 'PetaVerse';

  @override
  String get onboardingDesc1 =>
      'Your all-in-one companion for everything your pet needs: health, care, and more.';

  @override
  String get onboardingTitle2a => 'Track Health &';

  @override
  String get onboardingTitle2b => 'Reminders';

  @override
  String get onboardingDesc2 =>
      'Never miss a vaccination, vet visit, or medication with smart reminders.';

  @override
  String get onboardingTitle3a => 'Connect with the';

  @override
  String get onboardingTitle3b => 'Community';

  @override
  String get onboardingDesc3 =>
      'Share moments, find lost pets, and discover local services nearby.';

  @override
  String get loginTitle1 => 'Welcome';

  @override
  String get loginTitle2 => 'Back!';

  @override
  String get loginSubtitle =>
      'Log in to continue caring for your furry friends.';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get password => 'Password';

  @override
  String get logIn => 'Log In';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get joinTheFamily => 'Join the family';

  @override
  String get registerTitle1 => 'Join the';

  @override
  String get registerTitle2 => 'Family';

  @override
  String get registerSubtitle =>
      'Create an account and give your pets the care they deserve.';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get emailOptional => 'Email (optional)';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get signUp => 'Sign Up';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String get logInLink => 'Log in';

  @override
  String get otpTitle1 => 'Verify Your';

  @override
  String get otpTitle2 => 'Number';

  @override
  String otpSubtitle(String phone) {
    return 'Enter the 4-digit code we sent to $phone';
  }

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend code';

  @override
  String resendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String petDoingGreat(String petName) {
    return '$petName is doing great today! 🐾';
  }

  @override
  String get healthScore => 'Health Score';

  @override
  String get healthExcellent => 'Excellent';

  @override
  String get nextVisit => 'Next Visit';

  @override
  String get statHealth => 'Health';

  @override
  String get statNutrition => 'Nutrition';

  @override
  String get statActivity => 'Activity';

  @override
  String get statVaccines => 'Vaccines';

  @override
  String get statGreat => 'Great';

  @override
  String get statGood => 'Good';

  @override
  String stepsCount(int steps) {
    final intl.NumberFormat stepsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String stepsString = stepsNumberFormat.format(steps);

    return '$stepsString steps';
  }

  @override
  String get upToDate => 'Up to date';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get quickActions => 'Actions';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String get addRecord => 'Add Record';

  @override
  String get lostAndFound => 'Lost & Found';

  @override
  String get lostAndFoundDashboard => 'Lost & Found Dashboard';

  @override
  String lostAndFoundSubtitle(int count) {
    return '$count active alerts within 10 km';
  }

  @override
  String get liveMapView => 'Live Map View';

  @override
  String get recentAlerts => 'Recent Alerts';

  @override
  String get filterAll => 'All';

  @override
  String get filterLost => 'Lost';

  @override
  String get filterFound => 'Found';

  @override
  String get badgeLost => 'LOST';

  @override
  String get badgeFound => 'FOUND';

  @override
  String timeAgo(int n) {
    return '${n}h ago';
  }

  @override
  String get lostFoundDetailTitle => 'Report Details';

  @override
  String get reportReporter => 'Reported by';

  @override
  String get reportViewOnMap => 'View on map';

  @override
  String get contactOwner => 'Contact Owner';

  @override
  String get contactOwnerTitle => 'Contact Owner';

  @override
  String contactOwnerSubtitle(String petName) {
    return 'Reach out about $petName.';
  }

  @override
  String get contactCall => 'Call';

  @override
  String get contactCallSubtitle => 'Start a phone call';

  @override
  String get contactWhatsApp => 'WhatsApp';

  @override
  String get contactWhatsAppSubtitle => 'Message on WhatsApp';

  @override
  String get contactNoPhone => 'This report has no contact number.';

  @override
  String get contactLaunchError => 'Couldn\'t open the app. Please try again.';

  @override
  String get viewDetails => 'View Details';

  @override
  String get reportLostPet => 'Report Lost Pet';

  @override
  String get reportLostPetTitle => 'Report a Lost Pet';

  @override
  String get reportLostPetSubtitle =>
      'Pick your pet and where it was last seen.';

  @override
  String get reportSelectPet => 'Which pet is lost?';

  @override
  String get reportSelectPetHint => 'Select a pet';

  @override
  String get reportNoPets => 'You have no pets to report. Add a pet first.';

  @override
  String get reportDescription => 'Description';

  @override
  String get reportDescriptionHint =>
      'Collar, distinguishing marks, behaviour…';

  @override
  String get reportLastSeenAddress => 'Last seen address';

  @override
  String get reportLastSeenAddressHint => 'e.g. Sunset District, Park Ave';

  @override
  String get reportLocation => 'Last seen location';

  @override
  String get reportLocationHint => 'Tap the map to drop a pin';

  @override
  String get reportLocationRequired => 'Tap the map to set the location';

  @override
  String get reportReward => 'Reward (optional)';

  @override
  String get reportRewardLabel => 'Reward';

  @override
  String get reportRewardHint => '0–999';

  @override
  String get reportRewardRange => 'Reward must be between 0 and 999';

  @override
  String reportRewardBadge(int amount) {
    return 'Reward: \$$amount';
  }

  @override
  String get reportSubmit => 'Continue';

  @override
  String get reportHeaderSubtitle => 'Help reunite pets with their families.';

  @override
  String get reportRewardHelper =>
      'Offering a reward can increase the chances of being reunited.';

  @override
  String get reportUseMyLocation => 'Use my location';

  @override
  String get reportCreatedSuccess => 'Report created';

  @override
  String get deleteReportTitle => 'Delete Report?';

  @override
  String deleteReportMessage(String petName) {
    return 'This removes $petName\'s report from the map and listings. This can\'t be undone.';
  }

  @override
  String get deleteReportSuccess => 'Report deleted';

  @override
  String get reportSpeciesUnresolved =>
      'Couldn\'t determine your pet\'s species. Please try again.';

  @override
  String get reportTitle => 'Report a Pet';

  @override
  String get reportTypeLost => 'Lost';

  @override
  String get reportTypeFound => 'Found';

  @override
  String get reportLostSubtitle => 'Pick your pet and where it was last seen.';

  @override
  String get reportFoundSubtitle =>
      'Describe the pet you found and where you saw it.';

  @override
  String get reportFoundName => 'Pet name';

  @override
  String get reportFoundNameHint =>
      'A name or nickname (e.g. \"Ginger tabby\")';

  @override
  String get reportFoundSpecies => 'Species';

  @override
  String get reportFoundBreed => 'Breed';

  @override
  String get reportFoundSelectSpeciesFirst => 'Select a species first';

  @override
  String get reportPhoto => 'Photo';

  @override
  String get reportPhotoHint => 'Add a clear photo of the pet';

  @override
  String get reportPhotoRemove => 'Remove photo';

  @override
  String get reportPhotoRequired => 'A photo is required for found reports';

  @override
  String get howToHelp => 'How to Help More';

  @override
  String get howToHelpBody =>
      'Join our Volunteer Search Team to get notified when a lost pet is reported near you.';

  @override
  String get becomeVolunteer => 'Become a Volunteer';

  @override
  String get alreadyVolunteer => 'You\'re a Volunteer';

  @override
  String get becameVolunteer => 'You\'re now a volunteer';

  @override
  String get leftVolunteer => 'You\'ve left the volunteers';

  @override
  String get leaveVolunteerAction => 'Leave';

  @override
  String get leaveVolunteerTitle => 'Leave Volunteers?';

  @override
  String get leaveVolunteerMessage =>
      'You\'ll stop receiving alerts when a lost pet is reported near you.';

  @override
  String get leaveVolunteerConfirm => 'Leave';

  @override
  String get lostAndFoundNoAlerts => 'No alerts nearby right now.';

  @override
  String activeVolunteers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Active Volunteers',
      one: '1 Active Volunteer',
    );
    return '$_temp0';
  }

  @override
  String get volunteerThankYou => 'Thank you for making a difference!';

  @override
  String get medicationsReminders => 'Medications & Reminders';

  @override
  String get healthTracker => 'Health Tracker';

  @override
  String get notifications => 'Notifications';

  @override
  String get premiumMember => 'Premium Member';

  @override
  String get petProfiles => 'Pet Profiles';

  @override
  String get addPet => 'Add Pet';

  @override
  String get petActive => 'ACTIVE';

  @override
  String petAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '${years}y',
      one: '${years}y',
    );
    return '$_temp0';
  }

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get securityPrivacy => 'Security & Privacy';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get notificationsSupport => 'Notifications & Support';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get changeLanguage => 'Language';

  @override
  String get changeLanguageSubtitle =>
      'Choose the language you\'d like to use across the app';

  @override
  String get privacySettings => 'Privacy Settings';

  @override
  String get support => 'Support';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get reportProblem => 'Report a Problem';

  @override
  String get termsPrivacy => 'Terms & Privacy';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get toggleOn => 'On';

  @override
  String get toggleOff => 'Off';

  @override
  String get logOut => 'Log Out';

  @override
  String get logOutConfirmTitle => 'Log out?';

  @override
  String get logOutConfirmMessage =>
      'You\'ll need to sign in again to access your pets and reminders.';

  @override
  String get logOutConfirm => 'Yes, log out';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordTitle1 => 'Reset';

  @override
  String get forgotPasswordTitle2 => 'Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your mobile number and we\'ll send you a code to reset your password.';

  @override
  String get sendCode => 'Send Code';

  @override
  String get resetPasswordTitle1 => 'New';

  @override
  String get resetPasswordTitle2 => 'Password';

  @override
  String resetPasswordSubtitle(String phone) {
    return 'Enter the code we sent to $phone and choose a new password.';
  }

  @override
  String get newPassword => 'New Password';

  @override
  String get resetPasswordAction => 'Reset Password';

  @override
  String get passwordResetSuccess =>
      'Password reset. Please log in with your new password.';

  @override
  String get security => 'Security';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordSubtitle =>
      'Enter your current password and choose a new one.';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get passwordChangedSuccess => 'Your password has been changed.';

  @override
  String appVersion(String version, String build) {
    return 'Version $version (Build $build)';
  }

  @override
  String get aiAssistantTitle => 'PawBot Assistant';

  @override
  String get aiAskHint => 'Ask PawBot anything…';

  @override
  String get aiQuickFaqs => 'FAQs';

  @override
  String get aiQuickBreedInfo => 'BreedInfo';

  @override
  String get aiQuickSymptomChecker => 'Symptom Checker';

  @override
  String get aiHealthVaultTitle => 'Pet Health Vault';

  @override
  String aiHealthVaultSubtitle(String petName) {
    return 'Store vaccination records and medical history for $petName.';
  }

  @override
  String get aiStartingSession => 'Starting a new conversation…';

  @override
  String get aiSessionError =>
      'Couldn\'t start a conversation. Please try again.';

  @override
  String get aiResponseError => 'Response failed. Please try again.';

  @override
  String get aiRateLimitError => 'Too many messages. Please wait a moment.';

  @override
  String get aiAttach => 'Attach';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get invalidPhone => 'Enter a valid mobile number';

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
  String get confirm => 'Confirm';

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
  String get errorRateLimit =>
      'You\'re doing that too fast. Please slow down and try again.';

  @override
  String errorRateLimitRetry(int seconds) {
    return 'Too many requests. Try again in ${seconds}s.';
  }

  @override
  String get errorCache => 'Could not load saved data.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';

  @override
  String get errorNotFound =>
      'We couldn\'t find an account with that information.';

  @override
  String get errorPhoneNotRegistered =>
      'No account is registered with this mobile number.';

  @override
  String get petOnboardingTitleTop => 'Add your';

  @override
  String get petOnboardingTitleAccent => 'first pet';

  @override
  String get petOnboardingSubtitle =>
      'Tell us about your companion so we can tailor health, reminders, and care to them.';

  @override
  String get petOnboardingAction => 'Add a Pet';

  @override
  String get petOnboardingLoading => 'Checking your pets…';

  @override
  String get selectPetTitle => 'Select a Pet';

  @override
  String get selectPetSubtitle => 'Who are we caring for today?';

  @override
  String get createPetTitle => 'Add a Pet';

  @override
  String get createPetSubtitle => 'Tell us about your new furry friend';

  @override
  String get createPetName => 'Pet Name';

  @override
  String get createPetSpecies => 'Animal Type';

  @override
  String get createPetBreed => 'Breed';

  @override
  String get createPetSelectSpeciesFirst => 'Select an animal type first';

  @override
  String get createPetDateOfBirth => 'Date of Birth';

  @override
  String get createPetGender => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderUnknown => 'Unknown';

  @override
  String get createPetSubmit => 'Save Pet';

  @override
  String createPetSuccess(String name) {
    return '$name has been added!';
  }

  @override
  String get petDetailSetActive => 'Set as Active';

  @override
  String get petDetailAlreadyActive => 'Currently Active';

  @override
  String get petDetailGender => 'Gender';

  @override
  String get petDetailDateOfBirth => 'Date of Birth';

  @override
  String get petDetailBreed => 'Breed';

  @override
  String get petDetailSize => 'Size';

  @override
  String get petDetailCoatColor => 'Coat Color';

  @override
  String get petDetailMicrochip => 'Microchip';

  @override
  String get petDetailMicrochipLocation => 'Location';

  @override
  String get petDetailSterilization => 'Sterilization';

  @override
  String get petDetailSterilizationDate => 'Date';

  @override
  String petDetailAge(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years years old',
      one: '1 year old',
    );
    return '$_temp0';
  }

  @override
  String petDetailAgeMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months months old',
      one: '1 month old',
      zero: 'Less than a month old',
    );
    return '$_temp0';
  }

  @override
  String viewAllPets(int count) {
    return 'View all $count pets';
  }

  @override
  String get viewAll => 'View all';

  @override
  String get createPetAdditionalInfo => 'Additional Information';

  @override
  String get createPetAdditionalInfoSubtitle =>
      'Optional — you can fill these in later';

  @override
  String get createPetSize => 'Size';

  @override
  String get createPetCoatColor => 'Coat / Fur Color';

  @override
  String get createPetNotSpecified => 'Not specified';

  @override
  String get createPetMicrochipNumber => 'Microchip Number';

  @override
  String get createPetMicrochipLocation => 'Microchip Location';

  @override
  String get createPetSterilizationStatus => 'Sterilization Status';

  @override
  String get sterilizationStatusNotSterilized => 'Not Sterilized';

  @override
  String get sterilizationStatusSterilized => 'Sterilized';

  @override
  String get sterilizationStatusUnknown => 'Unknown';

  @override
  String get createPetSterilizationDate => 'Sterilization Date';

  @override
  String get editPetTitle => 'Edit Pet';

  @override
  String get editPetSave => 'Save Changes';

  @override
  String get deletePetTitle => 'Delete Pet';

  @override
  String deletePetMessage(String petName) {
    return 'Are you sure you want to delete $petName? This action cannot be undone.';
  }

  @override
  String get deletePetConfirm => 'Delete';

  @override
  String get petUpdatedSuccess => 'Pet updated successfully';

  @override
  String get petDeletedSuccess => 'Pet deleted';

  @override
  String get petDetailTabOverview => 'Overview';

  @override
  String get petDetailTabHealth => 'Health';

  @override
  String get petDetailTabRecords => 'Records';

  @override
  String get petDetailTabTimeline => 'Timeline';

  @override
  String get petDetailActionEdit => 'Edit';

  @override
  String get petDetailActionBook => 'Book';

  @override
  String get petDetailActionShare => 'Pet Vision';

  @override
  String get petDetailActionMore => 'More';

  @override
  String get petDetailDateAdded => 'Date Added';

  @override
  String petDetailProfileCompleteTitle(String petName) {
    return '$petName is all set!';
  }

  @override
  String get petDetailProfileCompleteSubtitle =>
      'Your pet profile is complete and information is up to date.';

  @override
  String get microchipCopied => 'Microchip number copied';

  @override
  String get healthWeightTitle => 'Weight';

  @override
  String get healthWeightAdd => 'Add weight';

  @override
  String get healthWeightEmpty =>
      'No weight recorded yet. Track your pet\'s weight over time.';

  @override
  String get healthWeightSteady => 'Steady';

  @override
  String healthWeightLastRecorded(String date) {
    return 'Last recorded $date';
  }

  @override
  String get healthMedicationsTitle => 'Medications';

  @override
  String get healthMedicationsAdd => 'Add medication';

  @override
  String get healthMedicationsEmpty =>
      'No active medications. Add reminders to stay on schedule.';

  @override
  String get healthMedicationsMarkGiven => 'Mark as given';

  @override
  String healthMedicationsGivenConfirmed(String name) {
    return 'Marked $name as given';
  }

  @override
  String get healthMedicationsOverdue => 'Overdue';

  @override
  String get healthMedicationsDueToday => 'Today';

  @override
  String healthMedicationsDueInDays(int days) {
    return 'In ${days}d';
  }

  @override
  String get healthVaccinationsTitle => 'Vaccinations';

  @override
  String get healthVaccinationsAdd => 'Add vaccination';

  @override
  String get healthVaccinationsEmpty => 'No vaccinations recorded yet.';

  @override
  String healthVaccinationsGivenOn(String date) {
    return 'Given $date';
  }

  @override
  String healthVaccinationsNextDue(String date) {
    return 'Due $date';
  }

  @override
  String get healthVaccinationsDue => 'Due';

  @override
  String get healthFrequencyDaily => 'Daily';

  @override
  String get healthFrequencyWeekly => 'Weekly';

  @override
  String get healthFrequencyBiweekly => 'Every 2 weeks';

  @override
  String get healthFrequencyMonthly => 'Monthly';

  @override
  String get healthFrequencyQuarterly => 'Every 3 months';

  @override
  String get petDetailSectionDetails => 'Pet Details';

  @override
  String get petDetailSectionHealth => 'Health data';

  @override
  String get healthWeightValueLabel => 'Weight';

  @override
  String get healthWeightValueHint => 'e.g. 12.4';

  @override
  String get healthWeightDateLabel => 'Date recorded';

  @override
  String get healthWeightInvalid => 'Enter a valid weight';

  @override
  String get healthWeightAddedSuccess => 'Weight recorded';

  @override
  String get healthWeightAllReadings => 'All readings';

  @override
  String get healthWeightDeleteTitle => 'Delete this reading?';

  @override
  String get healthWeightDeleteMessage =>
      'This weight record will be permanently removed.';

  @override
  String get healthWeightDeleteSuccess => 'Weight record deleted';

  @override
  String healthFrequencyEveryNDays(int days) {
    return 'Every $days days';
  }

  @override
  String get healthFrequencyCustomLabel => 'Custom';

  @override
  String get healthFrequencyDaysSuffix => 'days';

  @override
  String get searchHint => 'Search';

  @override
  String get searchNoResults => 'No results';

  @override
  String get healthNotesLabel => 'Notes (optional)';

  @override
  String get healthNotesHint => 'Anything worth remembering';

  @override
  String get healthMedicationsNameLabel => 'Medication';

  @override
  String get healthMedicationsNameHint => 'e.g. Apoquel';

  @override
  String get healthMedicationsNameRequired => 'Choose or enter a medication';

  @override
  String get healthMedicationsPickHint => 'Choose a medication';

  @override
  String get healthMedicationsUseCustom => 'Enter a custom name';

  @override
  String get healthMedicationsUseList => 'Choose from the list';

  @override
  String get healthMedicationsFrequencyLabel => 'Frequency';

  @override
  String get healthMedicationsStartDateLabel => 'Start date';

  @override
  String get healthMedicationsAddedSuccess => 'Medication added';

  @override
  String get healthMedicationsEditFrequency => 'Frequency';

  @override
  String get healthMedicationsFrequencyUpdated => 'Frequency updated';

  @override
  String get healthVaccinationsNameLabel => 'Vaccine';

  @override
  String get healthVaccinationsNameRequired => 'Choose a vaccine';

  @override
  String get healthVaccinationsPickHint => 'Choose a vaccine';

  @override
  String get healthVaccinationsAdministeredLabel => 'Date administered';

  @override
  String get healthVaccinationsNextDueLabel => 'Next booster (optional)';

  @override
  String get healthVaccinationsNoBooster => 'No booster scheduled';

  @override
  String get healthVaccinationsVetLabel => 'Vet (optional)';

  @override
  String get healthVaccinationsVetHint => 'e.g. Dr. Smith';

  @override
  String get healthVaccinationsAddedSuccess => 'Vaccination added';

  @override
  String get healthMedicationsDeleteTitle => 'Delete this medication?';

  @override
  String healthMedicationsDeleteMessage(String name) {
    return '$name will be permanently removed.';
  }

  @override
  String get healthMedicationsDeleteSuccess => 'Medication deleted';

  @override
  String get healthVaccinationsDeleteTitle => 'Delete this vaccination?';

  @override
  String healthVaccinationsDeleteMessage(String name) {
    return '$name\'s record will be permanently removed.';
  }

  @override
  String get healthVaccinationsDeleteSuccess => 'Vaccination deleted';

  @override
  String get healthScoreTitle => 'Health Score';

  @override
  String get healthScoreOutOf => 'out of 100';

  @override
  String get healthScoreViewBreakdown => 'View breakdown';

  @override
  String get healthScoreConfidence => 'Confidence';

  @override
  String healthScoreBasedOnSignals(int count) {
    return 'Based on $count of 4 signals';
  }

  @override
  String get healthScoreBandExcellent => 'Excellent';

  @override
  String get healthScoreBandGood => 'Good';

  @override
  String get healthScoreBandFair => 'Fair';

  @override
  String get healthScoreBandNeedsAttention => 'Needs Attention';

  @override
  String get healthScoreBandNoData => 'No data';

  @override
  String get healthScoreEmptyGeneric =>
      'Start logging vaccinations, weight, and meds to see this pet\'s health score.';

  @override
  String healthScoreEmptyNamed(String name) {
    return 'Start logging vaccinations, weight, and meds to see $name\'s health score.';
  }

  @override
  String get healthScoreBreakdownTitle => 'Component breakdown';

  @override
  String get healthScoreWhyTitle => 'Why this score';

  @override
  String get healthScoreNoReasons => 'No signals to explain yet.';

  @override
  String get healthScoreNotApplicable => 'N/A';

  @override
  String get healthScoreRedistributed =>
      'Weight redistributed to the other signals';

  @override
  String healthScoreRedistributedWith(String reason) {
    return '$reason — weight redistributed to the other signals';
  }

  @override
  String healthScoreDeltaPoints(String points) {
    return '$points pts';
  }

  @override
  String healthScoreManagedConditions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count managed conditions',
      one: '1 managed condition',
    );
    return '$_temp0';
  }

  @override
  String get healthScoreDisclaimer =>
      'This measures preventive-care compliance and vitals tracking, not clinical health. It scores weight volatility, not ideal body weight. Missing data is redistributed, never counted against your pet.';

  @override
  String get photoSavedToGallery => 'Photo saved to gallery';

  @override
  String get couldNotSavePhoto => 'Could not save photo';

  @override
  String get didYouKnow => 'Did you know?';

  @override
  String get gotIt => 'Got it';

  @override
  String get profile => 'Profile';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get personalInformationSubtitle =>
      'Manage your personal details and contact information';

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get contactDetails => 'Contact Details';

  @override
  String get accountDetails => 'Account Details';

  @override
  String get verified => 'Verified';

  @override
  String get unverified => 'Unverified';

  @override
  String get selectDate => 'Select date';

  @override
  String get noEmailAdded => 'No email added';

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String emailPendingVerification(String email) {
    return 'Pending verification: $email';
  }

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get userId => 'User ID';

  @override
  String get userIdCopied => 'User ID copied';

  @override
  String get profileTagCopied => 'Profile tag copied';

  @override
  String get onboardingCoOwnTitle => 'Want to co-own a pet?';

  @override
  String get onboardingCoOwnBody => 'Get invited using your profile tag:';

  @override
  String get onboardingViewInvites => 'View invitations';

  @override
  String onboardingViewInvitesCount(int count) {
    return 'View invitations ($count)';
  }

  @override
  String get inviteCoOwnerTitle => 'Invite Co-Owner';

  @override
  String inviteCoOwnerSubtitle(String petName) {
    return 'Search by profile tag to invite someone to co-own $petName.';
  }

  @override
  String get inviteCoOwnerSearchHint => 'Enter a profile tag (e.g. a1b2c3d4)';

  @override
  String get inviteCoOwnerSearchIdle =>
      'Enter a full profile tag to find someone';

  @override
  String get inviteCoOwnerSearchEmpty => 'No user found with that tag.';

  @override
  String get inviteCoOwnerInvite => 'Invite';

  @override
  String get inviteCoOwnerAlreadyInvited => 'Invited';

  @override
  String get inviteCoOwnerSent => 'Invitation sent';

  @override
  String get inviteCoOwnerSentTitle => 'Invitations sent';

  @override
  String get inviteCoOwnerNoneSent => 'You haven\'t invited anyone yet.';

  @override
  String get inviteCoOwnerCancel => 'Cancel invitation';

  @override
  String get inviteCoOwnerCancelled => 'Invitation cancelled';

  @override
  String get coOwnerCurrentTitle => 'Current co-owners';

  @override
  String get coOwnerPrimaryBadge => 'Owner';

  @override
  String coOwnerYou(String name) {
    return '$name (You)';
  }

  @override
  String get coOwnerRemoveAction => 'Remove co-owner';

  @override
  String get coOwnerLeaveAction => 'Leave';

  @override
  String get coOwnerLeavePetAction => 'Leave Co-Ownership';

  @override
  String get coOwnerRemoveTitle => 'Remove co-owner?';

  @override
  String coOwnerRemoveMessage(String name) {
    return '$name will lose access to this pet. This can\'t be undone.';
  }

  @override
  String get coOwnerRemoveConfirm => 'Remove';

  @override
  String get coOwnerRemovedSuccess => 'Co-owner removed';

  @override
  String get coOwnerLeaveTitle => 'Leave this pet?';

  @override
  String get coOwnerLeaveMessage =>
      'You\'ll lose access to this pet. The owner can invite you again later.';

  @override
  String get coOwnerLeaveConfirm => 'Leave';

  @override
  String get coOwnerLeftSuccess => 'You\'ve left the pet';

  @override
  String get coOwnerInvitationsTitle => 'Pet Invitations';

  @override
  String get coOwnerInvitationsEmpty => 'You have no pending invitations.';

  @override
  String coOwnerInvitedBy(String name) {
    return 'Invited by $name';
  }

  @override
  String get coOwnerAccept => 'Accept';

  @override
  String get coOwnerDecline => 'Decline';

  @override
  String coOwnerAccepted(String petName) {
    return 'You\'re now a co-owner of $petName';
  }

  @override
  String get coOwnerDeclined => 'Invitation declined';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusDeclined => 'Declined';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get locationName => 'Location';

  @override
  String get locationNameHint => 'e.g. Beirut, Lebanon';

  @override
  String get locationNameTooLong => 'Location must be 200 characters or fewer';

  @override
  String get locationPickHint => 'Tap the map to drop a pin';

  @override
  String get locationRequired => 'Pick your location on the map';

  @override
  String get locationUseMine => 'Use my location';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get photoUpdated => 'Profile photo updated';

  @override
  String get photoUploadFailed =>
      'Couldn\'t update your photo. Please try again.';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get continueLabel => 'Continue';

  @override
  String get petAvatarSetupTitle => 'Add a Photo';

  @override
  String get petAvatarSetupSubtitle => 'Give your pet a face on their profile.';

  @override
  String get petAvatarSetupOptional => 'Optional — you can change it anytime.';

  @override
  String get petAvatarUploadHint => 'Upload a photo';

  @override
  String get clear => 'Clear';

  @override
  String get providersNearby => 'Nearby Providers';

  @override
  String providerCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count providers found',
      one: '1 provider found',
      zero: 'No providers found',
    );
    return '$_temp0';
  }

  @override
  String get providerSearchHint => 'Search vets, groomers, shops…';

  @override
  String get providerSort => 'Sort';

  @override
  String get providerSortBy => 'Sort by';

  @override
  String get sortDistance => 'Distance';

  @override
  String get sortRating => 'Rating';

  @override
  String get sortOpenNow => 'Open now';

  @override
  String get sortMostReviewed => 'Most reviewed';

  @override
  String get providerShowList => 'Show list';

  @override
  String get providerShowMap => 'Show map';

  @override
  String get providerMyLocation => 'My location';

  @override
  String get providerOpen => 'Open';

  @override
  String get providerClosed => 'Closed';

  @override
  String get providerCall => 'Call';

  @override
  String get providerDirections => 'Directions';

  @override
  String get providerCallFailed =>
      'Couldn\'t start a call. No phone number available.';

  @override
  String get providerDirectionsFailed => 'Couldn\'t open directions.';

  @override
  String get providerNoResultsTitle => 'No providers found';

  @override
  String get providerNoResultsNearby =>
      'We couldn\'t find any pet businesses near you yet.';

  @override
  String get providerNoResultsFiltered =>
      'No providers match your filters. Try adjusting your search or category.';

  @override
  String get providerClearFilters => 'Clear filters';

  @override
  String get providerOfflineTitle => 'You\'re offline';

  @override
  String get providerOfflineMessage =>
      'Check your connection and try again to see nearby providers.';

  @override
  String get providerErrorTitle => 'Something went wrong';

  @override
  String get providerErrorMessage =>
      'We couldn\'t load providers right now. Please try again.';

  @override
  String get providerLocationDeniedTitle => 'Location is off';

  @override
  String get providerLocationDeniedMessage =>
      'Turn on location to discover pet services around you.';

  @override
  String get providerEnableLocation => 'Enable location';

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
    return 'Rated $rating';
  }

  @override
  String ratingWithReviews(String rating, int count) {
    return 'Rated $rating from $count reviews';
  }

  @override
  String reviewCountShort(int count) {
    return '($count)';
  }

  @override
  String get badgeVerified => 'Verified';

  @override
  String get badgeEmergency => 'Emergency';

  @override
  String get badge24_7 => '24/7';

  @override
  String get badgeMobile => 'Mobile';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryVeterinary => 'Veterinary';

  @override
  String get categoryGrooming => 'Grooming';

  @override
  String get categoryPetShop => 'Pet Shops';

  @override
  String get categoryBoarding => 'Boarding';

  @override
  String get categoryTraining => 'Training';

  @override
  String get categoryPetSitting => 'Pet Sitting';

  @override
  String get categoryWalking => 'Walking';

  @override
  String get categoryAdoption => 'Adoption';

  @override
  String get categoryShelter => 'Shelters';

  @override
  String get categoryEmergency => 'Emergency';

  @override
  String get categoryPharmacy => 'Pharmacy';

  @override
  String get adoptionTitle => 'Adoption';

  @override
  String adoptionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pets looking for a home',
      one: '1 pet looking for a home',
      zero: 'No pets available',
    );
    return '$_temp0';
  }

  @override
  String get adoptionListAPet => 'List a pet';

  @override
  String get adoptionSearchHint => 'Search by name, breed, or area';

  @override
  String get adoptionFilterAll => 'All';

  @override
  String get adoptionSpeciesDog => 'Dog';

  @override
  String get adoptionSpeciesCat => 'Cat';

  @override
  String get adoptionSpeciesBird => 'Bird';

  @override
  String get adoptionSpeciesRabbit => 'Rabbit';

  @override
  String get adoptionSpeciesOther => 'Other';

  @override
  String get adoptionSexMale => 'Male';

  @override
  String get adoptionSexFemale => 'Female';

  @override
  String adoptionAgeMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months months',
      one: '1 month',
      zero: 'Newborn',
    );
    return '$_temp0';
  }

  @override
  String adoptionAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get adoptionStatusAvailable => 'Available';

  @override
  String get adoptionStatusPending => 'Pending';

  @override
  String get adoptionStatusAdopted => 'Adopted';

  @override
  String get adoptionStatusUnavailable => 'Unavailable';

  @override
  String get adoptionStatusAdoptedSubtitle =>
      'This pet has found a forever home.';

  @override
  String get adoptionStatusUnavailableSubtitle =>
      'This listing is no longer accepting applications.';

  @override
  String adoptionPostedDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String adoptionPostedHoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours ago',
      one: '1 hour ago',
      zero: 'Just now',
    );
    return '$_temp0';
  }

  @override
  String get adoptionTraitVaccinated => 'Vaccinated';

  @override
  String get adoptionTraitNeutered => 'Neutered';

  @override
  String get adoptionTraitGoodWithKids => 'Good with kids';

  @override
  String get adoptionApply => 'Apply to adopt';

  @override
  String get adoptionApplied => 'Application sent';

  @override
  String get adoptionAppliedSubtitle =>
      'The owner will review your application';

  @override
  String adoptionManageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Manage · $count applicants',
      one: 'Manage · 1 applicant',
      zero: 'Manage listing',
    );
    return '$_temp0';
  }

  @override
  String get adoptionManageTitle => 'Applicants';

  @override
  String adoptionManageSubtitle(int count, String petName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people want to adopt $petName',
      one: '1 person wants to adopt $petName',
      zero: 'No applicants yet',
    );
    return '$_temp0';
  }

  @override
  String get adoptionManageEmptyTitle => 'No applicants yet';

  @override
  String adoptionManageEmptyMessage(String petName) {
    return 'When someone applies to adopt $petName, they\'ll show up here.';
  }

  @override
  String adoptionApplicantApplied(String ago) {
    return 'Applied $ago';
  }

  @override
  String get adoptionApprove => 'Approve';

  @override
  String get adoptionReject => 'Reject';

  @override
  String get adoptionRequestStatusPending => 'Pending review';

  @override
  String get adoptionRequestStatusApproved => 'Approved';

  @override
  String get adoptionRequestStatusRejected => 'Rejected';

  @override
  String get adoptionRequestStatusCancelled => 'Withdrawn';

  @override
  String get adoptionRequestStatusCompleted => 'Adopted';

  @override
  String get adoptionRequestStatusExpired => 'Expired';

  @override
  String get adoptionAwaitingAdopter => 'Waiting for them to accept';

  @override
  String get adoptionOnePickHint =>
      'You\'ve already picked an applicant. Reject them to choose someone else.';

  @override
  String get adoptionReadyToComplete => 'Ready to hand over';

  @override
  String get adoptionCompleteTransfer => 'Complete transfer';

  @override
  String adoptionApproveConfirmTitle(String name) {
    return 'Approve $name?';
  }

  @override
  String adoptionApproveConfirmMessage(String petName) {
    return 'They\'ll be asked to confirm they want $petName. Ownership only transfers once you both confirm.';
  }

  @override
  String adoptionRejectConfirmTitle(String name) {
    return 'Reject $name?';
  }

  @override
  String get adoptionRejectConfirmMessage =>
      'They\'ll be notified their application wasn\'t successful. This can\'t be undone.';

  @override
  String adoptionCompleteConfirmTitle(String petName, String name) {
    return 'Give $petName to $name?';
  }

  @override
  String adoptionCompleteConfirmMessage(String petName, String name) {
    return 'This transfers ownership permanently and can\'t be undone. $petName and all their records will move to $name.';
  }

  @override
  String adoptionApproveSuccess(String name) {
    return '$name has been approved.';
  }

  @override
  String get adoptionRejectSuccess => 'Application rejected.';

  @override
  String get adoptionDelete => 'Delete listing';

  @override
  String get adoptionDeleteConfirmTitle => 'Delete this listing?';

  @override
  String adoptionDeleteConfirmMessage(String petName) {
    return '$petName\'s listing will be permanently removed. This can\'t be undone.';
  }

  @override
  String adoptionDeleteConfirmMessageWithApplicants(String petName, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# applications',
      one: '# application',
    );
    return '$petName\'s listing and $_temp0 will be permanently removed. This can\'t be undone.';
  }

  @override
  String get adoptionDeleteSuccess => 'Listing deleted.';

  @override
  String adoptionRehomeSuccessTitle(String petName) {
    return '$petName has a new home!';
  }

  @override
  String adoptionRehomeSuccessMessage(String petName, String name) {
    return '$petName is now with $name, along with all their records. Thank you for giving them a loving new home.';
  }

  @override
  String get adoptionRehomeSuccessDone => 'Done';

  @override
  String get adoptionEmptyTitle => 'No pets up for adoption';

  @override
  String get adoptionEmptyNearby =>
      'There are no listings near you right now. Check back soon.';

  @override
  String get adoptionEmptyFiltered =>
      'No listings match your filters. Try widening your search.';

  @override
  String get adoptionClearFilters => 'Clear filters';

  @override
  String get adoptionAboutTitle => 'About';

  @override
  String get adoptionPostedBy => 'Posted by';

  @override
  String get adoptionFactSpecies => 'Species';

  @override
  String get adoptionFactSex => 'Sex';

  @override
  String get adoptionFactAge => 'Age';

  @override
  String get adoptionFactSize => 'Size';

  @override
  String adoptionApplyConfirmTitle(String petName) {
    return 'Apply to adopt $petName?';
  }

  @override
  String get adoptionApplyConfirmMessage =>
      'The current owner will review your request. If they approve, both of you confirm before ownership transfers.';

  @override
  String get adoptionApplySuccess => 'Your application was sent to the owner.';

  @override
  String get adoptionTransferNote =>
      'You\'ll both confirm before ownership transfers — nothing moves without your approval.';

  @override
  String get adoptionListTitle => 'List a Pet';

  @override
  String get adoptionListSubtitle => 'Find your pet a loving new home.';

  @override
  String get adoptionListWhichPet => 'Which pet?';

  @override
  String get adoptionListSelectPet => 'Select a pet';

  @override
  String get adoptionListSelectPetHint => 'Choose one of your pets';

  @override
  String get adoptionListNoPets => 'You don\'t have any pets to list yet.';

  @override
  String get adoptionListDescriptionHint =>
      'Tell adopters about their personality, needs, and why you\'re rehoming them.';

  @override
  String get adoptionListTraits => 'Traits';

  @override
  String get adoptionListLocation => 'Pickup location';

  @override
  String get adoptionListTransferNote =>
      'When someone applies, you review and approve them. Ownership transfers only after you both confirm — records travel with your pet.';

  @override
  String get adoptionListSubmit => 'Post listing';

  @override
  String get adoptionListingCreated => 'Your pet is now listed for adoption.';

  @override
  String get adoptionModeMyPet => 'My pet';

  @override
  String get adoptionModeShelter => 'Shelter / stray';

  @override
  String get adoptionShelterAnimalDetails => 'Animal details';

  @override
  String get adoptionShelterName => 'Name';

  @override
  String get adoptionShelterTransferNote =>
      'No pet record needed. When someone adopts, a new pet profile is created for them with this photo and these details.';

  @override
  String get adoptionShelterBadge => 'Shelter';

  @override
  String get adoptionMyTitle => 'My Adoptions';

  @override
  String get adoptionMyTooltip => 'My adoptions';

  @override
  String get adoptionMyRowHint => 'Your listings & applications';

  @override
  String get adoptionMyTabListings => 'My listings';

  @override
  String get adoptionMyTabApplications => 'My applications';

  @override
  String get adoptionMyListingsEmptyTitle => 'No listings yet';

  @override
  String get adoptionMyListingsEmptyMessage =>
      'Pets you put up for adoption will appear here.';

  @override
  String get adoptionMyApplicationsEmptyTitle => 'No applications yet';

  @override
  String get adoptionMyApplicationsEmptyMessage =>
      'Pets you apply to adopt will appear here.';

  @override
  String adoptionApplicationFrom(String name) {
    return 'From $name';
  }

  @override
  String get adoptionAcceptCta => 'I\'ll take them';

  @override
  String get adoptionAcceptHint =>
      'You\'re approved! Confirm you want to adopt, then the owner completes the handover.';

  @override
  String get adoptionAwaitingHandover => 'Waiting for the owner to hand over';

  @override
  String get adoptionAwaitingReview =>
      'Waiting for the owner to review your application';

  @override
  String get adoptionCancelApplication => 'Withdraw application';

  @override
  String get adoptionCancelConfirmTitle => 'Withdraw your application?';

  @override
  String get adoptionCancelConfirmMessage =>
      'You can apply again later while the listing is open.';

  @override
  String get adoptionAcceptSuccess =>
      'You\'re confirmed. The owner will complete the handover.';

  @override
  String get adoptionCancelSuccess => 'Your application was withdrawn.';

  @override
  String adoptionWelcomeTitle(String petName) {
    return '$petName is now yours!';
  }

  @override
  String adoptionWelcomeMessage(String petName) {
    return 'Welcome $petName to the family. Their full profile and records are already in your account.';
  }

  @override
  String adoptionWelcomeViewPet(String petName) {
    return 'View $petName\'s profile';
  }

  @override
  String get adoptionWelcomeDone => 'Done';

  @override
  String get onboardingAdoptPrompt => 'Looking to adopt a pet?';

  @override
  String get walkStartTitle => 'Start a walk';

  @override
  String walkStartSubtitle(String petName) {
    return 'Track $petName\'s activity';
  }

  @override
  String get walkStartButton => 'Go';

  @override
  String walkActiveTitle(String petName) {
    return 'Walking with $petName';
  }

  @override
  String get walkStopButton => 'Stop';

  @override
  String get walkStatDuration => 'Duration';

  @override
  String get walkStatDistance => 'Distance';

  @override
  String get walkStatSpeed => 'Avg Speed';

  @override
  String get walkNoLocation => 'Location unavailable — showing timer only';

  @override
  String get walkHistoryTitle => 'Walk History';

  @override
  String get walkHistoryEmpty =>
      'No walks recorded yet.\nStart a walk from the home screen.';

  @override
  String get walkDeleteTitle => 'Delete this walk?';

  @override
  String get walkDeleteMessage =>
      'This walk record will be permanently removed.';

  @override
  String get walkDeleteSuccess => 'Walk deleted';

  @override
  String get walkDeleteTooOld => 'Walks older than 2 days can\'t be deleted';

  @override
  String get appointmentsTitle => 'Appointments';

  @override
  String get appointmentsAdd => 'Add appointment';

  @override
  String get appointmentsEmpty =>
      'No upcoming appointments. Add one to stay on schedule.';

  @override
  String get appointmentsTitleLabel => 'Title';

  @override
  String get appointmentsTitleHint => 'e.g. Annual Check-up';

  @override
  String get appointmentsTitleRequired => 'Enter an appointment title';

  @override
  String get appointmentsDateLabel => 'Date & time';

  @override
  String get appointmentsLocationLabel => 'Location (optional)';

  @override
  String get appointmentsLocationHint => 'e.g. City Vet Clinic';

  @override
  String get appointmentsAddedSuccess => 'Appointment added';

  @override
  String get appointmentsDeleteTitle => 'Delete this appointment?';

  @override
  String appointmentsDeleteMessage(String title) {
    return '$title will be permanently removed.';
  }

  @override
  String get appointmentsDeleteSuccess => 'Appointment deleted';

  @override
  String appointmentInDays(int days) {
    return 'In ${days}d';
  }

  @override
  String get appointmentsEdit => 'Edit Appointment';

  @override
  String get appointmentsUpdatedSuccess => 'Appointment updated';

  @override
  String get upcomingEmptyTitle => 'All clear for now';

  @override
  String get upcomingEmptySubtitle =>
      'Medications, vaccinations, and appointments will appear here.';

  @override
  String reminderAppointment(Object petName) {
    return 'Appointment · $petName';
  }

  @override
  String reminderMedicationDose(Object petName) {
    return 'Medication · $petName';
  }

  @override
  String reminderVaccinationBooster(Object petName) {
    return 'Vaccination booster · $petName';
  }

  @override
  String get reminderDueToday => 'Due today';

  @override
  String get reminderOverdue => 'Overdue';

  @override
  String reminderDueInDays(Object days) {
    return 'Due in ${days}d';
  }

  @override
  String get dateToday => 'Today';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String get pawHubSearchHint => 'Search pets, posts, #tags';

  @override
  String get pawHubFeedTabFollowing => 'Following';

  @override
  String get pawHubFeedTabDiscover => 'Discover';

  @override
  String get pawHubNewPosts => 'New paw-sts';

  @override
  String get pawHubFeedEmptyTitle => 'Your feed is a little quiet';

  @override
  String get pawHubFeedEmptyDescription =>
      'Follow some pets and their moments will show up right here 🐾';

  @override
  String get pawHubDiscoverPets => 'Discover pets';

  @override
  String get pawHubSuggestedPets => 'Pets you might like';

  @override
  String get pawHubLostPetNearby => 'LOST PET NEARBY';

  @override
  String get pawHubViewOnMap => 'View on map';

  @override
  String get pawHubFollow => 'Follow';

  @override
  String get pawHubFollowing => 'Following';

  @override
  String get pawHubCouldNotLoadFeed => 'Could not load feed';

  @override
  String get pawHubPostSaved => 'Saved';

  @override
  String get pawHubPostRemovedFromSaved => 'Removed from saved';

  @override
  String get pawHubLinkCopied => 'Link copied';

  @override
  String get pawHubPostHidden => 'Post hidden';

  @override
  String get pawHubPostReported => 'Reported. Thank you.';

  @override
  String pawHubBlockedUser(String name) {
    return 'Blocked $name';
  }

  @override
  String get pawHubPostDeleted => 'Post deleted';

  @override
  String get pawHubEditCaption => 'Edit caption';

  @override
  String get pawHubCaptionUpdated => 'Caption updated';

  @override
  String pawHubFollowingPet(String name) {
    return 'Following $name';
  }

  @override
  String pawHubUnfollowedPet(String name) {
    return 'Unfollowed $name';
  }

  @override
  String get pawHubAddPetFirstToPost => 'Add a pet first to post';

  @override
  String pawHubPostedAs(String name) {
    return 'Posted as $name 🐾';
  }

  @override
  String get pawHubPostOptionSave => 'Save';

  @override
  String get pawHubPostOptionRemoveSaved => 'Remove from saved';

  @override
  String get pawHubPostOptionCopyLink => 'Copy link';

  @override
  String get pawHubPostOptionShareTo => 'Share to…';

  @override
  String get pawHubPostOptionEditPost => 'Edit post';

  @override
  String get pawHubPostOptionDeletePost => 'Delete post';

  @override
  String get pawHubPostOptionHidePost => 'Hide this post';

  @override
  String get pawHubPostOptionReport => 'Report';

  @override
  String pawHubPostOptionBlock(String name) {
    return 'Block $name';
  }

  @override
  String get pawHubReportTitle => 'Why are you reporting this?';

  @override
  String get pawHubReportReasonCruelty => 'Animal cruelty or harm';

  @override
  String get pawHubReportReasonSpam => 'Spam or a scam';

  @override
  String get pawHubReportReasonNudity => 'Nudity or sexual content';

  @override
  String get pawHubReportReasonHarassment => 'Harassment or bullying';

  @override
  String get pawHubReportReasonImpersonation =>
      'Not a real pet / impersonation';

  @override
  String get pawHubReportReasonOther => 'Something else';

  @override
  String get pawHubCommentsTitle => 'Comments';

  @override
  String get pawHubCommentAs => 'Comment as';

  @override
  String pawHubCommentHint(String name) {
    return 'Add a comment as $name…';
  }

  @override
  String pawHubReplyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get pawHubSortTop => 'Top';

  @override
  String get pawHubSortNewest => 'Newest';

  @override
  String get pawHubCommentReply => 'Reply';

  @override
  String get pawHubNoCommentsYet => 'No comments yet';

  @override
  String get pawHubFirstCommentEncouragement =>
      'Be the first to say something nice 🐾';

  @override
  String get pawHubNotificationsTitle => 'Notifications';

  @override
  String get pawHubMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmptyTitle => 'You\'re all caught up';

  @override
  String get notificationsEmptyMessage =>
      'No notifications yet. We\'ll let you know when something happens.';

  @override
  String get notificationsSectionToday => 'Today';

  @override
  String get notificationsSectionEarlier => 'Earlier';

  @override
  String get notificationsAllCaughtUp => 'You\'re all caught up';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get notificationSettingsSubtitle =>
      'Choose what you want to be notified about';

  @override
  String get notifGroupHealth => 'Health Reminders';

  @override
  String get notifGroupSocial => 'Community';

  @override
  String get notifGroupAdoption => 'Adoption';

  @override
  String get notifGroupCoOwnership => 'Co-ownership';

  @override
  String get notifGroupNearby => 'Nearby';

  @override
  String get notifGroupSecurity => 'Security';

  @override
  String get notifMedication => 'Medication reminders';

  @override
  String get notifMedicationDesc =>
      'Overdue and upcoming medication alerts for your pets';

  @override
  String get notifVaccination => 'Vaccination reminders';

  @override
  String get notifVaccinationDesc =>
      'Booster and upcoming vaccination alerts for your pets';

  @override
  String get notifAppointment => 'Appointment reminders';

  @override
  String get notifAppointmentDesc =>
      '24-hour and 1-hour reminders before scheduled appointments';

  @override
  String get notifCommunityInteractions => 'Likes, comments & replies';

  @override
  String get notifCommunityInteractionsDesc =>
      'When someone likes or comments on your posts';

  @override
  String get notifNewFollower => 'New followers';

  @override
  String get notifNewFollowerDesc =>
      'When a pet starts following one of your pets';

  @override
  String get notifMentions => 'Mentions';

  @override
  String get notifMentionsDesc =>
      'When someone mentions your pet in a post or comment';

  @override
  String get notifAdoption => 'Adoption updates';

  @override
  String get notifAdoptionDesc =>
      'Applications, approvals, and transfer completions';

  @override
  String get notifCoOwnership => 'Co-ownership invites';

  @override
  String get notifCoOwnershipDesc =>
      'Invitations to co-own a pet and responses to your invites';

  @override
  String get notifLostPetNearby => 'Lost pet nearby';

  @override
  String get notifLostPetNearbyDesc =>
      'When a lost pet is reported within 10 km of your location';

  @override
  String get notifSecurityAlerts => 'Security alerts';

  @override
  String get notifSecurityAlertsDesc =>
      'Password changes and new device sign-ins — always enabled';

  @override
  String get pawHubPostLike => 'Like';

  @override
  String get pawHubPostComment => 'Comment';

  @override
  String get pawHubPostShare => 'Share';

  @override
  String get pawHubPostSaveAction => 'Save';

  @override
  String get pawHubLikesCountPaw => 'paw';

  @override
  String get pawHubLikesCountPaws => 'paws';

  @override
  String pawHubTaggedWith(String names) {
    return 'with $names';
  }

  @override
  String get pawHubPostEdited => ' · Edited';

  @override
  String pawHubViewAllComments(int count) {
    return 'View all $count comments';
  }

  @override
  String get pawHubNewPostTitle => 'New post';

  @override
  String get pawHubShare => 'Share';

  @override
  String get pawHubPostingAs => 'Posting as';

  @override
  String get pawHubCaptionHint =>
      'Write a caption… add #hashtags and @mentions';

  @override
  String get pawHubTagPets => 'Tag pets';

  @override
  String get pawHubAddLocation => 'Add location';

  @override
  String get pawHubVisibility => 'Visibility';

  @override
  String get pawHubAddMedia => 'Add';

  @override
  String get pawHubCoverPhoto => 'Cover';

  @override
  String get pawHubDone => 'Done';

  @override
  String get pawHubAddPhotoRequired => 'Add at least one photo';

  @override
  String get pawHubProfilePosts => 'Posts';

  @override
  String get pawHubProfileFollowers => 'Followers';

  @override
  String get pawHubProfileFollowing => 'Following';

  @override
  String get pawHubProfileManagePet => 'Manage pet';

  @override
  String pawHubProfileSiblings(String name) {
    return '$name\'s siblings';
  }

  @override
  String pawHubProfileCaredForBy(String owner) {
    return 'cared for by $owner';
  }

  @override
  String get communitiesTitle => 'Communities';

  @override
  String get communitiesEntryButton => 'Communities';

  @override
  String get communitiesSearchHint => 'Search communities';

  @override
  String get communitiesMyCommunities => 'My communities';

  @override
  String get communitiesTabDiscover => 'Discover';

  @override
  String get communitiesTabMine => 'My communities';

  @override
  String get communitiesMineEmptyTitle => 'You haven\'t joined any communities';

  @override
  String get communitiesMineEmptyDescription =>
      'Explore communities and join the ones your pet belongs in 🐾';

  @override
  String get communitiesDiscoverRailTitle => 'Communities to join';

  @override
  String get communitiesSeeAll => 'See all';

  @override
  String get communitiesEmptyTitle => 'No communities yet';

  @override
  String get communitiesEmptyDescription =>
      'Be the first to start one for your pack 🐾';

  @override
  String communitiesSearchEmpty(String query) {
    return 'No communities match “$query”';
  }

  @override
  String get communitiesCouldNotLoad => 'Could not load communities';

  @override
  String get communitiesRetry => 'Retry';

  @override
  String get communitySortPopular => 'Popular';

  @override
  String get communitySortNewest => 'Newest';

  @override
  String get communitySortMostActive => 'Most active';

  @override
  String get communityCategoryAll => 'All';

  @override
  String get communityCategoryBreedClub => 'Breed club';

  @override
  String get communityCategoryShelterRescues => 'Shelters & rescues';

  @override
  String get communityCategoryBreeding => 'Breeding';

  @override
  String get communityCategorySpecialNeeds => 'Special needs';

  @override
  String get communityCategoryActivity => 'Activity';

  @override
  String get communityCategoryHealth => 'Health';

  @override
  String get communityCategoryOther => 'Other';

  @override
  String get communityJoin => 'Join';

  @override
  String get communityJoined => 'Joined';

  @override
  String get communityLeave => 'Leave';

  @override
  String get communityManage => 'Manage';

  @override
  String get communityEditAvatar => 'Change profile photo';

  @override
  String get communityEditBanner => 'Change cover photo';

  @override
  String get communityImagesUpdating => 'Updating…';

  @override
  String get communityImagesUpdated => 'Photo updated';

  @override
  String get communityImagesUpdateFailed =>
      'Couldn\'t update the photo. Please try again.';

  @override
  String get communityLeadBadge => 'Lead';

  @override
  String communityMembersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '1 member',
      zero: 'No members',
    );
    return '$_temp0';
  }

  @override
  String communityPostsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count posts',
      one: '1 post',
      zero: 'No posts',
    );
    return '$_temp0';
  }

  @override
  String communityLedBy(String name) {
    return 'Led by $name';
  }

  @override
  String communityJoinedToast(String name) {
    return 'Joined $name';
  }

  @override
  String communityLeftToast(String name) {
    return 'Left $name';
  }

  @override
  String get communityDetailAbout => 'About';

  @override
  String get communityDetailMembers => 'Members';

  @override
  String get communityStatPosts => 'Posts';

  @override
  String get communityLeaderLabel => 'Leader';

  @override
  String get communityDetailFeedEmptyTitle => 'No posts yet';

  @override
  String get communityCreateFirstPost => 'Create first post';

  @override
  String get communityDetailViewMembers => 'View all members';

  @override
  String get communityDetailFeedEmpty => 'No posts yet — be the first to share';

  @override
  String get communityDetailJoinToPost => 'Join to post here';

  @override
  String get communityLeaveConfirmTitle => 'Leave community?';

  @override
  String communityLeaveConfirmMessage(String name) {
    return 'You’ll stop seeing posts from $name.';
  }

  @override
  String get communityDeleteConfirmTitle => 'Delete community?';

  @override
  String communityDeleteConfirmMessage(String name) {
    return 'This permanently removes $name and all its posts. This can’t be undone.';
  }

  @override
  String get communityDelete => 'Delete';

  @override
  String get communityDeletedToast => 'Community deleted';

  @override
  String get communityCancel => 'Cancel';

  @override
  String get communityCreateTitle => 'New community';

  @override
  String get communityCreateNameLabel => 'Name';

  @override
  String get communityCreateNameHint => 'e.g. Golden Retriever Club';

  @override
  String get communityCreateHandleLabel => 'Handle';

  @override
  String get communityCreateHandleHint => 'golden-club';

  @override
  String get communityHandleChecking => 'Checking availability…';

  @override
  String get communityHandleAvailable => 'Handle is available';

  @override
  String get communityHandleTaken => 'That handle is already taken';

  @override
  String get communityHandleInvalid =>
      'Use lowercase letters, numbers, and hyphens only';

  @override
  String get communityCreateDescriptionLabel => 'Description';

  @override
  String get communityCreateDescriptionHint => 'What is this community about?';

  @override
  String get communityCreateCategoryLabel => 'Category';

  @override
  String get communityCreateBannerLabel => 'Add a cover photo';

  @override
  String get communityCreateSubmit => 'Create community';

  @override
  String get communityCreateNameRequired => 'Please enter a name';

  @override
  String get communityCreateCategoryRequired => 'Please choose a category';

  @override
  String get communityCreatedToast => 'Community created 🎉';

  @override
  String get communityCreateFailed =>
      'Could not create community. Please try again.';

  @override
  String get communityCreateAddPetFirst =>
      'Add a pet first to lead a community';

  @override
  String get communityMembersTitle => 'Members';

  @override
  String get communityMemberRemove => 'Remove';

  @override
  String get communityMemberRemoveConfirmTitle => 'Remove member?';

  @override
  String communityMemberRemoveConfirmMessage(String name) {
    return 'Remove $name from this community?';
  }

  @override
  String get communityMemberRemovedToast => 'Member removed';

  @override
  String communityComposerPostingIn(String name) {
    return 'Posting in $name';
  }

  @override
  String get communityCreateSheetTitle => 'Create';

  @override
  String get communityCreateSheetSubtitle => 'What would you like to add?';

  @override
  String get composeNewPost => 'New Post';

  @override
  String get composeNewPostSubtitle => 'Share a photo or video';

  @override
  String get composeNewPoll => 'New Poll';

  @override
  String get composeNewPollSubtitle => 'Ask the community a question';

  @override
  String get composeNewEvent => 'New Event';

  @override
  String get composeNewEventSubtitle => 'Plan a meetup or gathering';

  @override
  String get pollNewTitle => 'New poll';

  @override
  String get pollQuestionLabel => 'Question';

  @override
  String get pollQuestionHint => 'e.g. Favourite dog park?';

  @override
  String get pollQuestionRequired => 'Please enter a question';

  @override
  String get pollDescriptionLabel => 'Description (optional)';

  @override
  String get pollDescriptionHint => 'Add more context';

  @override
  String get pollOptionsLabel => 'Options';

  @override
  String pollOptionHint(int number) {
    return 'Option $number';
  }

  @override
  String get pollAddOption => 'Add option';

  @override
  String get pollOptionsMin => 'Add at least 2 options';

  @override
  String get pollAllowMultiple => 'Allow multiple choices';

  @override
  String get pollAllowMultipleSubtitle =>
      'Let voters pick more than one option';

  @override
  String get pollSetExpiry => 'Set a closing date';

  @override
  String get pollExpiryLabel => 'Closes on';

  @override
  String get pollNoExpiry => 'No closing date';

  @override
  String get pollCreateSubmit => 'Create poll';

  @override
  String get pollCreatedToast => 'Poll created';

  @override
  String get pollCreateFailed => 'Could not create poll. Please try again.';

  @override
  String pollTotalVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votes',
      one: '1 vote',
      zero: 'No votes yet',
    );
    return '$_temp0';
  }

  @override
  String pollClosesIn(String when) {
    return 'Closes $when';
  }

  @override
  String get pollClosed => 'Poll closed';

  @override
  String get pollJoinToVote => 'Join to vote';

  @override
  String get pollTapToVote => 'Tap an option to vote';

  @override
  String get pollChangeVote => 'Tap to change your vote';

  @override
  String get pollRetractVote => 'Remove my vote';

  @override
  String get pollVoteFailed => 'Could not record your vote';

  @override
  String get pollDeleteTitle => 'Delete poll?';

  @override
  String get pollDeleteMessage =>
      'This permanently removes the poll and its votes.';

  @override
  String get pollDeletedToast => 'Poll deleted';

  @override
  String get pollBadge => 'Poll';

  @override
  String get eventNewTitle => 'New event';

  @override
  String get eventTitleLabel => 'Title';

  @override
  String get eventTitleHint => 'e.g. Summer Paw Party';

  @override
  String get eventTitleRequired => 'Please enter a title';

  @override
  String get eventDescriptionLabel => 'Description (optional)';

  @override
  String get eventDescriptionHint => 'What\'s this event about?';

  @override
  String get eventLocationLabel => 'Location (optional)';

  @override
  String get eventLocationHint => 'e.g. Central Park, NY';

  @override
  String get eventStartsLabel => 'Starts';

  @override
  String get eventEndsLabel => 'Ends (optional)';

  @override
  String get eventStartRequired => 'Please choose a start date & time';

  @override
  String get eventStartMustBeFuture => 'Start must be in the future';

  @override
  String get eventEndAfterStart => 'End must be after the start';

  @override
  String get eventCreateSubmit => 'Create event';

  @override
  String get eventEditTitle => 'Edit event';

  @override
  String get eventUpdateSubmit => 'Save changes';

  @override
  String get eventCreatedToast => 'Event created';

  @override
  String get eventUpdatedToast => 'Event updated';

  @override
  String get eventCreateFailed => 'Could not create event. Please try again.';

  @override
  String get eventBadge => 'Event';

  @override
  String get eventPast => 'Past event';

  @override
  String get eventGoing => 'Going';

  @override
  String get eventInterested => 'Interested';

  @override
  String get eventCantGo => 'Can\'t go';

  @override
  String eventAttendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count going',
      one: '1 going',
      zero: 'No one going yet',
    );
    return '$_temp0';
  }

  @override
  String eventInterestedCount(int count) {
    return '$count interested';
  }

  @override
  String get eventJoinToRsvp => 'Join to RSVP';

  @override
  String get eventViewAttendees => 'View attendees';

  @override
  String get eventAttendeesTitle => 'Attendees';

  @override
  String get eventRsvpFailed => 'Could not update your RSVP';

  @override
  String get eventDeleteTitle => 'Delete event?';

  @override
  String get eventDeleteMessage => 'This permanently removes the event.';

  @override
  String get eventDeletedToast => 'Event deleted';

  @override
  String get eventEdit => 'Edit event';

  @override
  String get eventTabAttending => 'Going';

  @override
  String get eventTabInterested => 'Interested';

  @override
  String get eventTabDeclined => 'Declined';

  @override
  String get eventNoAttendees => 'No responses yet';

  @override
  String get eventDirections => 'Directions';

  @override
  String get eventDirectionsFailed => 'Couldn\'t open maps';

  @override
  String get pawhubManagePet => 'Manage pet';

  @override
  String get pawhubComposerAddToPost => 'Add to your post';

  @override
  String get pawhubComposerAddToPostSubtitle =>
      'Choose where to pull your photo or video from';

  @override
  String get pawhubComposerCameraSubtitle => 'Take a photo';

  @override
  String get pawhubComposerGallerySubtitle => 'Choose from library';

  @override
  String get pawhubComposerAddPhotosOrVideos => 'Add photos or videos';

  @override
  String get pawhubComposerAddMedia => 'Add media';

  @override
  String get pawhubComposerMediaLimit => 'Up to 10 items';

  @override
  String get pawhubComposerCoverBadge => 'Cover';

  @override
  String get pawhubComposerTagPetsSubtitle => 'Add your pets to this post';

  @override
  String get pawhubComposerAddLocationSubtitle => 'Share where this happened';

  @override
  String get pawhubComposerPostingIn => 'Posting in';

  @override
  String get pawhubComposerVideoLengthError =>
      'Couldn\'t read a selected video\'s length. Please remove and re-add it.';

  @override
  String get pawhubErrorPickingImage => 'Couldn\'t pick image';

  @override
  String get pawhubErrorPickingMedia => 'Couldn\'t pick media';

  @override
  String get pawhubMyPostsLink => 'My posts';

  @override
  String get pawHubActingAs => 'Acting as';

  @override
  String pawhubAlertReward(int amount) {
    return '\$$amount reward';
  }

  @override
  String get pawhubEditComment => 'Edit comment';

  @override
  String pawhubCommentsCountLabel(int count) {
    return '$count Comments';
  }

  @override
  String get pawhubCouldNotLoadComments => 'Could not load comments';

  @override
  String get pawhubCommentOptionDeleteComment => 'Delete comment';

  @override
  String get pawhubCommentOptionReportComment => 'Report comment';

  @override
  String get pawhubBlockedTitle => 'Blocked Pets';

  @override
  String get pawhubBlockedFailed => 'Failed to load blocked pets';

  @override
  String get pawhubBlockedEmptyTitle => 'No blocked pets';

  @override
  String get pawhubBlockedEmptyMessage =>
      'Pets you block won\'t appear in your feed';

  @override
  String get pawhubUnblock => 'Unblock';

  @override
  String pawhubUnblockConfirmTitle(String name) {
    return 'Unblock $name?';
  }

  @override
  String get pawhubUnblockConfirmMessage =>
      'They\'ll be able to see your posts again.';

  @override
  String pawhubUnfollowConfirmTitle(String name) {
    return 'Unfollow $name?';
  }

  @override
  String pawhubUnfollowConfirmMessage(String name) {
    return 'You won\'t see $name\'s posts in your feed';
  }

  @override
  String get pawhubUnfollow => 'Unfollow';

  @override
  String get pawhubMyPostsTitle => 'My Posts';

  @override
  String get pawhubMyPostsFailed => 'Failed to load your posts';

  @override
  String get pawhubMyPostsEmptyTitle => 'No posts yet';

  @override
  String get pawhubMyPostsEmptyMessage =>
      'Share your first post with the community';

  @override
  String get pawhubDeletePostTitle => 'Delete post?';

  @override
  String get pawhubDeletePostMessage => 'This action cannot be undone.';

  @override
  String get pawhubSavedTitle => 'Saved';

  @override
  String get pawhubSavedFailed => 'Failed to load saved posts';

  @override
  String get pawhubSavedEmptyTitle => 'No saved posts yet';

  @override
  String get pawhubSavedEmptyMessage =>
      'Tap the bookmark on any post to save it';

  @override
  String get pawhubFollowersTitle => 'Followers';

  @override
  String pawhubFollowersTitleCount(int count) {
    return 'Followers ($count)';
  }

  @override
  String get pawhubFollowersFailed => 'Failed to load followers';

  @override
  String get pawhubFollowersEmptyTitle => 'No followers yet';

  @override
  String get pawhubFollowingTitle => 'Following';

  @override
  String pawhubFollowingTitleCount(int count) {
    return 'Following ($count)';
  }

  @override
  String get pawhubFollowingFailed => 'Failed to load following';

  @override
  String get pawhubFollowingEmptyTitle => 'Not following anyone yet';

  @override
  String get pawhubTrendingTitle => 'Trending';

  @override
  String get pawhubTrendingFailed => 'Failed to load trending';

  @override
  String get pawhubTrendingHashtags => 'Trending Hashtags';

  @override
  String get pawhubTopPosts => 'Top Posts';

  @override
  String pawhubHashtagPostsCount(int count) {
    return '$count posts';
  }

  @override
  String get pawhubSearchTitle => 'Search PawHub';

  @override
  String get pawhubSearchSubtitle => 'Find pets, posts, or hashtags';

  @override
  String get pawhubSearchScopeAll => 'All';

  @override
  String get pawhubSearchScopePosts => 'Posts';

  @override
  String get pawhubSearchScopeHashtags => 'Hashtags';

  @override
  String get pawhubSearchScopePets => 'Pets';

  @override
  String pawhubSearchNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get pawhubSearchTryDifferent => 'Try a different keyword';

  @override
  String get pawhubSearchSectionPets => 'Pets';

  @override
  String get pawhubSearchSectionHashtags => 'Hashtags';

  @override
  String get pawhubSearchSectionPosts => 'Posts';

  @override
  String pawhubSearchPostBy(String name) {
    return 'by $name';
  }

  @override
  String get pawhubHashtagFailed => 'Failed to load posts';

  @override
  String pawhubHashtagEmpty(String hashtag) {
    return 'No posts for #$hashtag yet';
  }

  @override
  String get pawhubPostTitle => 'Post';

  @override
  String get pawhubPostFailed => 'Failed to load post';

  @override
  String get pawhubProfileFailedPosts => 'Failed to load posts';

  @override
  String get pawhubProfileNoPosts => 'No posts yet';

  @override
  String get pawhubTagPetsTitle => 'Tag pets';

  @override
  String get pawhubTagPetsSearchHint => 'Search pets by name…';

  @override
  String get pawhubTagPetsNoMatch => 'No pets found.';

  @override
  String get pawhubTagPetsResults => 'Results';

  @override
  String pawhubTagPetsTaggedCount(int count) {
    return 'Tagged ($count)';
  }

  @override
  String get pawhubTagPetsMyPets => 'My pets';

  @override
  String get pawhubTagPetsEmpty => 'You have no pets to tag yet.';

  @override
  String get pawhubDiscoverEmptyTitle => 'Nothing to discover yet';

  @override
  String get pawhubDiscoverEmptyMessage =>
      'New posts from the community will show up here soon 🐾';

  @override
  String get pawhubSavedPostsTooltip => 'Saved posts';

  @override
  String get pawhubComposerLocationHint => 'Search or tap the map';

  @override
  String get locationResolving => 'Finding address…';

  @override
  String get pawhubLike => 'Like';

  @override
  String get pawhubComment => 'Comment';

  @override
  String get communityMembersEmptyTitle => 'No members yet';

  @override
  String get communityMembersEmptyMessage =>
      'Be the first to join this community.';

  @override
  String get pawhubTrendingEmptyTitle => 'Nothing trending yet';

  @override
  String get pawhubTrendingEmptyMessage =>
      'Popular hashtags and posts will appear here as the community grows.';

  @override
  String get pawhubBack => 'Back';

  @override
  String get pawhubMoreOptions => 'More options';

  @override
  String get pawhubRemoveOption => 'Remove option';

  @override
  String get pawhubRemoveTag => 'Remove tag';

  @override
  String get pawhubViewPost => 'View post';

  @override
  String get pawhubViewProfile => 'View profile';

  @override
  String get pawhubExpandMap => 'Expand map';

  @override
  String get pawhubComposerSetCover => 'Set cover';

  @override
  String get pawhubComposerChangeCover => 'Change cover';

  @override
  String get pawhubComposerLocationFieldHint => 'e.g. Beirut, Lebanon';

  @override
  String pawhubComposerTaggedSummary(String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count more',
      one: '1 more',
    );
    return '$name & $_temp0';
  }
}
