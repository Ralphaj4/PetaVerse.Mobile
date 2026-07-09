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
  String get goodMorning => 'Good Morning 👋';

  @override
  String get goodAfternoon => 'Good Afternoon 👋';

  @override
  String get goodEvening => 'Good Evening 👋';

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
  String get petDetailPelage => 'Coat';

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
  String viewAllPets(int count) {
    return 'View all $count pets';
  }

  @override
  String get createPetAdditionalInfo => 'Additional Information';

  @override
  String get createPetAdditionalInfoSubtitle =>
      'Optional — you can fill these in later';

  @override
  String get createPetPelage => 'Coat / Fur Color';

  @override
  String get createPetMicrochipNumber => 'Microchip Number';

  @override
  String get createPetMicrochipLocation => 'Microchip Location';

  @override
  String get createPetSterilizationStatus => 'Sterilization Status';

  @override
  String get sterilizationStatusIntact => 'Intact';

  @override
  String get sterilizationStatusNeutered => 'Neutered';

  @override
  String get sterilizationStatusSpayed => 'Spayed';

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
}
