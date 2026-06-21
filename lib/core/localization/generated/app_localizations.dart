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
  /// **'Good Morning, {name} 👋'**
  String goodMorning(String name);

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon, {name} 👋'**
  String goodAfternoon(String name);

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening, {name} 👋'**
  String goodEvening(String name);

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
  /// **'{count} active alerts within 5 miles'**
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

  /// No description provided for @contactOwner.
  ///
  /// In en, this message translates to:
  /// **'Contact Owner'**
  String get contactOwner;

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

  /// No description provided for @activeVolunteers.
  ///
  /// In en, this message translates to:
  /// **'{count} Active Volunteers'**
  String activeVolunteers(int count);

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

  /// No description provided for @petDetailPelage.
  ///
  /// In en, this message translates to:
  /// **'Coat'**
  String get petDetailPelage;

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

  /// No description provided for @viewAllPets.
  ///
  /// In en, this message translates to:
  /// **'View all {count} pets'**
  String viewAllPets(int count);

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

  /// No description provided for @createPetPelage.
  ///
  /// In en, this message translates to:
  /// **'Coat / Fur Color'**
  String get createPetPelage;

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

  /// No description provided for @sterilizationStatusIntact.
  ///
  /// In en, this message translates to:
  /// **'Intact'**
  String get sterilizationStatusIntact;

  /// No description provided for @sterilizationStatusNeutered.
  ///
  /// In en, this message translates to:
  /// **'Neutered'**
  String get sterilizationStatusNeutered;

  /// No description provided for @sterilizationStatusSpayed.
  ///
  /// In en, this message translates to:
  /// **'Spayed'**
  String get sterilizationStatusSpayed;

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
