import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'PetaVerse'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCommunity.
  ///
  /// In en, this message translates to:
  /// **'PawHub'**
  String get navCommunity;

  /// No description provided for @communityTabFeed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get communityTabFeed;

  /// No description provided for @navCare.
  ///
  /// In en, this message translates to:
  /// **'PawCare'**
  String get navCare;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @onboardingTitle1a.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get onboardingTitle1a;

  /// No description provided for @onboardingTitle1b.
  ///
  /// In en, this message translates to:
  /// **'PetaVerse'**
  String get onboardingTitle1b;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Your all-in-one companion for everything your pet needs: health, care, and more.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2a.
  ///
  /// In en, this message translates to:
  /// **'Track Health &'**
  String get onboardingTitle2a;

  /// No description provided for @onboardingTitle2b.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get onboardingTitle2b;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Never miss a vaccination, vet visit, or medication with smart reminders.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3a.
  ///
  /// In en, this message translates to:
  /// **'Connect with the'**
  String get onboardingTitle3a;

  /// No description provided for @onboardingTitle3b.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get onboardingTitle3b;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Share moments, find lost pets, and discover local services nearby.'**
  String get onboardingDesc3;

  /// No description provided for @loginTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get loginTitle1;

  /// No description provided for @loginTitle2.
  ///
  /// In en, this message translates to:
  /// **'Back!'**
  String get loginTitle2;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue caring for your furry friends.'**
  String get loginSubtitle;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @joinTheFamily.
  ///
  /// In en, this message translates to:
  /// **'Join the family'**
  String get joinTheFamily;

  /// No description provided for @registerTitle1.
  ///
  /// In en, this message translates to:
  /// **'Join the'**
  String get registerTitle1;

  /// No description provided for @registerTitle2.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get registerTitle2;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account and give your pets the care they deserve.'**
  String get registerSubtitle;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @emailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email (optional)'**
  String get emailOptional;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @haveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountPrompt;

  /// No description provided for @logInLink.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logInLink;

  /// No description provided for @otpTitle1.
  ///
  /// In en, this message translates to:
  /// **'Verify Your'**
  String get otpTitle1;

  /// No description provided for @otpTitle2.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get otpTitle2;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4-digit code we sent to {phone}'**
  String otpSubtitle(String phone);

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendIn(int seconds);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @petDoingGreat.
  ///
  /// In en, this message translates to:
  /// **'{petName} is doing great today! 🐾'**
  String petDoingGreat(String petName);

  /// No description provided for @healthScore.
  ///
  /// In en, this message translates to:
  /// **'Health Score'**
  String get healthScore;

  /// No description provided for @healthExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get healthExcellent;

  /// No description provided for @nextVisit.
  ///
  /// In en, this message translates to:
  /// **'Next Visit'**
  String get nextVisit;

  /// No description provided for @statHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get statHealth;

  /// No description provided for @statNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get statNutrition;

  /// No description provided for @statActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get statActivity;

  /// No description provided for @statVaccines.
  ///
  /// In en, this message translates to:
  /// **'Vaccines'**
  String get statVaccines;

  /// No description provided for @statGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get statGreat;

  /// No description provided for @statGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get statGood;

  /// No description provided for @stepsCount.
  ///
  /// In en, this message translates to:
  /// **'{steps} steps'**
  String stepsCount(int steps);

  /// No description provided for @upToDate.
  ///
  /// In en, this message translates to:
  /// **'Up to date'**
  String get upToDate;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get quickActions;

  /// No description provided for @bookAppointment.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get bookAppointment;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// No description provided for @lostAndFound.
  ///
  /// In en, this message translates to:
  /// **'Lost & Found'**
  String get lostAndFound;

  /// No description provided for @lostAndFoundDashboard.
  ///
  /// In en, this message translates to:
  /// **'Lost & Found Dashboard'**
  String get lostAndFoundDashboard;

  /// No description provided for @lostAndFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} active alerts within 10 km'**
  String lostAndFoundSubtitle(int count);

  /// No description provided for @liveMapView.
  ///
  /// In en, this message translates to:
  /// **'Live Map View'**
  String get liveMapView;

  /// No description provided for @recentAlerts.
  ///
  /// In en, this message translates to:
  /// **'Recent Alerts'**
  String get recentAlerts;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterLost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get filterLost;

  /// No description provided for @filterFound.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get filterFound;

  /// No description provided for @badgeLost.
  ///
  /// In en, this message translates to:
  /// **'LOST'**
  String get badgeLost;

  /// No description provided for @badgeFound.
  ///
  /// In en, this message translates to:
  /// **'FOUND'**
  String get badgeFound;

  /// No description provided for @timeAgo.
  ///
  /// In en, this message translates to:
  /// **'{n}h ago'**
  String timeAgo(int n);

  /// No description provided for @lostFoundDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Details'**
  String get lostFoundDetailTitle;

  /// No description provided for @reportReporter.
  ///
  /// In en, this message translates to:
  /// **'Reported by'**
  String get reportReporter;

  /// No description provided for @reportViewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on map'**
  String get reportViewOnMap;

  /// No description provided for @contactOwner.
  ///
  /// In en, this message translates to:
  /// **'Contact Owner'**
  String get contactOwner;

  /// No description provided for @contactOwnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Owner'**
  String get contactOwnerTitle;

  /// No description provided for @contactOwnerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reach out about {petName}.'**
  String contactOwnerSubtitle(String petName);

  /// No description provided for @contactCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get contactCall;

  /// No description provided for @contactCallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start a phone call'**
  String get contactCallSubtitle;

  /// No description provided for @contactWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get contactWhatsApp;

  /// No description provided for @contactWhatsAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Message on WhatsApp'**
  String get contactWhatsAppSubtitle;

  /// No description provided for @contactNoPhone.
  ///
  /// In en, this message translates to:
  /// **'This report has no contact number.'**
  String get contactNoPhone;

  /// No description provided for @contactLaunchError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the app. Please try again.'**
  String get contactLaunchError;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @reportLostPet.
  ///
  /// In en, this message translates to:
  /// **'Report Lost Pet'**
  String get reportLostPet;

  /// No description provided for @reportLostPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a Lost Pet'**
  String get reportLostPetTitle;

  /// No description provided for @reportLostPetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick your pet and where it was last seen.'**
  String get reportLostPetSubtitle;

  /// No description provided for @reportSelectPet.
  ///
  /// In en, this message translates to:
  /// **'Which pet is lost?'**
  String get reportSelectPet;

  /// No description provided for @reportSelectPetHint.
  ///
  /// In en, this message translates to:
  /// **'Select a pet'**
  String get reportSelectPetHint;

  /// No description provided for @reportNoPets.
  ///
  /// In en, this message translates to:
  /// **'You have no pets to report. Add a pet first.'**
  String get reportNoPets;

  /// No description provided for @reportDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get reportDescription;

  /// No description provided for @reportDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Collar, distinguishing marks, behaviour…'**
  String get reportDescriptionHint;

  /// No description provided for @reportLastSeenAddress.
  ///
  /// In en, this message translates to:
  /// **'Last seen address'**
  String get reportLastSeenAddress;

  /// No description provided for @reportLastSeenAddressHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Sunset District, Park Ave'**
  String get reportLastSeenAddressHint;

  /// No description provided for @reportLocation.
  ///
  /// In en, this message translates to:
  /// **'Last seen location'**
  String get reportLocation;

  /// No description provided for @reportLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to drop a pin'**
  String get reportLocationHint;

  /// No description provided for @reportLocationRequired.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to set the location'**
  String get reportLocationRequired;

  /// No description provided for @reportReward.
  ///
  /// In en, this message translates to:
  /// **'Reward (optional)'**
  String get reportReward;

  /// No description provided for @reportRewardLabel.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get reportRewardLabel;

  /// No description provided for @reportRewardHint.
  ///
  /// In en, this message translates to:
  /// **'0–999'**
  String get reportRewardHint;

  /// No description provided for @reportRewardRange.
  ///
  /// In en, this message translates to:
  /// **'Reward must be between 0 and 999'**
  String get reportRewardRange;

  /// No description provided for @reportRewardBadge.
  ///
  /// In en, this message translates to:
  /// **'Reward: \${amount}'**
  String reportRewardBadge(int amount);

  /// No description provided for @reportSubmit.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get reportSubmit;

  /// No description provided for @reportHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help reunite pets with their families.'**
  String get reportHeaderSubtitle;

  /// No description provided for @reportRewardHelper.
  ///
  /// In en, this message translates to:
  /// **'Offering a reward can increase the chances of being reunited.'**
  String get reportRewardHelper;

  /// No description provided for @reportUseMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get reportUseMyLocation;

  /// No description provided for @reportCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report created'**
  String get reportCreatedSuccess;

  /// No description provided for @deleteReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Report?'**
  String get deleteReportTitle;

  /// No description provided for @deleteReportMessage.
  ///
  /// In en, this message translates to:
  /// **'This removes {petName}\'s report from the map and listings. This can\'t be undone.'**
  String deleteReportMessage(String petName);

  /// No description provided for @deleteReportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report deleted'**
  String get deleteReportSuccess;

  /// No description provided for @reportSpeciesUnresolved.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t determine your pet\'s species. Please try again.'**
  String get reportSpeciesUnresolved;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report a Pet'**
  String get reportTitle;

  /// No description provided for @reportTypeLost.
  ///
  /// In en, this message translates to:
  /// **'Lost'**
  String get reportTypeLost;

  /// No description provided for @reportTypeFound.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get reportTypeFound;

  /// No description provided for @reportLostSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick your pet and where it was last seen.'**
  String get reportLostSubtitle;

  /// No description provided for @reportFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Describe the pet you found and where you saw it.'**
  String get reportFoundSubtitle;

  /// No description provided for @reportFoundName.
  ///
  /// In en, this message translates to:
  /// **'Pet name'**
  String get reportFoundName;

  /// No description provided for @reportFoundNameHint.
  ///
  /// In en, this message translates to:
  /// **'A name or nickname (e.g. \"Ginger tabby\")'**
  String get reportFoundNameHint;

  /// No description provided for @reportFoundSpecies.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get reportFoundSpecies;

  /// No description provided for @reportFoundBreed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get reportFoundBreed;

  /// No description provided for @reportFoundSelectSpeciesFirst.
  ///
  /// In en, this message translates to:
  /// **'Select a species first'**
  String get reportFoundSelectSpeciesFirst;

  /// No description provided for @reportPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get reportPhoto;

  /// No description provided for @reportPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Add a clear photo of the pet'**
  String get reportPhotoHint;

  /// No description provided for @reportPhotoRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get reportPhotoRemove;

  /// No description provided for @reportPhotoRequired.
  ///
  /// In en, this message translates to:
  /// **'A photo is required for found reports'**
  String get reportPhotoRequired;

  /// No description provided for @howToHelp.
  ///
  /// In en, this message translates to:
  /// **'How to Help More'**
  String get howToHelp;

  /// No description provided for @howToHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Join our Volunteer Search Team to get notified when a lost pet is reported near you.'**
  String get howToHelpBody;

  /// No description provided for @becomeVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Become a Volunteer'**
  String get becomeVolunteer;

  /// No description provided for @alreadyVolunteer.
  ///
  /// In en, this message translates to:
  /// **'You\'re a Volunteer'**
  String get alreadyVolunteer;

  /// No description provided for @becameVolunteer.
  ///
  /// In en, this message translates to:
  /// **'You\'re now a volunteer'**
  String get becameVolunteer;

  /// No description provided for @leftVolunteer.
  ///
  /// In en, this message translates to:
  /// **'You\'ve left the volunteers'**
  String get leftVolunteer;

  /// No description provided for @leaveVolunteerAction.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leaveVolunteerAction;

  /// No description provided for @leaveVolunteerTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave Volunteers?'**
  String get leaveVolunteerTitle;

  /// No description provided for @leaveVolunteerMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ll stop receiving alerts when a lost pet is reported near you.'**
  String get leaveVolunteerMessage;

  /// No description provided for @leaveVolunteerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leaveVolunteerConfirm;

  /// No description provided for @lostAndFoundNoAlerts.
  ///
  /// In en, this message translates to:
  /// **'No alerts nearby right now.'**
  String get lostAndFoundNoAlerts;

  /// No description provided for @activeVolunteers.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 Active Volunteer} other{{count} Active Volunteers}}'**
  String activeVolunteers(int count);

  /// No description provided for @volunteerThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for making a difference!'**
  String get volunteerThankYou;

  /// No description provided for @medicationsReminders.
  ///
  /// In en, this message translates to:
  /// **'Medications & Reminders'**
  String get medicationsReminders;

  /// No description provided for @healthTracker.
  ///
  /// In en, this message translates to:
  /// **'Health Tracker'**
  String get healthTracker;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @premiumMember.
  ///
  /// In en, this message translates to:
  /// **'Premium Member'**
  String get premiumMember;

  /// No description provided for @petProfiles.
  ///
  /// In en, this message translates to:
  /// **'Pet Profiles'**
  String get petProfiles;

  /// No description provided for @addPet.
  ///
  /// In en, this message translates to:
  /// **'Add Pet'**
  String get addPet;

  /// No description provided for @petActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get petActive;

  /// No description provided for @petAgeYears.
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =1{{years}y} other{{years}y}}'**
  String petAgeYears(int years);

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @securityPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Security & Privacy'**
  String get securityPrivacy;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @notificationsSupport.
  ///
  /// In en, this message translates to:
  /// **'Notifications & Support'**
  String get notificationsSupport;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get changeLanguage;

  /// No description provided for @changeLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the language you\'d like to use across the app'**
  String get changeLanguageSubtitle;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @reportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get reportProblem;

  /// No description provided for @termsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Terms & Privacy'**
  String get termsPrivacy;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @toggleOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get toggleOn;

  /// No description provided for @toggleOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get toggleOff;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @logOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logOutConfirmTitle;

  /// No description provided for @logOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need to sign in again to access your pets and reminders.'**
  String get logOutConfirmMessage;

  /// No description provided for @logOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, log out'**
  String get logOutConfirm;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle1.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get forgotPasswordTitle1;

  /// No description provided for @forgotPasswordTitle2.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get forgotPasswordTitle2;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number and we\'ll send you a code to reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @resetPasswordTitle1.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get resetPasswordTitle1;

  /// No description provided for @resetPasswordTitle2.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get resetPasswordTitle2;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to {phone} and choose a new password.'**
  String resetPasswordSubtitle(String phone);

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @resetPasswordAction.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordAction;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset. Please log in with your new password.'**
  String get passwordResetSuccess;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password and choose a new one.'**
  String get changePasswordSubtitle;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed.'**
  String get passwordChangedSuccess;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version} (Build {build})'**
  String appVersion(String version, String build);

  /// No description provided for @aiAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'PawBot Assistant'**
  String get aiAssistantTitle;

  /// No description provided for @aiAskHint.
  ///
  /// In en, this message translates to:
  /// **'Ask PawBot anything…'**
  String get aiAskHint;

  /// No description provided for @aiQuickFaqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get aiQuickFaqs;

  /// No description provided for @aiQuickBreedInfo.
  ///
  /// In en, this message translates to:
  /// **'BreedInfo'**
  String get aiQuickBreedInfo;

  /// No description provided for @aiQuickSymptomChecker.
  ///
  /// In en, this message translates to:
  /// **'Symptom Checker'**
  String get aiQuickSymptomChecker;

  /// No description provided for @aiHealthVaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Pet Health Vault'**
  String get aiHealthVaultTitle;

  /// No description provided for @aiHealthVaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Store vaccination records and medical history for {petName}.'**
  String aiHealthVaultSubtitle(String petName);

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mobile number'**
  String get invalidPhone;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get errorNetwork;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to do that.'**
  String get errorForbidden;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Some information is invalid. Please review and try again.'**
  String get errorValidation;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Our servers are having trouble. Please try again later.'**
  String get errorServer;

  /// No description provided for @errorRateLimit.
  ///
  /// In en, this message translates to:
  /// **'You\'re doing that too fast. Please slow down and try again.'**
  String get errorRateLimit;

  /// No description provided for @errorRateLimitRetry.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again in {seconds}s.'**
  String errorRateLimitRetry(int seconds);

  /// No description provided for @errorCache.
  ///
  /// In en, this message translates to:
  /// **'Could not load saved data.'**
  String get errorCache;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find an account with that information.'**
  String get errorNotFound;

  /// No description provided for @errorPhoneNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'No account is registered with this mobile number.'**
  String get errorPhoneNotRegistered;

  /// No description provided for @petOnboardingTitleTop.
  ///
  /// In en, this message translates to:
  /// **'Add your'**
  String get petOnboardingTitleTop;

  /// No description provided for @petOnboardingTitleAccent.
  ///
  /// In en, this message translates to:
  /// **'first pet'**
  String get petOnboardingTitleAccent;

  /// No description provided for @petOnboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your companion so we can tailor health, reminders, and care to them.'**
  String get petOnboardingSubtitle;

  /// No description provided for @petOnboardingAction.
  ///
  /// In en, this message translates to:
  /// **'Add a Pet'**
  String get petOnboardingAction;

  /// No description provided for @petOnboardingLoading.
  ///
  /// In en, this message translates to:
  /// **'Checking your pets…'**
  String get petOnboardingLoading;

  /// No description provided for @selectPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Pet'**
  String get selectPetTitle;

  /// No description provided for @selectPetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Who are we caring for today?'**
  String get selectPetSubtitle;

  /// No description provided for @createPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a Pet'**
  String get createPetTitle;

  /// No description provided for @createPetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your new furry friend'**
  String get createPetSubtitle;

  /// No description provided for @createPetName.
  ///
  /// In en, this message translates to:
  /// **'Pet Name'**
  String get createPetName;

  /// No description provided for @createPetSpecies.
  ///
  /// In en, this message translates to:
  /// **'Animal Type'**
  String get createPetSpecies;

  /// No description provided for @createPetBreed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get createPetBreed;

  /// No description provided for @createPetSelectSpeciesFirst.
  ///
  /// In en, this message translates to:
  /// **'Select an animal type first'**
  String get createPetSelectSpeciesFirst;

  /// No description provided for @createPetDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get createPetDateOfBirth;

  /// No description provided for @createPetGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get createPetGender;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get genderUnknown;

  /// No description provided for @createPetSubmit.
  ///
  /// In en, this message translates to:
  /// **'Save Pet'**
  String get createPetSubmit;

  /// No description provided for @createPetSuccess.
  ///
  /// In en, this message translates to:
  /// **'{name} has been added!'**
  String createPetSuccess(String name);

  /// No description provided for @petDetailSetActive.
  ///
  /// In en, this message translates to:
  /// **'Set as Active'**
  String get petDetailSetActive;

  /// No description provided for @petDetailAlreadyActive.
  ///
  /// In en, this message translates to:
  /// **'Currently Active'**
  String get petDetailAlreadyActive;

  /// No description provided for @petDetailGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get petDetailGender;

  /// No description provided for @petDetailDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get petDetailDateOfBirth;

  /// No description provided for @petDetailBreed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get petDetailBreed;

  /// No description provided for @petDetailSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get petDetailSize;

  /// No description provided for @petDetailCoatColor.
  ///
  /// In en, this message translates to:
  /// **'Coat Color'**
  String get petDetailCoatColor;

  /// No description provided for @petDetailMicrochip.
  ///
  /// In en, this message translates to:
  /// **'Microchip'**
  String get petDetailMicrochip;

  /// No description provided for @petDetailMicrochipLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get petDetailMicrochipLocation;

  /// No description provided for @petDetailSterilization.
  ///
  /// In en, this message translates to:
  /// **'Sterilization'**
  String get petDetailSterilization;

  /// No description provided for @petDetailSterilizationDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get petDetailSterilizationDate;

  /// No description provided for @petDetailAge.
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =1{1 year old} other{{years} years old}}'**
  String petDetailAge(int years);

  /// No description provided for @petDetailAgeMonths.
  ///
  /// In en, this message translates to:
  /// **'{months, plural, =0{Less than a month old} =1{1 month old} other{{months} months old}}'**
  String petDetailAgeMonths(int months);

  /// No description provided for @viewAllPets.
  ///
  /// In en, this message translates to:
  /// **'View all {count} pets'**
  String viewAllPets(int count);

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @createPetAdditionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get createPetAdditionalInfo;

  /// No description provided for @createPetAdditionalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional — you can fill these in later'**
  String get createPetAdditionalInfoSubtitle;

  /// No description provided for @createPetSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get createPetSize;

  /// No description provided for @createPetCoatColor.
  ///
  /// In en, this message translates to:
  /// **'Coat / Fur Color'**
  String get createPetCoatColor;

  /// No description provided for @createPetNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get createPetNotSpecified;

  /// No description provided for @createPetMicrochipNumber.
  ///
  /// In en, this message translates to:
  /// **'Microchip Number'**
  String get createPetMicrochipNumber;

  /// No description provided for @createPetMicrochipLocation.
  ///
  /// In en, this message translates to:
  /// **'Microchip Location'**
  String get createPetMicrochipLocation;

  /// No description provided for @createPetSterilizationStatus.
  ///
  /// In en, this message translates to:
  /// **'Sterilization Status'**
  String get createPetSterilizationStatus;

  /// No description provided for @sterilizationStatusNotSterilized.
  ///
  /// In en, this message translates to:
  /// **'Not Sterilized'**
  String get sterilizationStatusNotSterilized;

  /// No description provided for @sterilizationStatusSterilized.
  ///
  /// In en, this message translates to:
  /// **'Sterilized'**
  String get sterilizationStatusSterilized;

  /// No description provided for @sterilizationStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get sterilizationStatusUnknown;

  /// No description provided for @createPetSterilizationDate.
  ///
  /// In en, this message translates to:
  /// **'Sterilization Date'**
  String get createPetSterilizationDate;

  /// No description provided for @editPetTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Pet'**
  String get editPetTitle;

  /// No description provided for @editPetSave.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get editPetSave;

  /// No description provided for @deletePetTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Pet'**
  String get deletePetTitle;

  /// No description provided for @deletePetMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {petName}? This action cannot be undone.'**
  String deletePetMessage(String petName);

  /// No description provided for @deletePetConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deletePetConfirm;

  /// No description provided for @petUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pet updated successfully'**
  String get petUpdatedSuccess;

  /// No description provided for @petDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pet deleted'**
  String get petDeletedSuccess;

  /// No description provided for @petDetailTabOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get petDetailTabOverview;

  /// No description provided for @petDetailTabHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get petDetailTabHealth;

  /// No description provided for @petDetailTabRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get petDetailTabRecords;

  /// No description provided for @petDetailTabTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get petDetailTabTimeline;

  /// No description provided for @petDetailActionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get petDetailActionEdit;

  /// No description provided for @petDetailActionBook.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get petDetailActionBook;

  /// No description provided for @petDetailActionShare.
  ///
  /// In en, this message translates to:
  /// **'Pet Vision'**
  String get petDetailActionShare;

  /// No description provided for @petDetailActionMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get petDetailActionMore;

  /// No description provided for @petDetailDateAdded.
  ///
  /// In en, this message translates to:
  /// **'Date Added'**
  String get petDetailDateAdded;

  /// No description provided for @petDetailProfileCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'{petName} is all set!'**
  String petDetailProfileCompleteTitle(String petName);

  /// No description provided for @petDetailProfileCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your pet profile is complete and information is up to date.'**
  String get petDetailProfileCompleteSubtitle;

  /// No description provided for @microchipCopied.
  ///
  /// In en, this message translates to:
  /// **'Microchip number copied'**
  String get microchipCopied;

  /// No description provided for @healthWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get healthWeightTitle;

  /// No description provided for @healthWeightAdd.
  ///
  /// In en, this message translates to:
  /// **'Add weight'**
  String get healthWeightAdd;

  /// No description provided for @healthWeightEmpty.
  ///
  /// In en, this message translates to:
  /// **'No weight recorded yet. Track your pet\'s weight over time.'**
  String get healthWeightEmpty;

  /// No description provided for @healthWeightSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get healthWeightSteady;

  /// No description provided for @healthWeightLastRecorded.
  ///
  /// In en, this message translates to:
  /// **'Last recorded {date}'**
  String healthWeightLastRecorded(String date);

  /// No description provided for @healthMedicationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get healthMedicationsTitle;

  /// No description provided for @healthMedicationsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add medication'**
  String get healthMedicationsAdd;

  /// No description provided for @healthMedicationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No active medications. Add reminders to stay on schedule.'**
  String get healthMedicationsEmpty;

  /// No description provided for @healthMedicationsMarkGiven.
  ///
  /// In en, this message translates to:
  /// **'Mark as given'**
  String get healthMedicationsMarkGiven;

  /// No description provided for @healthMedicationsGivenConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Marked {name} as given'**
  String healthMedicationsGivenConfirmed(String name);

  /// No description provided for @healthMedicationsOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get healthMedicationsOverdue;

  /// No description provided for @healthMedicationsDueToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get healthMedicationsDueToday;

  /// No description provided for @healthMedicationsDueInDays.
  ///
  /// In en, this message translates to:
  /// **'In {days}d'**
  String healthMedicationsDueInDays(int days);

  /// No description provided for @healthVaccinationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Vaccinations'**
  String get healthVaccinationsTitle;

  /// No description provided for @healthVaccinationsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add vaccination'**
  String get healthVaccinationsAdd;

  /// No description provided for @healthVaccinationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No vaccinations recorded yet.'**
  String get healthVaccinationsEmpty;

  /// No description provided for @healthVaccinationsGivenOn.
  ///
  /// In en, this message translates to:
  /// **'Given {date}'**
  String healthVaccinationsGivenOn(String date);

  /// No description provided for @healthVaccinationsNextDue.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String healthVaccinationsNextDue(String date);

  /// No description provided for @healthVaccinationsDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get healthVaccinationsDue;

  /// No description provided for @healthFrequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get healthFrequencyDaily;

  /// No description provided for @healthFrequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get healthFrequencyWeekly;

  /// No description provided for @healthFrequencyBiweekly.
  ///
  /// In en, this message translates to:
  /// **'Every 2 weeks'**
  String get healthFrequencyBiweekly;

  /// No description provided for @healthFrequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get healthFrequencyMonthly;

  /// No description provided for @healthFrequencyQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Every 3 months'**
  String get healthFrequencyQuarterly;

  /// No description provided for @petDetailSectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Pet Details'**
  String get petDetailSectionDetails;

  /// No description provided for @petDetailSectionHealth.
  ///
  /// In en, this message translates to:
  /// **'Health data'**
  String get petDetailSectionHealth;

  /// No description provided for @healthWeightValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get healthWeightValueLabel;

  /// No description provided for @healthWeightValueHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 12.4'**
  String get healthWeightValueHint;

  /// No description provided for @healthWeightDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date recorded'**
  String get healthWeightDateLabel;

  /// No description provided for @healthWeightInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight'**
  String get healthWeightInvalid;

  /// No description provided for @healthWeightAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Weight recorded'**
  String get healthWeightAddedSuccess;

  /// No description provided for @healthWeightAllReadings.
  ///
  /// In en, this message translates to:
  /// **'All readings'**
  String get healthWeightAllReadings;

  /// No description provided for @healthWeightDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this reading?'**
  String get healthWeightDeleteTitle;

  /// No description provided for @healthWeightDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This weight record will be permanently removed.'**
  String get healthWeightDeleteMessage;

  /// No description provided for @healthWeightDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Weight record deleted'**
  String get healthWeightDeleteSuccess;

  /// No description provided for @healthFrequencyEveryNDays.
  ///
  /// In en, this message translates to:
  /// **'Every {days} days'**
  String healthFrequencyEveryNDays(int days);

  /// No description provided for @healthFrequencyCustomLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get healthFrequencyCustomLabel;

  /// No description provided for @healthFrequencyDaysSuffix.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get healthFrequencyDaysSuffix;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchHint;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get searchNoResults;

  /// No description provided for @healthNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get healthNotesLabel;

  /// No description provided for @healthNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering'**
  String get healthNotesHint;

  /// No description provided for @healthMedicationsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get healthMedicationsNameLabel;

  /// No description provided for @healthMedicationsNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Apoquel'**
  String get healthMedicationsNameHint;

  /// No description provided for @healthMedicationsNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose or enter a medication'**
  String get healthMedicationsNameRequired;

  /// No description provided for @healthMedicationsPickHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a medication'**
  String get healthMedicationsPickHint;

  /// No description provided for @healthMedicationsUseCustom.
  ///
  /// In en, this message translates to:
  /// **'Enter a custom name'**
  String get healthMedicationsUseCustom;

  /// No description provided for @healthMedicationsUseList.
  ///
  /// In en, this message translates to:
  /// **'Choose from the list'**
  String get healthMedicationsUseList;

  /// No description provided for @healthMedicationsFrequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get healthMedicationsFrequencyLabel;

  /// No description provided for @healthMedicationsStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get healthMedicationsStartDateLabel;

  /// No description provided for @healthMedicationsAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Medication added'**
  String get healthMedicationsAddedSuccess;

  /// No description provided for @healthMedicationsEditFrequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get healthMedicationsEditFrequency;

  /// No description provided for @healthMedicationsFrequencyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Frequency updated'**
  String get healthMedicationsFrequencyUpdated;

  /// No description provided for @healthVaccinationsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Vaccine'**
  String get healthVaccinationsNameLabel;

  /// No description provided for @healthVaccinationsNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a vaccine'**
  String get healthVaccinationsNameRequired;

  /// No description provided for @healthVaccinationsPickHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a vaccine'**
  String get healthVaccinationsPickHint;

  /// No description provided for @healthVaccinationsAdministeredLabel.
  ///
  /// In en, this message translates to:
  /// **'Date administered'**
  String get healthVaccinationsAdministeredLabel;

  /// No description provided for @healthVaccinationsNextDueLabel.
  ///
  /// In en, this message translates to:
  /// **'Next booster (optional)'**
  String get healthVaccinationsNextDueLabel;

  /// No description provided for @healthVaccinationsNoBooster.
  ///
  /// In en, this message translates to:
  /// **'No booster scheduled'**
  String get healthVaccinationsNoBooster;

  /// No description provided for @healthVaccinationsVetLabel.
  ///
  /// In en, this message translates to:
  /// **'Vet (optional)'**
  String get healthVaccinationsVetLabel;

  /// No description provided for @healthVaccinationsVetHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Dr. Smith'**
  String get healthVaccinationsVetHint;

  /// No description provided for @healthVaccinationsAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Vaccination added'**
  String get healthVaccinationsAddedSuccess;

  /// No description provided for @healthMedicationsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this medication?'**
  String get healthMedicationsDeleteTitle;

  /// No description provided for @healthMedicationsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} will be permanently removed.'**
  String healthMedicationsDeleteMessage(String name);

  /// No description provided for @healthMedicationsDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Medication deleted'**
  String get healthMedicationsDeleteSuccess;

  /// No description provided for @healthVaccinationsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this vaccination?'**
  String get healthVaccinationsDeleteTitle;

  /// No description provided for @healthVaccinationsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s record will be permanently removed.'**
  String healthVaccinationsDeleteMessage(String name);

  /// No description provided for @healthVaccinationsDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Vaccination deleted'**
  String get healthVaccinationsDeleteSuccess;

  /// No description provided for @photoSavedToGallery.
  ///
  /// In en, this message translates to:
  /// **'Photo saved to gallery'**
  String get photoSavedToGallery;

  /// No description provided for @couldNotSavePhoto.
  ///
  /// In en, this message translates to:
  /// **'Could not save photo'**
  String get couldNotSavePhoto;

  /// No description provided for @didYouKnow.
  ///
  /// In en, this message translates to:
  /// **'Did you know?'**
  String get didYouKnow;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @personalInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your personal details and contact information'**
  String get personalInformationSubtitle;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get contactDetails;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetails;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @noEmailAdded.
  ///
  /// In en, this message translates to:
  /// **'No email added'**
  String get noEmailAdded;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String memberSince(String date);

  /// No description provided for @emailPendingVerification.
  ///
  /// In en, this message translates to:
  /// **'Pending verification: {email}'**
  String emailPendingVerification(String email);

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @userIdCopied.
  ///
  /// In en, this message translates to:
  /// **'User ID copied'**
  String get userIdCopied;

  /// No description provided for @profileTagCopied.
  ///
  /// In en, this message translates to:
  /// **'Profile tag copied'**
  String get profileTagCopied;

  /// No description provided for @onboardingCoOwnTitle.
  ///
  /// In en, this message translates to:
  /// **'Want to co-own a pet?'**
  String get onboardingCoOwnTitle;

  /// No description provided for @onboardingCoOwnBody.
  ///
  /// In en, this message translates to:
  /// **'Get invited using your profile tag:'**
  String get onboardingCoOwnBody;

  /// No description provided for @onboardingViewInvites.
  ///
  /// In en, this message translates to:
  /// **'View invitations'**
  String get onboardingViewInvites;

  /// No description provided for @onboardingViewInvitesCount.
  ///
  /// In en, this message translates to:
  /// **'View invitations ({count})'**
  String onboardingViewInvitesCount(int count);

  /// No description provided for @inviteCoOwnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite Co-Owner'**
  String get inviteCoOwnerTitle;

  /// No description provided for @inviteCoOwnerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search by profile tag to invite someone to co-own {petName}.'**
  String inviteCoOwnerSubtitle(String petName);

  /// No description provided for @inviteCoOwnerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a profile tag (e.g. a1b2c3d4)'**
  String get inviteCoOwnerSearchHint;

  /// No description provided for @inviteCoOwnerSearchIdle.
  ///
  /// In en, this message translates to:
  /// **'Enter a full profile tag to find someone'**
  String get inviteCoOwnerSearchIdle;

  /// No description provided for @inviteCoOwnerSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No user found with that tag.'**
  String get inviteCoOwnerSearchEmpty;

  /// No description provided for @inviteCoOwnerInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get inviteCoOwnerInvite;

  /// No description provided for @inviteCoOwnerAlreadyInvited.
  ///
  /// In en, this message translates to:
  /// **'Invited'**
  String get inviteCoOwnerAlreadyInvited;

  /// No description provided for @inviteCoOwnerSent.
  ///
  /// In en, this message translates to:
  /// **'Invitation sent'**
  String get inviteCoOwnerSent;

  /// No description provided for @inviteCoOwnerSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Invitations sent'**
  String get inviteCoOwnerSentTitle;

  /// No description provided for @inviteCoOwnerNoneSent.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t invited anyone yet.'**
  String get inviteCoOwnerNoneSent;

  /// No description provided for @inviteCoOwnerCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel invitation'**
  String get inviteCoOwnerCancel;

  /// No description provided for @inviteCoOwnerCancelled.
  ///
  /// In en, this message translates to:
  /// **'Invitation cancelled'**
  String get inviteCoOwnerCancelled;

  /// No description provided for @coOwnerCurrentTitle.
  ///
  /// In en, this message translates to:
  /// **'Current co-owners'**
  String get coOwnerCurrentTitle;

  /// No description provided for @coOwnerPrimaryBadge.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get coOwnerPrimaryBadge;

  /// No description provided for @coOwnerYou.
  ///
  /// In en, this message translates to:
  /// **'{name} (You)'**
  String coOwnerYou(String name);

  /// No description provided for @coOwnerRemoveAction.
  ///
  /// In en, this message translates to:
  /// **'Remove co-owner'**
  String get coOwnerRemoveAction;

  /// No description provided for @coOwnerLeaveAction.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get coOwnerLeaveAction;

  /// No description provided for @coOwnerLeavePetAction.
  ///
  /// In en, this message translates to:
  /// **'Leave Co-Ownership'**
  String get coOwnerLeavePetAction;

  /// No description provided for @coOwnerRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove co-owner?'**
  String get coOwnerRemoveTitle;

  /// No description provided for @coOwnerRemoveMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} will lose access to this pet. This can\'t be undone.'**
  String coOwnerRemoveMessage(String name);

  /// No description provided for @coOwnerRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get coOwnerRemoveConfirm;

  /// No description provided for @coOwnerRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Co-owner removed'**
  String get coOwnerRemovedSuccess;

  /// No description provided for @coOwnerLeaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave this pet?'**
  String get coOwnerLeaveTitle;

  /// No description provided for @coOwnerLeaveMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ll lose access to this pet. The owner can invite you again later.'**
  String get coOwnerLeaveMessage;

  /// No description provided for @coOwnerLeaveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get coOwnerLeaveConfirm;

  /// No description provided for @coOwnerLeftSuccess.
  ///
  /// In en, this message translates to:
  /// **'You\'ve left the pet'**
  String get coOwnerLeftSuccess;

  /// No description provided for @coOwnerInvitationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pet Invitations'**
  String get coOwnerInvitationsTitle;

  /// No description provided for @coOwnerInvitationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no pending invitations.'**
  String get coOwnerInvitationsEmpty;

  /// No description provided for @coOwnerInvitedBy.
  ///
  /// In en, this message translates to:
  /// **'Invited by {name}'**
  String coOwnerInvitedBy(String name);

  /// No description provided for @coOwnerAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get coOwnerAccept;

  /// No description provided for @coOwnerDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get coOwnerDecline;

  /// No description provided for @coOwnerAccepted.
  ///
  /// In en, this message translates to:
  /// **'You\'re now a co-owner of {petName}'**
  String coOwnerAccepted(String petName);

  /// No description provided for @coOwnerDeclined.
  ///
  /// In en, this message translates to:
  /// **'Invitation declined'**
  String get coOwnerDeclined;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get statusDeclined;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @locationName.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationName;

  /// No description provided for @locationNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Beirut, Lebanon'**
  String get locationNameHint;

  /// No description provided for @locationNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Location must be 200 characters or fewer'**
  String get locationNameTooLong;

  /// No description provided for @locationPickHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to drop a pin'**
  String get locationPickHint;

  /// No description provided for @locationRequired.
  ///
  /// In en, this message translates to:
  /// **'Pick your location on the map'**
  String get locationRequired;

  /// No description provided for @locationUseMine.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get locationUseMine;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @photoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated'**
  String get photoUpdated;

  /// No description provided for @photoUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update your photo. Please try again.'**
  String get photoUploadFailed;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @petAvatarSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a Photo'**
  String get petAvatarSetupTitle;

  /// No description provided for @petAvatarSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give your pet a face on their profile.'**
  String get petAvatarSetupSubtitle;

  /// No description provided for @petAvatarSetupOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional — you can change it anytime.'**
  String get petAvatarSetupOptional;

  /// No description provided for @petAvatarUploadHint.
  ///
  /// In en, this message translates to:
  /// **'Upload a photo'**
  String get petAvatarUploadHint;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @providersNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby Providers'**
  String get providersNearby;

  /// No description provided for @providerCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No providers found} =1{1 provider found} other{{count} providers found}}'**
  String providerCount(int count);

  /// No description provided for @providerSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search vets, groomers, shops…'**
  String get providerSearchHint;

  /// No description provided for @providerSort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get providerSort;

  /// No description provided for @providerSortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get providerSortBy;

  /// No description provided for @sortDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get sortDistance;

  /// No description provided for @sortRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get sortRating;

  /// No description provided for @sortOpenNow.
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get sortOpenNow;

  /// No description provided for @sortMostReviewed.
  ///
  /// In en, this message translates to:
  /// **'Most reviewed'**
  String get sortMostReviewed;

  /// No description provided for @providerShowList.
  ///
  /// In en, this message translates to:
  /// **'Show list'**
  String get providerShowList;

  /// No description provided for @providerShowMap.
  ///
  /// In en, this message translates to:
  /// **'Show map'**
  String get providerShowMap;

  /// No description provided for @providerMyLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get providerMyLocation;

  /// No description provided for @providerOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get providerOpen;

  /// No description provided for @providerClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get providerClosed;

  /// No description provided for @providerCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get providerCall;

  /// No description provided for @providerDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get providerDirections;

  /// No description provided for @providerCallFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start a call. No phone number available.'**
  String get providerCallFailed;

  /// No description provided for @providerDirectionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open directions.'**
  String get providerDirectionsFailed;

  /// No description provided for @providerNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No providers found'**
  String get providerNoResultsTitle;

  /// No description provided for @providerNoResultsNearby.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t find any pet businesses near you yet.'**
  String get providerNoResultsNearby;

  /// No description provided for @providerNoResultsFiltered.
  ///
  /// In en, this message translates to:
  /// **'No providers match your filters. Try adjusting your search or category.'**
  String get providerNoResultsFiltered;

  /// No description provided for @providerClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get providerClearFilters;

  /// No description provided for @providerOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline'**
  String get providerOfflineTitle;

  /// No description provided for @providerOfflineMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again to see nearby providers.'**
  String get providerOfflineMessage;

  /// No description provided for @providerErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get providerErrorTitle;

  /// No description provided for @providerErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load providers right now. Please try again.'**
  String get providerErrorMessage;

  /// No description provided for @providerLocationDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Location is off'**
  String get providerLocationDeniedTitle;

  /// No description provided for @providerLocationDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Turn on location to discover pet services around you.'**
  String get providerLocationDeniedMessage;

  /// No description provided for @providerEnableLocation.
  ///
  /// In en, this message translates to:
  /// **'Enable location'**
  String get providerEnableLocation;

  /// No description provided for @distanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{meters} m'**
  String distanceMeters(int meters);

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String distanceKm(String km);

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rated {rating}'**
  String ratingLabel(String rating);

  /// No description provided for @ratingWithReviews.
  ///
  /// In en, this message translates to:
  /// **'Rated {rating} from {count} reviews'**
  String ratingWithReviews(String rating, int count);

  /// No description provided for @reviewCountShort.
  ///
  /// In en, this message translates to:
  /// **'({count})'**
  String reviewCountShort(int count);

  /// No description provided for @badgeVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get badgeVerified;

  /// No description provided for @badgeEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get badgeEmergency;

  /// No description provided for @badge24_7.
  ///
  /// In en, this message translates to:
  /// **'24/7'**
  String get badge24_7;

  /// No description provided for @badgeMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get badgeMobile;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryVeterinary.
  ///
  /// In en, this message translates to:
  /// **'Veterinary'**
  String get categoryVeterinary;

  /// No description provided for @categoryGrooming.
  ///
  /// In en, this message translates to:
  /// **'Grooming'**
  String get categoryGrooming;

  /// No description provided for @categoryPetShop.
  ///
  /// In en, this message translates to:
  /// **'Pet Shops'**
  String get categoryPetShop;

  /// No description provided for @categoryBoarding.
  ///
  /// In en, this message translates to:
  /// **'Boarding'**
  String get categoryBoarding;

  /// No description provided for @categoryTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get categoryTraining;

  /// No description provided for @categoryPetSitting.
  ///
  /// In en, this message translates to:
  /// **'Pet Sitting'**
  String get categoryPetSitting;

  /// No description provided for @categoryWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get categoryWalking;

  /// No description provided for @categoryAdoption.
  ///
  /// In en, this message translates to:
  /// **'Adoption'**
  String get categoryAdoption;

  /// No description provided for @categoryShelter.
  ///
  /// In en, this message translates to:
  /// **'Shelters'**
  String get categoryShelter;

  /// No description provided for @categoryEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get categoryEmergency;

  /// No description provided for @categoryPharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get categoryPharmacy;

  /// No description provided for @adoptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Adoption'**
  String get adoptionTitle;

  /// No description provided for @adoptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No pets available} =1{1 pet looking for a home} other{{count} pets looking for a home}}'**
  String adoptionSubtitle(int count);

  /// No description provided for @adoptionListAPet.
  ///
  /// In en, this message translates to:
  /// **'List a pet'**
  String get adoptionListAPet;

  /// No description provided for @adoptionSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, breed, or area'**
  String get adoptionSearchHint;

  /// No description provided for @adoptionFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get adoptionFilterAll;

  /// No description provided for @adoptionSpeciesDog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get adoptionSpeciesDog;

  /// No description provided for @adoptionSpeciesCat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get adoptionSpeciesCat;

  /// No description provided for @adoptionSpeciesBird.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get adoptionSpeciesBird;

  /// No description provided for @adoptionSpeciesRabbit.
  ///
  /// In en, this message translates to:
  /// **'Rabbit'**
  String get adoptionSpeciesRabbit;

  /// No description provided for @adoptionSpeciesOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get adoptionSpeciesOther;

  /// No description provided for @adoptionSexMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get adoptionSexMale;

  /// No description provided for @adoptionSexFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get adoptionSexFemale;

  /// No description provided for @adoptionAgeMonths.
  ///
  /// In en, this message translates to:
  /// **'{months, plural, =0{Newborn} =1{1 month} other{{months} months}}'**
  String adoptionAgeMonths(int months);

  /// No description provided for @adoptionAgeYears.
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =1{1 year} other{{years} years}}'**
  String adoptionAgeYears(int years);

  /// No description provided for @adoptionStatusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get adoptionStatusAvailable;

  /// No description provided for @adoptionStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adoptionStatusPending;

  /// No description provided for @adoptionStatusAdopted.
  ///
  /// In en, this message translates to:
  /// **'Adopted'**
  String get adoptionStatusAdopted;

  /// No description provided for @adoptionStatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get adoptionStatusUnavailable;

  /// No description provided for @adoptionPostedDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day ago} other{{days} days ago}}'**
  String adoptionPostedDaysAgo(int days);

  /// No description provided for @adoptionPostedHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =0{Just now} =1{1 hour ago} other{{hours} hours ago}}'**
  String adoptionPostedHoursAgo(int hours);

  /// No description provided for @adoptionTraitVaccinated.
  ///
  /// In en, this message translates to:
  /// **'Vaccinated'**
  String get adoptionTraitVaccinated;

  /// No description provided for @adoptionTraitNeutered.
  ///
  /// In en, this message translates to:
  /// **'Neutered'**
  String get adoptionTraitNeutered;

  /// No description provided for @adoptionTraitGoodWithKids.
  ///
  /// In en, this message translates to:
  /// **'Good with kids'**
  String get adoptionTraitGoodWithKids;

  /// No description provided for @adoptionApply.
  ///
  /// In en, this message translates to:
  /// **'Apply to adopt'**
  String get adoptionApply;

  /// No description provided for @adoptionApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get adoptionApplied;

  /// No description provided for @adoptionManageCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Manage listing} =1{Manage · 1 applicant} other{Manage · {count} applicants}}'**
  String adoptionManageCount(int count);

  /// No description provided for @adoptionManageTitle.
  ///
  /// In en, this message translates to:
  /// **'Applicants'**
  String get adoptionManageTitle;

  /// No description provided for @adoptionManageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No applicants yet} =1{1 person wants to adopt {petName}} other{{count} people want to adopt {petName}}}'**
  String adoptionManageSubtitle(int count, String petName);

  /// No description provided for @adoptionManageEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No applicants yet'**
  String get adoptionManageEmptyTitle;

  /// No description provided for @adoptionManageEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'When someone applies to adopt {petName}, they\'ll show up here.'**
  String adoptionManageEmptyMessage(String petName);

  /// No description provided for @adoptionApplicantApplied.
  ///
  /// In en, this message translates to:
  /// **'Applied {ago}'**
  String adoptionApplicantApplied(String ago);

  /// No description provided for @adoptionApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get adoptionApprove;

  /// No description provided for @adoptionReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get adoptionReject;

  /// No description provided for @adoptionRequestStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending review'**
  String get adoptionRequestStatusPending;

  /// No description provided for @adoptionRequestStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get adoptionRequestStatusApproved;

  /// No description provided for @adoptionRequestStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get adoptionRequestStatusRejected;

  /// No description provided for @adoptionRequestStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get adoptionRequestStatusCancelled;

  /// No description provided for @adoptionRequestStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Adopted'**
  String get adoptionRequestStatusCompleted;

  /// No description provided for @adoptionRequestStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get adoptionRequestStatusExpired;

  /// No description provided for @adoptionAwaitingAdopter.
  ///
  /// In en, this message translates to:
  /// **'Waiting for them to accept'**
  String get adoptionAwaitingAdopter;

  /// No description provided for @adoptionOnePickHint.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already picked an applicant. Reject them to choose someone else.'**
  String get adoptionOnePickHint;

  /// No description provided for @adoptionReadyToComplete.
  ///
  /// In en, this message translates to:
  /// **'Ready to hand over'**
  String get adoptionReadyToComplete;

  /// No description provided for @adoptionCompleteTransfer.
  ///
  /// In en, this message translates to:
  /// **'Complete transfer'**
  String get adoptionCompleteTransfer;

  /// No description provided for @adoptionApproveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Approve {name}?'**
  String adoptionApproveConfirmTitle(String name);

  /// No description provided for @adoptionApproveConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'They\'ll be asked to confirm they want {petName}. Ownership only transfers once you both confirm.'**
  String adoptionApproveConfirmMessage(String petName);

  /// No description provided for @adoptionRejectConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject {name}?'**
  String adoptionRejectConfirmTitle(String name);

  /// No description provided for @adoptionRejectConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'They\'ll be notified their application wasn\'t successful. This can\'t be undone.'**
  String get adoptionRejectConfirmMessage;

  /// No description provided for @adoptionCompleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Give {petName} to {name}?'**
  String adoptionCompleteConfirmTitle(String petName, String name);

  /// No description provided for @adoptionCompleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This transfers ownership permanently and can\'t be undone. {petName} and all their records will move to {name}.'**
  String adoptionCompleteConfirmMessage(String petName, String name);

  /// No description provided for @adoptionApproveSuccess.
  ///
  /// In en, this message translates to:
  /// **'{name} has been approved.'**
  String adoptionApproveSuccess(String name);

  /// No description provided for @adoptionRejectSuccess.
  ///
  /// In en, this message translates to:
  /// **'Application rejected.'**
  String get adoptionRejectSuccess;

  /// No description provided for @adoptionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete listing'**
  String get adoptionDelete;

  /// No description provided for @adoptionDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this listing?'**
  String get adoptionDeleteConfirmTitle;

  /// No description provided for @adoptionDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'{petName}\'s listing will be permanently removed. This can\'t be undone.'**
  String adoptionDeleteConfirmMessage(String petName);

  /// No description provided for @adoptionDeleteConfirmMessageWithApplicants.
  ///
  /// In en, this message translates to:
  /// **'{petName}\'s listing and {count, plural, one{# application} other{# applications}} will be permanently removed. This can\'t be undone.'**
  String adoptionDeleteConfirmMessageWithApplicants(String petName, int count);

  /// No description provided for @adoptionDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Listing deleted.'**
  String get adoptionDeleteSuccess;

  /// No description provided for @adoptionRehomeSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'{petName} has a new home!'**
  String adoptionRehomeSuccessTitle(String petName);

  /// No description provided for @adoptionRehomeSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'{petName} is now with {name}, along with all their records. Thank you for giving them a loving new home.'**
  String adoptionRehomeSuccessMessage(String petName, String name);

  /// No description provided for @adoptionRehomeSuccessDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get adoptionRehomeSuccessDone;

  /// No description provided for @adoptionEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No pets up for adoption'**
  String get adoptionEmptyTitle;

  /// No description provided for @adoptionEmptyNearby.
  ///
  /// In en, this message translates to:
  /// **'There are no listings near you right now. Check back soon.'**
  String get adoptionEmptyNearby;

  /// No description provided for @adoptionEmptyFiltered.
  ///
  /// In en, this message translates to:
  /// **'No listings match your filters. Try widening your search.'**
  String get adoptionEmptyFiltered;

  /// No description provided for @adoptionClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get adoptionClearFilters;

  /// No description provided for @adoptionAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get adoptionAboutTitle;

  /// No description provided for @adoptionPostedBy.
  ///
  /// In en, this message translates to:
  /// **'Posted by'**
  String get adoptionPostedBy;

  /// No description provided for @adoptionFactSpecies.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get adoptionFactSpecies;

  /// No description provided for @adoptionFactSex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get adoptionFactSex;

  /// No description provided for @adoptionFactAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get adoptionFactAge;

  /// No description provided for @adoptionFactSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get adoptionFactSize;

  /// No description provided for @adoptionApplyConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply to adopt {petName}?'**
  String adoptionApplyConfirmTitle(String petName);

  /// No description provided for @adoptionApplyConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'The current owner will review your request. If they approve, both of you confirm before ownership transfers.'**
  String get adoptionApplyConfirmMessage;

  /// No description provided for @adoptionApplySuccess.
  ///
  /// In en, this message translates to:
  /// **'Your application was sent to the owner.'**
  String get adoptionApplySuccess;

  /// No description provided for @adoptionTransferNote.
  ///
  /// In en, this message translates to:
  /// **'You\'ll both confirm before ownership transfers — nothing moves without your approval.'**
  String get adoptionTransferNote;

  /// No description provided for @adoptionListTitle.
  ///
  /// In en, this message translates to:
  /// **'List a Pet'**
  String get adoptionListTitle;

  /// No description provided for @adoptionListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your pet a loving new home.'**
  String get adoptionListSubtitle;

  /// No description provided for @adoptionListWhichPet.
  ///
  /// In en, this message translates to:
  /// **'Which pet?'**
  String get adoptionListWhichPet;

  /// No description provided for @adoptionListSelectPet.
  ///
  /// In en, this message translates to:
  /// **'Select a pet'**
  String get adoptionListSelectPet;

  /// No description provided for @adoptionListSelectPetHint.
  ///
  /// In en, this message translates to:
  /// **'Choose one of your pets'**
  String get adoptionListSelectPetHint;

  /// No description provided for @adoptionListNoPets.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any pets to list yet.'**
  String get adoptionListNoPets;

  /// No description provided for @adoptionListDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Tell adopters about their personality, needs, and why you\'re rehoming them.'**
  String get adoptionListDescriptionHint;

  /// No description provided for @adoptionListTraits.
  ///
  /// In en, this message translates to:
  /// **'Traits'**
  String get adoptionListTraits;

  /// No description provided for @adoptionListLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get adoptionListLocation;

  /// No description provided for @adoptionListTransferNote.
  ///
  /// In en, this message translates to:
  /// **'When someone applies, you review and approve them. Ownership transfers only after you both confirm — records travel with your pet.'**
  String get adoptionListTransferNote;

  /// No description provided for @adoptionListSubmit.
  ///
  /// In en, this message translates to:
  /// **'Post listing'**
  String get adoptionListSubmit;

  /// No description provided for @adoptionListingCreated.
  ///
  /// In en, this message translates to:
  /// **'Your pet is now listed for adoption.'**
  String get adoptionListingCreated;

  /// No description provided for @adoptionModeMyPet.
  ///
  /// In en, this message translates to:
  /// **'My pet'**
  String get adoptionModeMyPet;

  /// No description provided for @adoptionModeShelter.
  ///
  /// In en, this message translates to:
  /// **'Shelter / stray'**
  String get adoptionModeShelter;

  /// No description provided for @adoptionShelterAnimalDetails.
  ///
  /// In en, this message translates to:
  /// **'Animal details'**
  String get adoptionShelterAnimalDetails;

  /// No description provided for @adoptionShelterName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get adoptionShelterName;

  /// No description provided for @adoptionShelterTransferNote.
  ///
  /// In en, this message translates to:
  /// **'No pet record needed. When someone adopts, a new pet profile is created for them with this photo and these details.'**
  String get adoptionShelterTransferNote;

  /// No description provided for @adoptionShelterBadge.
  ///
  /// In en, this message translates to:
  /// **'Shelter'**
  String get adoptionShelterBadge;

  /// No description provided for @adoptionMyTitle.
  ///
  /// In en, this message translates to:
  /// **'My Adoptions'**
  String get adoptionMyTitle;

  /// No description provided for @adoptionMyTooltip.
  ///
  /// In en, this message translates to:
  /// **'My adoptions'**
  String get adoptionMyTooltip;

  /// No description provided for @adoptionMyRowHint.
  ///
  /// In en, this message translates to:
  /// **'Your listings & applications'**
  String get adoptionMyRowHint;

  /// No description provided for @adoptionMyTabListings.
  ///
  /// In en, this message translates to:
  /// **'My listings'**
  String get adoptionMyTabListings;

  /// No description provided for @adoptionMyTabApplications.
  ///
  /// In en, this message translates to:
  /// **'My applications'**
  String get adoptionMyTabApplications;

  /// No description provided for @adoptionMyListingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No listings yet'**
  String get adoptionMyListingsEmptyTitle;

  /// No description provided for @adoptionMyListingsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Pets you put up for adoption will appear here.'**
  String get adoptionMyListingsEmptyMessage;

  /// No description provided for @adoptionMyApplicationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No applications yet'**
  String get adoptionMyApplicationsEmptyTitle;

  /// No description provided for @adoptionMyApplicationsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Pets you apply to adopt will appear here.'**
  String get adoptionMyApplicationsEmptyMessage;

  /// No description provided for @adoptionApplicationFrom.
  ///
  /// In en, this message translates to:
  /// **'From {name}'**
  String adoptionApplicationFrom(String name);

  /// No description provided for @adoptionAcceptCta.
  ///
  /// In en, this message translates to:
  /// **'I\'ll take them'**
  String get adoptionAcceptCta;

  /// No description provided for @adoptionAcceptHint.
  ///
  /// In en, this message translates to:
  /// **'You\'re approved! Confirm you want to adopt, then the owner completes the handover.'**
  String get adoptionAcceptHint;

  /// No description provided for @adoptionAwaitingHandover.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the owner to hand over'**
  String get adoptionAwaitingHandover;

  /// No description provided for @adoptionAwaitingReview.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the owner to review your application'**
  String get adoptionAwaitingReview;

  /// No description provided for @adoptionCancelApplication.
  ///
  /// In en, this message translates to:
  /// **'Withdraw application'**
  String get adoptionCancelApplication;

  /// No description provided for @adoptionCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw your application?'**
  String get adoptionCancelConfirmTitle;

  /// No description provided for @adoptionCancelConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You can apply again later while the listing is open.'**
  String get adoptionCancelConfirmMessage;

  /// No description provided for @adoptionAcceptSuccess.
  ///
  /// In en, this message translates to:
  /// **'You\'re confirmed. The owner will complete the handover.'**
  String get adoptionAcceptSuccess;

  /// No description provided for @adoptionCancelSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your application was withdrawn.'**
  String get adoptionCancelSuccess;

  /// No description provided for @adoptionWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'{petName} is now yours!'**
  String adoptionWelcomeTitle(String petName);

  /// No description provided for @adoptionWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome {petName} to the family. Their full profile and records are already in your account.'**
  String adoptionWelcomeMessage(String petName);

  /// No description provided for @adoptionWelcomeViewPet.
  ///
  /// In en, this message translates to:
  /// **'View {petName}\'s profile'**
  String adoptionWelcomeViewPet(String petName);

  /// No description provided for @adoptionWelcomeDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get adoptionWelcomeDone;

  /// No description provided for @onboardingAdoptPrompt.
  ///
  /// In en, this message translates to:
  /// **'Looking to adopt a pet?'**
  String get onboardingAdoptPrompt;

  /// No description provided for @walkStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a walk'**
  String get walkStartTitle;

  /// No description provided for @walkStartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track {petName}\'s activity'**
  String walkStartSubtitle(String petName);

  /// No description provided for @walkStartButton.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get walkStartButton;

  /// No description provided for @walkActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Walking with {petName}'**
  String walkActiveTitle(String petName);

  /// No description provided for @walkStopButton.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get walkStopButton;

  /// No description provided for @walkStatDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get walkStatDuration;

  /// No description provided for @walkStatDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get walkStatDistance;

  /// No description provided for @walkStatSpeed.
  ///
  /// In en, this message translates to:
  /// **'Avg Speed'**
  String get walkStatSpeed;

  /// No description provided for @walkNoLocation.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable — showing timer only'**
  String get walkNoLocation;

  /// No description provided for @walkHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Walk History'**
  String get walkHistoryTitle;

  /// No description provided for @walkHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No walks recorded yet.\nStart a walk from the home screen.'**
  String get walkHistoryEmpty;

  /// No description provided for @walkDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this walk?'**
  String get walkDeleteTitle;

  /// No description provided for @walkDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This walk record will be permanently removed.'**
  String get walkDeleteMessage;

  /// No description provided for @walkDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Walk deleted'**
  String get walkDeleteSuccess;

  /// No description provided for @walkDeleteTooOld.
  ///
  /// In en, this message translates to:
  /// **'Walks older than 2 days can\'t be deleted'**
  String get walkDeleteTooOld;

  /// No description provided for @reminderMedicationDose.
  ///
  /// In en, this message translates to:
  /// **'Medication · {petName}'**
  String reminderMedicationDose(Object petName);

  /// No description provided for @reminderVaccinationBooster.
  ///
  /// In en, this message translates to:
  /// **'Vaccination booster · {petName}'**
  String reminderVaccinationBooster(Object petName);

  /// No description provided for @reminderDueToday.
  ///
  /// In en, this message translates to:
  /// **'Due today'**
  String get reminderDueToday;

  /// No description provided for @reminderOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get reminderOverdue;

  /// No description provided for @reminderDueInDays.
  ///
  /// In en, this message translates to:
  /// **'Due in {days}d'**
  String reminderDueInDays(Object days);

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// No description provided for @pawHubSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search pets, posts, #tags'**
  String get pawHubSearchHint;

  /// No description provided for @pawHubFeedTabFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get pawHubFeedTabFollowing;

  /// No description provided for @pawHubFeedTabDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get pawHubFeedTabDiscover;

  /// No description provided for @pawHubNewPosts.
  ///
  /// In en, this message translates to:
  /// **'New paw-sts'**
  String get pawHubNewPosts;

  /// No description provided for @pawHubFeedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your feed is a little quiet'**
  String get pawHubFeedEmptyTitle;

  /// No description provided for @pawHubFeedEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow some pets and their moments will show up right here 🐾'**
  String get pawHubFeedEmptyDescription;

  /// No description provided for @pawHubDiscoverPets.
  ///
  /// In en, this message translates to:
  /// **'Discover pets'**
  String get pawHubDiscoverPets;

  /// No description provided for @pawHubSuggestedPets.
  ///
  /// In en, this message translates to:
  /// **'Pets you might like'**
  String get pawHubSuggestedPets;

  /// No description provided for @pawHubLostPetNearby.
  ///
  /// In en, this message translates to:
  /// **'LOST PET NEARBY'**
  String get pawHubLostPetNearby;

  /// No description provided for @pawHubViewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on map'**
  String get pawHubViewOnMap;

  /// No description provided for @pawHubFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get pawHubFollow;

  /// No description provided for @pawHubFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get pawHubFollowing;

  /// No description provided for @pawHubCouldNotLoadFeed.
  ///
  /// In en, this message translates to:
  /// **'Could not load feed'**
  String get pawHubCouldNotLoadFeed;

  /// No description provided for @pawHubPostSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get pawHubPostSaved;

  /// No description provided for @pawHubPostRemovedFromSaved.
  ///
  /// In en, this message translates to:
  /// **'Removed from saved'**
  String get pawHubPostRemovedFromSaved;

  /// No description provided for @pawHubLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied'**
  String get pawHubLinkCopied;

  /// No description provided for @pawHubPostHidden.
  ///
  /// In en, this message translates to:
  /// **'Post hidden'**
  String get pawHubPostHidden;

  /// No description provided for @pawHubPostReported.
  ///
  /// In en, this message translates to:
  /// **'Reported. Thank you.'**
  String get pawHubPostReported;

  /// No description provided for @pawHubBlockedUser.
  ///
  /// In en, this message translates to:
  /// **'Blocked {name}'**
  String pawHubBlockedUser(String name);

  /// No description provided for @pawHubPostDeleted.
  ///
  /// In en, this message translates to:
  /// **'Post deleted'**
  String get pawHubPostDeleted;

  /// No description provided for @pawHubEditCaption.
  ///
  /// In en, this message translates to:
  /// **'Edit caption'**
  String get pawHubEditCaption;

  /// No description provided for @pawHubCaptionUpdated.
  ///
  /// In en, this message translates to:
  /// **'Caption updated'**
  String get pawHubCaptionUpdated;

  /// No description provided for @pawHubFollowingPet.
  ///
  /// In en, this message translates to:
  /// **'Following {name}'**
  String pawHubFollowingPet(String name);

  /// No description provided for @pawHubUnfollowedPet.
  ///
  /// In en, this message translates to:
  /// **'Unfollowed {name}'**
  String pawHubUnfollowedPet(String name);

  /// No description provided for @pawHubAddPetFirstToPost.
  ///
  /// In en, this message translates to:
  /// **'Add a pet first to post'**
  String get pawHubAddPetFirstToPost;

  /// No description provided for @pawHubPostedAs.
  ///
  /// In en, this message translates to:
  /// **'Posted as {name} 🐾'**
  String pawHubPostedAs(String name);

  /// No description provided for @pawHubPostOptionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get pawHubPostOptionSave;

  /// No description provided for @pawHubPostOptionRemoveSaved.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get pawHubPostOptionRemoveSaved;

  /// No description provided for @pawHubPostOptionCopyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get pawHubPostOptionCopyLink;

  /// No description provided for @pawHubPostOptionShareTo.
  ///
  /// In en, this message translates to:
  /// **'Share to…'**
  String get pawHubPostOptionShareTo;

  /// No description provided for @pawHubPostOptionEditPost.
  ///
  /// In en, this message translates to:
  /// **'Edit post'**
  String get pawHubPostOptionEditPost;

  /// No description provided for @pawHubPostOptionDeletePost.
  ///
  /// In en, this message translates to:
  /// **'Delete post'**
  String get pawHubPostOptionDeletePost;

  /// No description provided for @pawHubPostOptionHidePost.
  ///
  /// In en, this message translates to:
  /// **'Hide this post'**
  String get pawHubPostOptionHidePost;

  /// No description provided for @pawHubPostOptionReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get pawHubPostOptionReport;

  /// No description provided for @pawHubPostOptionBlock.
  ///
  /// In en, this message translates to:
  /// **'Block {name}'**
  String pawHubPostOptionBlock(String name);

  /// No description provided for @pawHubReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this?'**
  String get pawHubReportTitle;

  /// No description provided for @pawHubReportReasonCruelty.
  ///
  /// In en, this message translates to:
  /// **'Animal cruelty or harm'**
  String get pawHubReportReasonCruelty;

  /// No description provided for @pawHubReportReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or a scam'**
  String get pawHubReportReasonSpam;

  /// No description provided for @pawHubReportReasonNudity.
  ///
  /// In en, this message translates to:
  /// **'Nudity or sexual content'**
  String get pawHubReportReasonNudity;

  /// No description provided for @pawHubReportReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment or bullying'**
  String get pawHubReportReasonHarassment;

  /// No description provided for @pawHubReportReasonImpersonation.
  ///
  /// In en, this message translates to:
  /// **'Not a real pet / impersonation'**
  String get pawHubReportReasonImpersonation;

  /// No description provided for @pawHubReportReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get pawHubReportReasonOther;

  /// No description provided for @pawHubCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get pawHubCommentsTitle;

  /// No description provided for @pawHubCommentAs.
  ///
  /// In en, this message translates to:
  /// **'Comment as'**
  String get pawHubCommentAs;

  /// No description provided for @pawHubCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment as {name}…'**
  String pawHubCommentHint(String name);

  /// No description provided for @pawHubReplyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String pawHubReplyingTo(String name);

  /// No description provided for @pawHubSortTop.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get pawHubSortTop;

  /// No description provided for @pawHubSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get pawHubSortNewest;

  /// No description provided for @pawHubCommentReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get pawHubCommentReply;

  /// No description provided for @pawHubNoCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get pawHubNoCommentsYet;

  /// No description provided for @pawHubFirstCommentEncouragement.
  ///
  /// In en, this message translates to:
  /// **'Be the first to say something nice 🐾'**
  String get pawHubFirstCommentEncouragement;

  /// No description provided for @pawHubNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get pawHubNotificationsTitle;

  /// No description provided for @pawHubMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get pawHubMarkAllRead;

  /// No description provided for @pawHubPostLike.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get pawHubPostLike;

  /// No description provided for @pawHubPostComment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get pawHubPostComment;

  /// No description provided for @pawHubPostShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get pawHubPostShare;

  /// No description provided for @pawHubPostSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get pawHubPostSaveAction;

  /// No description provided for @pawHubLikesCountPaw.
  ///
  /// In en, this message translates to:
  /// **'paw'**
  String get pawHubLikesCountPaw;

  /// No description provided for @pawHubLikesCountPaws.
  ///
  /// In en, this message translates to:
  /// **'paws'**
  String get pawHubLikesCountPaws;

  /// No description provided for @pawHubTaggedWith.
  ///
  /// In en, this message translates to:
  /// **'with {names}'**
  String pawHubTaggedWith(String names);

  /// No description provided for @pawHubPostEdited.
  ///
  /// In en, this message translates to:
  /// **' · Edited'**
  String get pawHubPostEdited;

  /// No description provided for @pawHubViewAllComments.
  ///
  /// In en, this message translates to:
  /// **'View all {count} comments'**
  String pawHubViewAllComments(int count);

  /// No description provided for @pawHubNewPostTitle.
  ///
  /// In en, this message translates to:
  /// **'New post'**
  String get pawHubNewPostTitle;

  /// No description provided for @pawHubShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get pawHubShare;

  /// No description provided for @pawHubPostingAs.
  ///
  /// In en, this message translates to:
  /// **'Posting as'**
  String get pawHubPostingAs;

  /// No description provided for @pawHubCaptionHint.
  ///
  /// In en, this message translates to:
  /// **'Write a caption… add #hashtags and @mentions'**
  String get pawHubCaptionHint;

  /// No description provided for @pawHubTagPets.
  ///
  /// In en, this message translates to:
  /// **'Tag pets'**
  String get pawHubTagPets;

  /// No description provided for @pawHubAddLocation.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get pawHubAddLocation;

  /// No description provided for @pawHubVisibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get pawHubVisibility;

  /// No description provided for @pawHubAddMedia.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get pawHubAddMedia;

  /// No description provided for @pawHubCoverPhoto.
  ///
  /// In en, this message translates to:
  /// **'Cover'**
  String get pawHubCoverPhoto;

  /// No description provided for @pawHubDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get pawHubDone;

  /// No description provided for @pawHubAddPhotoRequired.
  ///
  /// In en, this message translates to:
  /// **'Add at least one photo'**
  String get pawHubAddPhotoRequired;

  /// No description provided for @pawHubProfilePosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get pawHubProfilePosts;

  /// No description provided for @pawHubProfileFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get pawHubProfileFollowers;

  /// No description provided for @pawHubProfileFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get pawHubProfileFollowing;

  /// No description provided for @pawHubProfileManagePet.
  ///
  /// In en, this message translates to:
  /// **'Manage pet'**
  String get pawHubProfileManagePet;

  /// No description provided for @pawHubProfileSiblings.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s siblings'**
  String pawHubProfileSiblings(String name);

  /// No description provided for @pawHubProfileCaredForBy.
  ///
  /// In en, this message translates to:
  /// **'cared for by {owner}'**
  String pawHubProfileCaredForBy(String owner);

  /// No description provided for @communitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get communitiesTitle;

  /// No description provided for @communitiesEntryButton.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get communitiesEntryButton;

  /// No description provided for @communitiesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search communities'**
  String get communitiesSearchHint;

  /// No description provided for @communitiesMyCommunities.
  ///
  /// In en, this message translates to:
  /// **'My communities'**
  String get communitiesMyCommunities;

  /// No description provided for @communitiesTabDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get communitiesTabDiscover;

  /// No description provided for @communitiesTabMine.
  ///
  /// In en, this message translates to:
  /// **'My communities'**
  String get communitiesTabMine;

  /// No description provided for @communitiesMineEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t joined any communities'**
  String get communitiesMineEmptyTitle;

  /// No description provided for @communitiesMineEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore communities and join the ones your pet belongs in 🐾'**
  String get communitiesMineEmptyDescription;

  /// No description provided for @communitiesDiscoverRailTitle.
  ///
  /// In en, this message translates to:
  /// **'Communities to join'**
  String get communitiesDiscoverRailTitle;

  /// No description provided for @communitiesSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get communitiesSeeAll;

  /// No description provided for @communitiesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No communities yet'**
  String get communitiesEmptyTitle;

  /// No description provided for @communitiesEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Be the first to start one for your pack 🐾'**
  String get communitiesEmptyDescription;

  /// No description provided for @communitiesSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No communities match “{query}”'**
  String communitiesSearchEmpty(String query);

  /// No description provided for @communitiesCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load communities'**
  String get communitiesCouldNotLoad;

  /// No description provided for @communitiesRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get communitiesRetry;

  /// No description provided for @communitySortPopular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get communitySortPopular;

  /// No description provided for @communitySortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get communitySortNewest;

  /// No description provided for @communitySortMostActive.
  ///
  /// In en, this message translates to:
  /// **'Most active'**
  String get communitySortMostActive;

  /// No description provided for @communityCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get communityCategoryAll;

  /// No description provided for @communityCategoryBreedClub.
  ///
  /// In en, this message translates to:
  /// **'Breed club'**
  String get communityCategoryBreedClub;

  /// No description provided for @communityCategoryShelterRescues.
  ///
  /// In en, this message translates to:
  /// **'Shelters & rescues'**
  String get communityCategoryShelterRescues;

  /// No description provided for @communityCategoryBreeding.
  ///
  /// In en, this message translates to:
  /// **'Breeding'**
  String get communityCategoryBreeding;

  /// No description provided for @communityCategorySpecialNeeds.
  ///
  /// In en, this message translates to:
  /// **'Special needs'**
  String get communityCategorySpecialNeeds;

  /// No description provided for @communityCategoryActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get communityCategoryActivity;

  /// No description provided for @communityCategoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get communityCategoryHealth;

  /// No description provided for @communityCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get communityCategoryOther;

  /// No description provided for @communityJoin.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get communityJoin;

  /// No description provided for @communityJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get communityJoined;

  /// No description provided for @communityLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get communityLeave;

  /// No description provided for @communityManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get communityManage;

  /// No description provided for @communityEditAvatar.
  ///
  /// In en, this message translates to:
  /// **'Change profile photo'**
  String get communityEditAvatar;

  /// No description provided for @communityEditBanner.
  ///
  /// In en, this message translates to:
  /// **'Change cover photo'**
  String get communityEditBanner;

  /// No description provided for @communityImagesUpdating.
  ///
  /// In en, this message translates to:
  /// **'Updating…'**
  String get communityImagesUpdating;

  /// No description provided for @communityImagesUpdated.
  ///
  /// In en, this message translates to:
  /// **'Photo updated'**
  String get communityImagesUpdated;

  /// No description provided for @communityImagesUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update the photo. Please try again.'**
  String get communityImagesUpdateFailed;

  /// No description provided for @communityLeadBadge.
  ///
  /// In en, this message translates to:
  /// **'Lead'**
  String get communityLeadBadge;

  /// No description provided for @communityMembersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No members} =1{1 member} other{{count} members}}'**
  String communityMembersCount(int count);

  /// No description provided for @communityPostsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No posts} =1{1 post} other{{count} posts}}'**
  String communityPostsCount(int count);

  /// No description provided for @communityLedBy.
  ///
  /// In en, this message translates to:
  /// **'Led by {name}'**
  String communityLedBy(String name);

  /// No description provided for @communityJoinedToast.
  ///
  /// In en, this message translates to:
  /// **'Joined {name}'**
  String communityJoinedToast(String name);

  /// No description provided for @communityLeftToast.
  ///
  /// In en, this message translates to:
  /// **'Left {name}'**
  String communityLeftToast(String name);

  /// No description provided for @communityDetailAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get communityDetailAbout;

  /// No description provided for @communityDetailMembers.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get communityDetailMembers;

  /// No description provided for @communityStatPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get communityStatPosts;

  /// No description provided for @communityLeaderLabel.
  ///
  /// In en, this message translates to:
  /// **'Leader'**
  String get communityLeaderLabel;

  /// No description provided for @communityDetailFeedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get communityDetailFeedEmptyTitle;

  /// No description provided for @communityCreateFirstPost.
  ///
  /// In en, this message translates to:
  /// **'Create first post'**
  String get communityCreateFirstPost;

  /// No description provided for @communityDetailViewMembers.
  ///
  /// In en, this message translates to:
  /// **'View all members'**
  String get communityDetailViewMembers;

  /// No description provided for @communityDetailFeedEmpty.
  ///
  /// In en, this message translates to:
  /// **'No posts yet — be the first to share'**
  String get communityDetailFeedEmpty;

  /// No description provided for @communityDetailJoinToPost.
  ///
  /// In en, this message translates to:
  /// **'Join to post here'**
  String get communityDetailJoinToPost;

  /// No description provided for @communityLeaveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave community?'**
  String get communityLeaveConfirmTitle;

  /// No description provided for @communityLeaveConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You’ll stop seeing posts from {name}.'**
  String communityLeaveConfirmMessage(String name);

  /// No description provided for @communityDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete community?'**
  String get communityDeleteConfirmTitle;

  /// No description provided for @communityDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes {name} and all its posts. This can’t be undone.'**
  String communityDeleteConfirmMessage(String name);

  /// No description provided for @communityDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get communityDelete;

  /// No description provided for @communityDeletedToast.
  ///
  /// In en, this message translates to:
  /// **'Community deleted'**
  String get communityDeletedToast;

  /// No description provided for @communityCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get communityCancel;

  /// No description provided for @communityCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'New community'**
  String get communityCreateTitle;

  /// No description provided for @communityCreateNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get communityCreateNameLabel;

  /// No description provided for @communityCreateNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Golden Retriever Club'**
  String get communityCreateNameHint;

  /// No description provided for @communityCreateHandleLabel.
  ///
  /// In en, this message translates to:
  /// **'Handle'**
  String get communityCreateHandleLabel;

  /// No description provided for @communityCreateHandleHint.
  ///
  /// In en, this message translates to:
  /// **'golden-club'**
  String get communityCreateHandleHint;

  /// No description provided for @communityHandleChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking availability…'**
  String get communityHandleChecking;

  /// No description provided for @communityHandleAvailable.
  ///
  /// In en, this message translates to:
  /// **'Handle is available'**
  String get communityHandleAvailable;

  /// No description provided for @communityHandleTaken.
  ///
  /// In en, this message translates to:
  /// **'That handle is already taken'**
  String get communityHandleTaken;

  /// No description provided for @communityHandleInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use lowercase letters, numbers, and hyphens only'**
  String get communityHandleInvalid;

  /// No description provided for @communityCreateDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get communityCreateDescriptionLabel;

  /// No description provided for @communityCreateDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'What is this community about?'**
  String get communityCreateDescriptionHint;

  /// No description provided for @communityCreateCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get communityCreateCategoryLabel;

  /// No description provided for @communityCreateBannerLabel.
  ///
  /// In en, this message translates to:
  /// **'Add a cover photo'**
  String get communityCreateBannerLabel;

  /// No description provided for @communityCreateSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create community'**
  String get communityCreateSubmit;

  /// No description provided for @communityCreateNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get communityCreateNameRequired;

  /// No description provided for @communityCreateCategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please choose a category'**
  String get communityCreateCategoryRequired;

  /// No description provided for @communityCreatedToast.
  ///
  /// In en, this message translates to:
  /// **'Community created 🎉'**
  String get communityCreatedToast;

  /// No description provided for @communityCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create community. Please try again.'**
  String get communityCreateFailed;

  /// No description provided for @communityCreateAddPetFirst.
  ///
  /// In en, this message translates to:
  /// **'Add a pet first to lead a community'**
  String get communityCreateAddPetFirst;

  /// No description provided for @communityMembersTitle.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get communityMembersTitle;

  /// No description provided for @communityMemberRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get communityMemberRemove;

  /// No description provided for @communityMemberRemoveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove member?'**
  String get communityMemberRemoveConfirmTitle;

  /// No description provided for @communityMemberRemoveConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from this community?'**
  String communityMemberRemoveConfirmMessage(String name);

  /// No description provided for @communityMemberRemovedToast.
  ///
  /// In en, this message translates to:
  /// **'Member removed'**
  String get communityMemberRemovedToast;

  /// No description provided for @communityComposerPostingIn.
  ///
  /// In en, this message translates to:
  /// **'Posting in {name}'**
  String communityComposerPostingIn(String name);

  /// No description provided for @communityCreateSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get communityCreateSheetTitle;

  /// No description provided for @communityCreateSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to add?'**
  String get communityCreateSheetSubtitle;

  /// No description provided for @composeNewPost.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get composeNewPost;

  /// No description provided for @composeNewPostSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share a photo or video'**
  String get composeNewPostSubtitle;

  /// No description provided for @composeNewPoll.
  ///
  /// In en, this message translates to:
  /// **'New Poll'**
  String get composeNewPoll;

  /// No description provided for @composeNewPollSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask the community a question'**
  String get composeNewPollSubtitle;

  /// No description provided for @composeNewEvent.
  ///
  /// In en, this message translates to:
  /// **'New Event'**
  String get composeNewEvent;

  /// No description provided for @composeNewEventSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plan a meetup or gathering'**
  String get composeNewEventSubtitle;

  /// No description provided for @pollNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New poll'**
  String get pollNewTitle;

  /// No description provided for @pollQuestionLabel.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get pollQuestionLabel;

  /// No description provided for @pollQuestionHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Favourite dog park?'**
  String get pollQuestionHint;

  /// No description provided for @pollQuestionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a question'**
  String get pollQuestionRequired;

  /// No description provided for @pollDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get pollDescriptionLabel;

  /// No description provided for @pollDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add more context'**
  String get pollDescriptionHint;

  /// No description provided for @pollOptionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get pollOptionsLabel;

  /// No description provided for @pollOptionHint.
  ///
  /// In en, this message translates to:
  /// **'Option {number}'**
  String pollOptionHint(int number);

  /// No description provided for @pollAddOption.
  ///
  /// In en, this message translates to:
  /// **'Add option'**
  String get pollAddOption;

  /// No description provided for @pollOptionsMin.
  ///
  /// In en, this message translates to:
  /// **'Add at least 2 options'**
  String get pollOptionsMin;

  /// No description provided for @pollAllowMultiple.
  ///
  /// In en, this message translates to:
  /// **'Allow multiple choices'**
  String get pollAllowMultiple;

  /// No description provided for @pollAllowMultipleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let voters pick more than one option'**
  String get pollAllowMultipleSubtitle;

  /// No description provided for @pollSetExpiry.
  ///
  /// In en, this message translates to:
  /// **'Set a closing date'**
  String get pollSetExpiry;

  /// No description provided for @pollExpiryLabel.
  ///
  /// In en, this message translates to:
  /// **'Closes on'**
  String get pollExpiryLabel;

  /// No description provided for @pollNoExpiry.
  ///
  /// In en, this message translates to:
  /// **'No closing date'**
  String get pollNoExpiry;

  /// No description provided for @pollCreateSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create poll'**
  String get pollCreateSubmit;

  /// No description provided for @pollCreatedToast.
  ///
  /// In en, this message translates to:
  /// **'Poll created'**
  String get pollCreatedToast;

  /// No description provided for @pollCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create poll. Please try again.'**
  String get pollCreateFailed;

  /// No description provided for @pollTotalVotes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No votes yet} =1{1 vote} other{{count} votes}}'**
  String pollTotalVotes(int count);

  /// No description provided for @pollClosesIn.
  ///
  /// In en, this message translates to:
  /// **'Closes {when}'**
  String pollClosesIn(String when);

  /// No description provided for @pollClosed.
  ///
  /// In en, this message translates to:
  /// **'Poll closed'**
  String get pollClosed;

  /// No description provided for @pollJoinToVote.
  ///
  /// In en, this message translates to:
  /// **'Join to vote'**
  String get pollJoinToVote;

  /// No description provided for @pollTapToVote.
  ///
  /// In en, this message translates to:
  /// **'Tap an option to vote'**
  String get pollTapToVote;

  /// No description provided for @pollChangeVote.
  ///
  /// In en, this message translates to:
  /// **'Tap to change your vote'**
  String get pollChangeVote;

  /// No description provided for @pollRetractVote.
  ///
  /// In en, this message translates to:
  /// **'Remove my vote'**
  String get pollRetractVote;

  /// No description provided for @pollVoteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not record your vote'**
  String get pollVoteFailed;

  /// No description provided for @pollDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete poll?'**
  String get pollDeleteTitle;

  /// No description provided for @pollDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes the poll and its votes.'**
  String get pollDeleteMessage;

  /// No description provided for @pollDeletedToast.
  ///
  /// In en, this message translates to:
  /// **'Poll deleted'**
  String get pollDeletedToast;

  /// No description provided for @pollBadge.
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get pollBadge;

  /// No description provided for @eventNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New event'**
  String get eventNewTitle;

  /// No description provided for @eventTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get eventTitleLabel;

  /// No description provided for @eventTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Summer Paw Party'**
  String get eventTitleHint;

  /// No description provided for @eventTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get eventTitleRequired;

  /// No description provided for @eventDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get eventDescriptionLabel;

  /// No description provided for @eventDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s this event about?'**
  String get eventDescriptionHint;

  /// No description provided for @eventLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location (optional)'**
  String get eventLocationLabel;

  /// No description provided for @eventLocationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Central Park, NY'**
  String get eventLocationHint;

  /// No description provided for @eventStartsLabel.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get eventStartsLabel;

  /// No description provided for @eventEndsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ends (optional)'**
  String get eventEndsLabel;

  /// No description provided for @eventStartRequired.
  ///
  /// In en, this message translates to:
  /// **'Please choose a start date & time'**
  String get eventStartRequired;

  /// No description provided for @eventStartMustBeFuture.
  ///
  /// In en, this message translates to:
  /// **'Start must be in the future'**
  String get eventStartMustBeFuture;

  /// No description provided for @eventEndAfterStart.
  ///
  /// In en, this message translates to:
  /// **'End must be after the start'**
  String get eventEndAfterStart;

  /// No description provided for @eventCreateSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create event'**
  String get eventCreateSubmit;

  /// No description provided for @eventEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit event'**
  String get eventEditTitle;

  /// No description provided for @eventUpdateSubmit.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get eventUpdateSubmit;

  /// No description provided for @eventCreatedToast.
  ///
  /// In en, this message translates to:
  /// **'Event created'**
  String get eventCreatedToast;

  /// No description provided for @eventUpdatedToast.
  ///
  /// In en, this message translates to:
  /// **'Event updated'**
  String get eventUpdatedToast;

  /// No description provided for @eventCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create event. Please try again.'**
  String get eventCreateFailed;

  /// No description provided for @eventBadge.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get eventBadge;

  /// No description provided for @eventPast.
  ///
  /// In en, this message translates to:
  /// **'Past event'**
  String get eventPast;

  /// No description provided for @eventGoing.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get eventGoing;

  /// No description provided for @eventInterested.
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get eventInterested;

  /// No description provided for @eventCantGo.
  ///
  /// In en, this message translates to:
  /// **'Can\'t go'**
  String get eventCantGo;

  /// No description provided for @eventAttendingCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No one going yet} =1{1 going} other{{count} going}}'**
  String eventAttendingCount(int count);

  /// No description provided for @eventInterestedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} interested'**
  String eventInterestedCount(int count);

  /// No description provided for @eventJoinToRsvp.
  ///
  /// In en, this message translates to:
  /// **'Join to RSVP'**
  String get eventJoinToRsvp;

  /// No description provided for @eventViewAttendees.
  ///
  /// In en, this message translates to:
  /// **'View attendees'**
  String get eventViewAttendees;

  /// No description provided for @eventAttendeesTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendees'**
  String get eventAttendeesTitle;

  /// No description provided for @eventRsvpFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update your RSVP'**
  String get eventRsvpFailed;

  /// No description provided for @eventDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete event?'**
  String get eventDeleteTitle;

  /// No description provided for @eventDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes the event.'**
  String get eventDeleteMessage;

  /// No description provided for @eventDeletedToast.
  ///
  /// In en, this message translates to:
  /// **'Event deleted'**
  String get eventDeletedToast;

  /// No description provided for @eventEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit event'**
  String get eventEdit;

  /// No description provided for @eventTabAttending.
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get eventTabAttending;

  /// No description provided for @eventTabInterested.
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get eventTabInterested;

  /// No description provided for @eventTabDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get eventTabDeclined;

  /// No description provided for @eventNoAttendees.
  ///
  /// In en, this message translates to:
  /// **'No responses yet'**
  String get eventNoAttendees;

  /// No description provided for @eventDirections.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get eventDirections;

  /// No description provided for @eventDirectionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open maps'**
  String get eventDirectionsFailed;

  /// No description provided for @pawhubManagePet.
  ///
  /// In en, this message translates to:
  /// **'Manage pet'**
  String get pawhubManagePet;

  /// No description provided for @pawhubComposerAddToPost.
  ///
  /// In en, this message translates to:
  /// **'Add to your post'**
  String get pawhubComposerAddToPost;

  /// No description provided for @pawhubComposerAddToPostSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose where to pull your photo or video from'**
  String get pawhubComposerAddToPostSubtitle;

  /// No description provided for @pawhubComposerCameraSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get pawhubComposerCameraSubtitle;

  /// No description provided for @pawhubComposerGallerySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose from library'**
  String get pawhubComposerGallerySubtitle;

  /// No description provided for @pawhubComposerAddPhotosOrVideos.
  ///
  /// In en, this message translates to:
  /// **'Add photos or videos'**
  String get pawhubComposerAddPhotosOrVideos;

  /// No description provided for @pawhubComposerAddMedia.
  ///
  /// In en, this message translates to:
  /// **'Add media'**
  String get pawhubComposerAddMedia;

  /// No description provided for @pawhubComposerMediaLimit.
  ///
  /// In en, this message translates to:
  /// **'Up to 10 items'**
  String get pawhubComposerMediaLimit;

  /// No description provided for @pawhubComposerCoverBadge.
  ///
  /// In en, this message translates to:
  /// **'Cover'**
  String get pawhubComposerCoverBadge;

  /// No description provided for @pawhubComposerTagPetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your pets to this post'**
  String get pawhubComposerTagPetsSubtitle;

  /// No description provided for @pawhubComposerAddLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share where this happened'**
  String get pawhubComposerAddLocationSubtitle;

  /// No description provided for @pawhubComposerPostingIn.
  ///
  /// In en, this message translates to:
  /// **'Posting in'**
  String get pawhubComposerPostingIn;

  /// No description provided for @pawhubComposerVideoLengthError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read a selected video\'s length. Please remove and re-add it.'**
  String get pawhubComposerVideoLengthError;

  /// No description provided for @pawhubErrorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t pick image'**
  String get pawhubErrorPickingImage;

  /// No description provided for @pawhubErrorPickingMedia.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t pick media'**
  String get pawhubErrorPickingMedia;

  /// No description provided for @pawhubMyPostsLink.
  ///
  /// In en, this message translates to:
  /// **'My posts'**
  String get pawhubMyPostsLink;

  /// No description provided for @pawHubActingAs.
  ///
  /// In en, this message translates to:
  /// **'Acting as'**
  String get pawHubActingAs;

  /// No description provided for @pawhubAlertReward.
  ///
  /// In en, this message translates to:
  /// **'\${amount} reward'**
  String pawhubAlertReward(int amount);

  /// No description provided for @pawhubEditComment.
  ///
  /// In en, this message translates to:
  /// **'Edit comment'**
  String get pawhubEditComment;

  /// No description provided for @pawhubCommentsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} Comments'**
  String pawhubCommentsCountLabel(int count);

  /// No description provided for @pawhubCouldNotLoadComments.
  ///
  /// In en, this message translates to:
  /// **'Could not load comments'**
  String get pawhubCouldNotLoadComments;

  /// No description provided for @pawhubCommentOptionDeleteComment.
  ///
  /// In en, this message translates to:
  /// **'Delete comment'**
  String get pawhubCommentOptionDeleteComment;

  /// No description provided for @pawhubCommentOptionReportComment.
  ///
  /// In en, this message translates to:
  /// **'Report comment'**
  String get pawhubCommentOptionReportComment;

  /// No description provided for @pawhubBlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Pets'**
  String get pawhubBlockedTitle;

  /// No description provided for @pawhubBlockedFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load blocked pets'**
  String get pawhubBlockedFailed;

  /// No description provided for @pawhubBlockedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No blocked pets'**
  String get pawhubBlockedEmptyTitle;

  /// No description provided for @pawhubBlockedEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Pets you block won\'t appear in your feed'**
  String get pawhubBlockedEmptyMessage;

  /// No description provided for @pawhubUnblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get pawhubUnblock;

  /// No description provided for @pawhubUnblockConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Unblock {name}?'**
  String pawhubUnblockConfirmTitle(String name);

  /// No description provided for @pawhubUnblockConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'They\'ll be able to see your posts again.'**
  String get pawhubUnblockConfirmMessage;

  /// No description provided for @pawhubUnfollowConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Unfollow {name}?'**
  String pawhubUnfollowConfirmTitle(String name);

  /// No description provided for @pawhubUnfollowConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You won\'t see {name}\'s posts in your feed'**
  String pawhubUnfollowConfirmMessage(String name);

  /// No description provided for @pawhubUnfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get pawhubUnfollow;

  /// No description provided for @pawhubMyPostsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Posts'**
  String get pawhubMyPostsTitle;

  /// No description provided for @pawhubMyPostsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load your posts'**
  String get pawhubMyPostsFailed;

  /// No description provided for @pawhubMyPostsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get pawhubMyPostsEmptyTitle;

  /// No description provided for @pawhubMyPostsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Share your first post with the community'**
  String get pawhubMyPostsEmptyMessage;

  /// No description provided for @pawhubDeletePostTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete post?'**
  String get pawhubDeletePostTitle;

  /// No description provided for @pawhubDeletePostMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get pawhubDeletePostMessage;

  /// No description provided for @pawhubSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get pawhubSavedTitle;

  /// No description provided for @pawhubSavedFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load saved posts'**
  String get pawhubSavedFailed;

  /// No description provided for @pawhubSavedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved posts yet'**
  String get pawhubSavedEmptyTitle;

  /// No description provided for @pawhubSavedEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark on any post to save it'**
  String get pawhubSavedEmptyMessage;

  /// No description provided for @pawhubFollowersTitle.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get pawhubFollowersTitle;

  /// No description provided for @pawhubFollowersTitleCount.
  ///
  /// In en, this message translates to:
  /// **'Followers ({count})'**
  String pawhubFollowersTitleCount(int count);

  /// No description provided for @pawhubFollowersFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load followers'**
  String get pawhubFollowersFailed;

  /// No description provided for @pawhubFollowersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No followers yet'**
  String get pawhubFollowersEmptyTitle;

  /// No description provided for @pawhubFollowingTitle.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get pawhubFollowingTitle;

  /// No description provided for @pawhubFollowingTitleCount.
  ///
  /// In en, this message translates to:
  /// **'Following ({count})'**
  String pawhubFollowingTitleCount(int count);

  /// No description provided for @pawhubFollowingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load following'**
  String get pawhubFollowingFailed;

  /// No description provided for @pawhubFollowingEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Not following anyone yet'**
  String get pawhubFollowingEmptyTitle;

  /// No description provided for @pawhubTrendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get pawhubTrendingTitle;

  /// No description provided for @pawhubTrendingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load trending'**
  String get pawhubTrendingFailed;

  /// No description provided for @pawhubTrendingHashtags.
  ///
  /// In en, this message translates to:
  /// **'Trending Hashtags'**
  String get pawhubTrendingHashtags;

  /// No description provided for @pawhubTopPosts.
  ///
  /// In en, this message translates to:
  /// **'Top Posts'**
  String get pawhubTopPosts;

  /// No description provided for @pawhubHashtagPostsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} posts'**
  String pawhubHashtagPostsCount(int count);

  /// No description provided for @pawhubSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search PawHub'**
  String get pawhubSearchTitle;

  /// No description provided for @pawhubSearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find pets, posts, or hashtags'**
  String get pawhubSearchSubtitle;

  /// No description provided for @pawhubSearchScopeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get pawhubSearchScopeAll;

  /// No description provided for @pawhubSearchScopePosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get pawhubSearchScopePosts;

  /// No description provided for @pawhubSearchScopeHashtags.
  ///
  /// In en, this message translates to:
  /// **'Hashtags'**
  String get pawhubSearchScopeHashtags;

  /// No description provided for @pawhubSearchScopePets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get pawhubSearchScopePets;

  /// No description provided for @pawhubSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String pawhubSearchNoResults(String query);

  /// No description provided for @pawhubSearchTryDifferent.
  ///
  /// In en, this message translates to:
  /// **'Try a different keyword'**
  String get pawhubSearchTryDifferent;

  /// No description provided for @pawhubSearchSectionPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get pawhubSearchSectionPets;

  /// No description provided for @pawhubSearchSectionHashtags.
  ///
  /// In en, this message translates to:
  /// **'Hashtags'**
  String get pawhubSearchSectionHashtags;

  /// No description provided for @pawhubSearchSectionPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get pawhubSearchSectionPosts;

  /// No description provided for @pawhubSearchPostBy.
  ///
  /// In en, this message translates to:
  /// **'by {name}'**
  String pawhubSearchPostBy(String name);

  /// No description provided for @pawhubHashtagFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load posts'**
  String get pawhubHashtagFailed;

  /// No description provided for @pawhubHashtagEmpty.
  ///
  /// In en, this message translates to:
  /// **'No posts for #{hashtag} yet'**
  String pawhubHashtagEmpty(String hashtag);

  /// No description provided for @pawhubPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get pawhubPostTitle;

  /// No description provided for @pawhubPostFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load post'**
  String get pawhubPostFailed;

  /// No description provided for @pawhubProfileFailedPosts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load posts'**
  String get pawhubProfileFailedPosts;

  /// No description provided for @pawhubProfileNoPosts.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get pawhubProfileNoPosts;

  /// No description provided for @pawhubTagPetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tag pets'**
  String get pawhubTagPetsTitle;

  /// No description provided for @pawhubTagPetsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search pets by name…'**
  String get pawhubTagPetsSearchHint;

  /// No description provided for @pawhubTagPetsNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No pets found.'**
  String get pawhubTagPetsNoMatch;

  /// No description provided for @pawhubTagPetsResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get pawhubTagPetsResults;

  /// No description provided for @pawhubTagPetsTaggedCount.
  ///
  /// In en, this message translates to:
  /// **'Tagged ({count})'**
  String pawhubTagPetsTaggedCount(int count);

  /// No description provided for @pawhubTagPetsMyPets.
  ///
  /// In en, this message translates to:
  /// **'My pets'**
  String get pawhubTagPetsMyPets;

  /// No description provided for @pawhubTagPetsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no pets to tag yet.'**
  String get pawhubTagPetsEmpty;

  /// No description provided for @pawhubDiscoverEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to discover yet'**
  String get pawhubDiscoverEmptyTitle;

  /// No description provided for @pawhubDiscoverEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'New posts from the community will show up here soon 🐾'**
  String get pawhubDiscoverEmptyMessage;

  /// No description provided for @pawhubSavedPostsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Saved posts'**
  String get pawhubSavedPostsTooltip;

  /// No description provided for @pawhubComposerLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Search or tap the map'**
  String get pawhubComposerLocationHint;

  /// No description provided for @locationResolving.
  ///
  /// In en, this message translates to:
  /// **'Finding address…'**
  String get locationResolving;

  /// No description provided for @pawhubLike.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get pawhubLike;

  /// No description provided for @pawhubComment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get pawhubComment;

  /// No description provided for @communityMembersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No members yet'**
  String get communityMembersEmptyTitle;

  /// No description provided for @communityMembersEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Be the first to join this community.'**
  String get communityMembersEmptyMessage;

  /// No description provided for @pawhubTrendingEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing trending yet'**
  String get pawhubTrendingEmptyTitle;

  /// No description provided for @pawhubTrendingEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Popular hashtags and posts will appear here as the community grows.'**
  String get pawhubTrendingEmptyMessage;

  /// No description provided for @pawhubBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get pawhubBack;

  /// No description provided for @pawhubMoreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get pawhubMoreOptions;

  /// No description provided for @pawhubRemoveOption.
  ///
  /// In en, this message translates to:
  /// **'Remove option'**
  String get pawhubRemoveOption;

  /// No description provided for @pawhubRemoveTag.
  ///
  /// In en, this message translates to:
  /// **'Remove tag'**
  String get pawhubRemoveTag;

  /// No description provided for @pawhubViewPost.
  ///
  /// In en, this message translates to:
  /// **'View post'**
  String get pawhubViewPost;

  /// No description provided for @pawhubViewProfile.
  ///
  /// In en, this message translates to:
  /// **'View profile'**
  String get pawhubViewProfile;

  /// No description provided for @pawhubExpandMap.
  ///
  /// In en, this message translates to:
  /// **'Expand map'**
  String get pawhubExpandMap;

  /// No description provided for @pawhubComposerSetCover.
  ///
  /// In en, this message translates to:
  /// **'Set cover'**
  String get pawhubComposerSetCover;

  /// No description provided for @pawhubComposerChangeCover.
  ///
  /// In en, this message translates to:
  /// **'Change cover'**
  String get pawhubComposerChangeCover;

  /// No description provided for @pawhubComposerLocationFieldHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Beirut, Lebanon'**
  String get pawhubComposerLocationFieldHint;

  /// No description provided for @pawhubComposerTaggedSummary.
  ///
  /// In en, this message translates to:
  /// **'{name} & {count, plural, =1{1 more} other{{count} more}}'**
  String pawhubComposerTaggedSummary(String name, int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
