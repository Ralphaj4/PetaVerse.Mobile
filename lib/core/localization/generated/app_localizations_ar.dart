// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'بيتافيرس';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCommunity => 'المجتمع';

  @override
  String get navCare => 'PawCare';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get aiAssistant => 'المساعد الذكي';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get continueButton => 'متابعة';

  @override
  String get onboardingTitle1a => 'مرحباً بك في';

  @override
  String get onboardingTitle1b => 'بيتافيرس';

  @override
  String get onboardingDesc1 =>
      'رفيقك الشامل لكل ما يحتاجه حيوانك الأليف — صحة ورعاية والمزيد.';

  @override
  String get onboardingTitle2a => 'تتبع الصحة و';

  @override
  String get onboardingTitle2b => 'التذكيرات';

  @override
  String get onboardingDesc2 =>
      'لا تفوّت أي تطعيم أو زيارة بيطرية أو دواء مع التذكيرات الذكية.';

  @override
  String get onboardingTitle3a => 'تواصل مع';

  @override
  String get onboardingTitle3b => 'المجتمع';

  @override
  String get onboardingDesc3 =>
      'شارك اللحظات، واعثر على الحيوانات المفقودة، واكتشف الخدمات القريبة منك.';

  @override
  String get loginTitle1 => 'مرحباً';

  @override
  String get loginTitle2 => 'بعودتك!';

  @override
  String get loginSubtitle => 'سجّل الدخول لمواصلة الاعتناء بأصدقائك الأليفين.';

  @override
  String get mobileNumber => 'رقم الهاتف المحمول';

  @override
  String get password => 'كلمة المرور';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get noAccountPrompt => 'ليس لديك حساب؟';

  @override
  String get joinTheFamily => 'انضم إلى العائلة';

  @override
  String get registerTitle1 => 'انضم إلى';

  @override
  String get registerTitle2 => 'العائلة';

  @override
  String get registerSubtitle =>
      'أنشئ حساباً وامنح حيواناتك الأليفة الرعاية التي تستحقها.';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get emailOptional => 'البريد الإلكتروني (اختياري)';

  @override
  String get invalidEmail => 'أدخل عنوان بريد إلكتروني صالح';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get haveAccountPrompt => 'لديك حساب بالفعل؟';

  @override
  String get logInLink => 'تسجيل الدخول';

  @override
  String get otpTitle1 => 'تحقق من';

  @override
  String get otpTitle2 => 'رقمك';

  @override
  String otpSubtitle(String phone) {
    return 'أدخل الرمز المكوّن من 4 أرقام المرسل إلى $phone';
  }

  @override
  String get verify => 'تحقق';

  @override
  String get resendCode => 'إعادة إرسال الرمز';

  @override
  String resendIn(int seconds) {
    return 'إعادة الإرسال خلال $seconds ث';
  }

  @override
  String get goodMorning => 'صباح الخير 👋';

  @override
  String get goodAfternoon => 'مساء الخير 👋';

  @override
  String get goodEvening => 'مساء الخير 👋';

  @override
  String petDoingGreat(String petName) {
    return '$petName بحالة رائعة اليوم! 🐾';
  }

  @override
  String get healthScore => 'مؤشر الصحة';

  @override
  String get healthExcellent => 'ممتاز';

  @override
  String get nextVisit => 'الزيارة القادمة';

  @override
  String get statHealth => 'الصحة';

  @override
  String get statNutrition => 'التغذية';

  @override
  String get statActivity => 'النشاط';

  @override
  String get statVaccines => 'اللقاحات';

  @override
  String get statGreat => 'رائعة';

  @override
  String get statGood => 'جيدة';

  @override
  String stepsCount(int steps) {
    final intl.NumberFormat stepsNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String stepsString = stepsNumberFormat.format(steps);

    return '$stepsString خطوة';
  }

  @override
  String get upToDate => 'محدّثة';

  @override
  String get upcoming => 'القادمة';

  @override
  String get quickActions => 'إجراءات';

  @override
  String get bookAppointment => 'حجز موعد';

  @override
  String get addRecord => 'إضافة سجل';

  @override
  String get lostAndFound => 'الحيوانات المفقودة';

  @override
  String get lostAndFoundDashboard => 'لوحة الحيوانات المفقودة';

  @override
  String lostAndFoundSubtitle(int count) {
    return '$count تنبيه في دائرة 5 أميال';
  }

  @override
  String get liveMapView => 'خريطة مباشرة';

  @override
  String get recentAlerts => 'التنبيهات الأخيرة';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterLost => 'مفقود';

  @override
  String get filterFound => 'موجود';

  @override
  String get badgeLost => 'مفقود';

  @override
  String get badgeFound => 'موجود';

  @override
  String timeAgo(int n) {
    return 'منذ $nس';
  }

  @override
  String get contactOwner => 'تواصل مع المالك';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get reportLostPet => 'الإبلاغ عن حيوان مفقود';

  @override
  String get howToHelp => 'كيف تساعد؟';

  @override
  String get howToHelpBody =>
      'انضم إلى فريق المتطوعين وابقَ على اطلاع بالحيوانات المفقودة في محيطك.';

  @override
  String get becomeVolunteer => 'كن متطوعاً';

  @override
  String activeVolunteers(int count) {
    return '$count متطوع نشط';
  }

  @override
  String get medicationsReminders => 'الأدوية والتذكيرات';

  @override
  String get healthTracker => 'متتبع الصحة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get premiumMember => 'عضو مميّز';

  @override
  String get petProfiles => 'ملفات الحيوانات';

  @override
  String get addPet => 'إضافة حيوان';

  @override
  String get petActive => 'نشط';

  @override
  String petAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years سنة',
      few: '$years سنوات',
      two: 'سنتان',
      one: 'سنة',
    );
    return '$_temp0';
  }

  @override
  String get accountSettings => 'إعدادات الحساب';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get securityPrivacy => 'الأمان والخصوصية';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get notificationsSupport => 'الإشعارات والدعم';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get language => 'اللغة';

  @override
  String get changeLanguage => 'اللغة';

  @override
  String get changeLanguageSubtitle =>
      'اختر اللغة التي تريد استخدامها في التطبيق';

  @override
  String get privacySettings => 'إعدادات الخصوصية';

  @override
  String get support => 'الدعم';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get reportProblem => 'الإبلاغ عن مشكلة';

  @override
  String get termsPrivacy => 'الشروط والخصوصية';

  @override
  String get termsConditions => 'الشروط والأحكام';

  @override
  String get toggleOn => 'مفعّل';

  @override
  String get toggleOff => 'معطّل';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get logOutConfirmTitle => 'تسجيل الخروج؟';

  @override
  String get logOutConfirmMessage =>
      'ستحتاج إلى تسجيل الدخول مرة أخرى للوصول إلى حيواناتك وتذكيراتك.';

  @override
  String get logOutConfirm => 'نعم، تسجيل الخروج';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordTitle1 => 'إعادة تعيين';

  @override
  String get forgotPasswordTitle2 => 'كلمة المرور';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل رقم هاتفك المحمول وسنرسل لك رمزاً لإعادة تعيين كلمة المرور.';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get resetPasswordTitle1 => 'كلمة مرور';

  @override
  String get resetPasswordTitle2 => 'جديدة';

  @override
  String resetPasswordSubtitle(String phone) {
    return 'أدخل الرمز المرسل إلى $phone واختر كلمة مرور جديدة.';
  }

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get resetPasswordAction => 'إعادة تعيين';

  @override
  String get passwordResetSuccess =>
      'تمت إعادة تعيين كلمة المرور. سجّل الدخول بكلمة المرور الجديدة.';

  @override
  String get security => 'الأمان';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changePasswordSubtitle =>
      'أدخل كلمة المرور الحالية واختر كلمة مرور جديدة.';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get passwordChangedSuccess => 'تم تغيير كلمة المرور.';

  @override
  String appVersion(String version, String build) {
    return 'الإصدار $version (بناء $build)';
  }

  @override
  String get aiAssistantTitle => 'مساعد PawBot';

  @override
  String get aiAskHint => 'اسأل PawBot أي شيء…';

  @override
  String get aiQuickFaqs => 'الأسئلة الشائعة';

  @override
  String get aiQuickBreedInfo => 'معلومات السلالة';

  @override
  String get aiQuickSymptomChecker => 'فحص الأعراض';

  @override
  String get aiHealthVaultTitle => 'خزينة الصحة';

  @override
  String aiHealthVaultSubtitle(String petName) {
    return 'احفظ سجلات التطعيم والتاريخ الطبي لـ $petName.';
  }

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get invalidPhone => 'أدخل رقم هاتف محمول صالح';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';

  @override
  String get delete => 'حذف';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get errorTitle => 'حدث خطأ ما';

  @override
  String get errorNetwork =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get errorUnauthorized =>
      'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String get errorForbidden => 'ليس لديك إذن للقيام بذلك.';

  @override
  String get errorValidation =>
      'بعض المعلومات غير صالحة. يرجى المراجعة والمحاولة مرة أخرى.';

  @override
  String get errorServer => 'تواجه خوادمنا مشكلة. يرجى المحاولة لاحقاً.';

  @override
  String get errorCache => 'تعذر تحميل البيانات المحفوظة.';

  @override
  String get errorUnknown => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';

  @override
  String get errorNotFound => 'لم نتمكن من العثور على حساب بهذه المعلومات.';

  @override
  String get errorPhoneNotRegistered => 'لا يوجد حساب مسجّل بهذا الرقم.';

  @override
  String get petOnboardingTitleTop => 'أضف';

  @override
  String get petOnboardingTitleAccent => 'حيوانك الأول';

  @override
  String get petOnboardingSubtitle =>
      'أخبرنا عن رفيقك لنخصّص له الرعاية الصحية والتذكيرات والعناية.';

  @override
  String get petOnboardingAction => 'إضافة حيوان أليف';

  @override
  String get petOnboardingLoading => 'جارٍ التحقق من حيواناتك الأليفة…';

  @override
  String get selectPetTitle => 'اختر حيوانًا أليفًا';

  @override
  String get selectPetSubtitle => 'بمن نعتني اليوم؟';

  @override
  String get createPetTitle => 'إضافة حيوان أليف';

  @override
  String get createPetSubtitle => 'أخبرنا عن صديقك الجديد';

  @override
  String get createPetName => 'اسم الحيوان';

  @override
  String get createPetSpecies => 'نوع الحيوان';

  @override
  String get createPetBreed => 'السلالة';

  @override
  String get createPetSelectSpeciesFirst => 'اختر نوع الحيوان أولاً';

  @override
  String get createPetDateOfBirth => 'تاريخ الميلاد';

  @override
  String get createPetGender => 'الجنس';

  @override
  String get genderMale => 'ذكر';

  @override
  String get genderFemale => 'أنثى';

  @override
  String get genderUnknown => 'غير معروف';

  @override
  String get createPetSubmit => 'حفظ الحيوان';

  @override
  String createPetSuccess(String name) {
    return 'تمت إضافة $name!';
  }

  @override
  String get petDetailSetActive => 'تعيين كنشط';

  @override
  String get petDetailAlreadyActive => 'نشط حالياً';

  @override
  String get petDetailGender => 'الجنس';

  @override
  String get petDetailDateOfBirth => 'تاريخ الميلاد';

  @override
  String get petDetailBreed => 'السلالة';

  @override
  String get petDetailPelage => 'الفراء';

  @override
  String get petDetailMicrochip => 'الرقاقة';

  @override
  String get petDetailMicrochipLocation => 'الموقع';

  @override
  String get petDetailSterilization => 'التعقيم';

  @override
  String get petDetailSterilizationDate => 'التاريخ';

  @override
  String petDetailAge(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years سنوات',
      one: 'سنة واحدة',
    );
    return '$_temp0';
  }

  @override
  String viewAllPets(int count) {
    return 'عرض جميع الحيوانات ($count)';
  }

  @override
  String get createPetAdditionalInfo => 'معلومات إضافية';

  @override
  String get createPetAdditionalInfoSubtitle =>
      'اختياري — يمكنك إضافتها لاحقاً';

  @override
  String get createPetPelage => 'لون الفراء';

  @override
  String get createPetMicrochipNumber => 'رقم الرقاقة';

  @override
  String get createPetMicrochipLocation => 'موقع الرقاقة';

  @override
  String get createPetSterilizationStatus => 'حالة التعقيم';

  @override
  String get sterilizationStatusIntact => 'سليم';

  @override
  String get sterilizationStatusNeutered => 'مُخصى';

  @override
  String get sterilizationStatusSpayed => 'مُعقَّمة';

  @override
  String get sterilizationStatusUnknown => 'غير معروف';

  @override
  String get createPetSterilizationDate => 'تاريخ التعقيم';

  @override
  String get editPetTitle => 'تعديل الحيوان الأليف';

  @override
  String get editPetSave => 'حفظ التغييرات';

  @override
  String get deletePetTitle => 'حذف ملف الحيوان الأليف';

  @override
  String deletePetMessage(String petName) {
    return 'ملف هل أنت متأكد أنك تريد حذف $petName؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get deletePetConfirm => 'حذف';

  @override
  String get petUpdatedSuccess => 'تم تحديث الحيوان الأليف بنجاح';

  @override
  String get petDeletedSuccess => 'تم حذف الحيوان الأليف';

  @override
  String get petDetailTabOverview => 'نظرة عامة';

  @override
  String get petDetailTabHealth => 'الصحة';

  @override
  String get petDetailTabRecords => 'السجلات';

  @override
  String get petDetailTabTimeline => 'الجدول الزمني';

  @override
  String get petDetailActionEdit => 'تعديل';

  @override
  String get petDetailActionBook => 'حجز';

  @override
  String get petDetailActionShare => 'Pet Vision';

  @override
  String get petDetailActionMore => 'المزيد';

  @override
  String get petDetailDateAdded => 'تاريخ الإضافة';

  @override
  String petDetailProfileCompleteTitle(String petName) {
    return '$petName جاهز!';
  }

  @override
  String get petDetailProfileCompleteSubtitle =>
      'ملف حيوانك الأليف مكتمل والمعلومات محدَّثة.';

  @override
  String get microchipCopied => 'تم نسخ رقم الرقاقة';

  @override
  String get photoSavedToGallery => 'تم حفظ الصورة في المعرض';

  @override
  String get couldNotSavePhoto => 'تعذر حفظ الصورة';

  @override
  String get didYouKnow => 'هل تعلم؟';

  @override
  String get gotIt => 'حسناً';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get personalInformationSubtitle =>
      'إدارة بياناتك الشخصية ومعلومات الاتصال';

  @override
  String get basicInformation => 'المعلومات الأساسية';

  @override
  String get contactDetails => 'معلومات الاتصال';

  @override
  String get accountDetails => 'تفاصيل الحساب';

  @override
  String get verified => 'موثَّق';

  @override
  String get unverified => 'غير موثَّق';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get noEmailAdded => 'لم تتم إضافة بريد إلكتروني';

  @override
  String memberSince(String date) {
    return 'عضو منذ $date';
  }

  @override
  String emailPendingVerification(String email) {
    return 'في انتظار التحقق: $email';
  }

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get photoUpdated => 'تم تحديث صورة الملف الشخصي';

  @override
  String get photoUploadFailed => 'تعذر تحديث صورتك. يرجى المحاولة مرة أخرى.';

  @override
  String get skipForNow => 'تخطٍ الآن';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get petAvatarSetupTitle => 'إضافة صورة';

  @override
  String get petAvatarSetupSubtitle =>
      'أضف صورة لحيوانك الأليف. هذا اختياري ويمكنك تغييره في أي وقت.';

  @override
  String get petAvatarUploadHint => 'تحميل صورة';
}
