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
  String get communityTabFeed => 'الموجز';

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
    return '$count تنبيه في دائرة 10 كم';
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
  String get lostFoundDetailTitle => 'تفاصيل البلاغ';

  @override
  String get reportReporter => 'أبلغ عنه';

  @override
  String get reportViewOnMap => 'عرض على الخريطة';

  @override
  String get contactOwner => 'تواصل مع المالك';

  @override
  String get contactOwnerTitle => 'تواصل مع المالك';

  @override
  String contactOwnerSubtitle(String petName) {
    return 'تواصل بشأن $petName.';
  }

  @override
  String get contactCall => 'اتصال';

  @override
  String get contactCallSubtitle => 'بدء مكالمة هاتفية';

  @override
  String get contactWhatsApp => 'واتساب';

  @override
  String get contactWhatsAppSubtitle => 'المراسلة عبر واتساب';

  @override
  String get contactNoPhone => 'لا يوجد رقم تواصل لهذا البلاغ.';

  @override
  String get contactLaunchError => 'تعذّر فتح التطبيق. يرجى المحاولة مرة أخرى.';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get reportLostPet => 'الإبلاغ عن حيوان مفقود';

  @override
  String get reportLostPetTitle => 'الإبلاغ عن حيوان مفقود';

  @override
  String get reportLostPetSubtitle => 'اختر حيوانك ومكان آخر مشاهدة له.';

  @override
  String get reportSelectPet => 'أي حيوان مفقود؟';

  @override
  String get reportSelectPetHint => 'اختر حيواناً';

  @override
  String get reportNoPets =>
      'ليس لديك حيوانات للإبلاغ عنها. أضف حيواناً أولاً.';

  @override
  String get reportDescription => 'الوصف';

  @override
  String get reportDescriptionHint => 'الطوق، علامات مميزة، السلوك…';

  @override
  String get reportLastSeenAddress => 'عنوان آخر مشاهدة';

  @override
  String get reportLastSeenAddressHint => 'مثال: حي صن ست، شارع بارك';

  @override
  String get reportLocation => 'آخر موقع معروف';

  @override
  String get reportLocationHint => 'انقر على الخريطة لوضع علامة';

  @override
  String get reportLocationRequired => 'انقر على الخريطة لتحديد الموقع';

  @override
  String get reportReward => 'المكافأة (اختياري)';

  @override
  String get reportRewardLabel => 'المكافأة';

  @override
  String get reportRewardHint => '0–999';

  @override
  String get reportRewardRange => 'يجب أن تكون المكافأة بين 0 و 999';

  @override
  String reportRewardBadge(int amount) {
    return 'المكافأة: \$$amount';
  }

  @override
  String get reportSubmit => 'متابعة';

  @override
  String get reportHeaderSubtitle => 'ساعد في لمّ شمل الحيوانات مع عائلاتها.';

  @override
  String get reportRewardHelper => 'تقديم مكافأة قد يزيد من فرص لمّ الشمل.';

  @override
  String get reportUseMyLocation => 'استخدام موقعي';

  @override
  String get reportCreatedSuccess => 'تم إنشاء البلاغ';

  @override
  String get deleteReportTitle => 'حذف البلاغ؟';

  @override
  String deleteReportMessage(String petName) {
    return 'سيؤدي هذا إلى إزالة بلاغ $petName من الخريطة والقوائم. لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get deleteReportSuccess => 'تم حذف البلاغ';

  @override
  String get reportSpeciesUnresolved =>
      'تعذر تحديد نوع حيوانك. يرجى المحاولة مرة أخرى.';

  @override
  String get reportTitle => 'الإبلاغ عن حيوان';

  @override
  String get reportTypeLost => 'مفقود';

  @override
  String get reportTypeFound => 'موجود';

  @override
  String get reportLostSubtitle => 'اختر حيوانك ومكان آخر مشاهدة له.';

  @override
  String get reportFoundSubtitle =>
      'صف الحيوان الذي وجدته والمكان الذي رأيته فيه.';

  @override
  String get reportFoundName => 'اسم الحيوان';

  @override
  String get reportFoundNameHint => 'اسم أو لقب (مثال: «قط برتقالي»)';

  @override
  String get reportFoundSpecies => 'النوع';

  @override
  String get reportFoundBreed => 'السلالة';

  @override
  String get reportFoundSelectSpeciesFirst => 'اختر النوع أولاً';

  @override
  String get reportPhoto => 'صورة';

  @override
  String get reportPhotoHint => 'أضف صورة واضحة للحيوان';

  @override
  String get reportPhotoRemove => 'إزالة الصورة';

  @override
  String get reportPhotoRequired => 'الصورة مطلوبة لبلاغات العثور';

  @override
  String get howToHelp => 'كيف تساعد؟';

  @override
  String get howToHelpBody =>
      'انضم إلى فريق المتطوعين وابقَ على اطلاع بالحيوانات المفقودة في محيطك.';

  @override
  String get becomeVolunteer => 'كن متطوعاً';

  @override
  String get alreadyVolunteer => 'أنت متطوع';

  @override
  String get becameVolunteer => 'أنت الآن متطوع';

  @override
  String get leftVolunteer => 'لقد غادرت فريق المتطوعين';

  @override
  String get leaveVolunteerAction => 'مغادرة';

  @override
  String get leaveVolunteerTitle => 'مغادرة فريق المتطوعين؟';

  @override
  String get leaveVolunteerMessage =>
      'لن تتلقى تنبيهات بعد الآن عند الإبلاغ عن حيوان مفقود بالقرب منك.';

  @override
  String get leaveVolunteerConfirm => 'مغادرة';

  @override
  String get lostAndFoundNoAlerts => 'لا توجد تنبيهات قريبة حالياً.';

  @override
  String activeVolunteers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count متطوعين نشطين',
      one: 'متطوع نشط واحد',
    );
    return '$_temp0';
  }

  @override
  String get volunteerThankYou => 'شكراً لك على إحداث فرق!';

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
  String get confirm => 'تأكيد';

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
  String get errorRateLimit =>
      'أنت تقوم بذلك بسرعة كبيرة. يرجى التمهل والمحاولة مرة أخرى.';

  @override
  String errorRateLimitRetry(int seconds) {
    return 'طلبات كثيرة جداً. حاول مرة أخرى خلال $seconds ثانية.';
  }

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
  String get petDetailSize => 'الحجم';

  @override
  String get petDetailCoatColor => 'لون الفراء';

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
  String petDetailAgeMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months شهر',
      many: '$months شهرًا',
      few: '$months أشهر',
      two: 'شهران',
      one: 'شهر واحد',
      zero: 'أقل من شهر',
    );
    return '$_temp0';
  }

  @override
  String viewAllPets(int count) {
    return 'عرض جميع الحيوانات ($count)';
  }

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get createPetAdditionalInfo => 'معلومات إضافية';

  @override
  String get createPetAdditionalInfoSubtitle =>
      'اختياري — يمكنك إضافتها لاحقاً';

  @override
  String get createPetSize => 'الحجم';

  @override
  String get createPetCoatColor => 'لون الفراء';

  @override
  String get createPetNotSpecified => 'غير محدد';

  @override
  String get createPetMicrochipNumber => 'رقم الرقاقة';

  @override
  String get createPetMicrochipLocation => 'موقع الرقاقة';

  @override
  String get createPetSterilizationStatus => 'حالة التعقيم';

  @override
  String get sterilizationStatusNotSterilized => 'غير مُعقَّم';

  @override
  String get sterilizationStatusSterilized => 'مُعقَّم';

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
  String get healthWeightTitle => 'الوزن';

  @override
  String get healthWeightAdd => 'إضافة وزن';

  @override
  String get healthWeightEmpty =>
      'لم يُسجَّل أي وزن بعد. تتبَّع وزن حيوانك الأليف بمرور الوقت.';

  @override
  String get healthWeightSteady => 'ثابت';

  @override
  String healthWeightLastRecorded(String date) {
    return 'آخر تسجيل $date';
  }

  @override
  String get healthMedicationsTitle => 'الأدوية';

  @override
  String get healthMedicationsAdd => 'إضافة دواء';

  @override
  String get healthMedicationsEmpty =>
      'لا توجد أدوية فعّالة. أضِف تذكيرات للبقاء على الموعد.';

  @override
  String get healthMedicationsMarkGiven => 'تحديد كمُعطى';

  @override
  String healthMedicationsGivenConfirmed(String name) {
    return 'تم تحديد $name كمُعطى';
  }

  @override
  String get healthMedicationsOverdue => 'متأخر';

  @override
  String get healthMedicationsDueToday => 'اليوم';

  @override
  String healthMedicationsDueInDays(int days) {
    return 'خلال $days يوم';
  }

  @override
  String get healthVaccinationsTitle => 'اللقاحات';

  @override
  String get healthVaccinationsAdd => 'إضافة لقاح';

  @override
  String get healthVaccinationsEmpty => 'لم تُسجَّل أي لقاحات بعد.';

  @override
  String healthVaccinationsGivenOn(String date) {
    return 'أُعطي في $date';
  }

  @override
  String healthVaccinationsNextDue(String date) {
    return 'مستحق في $date';
  }

  @override
  String get healthVaccinationsDue => 'مستحق';

  @override
  String get healthFrequencyDaily => 'يوميًا';

  @override
  String get healthFrequencyWeekly => 'أسبوعيًا';

  @override
  String get healthFrequencyBiweekly => 'كل أسبوعين';

  @override
  String get healthFrequencyMonthly => 'شهريًا';

  @override
  String get healthFrequencyQuarterly => 'كل ثلاثة أشهر';

  @override
  String get petDetailSectionDetails => 'تفاصيل الحيوان';

  @override
  String get petDetailSectionHealth => 'البيانات الصحية';

  @override
  String get healthWeightValueLabel => 'الوزن';

  @override
  String get healthWeightValueHint => 'مثال: 12.4';

  @override
  String get healthWeightDateLabel => 'تاريخ التسجيل';

  @override
  String get healthWeightInvalid => 'أدخل وزناً صالحاً';

  @override
  String get healthWeightAddedSuccess => 'تم تسجيل الوزن';

  @override
  String get healthWeightAllReadings => 'كل القياسات';

  @override
  String get healthWeightDeleteTitle => 'حذف هذا القياس؟';

  @override
  String get healthWeightDeleteMessage => 'سيتم حذف سجل الوزن هذا نهائيًا.';

  @override
  String get healthWeightDeleteSuccess => 'تم حذف سجل الوزن';

  @override
  String healthFrequencyEveryNDays(int days) {
    return 'كل $days يوم';
  }

  @override
  String get healthFrequencyCustomLabel => 'مخصّص';

  @override
  String get healthFrequencyDaysSuffix => 'يوم';

  @override
  String get searchHint => 'بحث';

  @override
  String get searchNoResults => 'لا توجد نتائج';

  @override
  String get healthNotesLabel => 'ملاحظات (اختياري)';

  @override
  String get healthNotesHint => 'أي شيء يستحق التذكّر';

  @override
  String get healthMedicationsNameLabel => 'الدواء';

  @override
  String get healthMedicationsNameHint => 'مثال: أبوكيل';

  @override
  String get healthMedicationsNameRequired => 'اختر أو أدخل دواءً';

  @override
  String get healthMedicationsPickHint => 'اختر دواءً';

  @override
  String get healthMedicationsUseCustom => 'إدخال اسم مخصّص';

  @override
  String get healthMedicationsUseList => 'الاختيار من القائمة';

  @override
  String get healthMedicationsFrequencyLabel => 'التكرار';

  @override
  String get healthMedicationsStartDateLabel => 'تاريخ البدء';

  @override
  String get healthMedicationsAddedSuccess => 'تمت إضافة الدواء';

  @override
  String get healthMedicationsEditFrequency => 'التكرار';

  @override
  String get healthMedicationsFrequencyUpdated => 'تم تحديث التكرار';

  @override
  String get healthVaccinationsNameLabel => 'اللقاح';

  @override
  String get healthVaccinationsNameRequired => 'اختر لقاحاً';

  @override
  String get healthVaccinationsPickHint => 'اختر لقاحاً';

  @override
  String get healthVaccinationsAdministeredLabel => 'تاريخ الإعطاء';

  @override
  String get healthVaccinationsNextDueLabel =>
      'الجرعة المعزّزة القادمة (اختياري)';

  @override
  String get healthVaccinationsNoBooster => 'لا توجد جرعة معزّزة مجدولة';

  @override
  String get healthVaccinationsVetLabel => 'الطبيب البيطري (اختياري)';

  @override
  String get healthVaccinationsVetHint => 'مثال: د. سميث';

  @override
  String get healthVaccinationsAddedSuccess => 'تمت إضافة التطعيم';

  @override
  String get healthMedicationsDeleteTitle => 'حذف هذا الدواء؟';

  @override
  String healthMedicationsDeleteMessage(String name) {
    return 'سيتم حذف $name نهائيًا.';
  }

  @override
  String get healthMedicationsDeleteSuccess => 'تم حذف الدواء';

  @override
  String get healthVaccinationsDeleteTitle => 'حذف هذا التطعيم؟';

  @override
  String healthVaccinationsDeleteMessage(String name) {
    return 'سيتم حذف سجل $name نهائيًا.';
  }

  @override
  String get healthVaccinationsDeleteSuccess => 'تم حذف التطعيم';

  @override
  String get healthScoreTitle => 'مؤشر الصحة';

  @override
  String get healthScoreOutOf => 'من ١٠٠';

  @override
  String get healthScoreViewBreakdown => 'عرض التفاصيل';

  @override
  String get healthScoreConfidence => 'الموثوقية';

  @override
  String healthScoreBasedOnSignals(int count) {
    return 'بناءً على $count من ٤ مؤشرات';
  }

  @override
  String get healthScoreBandExcellent => 'ممتاز';

  @override
  String get healthScoreBandGood => 'جيد';

  @override
  String get healthScoreBandFair => 'مقبول';

  @override
  String get healthScoreBandNeedsAttention => 'يحتاج إلى اهتمام';

  @override
  String get healthScoreBandNoData => 'لا توجد بيانات';

  @override
  String get healthScoreEmptyGeneric =>
      'ابدأ بتسجيل التطعيمات والوزن والأدوية لعرض مؤشر صحة حيوانك الأليف.';

  @override
  String healthScoreEmptyNamed(String name) {
    return 'ابدأ بتسجيل التطعيمات والوزن والأدوية لعرض مؤشر صحة $name.';
  }

  @override
  String get healthScoreBreakdownTitle => 'تفاصيل المكوّنات';

  @override
  String get healthScoreWhyTitle => 'أسباب هذا المؤشر';

  @override
  String get healthScoreNoReasons => 'لا توجد مؤشرات لشرحها بعد.';

  @override
  String get healthScoreNotApplicable => 'غير متاح';

  @override
  String get healthScoreRedistributed =>
      'أُعيد توزيع الوزن على المؤشرات الأخرى';

  @override
  String healthScoreRedistributedWith(String reason) {
    return '$reason — أُعيد توزيع الوزن على المؤشرات الأخرى';
  }

  @override
  String healthScoreDeltaPoints(String points) {
    return '$points نقطة';
  }

  @override
  String healthScoreManagedConditions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حالات مزمنة قيد المتابعة',
      one: 'حالة مزمنة واحدة قيد المتابعة',
    );
    return '$_temp0';
  }

  @override
  String get healthScoreDisclaimer =>
      'يقيس هذا المؤشر الالتزام بالرعاية الوقائية ومتابعة المؤشرات الحيوية، وليس الحالة الصحية السريرية. يقيس تقلّب الوزن وليس الوزن المثالي. البيانات الناقصة يُعاد توزيعها ولا تُحتسب ضد حيوانك الأليف.';

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
  String get userId => 'معرّف المستخدم';

  @override
  String get userIdCopied => 'تم نسخ معرّف المستخدم';

  @override
  String get profileTagCopied => 'تم نسخ وسم الملف الشخصي';

  @override
  String get onboardingCoOwnTitle => 'هل تريد المشاركة في ملكية حيوان أليف؟';

  @override
  String get onboardingCoOwnBody => 'اطلب دعوة باستخدام وسم ملفك الشخصي:';

  @override
  String get onboardingViewInvites => 'عرض الدعوات';

  @override
  String onboardingViewInvitesCount(int count) {
    return 'عرض الدعوات ($count)';
  }

  @override
  String get inviteCoOwnerTitle => 'دعوة مالك مشارك';

  @override
  String inviteCoOwnerSubtitle(String petName) {
    return 'ابحث بوسم الملف الشخصي لدعوة شخص للمشاركة في ملكية $petName.';
  }

  @override
  String get inviteCoOwnerSearchHint => 'أدخل وسم ملف شخصي (مثال: a1b2c3d4)';

  @override
  String get inviteCoOwnerSearchIdle =>
      'أدخل وسم ملف شخصي كاملاً للعثور على شخص';

  @override
  String get inviteCoOwnerSearchEmpty => 'لم يتم العثور على مستخدم بهذا الوسم.';

  @override
  String get inviteCoOwnerInvite => 'دعوة';

  @override
  String get inviteCoOwnerAlreadyInvited => 'تمت الدعوة';

  @override
  String get inviteCoOwnerSent => 'تم إرسال الدعوة';

  @override
  String get inviteCoOwnerSentTitle => 'الدعوات المُرسَلة';

  @override
  String get inviteCoOwnerNoneSent => 'لم تقم بدعوة أي شخص بعد.';

  @override
  String get inviteCoOwnerCancel => 'إلغاء الدعوة';

  @override
  String get inviteCoOwnerCancelled => 'تم إلغاء الدعوة';

  @override
  String get coOwnerCurrentTitle => 'المالكون المشاركون الحاليون';

  @override
  String get coOwnerPrimaryBadge => 'المالك';

  @override
  String coOwnerYou(String name) {
    return '$name (أنت)';
  }

  @override
  String get coOwnerRemoveAction => 'إزالة المالك المشارك';

  @override
  String get coOwnerLeaveAction => 'مغادرة';

  @override
  String get coOwnerLeavePetAction => 'مغادرة الملكية المشتركة';

  @override
  String get coOwnerRemoveTitle => 'إزالة المالك المشارك؟';

  @override
  String coOwnerRemoveMessage(String name) {
    return 'سيفقد $name إمكانية الوصول إلى هذا الحيوان. لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get coOwnerRemoveConfirm => 'إزالة';

  @override
  String get coOwnerRemovedSuccess => 'تمت إزالة المالك المشارك';

  @override
  String get coOwnerLeaveTitle => 'مغادرة هذا الحيوان؟';

  @override
  String get coOwnerLeaveMessage =>
      'ستفقد إمكانية الوصول إلى هذا الحيوان. يمكن للمالك دعوتك مرة أخرى لاحقًا.';

  @override
  String get coOwnerLeaveConfirm => 'مغادرة';

  @override
  String get coOwnerLeftSuccess => 'لقد غادرت الحيوان';

  @override
  String get coOwnerInvitationsTitle => 'دعوات الحيوانات الأليفة';

  @override
  String get coOwnerInvitationsEmpty => 'ليس لديك دعوات معلّقة.';

  @override
  String coOwnerInvitedBy(String name) {
    return 'دعوة من $name';
  }

  @override
  String get coOwnerAccept => 'قبول';

  @override
  String get coOwnerDecline => 'رفض';

  @override
  String coOwnerAccepted(String petName) {
    return 'أصبحت الآن مالكًا مشاركًا لـ $petName';
  }

  @override
  String get coOwnerDeclined => 'تم رفض الدعوة';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusAccepted => 'مقبولة';

  @override
  String get statusDeclined => 'مرفوضة';

  @override
  String get statusCancelled => 'ملغاة';

  @override
  String get locationName => 'الموقع';

  @override
  String get locationNameHint => 'مثال: بيروت، لبنان';

  @override
  String get locationNameTooLong => 'يجب ألا يتجاوز الموقع 200 حرف';

  @override
  String get locationPickHint => 'انقر على الخريطة لإسقاط دبوس';

  @override
  String get locationRequired => 'اختر موقعك على الخريطة';

  @override
  String get locationUseMine => 'استخدام موقعي';

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
      'امنح حيوانك الأليف صورة في ملفه الشخصي.';

  @override
  String get petAvatarSetupOptional => 'اختياري — يمكنك تغييره في أي وقت.';

  @override
  String get petAvatarUploadHint => 'تحميل صورة';

  @override
  String get clear => 'مسح';

  @override
  String get providersNearby => 'مزوّدون قريبون';

  @override
  String providerCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مزوّدين',
      one: 'مزوّد واحد',
      zero: 'لم يتم العثور على مزوّدين',
    );
    return '$_temp0';
  }

  @override
  String get providerSearchHint => 'ابحث عن بيطري، تجميل، متاجر…';

  @override
  String get providerSort => 'ترتيب';

  @override
  String get providerSortBy => 'ترتيب حسب';

  @override
  String get sortDistance => 'المسافة';

  @override
  String get sortRating => 'التقييم';

  @override
  String get sortOpenNow => 'مفتوح الآن';

  @override
  String get sortMostReviewed => 'الأكثر تقييماً';

  @override
  String get providerShowList => 'عرض القائمة';

  @override
  String get providerShowMap => 'عرض الخريطة';

  @override
  String get providerMyLocation => 'موقعي';

  @override
  String get providerOpen => 'مفتوح';

  @override
  String get providerClosed => 'مغلق';

  @override
  String get providerCall => 'اتصال';

  @override
  String get providerDirections => 'الاتجاهات';

  @override
  String get providerCallFailed =>
      'تعذّر إجراء الاتصال. لا يوجد رقم هاتف متاح.';

  @override
  String get providerDirectionsFailed => 'تعذّر فتح الاتجاهات.';

  @override
  String get providerNoResultsTitle => 'لا يوجد مزوّدون';

  @override
  String get providerNoResultsNearby =>
      'لم نعثر على أي أعمال متعلقة بالحيوانات قريبة منك بعد.';

  @override
  String get providerNoResultsFiltered =>
      'لا يوجد مزوّدون يطابقون عوامل التصفية. جرّب تعديل بحثك أو الفئة.';

  @override
  String get providerClearFilters => 'مسح عوامل التصفية';

  @override
  String get providerOfflineTitle => 'أنت غير متصل';

  @override
  String get providerOfflineMessage =>
      'تحقق من اتصالك وحاول مرة أخرى لرؤية المزوّدين القريبين.';

  @override
  String get providerErrorTitle => 'حدث خطأ ما';

  @override
  String get providerErrorMessage =>
      'تعذّر تحميل المزوّدين حالياً. يرجى المحاولة مرة أخرى.';

  @override
  String get providerLocationDeniedTitle => 'الموقع مُعطّل';

  @override
  String get providerLocationDeniedMessage =>
      'فعّل الموقع لاكتشاف خدمات الحيوانات من حولك.';

  @override
  String get providerEnableLocation => 'تفعيل الموقع';

  @override
  String distanceMeters(int meters) {
    return '$meters م';
  }

  @override
  String distanceKm(String km) {
    return '$km كم';
  }

  @override
  String ratingLabel(String rating) {
    return 'التقييم $rating';
  }

  @override
  String ratingWithReviews(String rating, int count) {
    return 'التقييم $rating من $count مراجعة';
  }

  @override
  String reviewCountShort(int count) {
    return '($count)';
  }

  @override
  String get badgeVerified => 'موثّق';

  @override
  String get badgeEmergency => 'طوارئ';

  @override
  String get badge24_7 => '24/7';

  @override
  String get badgeMobile => 'متنقّل';

  @override
  String get categoryAll => 'الكل';

  @override
  String get categoryVeterinary => 'بيطري';

  @override
  String get categoryGrooming => 'تجميل';

  @override
  String get categoryPetShop => 'متاجر';

  @override
  String get categoryBoarding => 'إقامة';

  @override
  String get categoryTraining => 'تدريب';

  @override
  String get categoryPetSitting => 'رعاية';

  @override
  String get categoryWalking => 'تمشية';

  @override
  String get categoryAdoption => 'تبنّي';

  @override
  String get categoryShelter => 'ملاجئ';

  @override
  String get categoryEmergency => 'طوارئ';

  @override
  String get categoryPharmacy => 'صيدلية';

  @override
  String get adoptionTitle => 'التبنّي';

  @override
  String adoptionSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حيوان يبحث عن بيت',
      many: '$count حيوانًا يبحث عن بيت',
      few: '$count حيوانات تبحث عن بيت',
      two: 'حيوانان يبحثان عن بيت',
      one: 'حيوان واحد يبحث عن بيت',
      zero: 'لا توجد حيوانات متاحة',
    );
    return '$_temp0';
  }

  @override
  String get adoptionListAPet => 'أضف إعلانًا';

  @override
  String get adoptionSearchHint => 'ابحث بالاسم أو السلالة أو المنطقة';

  @override
  String get adoptionFilterAll => 'الكل';

  @override
  String get adoptionSpeciesDog => 'كلب';

  @override
  String get adoptionSpeciesCat => 'قطة';

  @override
  String get adoptionSpeciesBird => 'طائر';

  @override
  String get adoptionSpeciesRabbit => 'أرنب';

  @override
  String get adoptionSpeciesOther => 'أخرى';

  @override
  String get adoptionSexMale => 'ذكر';

  @override
  String get adoptionSexFemale => 'أنثى';

  @override
  String adoptionAgeMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months شهر',
      many: '$months شهرًا',
      few: '$months أشهر',
      two: 'شهران',
      one: 'شهر واحد',
      zero: 'حديث الولادة',
    );
    return '$_temp0';
  }

  @override
  String adoptionAgeYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years سنة',
      many: '$years سنة',
      few: '$years سنوات',
      two: 'سنتان',
      one: 'سنة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get adoptionStatusAvailable => 'متاح';

  @override
  String get adoptionStatusPending => 'قيد الانتظار';

  @override
  String get adoptionStatusAdopted => 'تم تبنّيه';

  @override
  String get adoptionStatusUnavailable => 'غير متاح';

  @override
  String adoptionPostedDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'منذ $days يوم',
      many: 'منذ $days يومًا',
      few: 'منذ $days أيام',
      two: 'منذ يومين',
      one: 'منذ يوم',
    );
    return '$_temp0';
  }

  @override
  String adoptionPostedHoursAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'منذ $hours ساعة',
      many: 'منذ $hours ساعة',
      few: 'منذ $hours ساعات',
      two: 'منذ ساعتين',
      one: 'منذ ساعة',
      zero: 'الآن',
    );
    return '$_temp0';
  }

  @override
  String get adoptionTraitVaccinated => 'مُطعّم';

  @override
  String get adoptionTraitNeutered => 'مُعقّم';

  @override
  String get adoptionTraitGoodWithKids => 'أليف مع الأطفال';

  @override
  String get adoptionApply => 'تقدّم للتبنّي';

  @override
  String get adoptionApplied => 'تم التقديم';

  @override
  String adoptionManageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'إدارة · $count متقدّم',
      many: 'إدارة · $count متقدّمًا',
      few: 'إدارة · $count متقدّمين',
      two: 'إدارة · متقدّمان',
      one: 'إدارة · متقدّم واحد',
      zero: 'إدارة الإعلان',
    );
    return '$_temp0';
  }

  @override
  String get adoptionManageTitle => 'المتقدّمون';

  @override
  String adoptionManageSubtitle(int count, String petName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شخص يريدون تبنّي $petName',
      many: '$count شخصًا يريدون تبنّي $petName',
      few: '$count أشخاص يريدون تبنّي $petName',
      two: 'شخصان يريدان تبنّي $petName',
      one: 'شخص واحد يريد تبنّي $petName',
      zero: 'لا يوجد متقدّمون بعد',
    );
    return '$_temp0';
  }

  @override
  String get adoptionManageEmptyTitle => 'لا يوجد متقدّمون بعد';

  @override
  String adoptionManageEmptyMessage(String petName) {
    return 'عندما يتقدّم شخص لتبنّي $petName، سيظهر هنا.';
  }

  @override
  String adoptionApplicantApplied(String ago) {
    return 'تقدّم $ago';
  }

  @override
  String get adoptionApprove => 'موافقة';

  @override
  String get adoptionReject => 'رفض';

  @override
  String get adoptionRequestStatusPending => 'قيد المراجعة';

  @override
  String get adoptionRequestStatusApproved => 'تمت الموافقة';

  @override
  String get adoptionRequestStatusRejected => 'مرفوض';

  @override
  String get adoptionRequestStatusCancelled => 'مسحوب';

  @override
  String get adoptionRequestStatusCompleted => 'تم التبنّي';

  @override
  String get adoptionRequestStatusExpired => 'منتهٍ';

  @override
  String get adoptionAwaitingAdopter => 'بانتظار تأكيده';

  @override
  String get adoptionOnePickHint =>
      'لقد اخترت متقدّمًا بالفعل. ارفضه لاختيار شخص آخر.';

  @override
  String get adoptionReadyToComplete => 'جاهز للتسليم';

  @override
  String get adoptionCompleteTransfer => 'إتمام النقل';

  @override
  String adoptionApproveConfirmTitle(String name) {
    return 'الموافقة على $name؟';
  }

  @override
  String adoptionApproveConfirmMessage(String petName) {
    return 'سيُطلب منه تأكيد رغبته في $petName. لا تُنقل الملكية إلا بعد تأكيدكما معًا.';
  }

  @override
  String adoptionRejectConfirmTitle(String name) {
    return 'رفض $name؟';
  }

  @override
  String get adoptionRejectConfirmMessage =>
      'سيتم إبلاغه بأن طلبه لم يُقبل. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String adoptionCompleteConfirmTitle(String petName, String name) {
    return 'إعطاء $petName إلى $name؟';
  }

  @override
  String adoptionCompleteConfirmMessage(String petName, String name) {
    return 'ينقل هذا الملكية بشكل دائم ولا يمكن التراجع عنه. سيُنقل $petName وجميع سجلاته إلى $name.';
  }

  @override
  String adoptionApproveSuccess(String name) {
    return 'تمت الموافقة على $name.';
  }

  @override
  String get adoptionRejectSuccess => 'تم رفض الطلب.';

  @override
  String get adoptionDelete => 'حذف الإعلان';

  @override
  String get adoptionDeleteConfirmTitle => 'حذف هذا الإعلان؟';

  @override
  String adoptionDeleteConfirmMessage(String petName) {
    return 'سيتم حذف إعلان $petName نهائيًا. لا يمكن التراجع عن ذلك.';
  }

  @override
  String adoptionDeleteConfirmMessageWithApplicants(String petName, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# طلب',
      many: '# طلبًا',
      few: '# طلبات',
      two: 'طلبان',
      one: 'طلب واحد',
      zero: 'لا طلبات',
    );
    return 'سيتم حذف إعلان $petName و$_temp0 نهائيًا. لا يمكن التراجع عن ذلك.';
  }

  @override
  String get adoptionDeleteSuccess => 'تم حذف الإعلان.';

  @override
  String adoptionRehomeSuccessTitle(String petName) {
    return 'حصل $petName على منزل جديد!';
  }

  @override
  String adoptionRehomeSuccessMessage(String petName, String name) {
    return 'أصبح $petName الآن مع $name، مع جميع سجلاته. شكرًا لمنحه منزلًا جديدًا مليئًا بالحب.';
  }

  @override
  String get adoptionRehomeSuccessDone => 'تم';

  @override
  String get adoptionEmptyTitle => 'لا توجد حيوانات للتبنّي';

  @override
  String get adoptionEmptyNearby =>
      'لا توجد إعلانات قريبة منك حاليًا. تحقّق لاحقًا.';

  @override
  String get adoptionEmptyFiltered =>
      'لا توجد إعلانات تطابق عوامل التصفية. حاول توسيع بحثك.';

  @override
  String get adoptionClearFilters => 'مسح عوامل التصفية';

  @override
  String get adoptionAboutTitle => 'نبذة';

  @override
  String get adoptionPostedBy => 'نشره';

  @override
  String get adoptionFactSpecies => 'النوع';

  @override
  String get adoptionFactSex => 'الجنس';

  @override
  String get adoptionFactAge => 'العمر';

  @override
  String get adoptionFactSize => 'الحجم';

  @override
  String adoptionApplyConfirmTitle(String petName) {
    return 'تقدّم لتبنّي $petName؟';
  }

  @override
  String get adoptionApplyConfirmMessage =>
      'سيراجع المالك طلبك. إذا وافق، يؤكّد كلاكما قبل نقل الملكية.';

  @override
  String get adoptionApplySuccess => 'تم إرسال طلبك إلى المالك.';

  @override
  String get adoptionTransferNote =>
      'ستؤكّدان كلاكما قبل نقل الملكية — لا شيء يتغيّر دون موافقتك.';

  @override
  String get adoptionListTitle => 'أضف إعلان تبنّي';

  @override
  String get adoptionListSubtitle => 'اعثر لحيوانك على بيت جديد محب.';

  @override
  String get adoptionListWhichPet => 'أي حيوان؟';

  @override
  String get adoptionListSelectPet => 'اختر حيوانًا';

  @override
  String get adoptionListSelectPetHint => 'اختر أحد حيواناتك';

  @override
  String get adoptionListNoPets => 'ليس لديك حيوانات لإضافتها بعد.';

  @override
  String get adoptionListDescriptionHint =>
      'أخبر المتبنّين عن طباعه واحتياجاته وسبب إعادة توطينه.';

  @override
  String get adoptionListTraits => 'السمات';

  @override
  String get adoptionListLocation => 'مكان الاستلام';

  @override
  String get adoptionListTransferNote =>
      'عندما يتقدّم شخص ما، تراجعه وتوافق عليه. لا تُنقل الملكية إلا بعد تأكيدكما معًا — وتنتقل السجلّات مع حيوانك.';

  @override
  String get adoptionListSubmit => 'نشر الإعلان';

  @override
  String get adoptionListingCreated => 'حيوانك الآن معروض للتبنّي.';

  @override
  String get adoptionModeMyPet => 'حيواني';

  @override
  String get adoptionModeShelter => 'ملجأ / ضالّ';

  @override
  String get adoptionShelterAnimalDetails => 'تفاصيل الحيوان';

  @override
  String get adoptionShelterName => 'الاسم';

  @override
  String get adoptionShelterTransferNote =>
      'لا حاجة لسجل حيوان. عند التبنّي، يُنشأ ملف حيوان جديد للمتبنّي بهذه الصورة وهذه التفاصيل.';

  @override
  String get adoptionShelterBadge => 'ملجأ';

  @override
  String get adoptionMyTitle => 'تبنّياتي';

  @override
  String get adoptionMyTooltip => 'تبنّياتي';

  @override
  String get adoptionMyRowHint => 'إعلاناتك وطلباتك';

  @override
  String get adoptionMyTabListings => 'إعلاناتي';

  @override
  String get adoptionMyTabApplications => 'طلباتي';

  @override
  String get adoptionMyListingsEmptyTitle => 'لا توجد إعلانات';

  @override
  String get adoptionMyListingsEmptyMessage =>
      'ستظهر هنا الحيوانات التي تعرضها للتبنّي.';

  @override
  String get adoptionMyApplicationsEmptyTitle => 'لا توجد طلبات';

  @override
  String get adoptionMyApplicationsEmptyMessage =>
      'ستظهر هنا الحيوانات التي تتقدّم لتبنّيها.';

  @override
  String adoptionApplicationFrom(String name) {
    return 'من $name';
  }

  @override
  String get adoptionAcceptCta => 'سآخذه';

  @override
  String get adoptionAcceptHint =>
      'تمت الموافقة عليك! أكّد رغبتك في التبنّي، ثم يُتمّ المالك التسليم.';

  @override
  String get adoptionAwaitingHandover => 'بانتظار تسليم المالك';

  @override
  String get adoptionAwaitingReview => 'بانتظار مراجعة المالك لطلبك';

  @override
  String get adoptionCancelApplication => 'سحب الطلب';

  @override
  String get adoptionCancelConfirmTitle => 'سحب طلبك؟';

  @override
  String get adoptionCancelConfirmMessage =>
      'يمكنك التقديم مرة أخرى طالما أن الإعلان مفتوح.';

  @override
  String get adoptionAcceptSuccess => 'تم التأكيد. سيُتمّ المالك التسليم.';

  @override
  String get adoptionCancelSuccess => 'تم سحب طلبك.';

  @override
  String adoptionWelcomeTitle(String petName) {
    return '$petName أصبح لك الآن!';
  }

  @override
  String adoptionWelcomeMessage(String petName) {
    return 'مرحبًا بـ $petName في العائلة. ملفه الكامل وسجلاته موجودة بالفعل في حسابك.';
  }

  @override
  String adoptionWelcomeViewPet(String petName) {
    return 'عرض ملف $petName';
  }

  @override
  String get adoptionWelcomeDone => 'تم';

  @override
  String get onboardingAdoptPrompt => 'هل تبحث عن التبنّي؟';

  @override
  String get walkStartTitle => 'ابدأ نزهة';

  @override
  String walkStartSubtitle(String petName) {
    return 'تتبع نشاط $petName';
  }

  @override
  String get walkStartButton => 'ابدأ';

  @override
  String walkActiveTitle(String petName) {
    return 'نزهة مع $petName';
  }

  @override
  String get walkStopButton => 'إيقاف';

  @override
  String get walkStatDuration => 'المدة';

  @override
  String get walkStatDistance => 'المسافة';

  @override
  String get walkStatSpeed => 'متوسط السرعة';

  @override
  String get walkNoLocation => 'الموقع غير متاح — مؤقت فقط';

  @override
  String get walkHistoryTitle => 'سجل النزهات';

  @override
  String get walkHistoryEmpty =>
      'لم يتم تسجيل أي نزهة بعد.\nابدأ من الشاشة الرئيسية.';

  @override
  String get walkDeleteTitle => 'حذف هذه النزهة؟';

  @override
  String get walkDeleteMessage => 'سيتم حذف هذا السجل نهائيًا.';

  @override
  String get walkDeleteSuccess => 'تم حذف النزهة';

  @override
  String get walkDeleteTooOld => 'لا يمكن حذف النزهات الأقدم من يومين';

  @override
  String reminderMedicationDose(Object petName) {
    return 'دواء · $petName';
  }

  @override
  String reminderVaccinationBooster(Object petName) {
    return 'جرعة تطعيم معززة · $petName';
  }

  @override
  String get reminderDueToday => 'مستحق اليوم';

  @override
  String get reminderOverdue => 'متأخر';

  @override
  String reminderDueInDays(Object days) {
    return 'خلال $days يوم';
  }

  @override
  String get dateToday => 'اليوم';

  @override
  String get dateYesterday => 'أمس';

  @override
  String get pawHubSearchHint => 'ابحث عن حيوانات ومنشورات ووسوم #';

  @override
  String get pawHubFeedTabFollowing => 'المتابَعون';

  @override
  String get pawHubFeedTabDiscover => 'اكتشف';

  @override
  String get pawHubNewPosts => 'منشورات جديدة';

  @override
  String get pawHubFeedEmptyTitle => 'فيدك هادئ بعض الشيء';

  @override
  String get pawHubFeedEmptyDescription =>
      'تابع حيوانات أخرى وستظهر لحظاتهم هنا 🐾';

  @override
  String get pawHubDiscoverPets => 'اكتشف حيوانات';

  @override
  String get pawHubSuggestedPets => 'حيوانات قد تعجبك';

  @override
  String get pawHubLostPetNearby => 'حيوان ضائع قريب';

  @override
  String get pawHubViewOnMap => 'عرض على الخريطة';

  @override
  String get pawHubFollow => 'متابعة';

  @override
  String get pawHubFollowing => 'تتابع';

  @override
  String get pawHubCouldNotLoadFeed => 'تعذّر تحميل الفيد';

  @override
  String get pawHubPostSaved => 'تم الحفظ';

  @override
  String get pawHubPostRemovedFromSaved => 'تمت الإزالة من المحفوظات';

  @override
  String get pawHubLinkCopied => 'تم نسخ الرابط';

  @override
  String get pawHubPostHidden => 'تم إخفاء المنشور';

  @override
  String get pawHubPostReported => 'تم الإبلاغ. شكراً لك.';

  @override
  String pawHubBlockedUser(String name) {
    return 'تم حظر $name';
  }

  @override
  String get pawHubPostDeleted => 'تم حذف المنشور';

  @override
  String get pawHubEditCaption => 'تعديل التعليق';

  @override
  String get pawHubCaptionUpdated => 'تم تحديث التعليق';

  @override
  String pawHubFollowingPet(String name) {
    return 'تتابع $name';
  }

  @override
  String pawHubUnfollowedPet(String name) {
    return 'إلغاء متابعة $name';
  }

  @override
  String get pawHubAddPetFirstToPost => 'أضف حيواناً أولاً للنشر';

  @override
  String pawHubPostedAs(String name) {
    return 'نُشر باسم $name 🐾';
  }

  @override
  String get pawHubPostOptionSave => 'حفظ';

  @override
  String get pawHubPostOptionRemoveSaved => 'إزالة من المحفوظات';

  @override
  String get pawHubPostOptionCopyLink => 'نسخ الرابط';

  @override
  String get pawHubPostOptionShareTo => 'مشاركة إلى…';

  @override
  String get pawHubPostOptionEditPost => 'تعديل المنشور';

  @override
  String get pawHubPostOptionDeletePost => 'حذف المنشور';

  @override
  String get pawHubPostOptionHidePost => 'إخفاء هذا المنشور';

  @override
  String get pawHubPostOptionReport => 'الإبلاغ';

  @override
  String pawHubPostOptionBlock(String name) {
    return 'حظر $name';
  }

  @override
  String get pawHubReportTitle => 'لماذا تُبلّغ عن هذا؟';

  @override
  String get pawHubReportReasonCruelty => 'إيذاء الحيوانات أو القسوة عليها';

  @override
  String get pawHubReportReasonSpam => 'بريد عشوائي أو احتيال';

  @override
  String get pawHubReportReasonNudity => 'محتوى إباحي أو جنسي';

  @override
  String get pawHubReportReasonHarassment => 'مضايقة أو تنمر';

  @override
  String get pawHubReportReasonImpersonation =>
      'ليس حيواناً حقيقياً / انتحال هوية';

  @override
  String get pawHubReportReasonOther => 'شيء آخر';

  @override
  String get pawHubCommentsTitle => 'التعليقات';

  @override
  String get pawHubCommentAs => 'التعليق باسم';

  @override
  String pawHubCommentHint(String name) {
    return 'أضف تعليقاً باسم $name…';
  }

  @override
  String pawHubReplyingTo(String name) {
    return 'رداً على $name';
  }

  @override
  String get pawHubSortTop => 'الأبرز';

  @override
  String get pawHubSortNewest => 'الأحدث';

  @override
  String get pawHubCommentReply => 'رد';

  @override
  String get pawHubNoCommentsYet => 'لا توجد تعليقات بعد';

  @override
  String get pawHubFirstCommentEncouragement =>
      'كن أول من يقول شيئاً لطيفاً 🐾';

  @override
  String get pawHubNotificationsTitle => 'الإشعارات';

  @override
  String get pawHubMarkAllRead => 'تعيين الكل كمقروء';

  @override
  String get pawHubPostLike => 'إعجاب';

  @override
  String get pawHubPostComment => 'تعليق';

  @override
  String get pawHubPostShare => 'مشاركة';

  @override
  String get pawHubPostSaveAction => 'حفظ';

  @override
  String get pawHubLikesCountPaw => 'مخلب';

  @override
  String get pawHubLikesCountPaws => 'مخالب';

  @override
  String pawHubTaggedWith(String names) {
    return 'مع $names';
  }

  @override
  String get pawHubPostEdited => ' · معدَّل';

  @override
  String pawHubViewAllComments(int count) {
    return 'عرض $count تعليقات';
  }

  @override
  String get pawHubNewPostTitle => 'منشور جديد';

  @override
  String get pawHubShare => 'مشاركة';

  @override
  String get pawHubPostingAs => 'النشر باسم';

  @override
  String get pawHubCaptionHint => 'اكتب تعليقاً… أضف #وسوم و@إشارات';

  @override
  String get pawHubTagPets => 'وسم الحيوانات';

  @override
  String get pawHubAddLocation => 'إضافة موقع';

  @override
  String get pawHubVisibility => 'الظهور';

  @override
  String get pawHubAddMedia => 'إضافة';

  @override
  String get pawHubCoverPhoto => 'غلاف';

  @override
  String get pawHubDone => 'تم';

  @override
  String get pawHubAddPhotoRequired => 'أضف صورة واحدة على الأقل';

  @override
  String get pawHubProfilePosts => 'المنشورات';

  @override
  String get pawHubProfileFollowers => 'المتابعون';

  @override
  String get pawHubProfileFollowing => 'المتابَعون';

  @override
  String get pawHubProfileManagePet => 'إدارة الحيوان';

  @override
  String pawHubProfileSiblings(String name) {
    return 'إخوة $name';
  }

  @override
  String pawHubProfileCaredForBy(String owner) {
    return 'يُعتنى به من قِبَل $owner';
  }

  @override
  String get communitiesTitle => 'المجتمعات';

  @override
  String get communitiesEntryButton => 'المجتمعات';

  @override
  String get communitiesSearchHint => 'ابحث عن المجتمعات';

  @override
  String get communitiesMyCommunities => 'مجتمعاتي';

  @override
  String get communitiesTabDiscover => 'استكشاف';

  @override
  String get communitiesTabMine => 'مجتمعاتي';

  @override
  String get communitiesMineEmptyTitle => 'لم تنضم إلى أي مجتمع';

  @override
  String get communitiesMineEmptyDescription =>
      'استكشف المجتمعات وانضم إلى ما يناسب حيوانك الأليف 🐾';

  @override
  String get communitiesDiscoverRailTitle => 'مجتمعات للانضمام';

  @override
  String get communitiesSeeAll => 'عرض الكل';

  @override
  String get communitiesEmptyTitle => 'لا توجد مجتمعات بعد';

  @override
  String get communitiesEmptyDescription => 'كن أول من ينشئ مجتمعًا لرفاقك 🐾';

  @override
  String communitiesSearchEmpty(String query) {
    return 'لا توجد مجتمعات تطابق «$query»';
  }

  @override
  String get communitiesCouldNotLoad => 'تعذّر تحميل المجتمعات';

  @override
  String get communitiesRetry => 'إعادة المحاولة';

  @override
  String get communitySortPopular => 'الأكثر شيوعًا';

  @override
  String get communitySortNewest => 'الأحدث';

  @override
  String get communitySortMostActive => 'الأكثر نشاطًا';

  @override
  String get communityCategoryAll => 'الكل';

  @override
  String get communityCategoryBreedClub => 'نادي السلالة';

  @override
  String get communityCategoryShelterRescues => 'الملاجئ والإنقاذ';

  @override
  String get communityCategoryBreeding => 'التربية';

  @override
  String get communityCategorySpecialNeeds => 'الاحتياجات الخاصة';

  @override
  String get communityCategoryActivity => 'النشاط';

  @override
  String get communityCategoryHealth => 'الصحة';

  @override
  String get communityCategoryOther => 'أخرى';

  @override
  String get communityJoin => 'انضمام';

  @override
  String get communityJoined => 'منضم';

  @override
  String get communityLeave => 'مغادرة';

  @override
  String get communityManage => 'إدارة';

  @override
  String get communityEditAvatar => 'تغيير صورة الملف';

  @override
  String get communityEditBanner => 'تغيير صورة الغلاف';

  @override
  String get communityImagesUpdating => 'جارٍ التحديث…';

  @override
  String get communityImagesUpdated => 'تم تحديث الصورة';

  @override
  String get communityImagesUpdateFailed => 'تعذّر تحديث الصورة. حاول مجددًا.';

  @override
  String get communityLeadBadge => 'القائد';

  @override
  String communityMembersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عضو',
      many: '$count عضوًا',
      few: '$count أعضاء',
      two: 'عضوان',
      one: 'عضو واحد',
      zero: 'لا أعضاء',
    );
    return '$_temp0';
  }

  @override
  String communityPostsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count منشور',
      many: '$count منشورًا',
      few: '$count منشورات',
      two: 'منشوران',
      one: 'منشور واحد',
      zero: 'لا منشورات',
    );
    return '$_temp0';
  }

  @override
  String communityLedBy(String name) {
    return 'بقيادة $name';
  }

  @override
  String communityJoinedToast(String name) {
    return 'انضممت إلى $name';
  }

  @override
  String communityLeftToast(String name) {
    return 'غادرت $name';
  }

  @override
  String get communityDetailAbout => 'نبذة';

  @override
  String get communityDetailMembers => 'الأعضاء';

  @override
  String get communityStatPosts => 'المنشورات';

  @override
  String get communityLeaderLabel => 'القائد';

  @override
  String get communityDetailFeedEmptyTitle => 'لا منشورات بعد';

  @override
  String get communityCreateFirstPost => 'أنشئ أول منشور';

  @override
  String get communityDetailViewMembers => 'عرض جميع الأعضاء';

  @override
  String get communityDetailFeedEmpty => 'لا منشورات بعد — كن أول من يشارك';

  @override
  String get communityDetailJoinToPost => 'انضم لتنشر هنا';

  @override
  String get communityLeaveConfirmTitle => 'مغادرة المجتمع؟';

  @override
  String communityLeaveConfirmMessage(String name) {
    return 'لن ترى بعد الآن منشورات $name.';
  }

  @override
  String get communityDeleteConfirmTitle => 'حذف المجتمع؟';

  @override
  String communityDeleteConfirmMessage(String name) {
    return 'سيؤدي هذا إلى حذف $name وكل منشوراته نهائيًا. لا يمكن التراجع.';
  }

  @override
  String get communityDelete => 'حذف';

  @override
  String get communityDeletedToast => 'تم حذف المجتمع';

  @override
  String get communityCancel => 'إلغاء';

  @override
  String get communityCreateTitle => 'مجتمع جديد';

  @override
  String get communityCreateNameLabel => 'الاسم';

  @override
  String get communityCreateNameHint => 'مثال: نادي الغولدن ريتريفر';

  @override
  String get communityCreateHandleLabel => 'المعرّف';

  @override
  String get communityCreateHandleHint => 'golden-club';

  @override
  String get communityHandleChecking => 'جارٍ التحقق من التوفر…';

  @override
  String get communityHandleAvailable => 'المعرّف متاح';

  @override
  String get communityHandleTaken => 'هذا المعرّف مستخدَم بالفعل';

  @override
  String get communityHandleInvalid =>
      'استخدم أحرفًا صغيرة وأرقامًا وشرطات فقط';

  @override
  String get communityCreateDescriptionLabel => 'الوصف';

  @override
  String get communityCreateDescriptionHint => 'عمّ يدور هذا المجتمع؟';

  @override
  String get communityCreateCategoryLabel => 'الفئة';

  @override
  String get communityCreateBannerLabel => 'أضِف صورة غلاف';

  @override
  String get communityCreateSubmit => 'إنشاء المجتمع';

  @override
  String get communityCreateNameRequired => 'يرجى إدخال اسم';

  @override
  String get communityCreateCategoryRequired => 'يرجى اختيار فئة';

  @override
  String get communityCreatedToast => 'تم إنشاء المجتمع 🎉';

  @override
  String get communityCreateFailed => 'تعذّر إنشاء المجتمع. حاول مجددًا.';

  @override
  String get communityCreateAddPetFirst =>
      'أضِف حيوانًا أليفًا أولًا لقيادة مجتمع';

  @override
  String get communityMembersTitle => 'الأعضاء';

  @override
  String get communityMemberRemove => 'إزالة';

  @override
  String get communityMemberRemoveConfirmTitle => 'إزالة العضو؟';

  @override
  String communityMemberRemoveConfirmMessage(String name) {
    return 'إزالة $name من هذا المجتمع؟';
  }

  @override
  String get communityMemberRemovedToast => 'تمت إزالة العضو';

  @override
  String communityComposerPostingIn(String name) {
    return 'النشر في $name';
  }

  @override
  String get communityCreateSheetTitle => 'إنشاء';

  @override
  String get communityCreateSheetSubtitle => 'ماذا تريد أن تضيف؟';

  @override
  String get composeNewPost => 'منشور جديد';

  @override
  String get composeNewPostSubtitle => 'شارك صورة أو فيديو';

  @override
  String get composeNewPoll => 'استطلاع جديد';

  @override
  String get composeNewPollSubtitle => 'اطرح سؤالاً على المجتمع';

  @override
  String get composeNewEvent => 'فعالية جديدة';

  @override
  String get composeNewEventSubtitle => 'خطط للقاء أو تجمع';

  @override
  String get pollNewTitle => 'استطلاع جديد';

  @override
  String get pollQuestionLabel => 'السؤال';

  @override
  String get pollQuestionHint => 'مثال: أفضل حديقة للكلاب؟';

  @override
  String get pollQuestionRequired => 'يرجى إدخال سؤال';

  @override
  String get pollDescriptionLabel => 'الوصف (اختياري)';

  @override
  String get pollDescriptionHint => 'أضف مزيداً من التفاصيل';

  @override
  String get pollOptionsLabel => 'الخيارات';

  @override
  String pollOptionHint(int number) {
    return 'الخيار $number';
  }

  @override
  String get pollAddOption => 'إضافة خيار';

  @override
  String get pollOptionsMin => 'أضف خيارين على الأقل';

  @override
  String get pollAllowMultiple => 'السماح بخيارات متعددة';

  @override
  String get pollAllowMultipleSubtitle => 'دع المصوّتين يختارون أكثر من خيار';

  @override
  String get pollSetExpiry => 'تحديد تاريخ الإغلاق';

  @override
  String get pollExpiryLabel => 'يُغلق في';

  @override
  String get pollNoExpiry => 'بدون تاريخ إغلاق';

  @override
  String get pollCreateSubmit => 'إنشاء استطلاع';

  @override
  String get pollCreatedToast => 'تم إنشاء الاستطلاع';

  @override
  String get pollCreateFailed =>
      'تعذّر إنشاء الاستطلاع. يرجى المحاولة مرة أخرى.';

  @override
  String pollTotalVotes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أصوات',
      one: 'صوت واحد',
      zero: 'لا أصوات بعد',
    );
    return '$_temp0';
  }

  @override
  String pollClosesIn(String when) {
    return 'يُغلق $when';
  }

  @override
  String get pollClosed => 'الاستطلاع مغلق';

  @override
  String get pollJoinToVote => 'انضم للتصويت';

  @override
  String get pollTapToVote => 'اضغط على خيار للتصويت';

  @override
  String get pollChangeVote => 'اضغط لتغيير صوتك';

  @override
  String get pollRetractVote => 'إزالة صوتي';

  @override
  String get pollVoteFailed => 'تعذّر تسجيل صوتك';

  @override
  String get pollDeleteTitle => 'حذف الاستطلاع؟';

  @override
  String get pollDeleteMessage =>
      'سيؤدي هذا إلى إزالة الاستطلاع وأصواته نهائياً.';

  @override
  String get pollDeletedToast => 'تم حذف الاستطلاع';

  @override
  String get pollBadge => 'استطلاع';

  @override
  String get eventNewTitle => 'فعالية جديدة';

  @override
  String get eventTitleLabel => 'العنوان';

  @override
  String get eventTitleHint => 'مثال: حفلة الكفوف الصيفية';

  @override
  String get eventTitleRequired => 'يرجى إدخال عنوان';

  @override
  String get eventDescriptionLabel => 'الوصف (اختياري)';

  @override
  String get eventDescriptionHint => 'عن ماذا تدور هذه الفعالية؟';

  @override
  String get eventLocationLabel => 'الموقع (اختياري)';

  @override
  String get eventLocationHint => 'مثال: الحديقة المركزية، نيويورك';

  @override
  String get eventStartsLabel => 'يبدأ';

  @override
  String get eventEndsLabel => 'ينتهي (اختياري)';

  @override
  String get eventStartRequired => 'يرجى اختيار تاريخ ووقت البدء';

  @override
  String get eventStartMustBeFuture => 'يجب أن يكون البدء في المستقبل';

  @override
  String get eventEndAfterStart => 'يجب أن يكون الانتهاء بعد البدء';

  @override
  String get eventCreateSubmit => 'إنشاء الفعالية';

  @override
  String get eventEditTitle => 'تعديل الفعالية';

  @override
  String get eventUpdateSubmit => 'حفظ التغييرات';

  @override
  String get eventCreatedToast => 'تم إنشاء الفعالية';

  @override
  String get eventUpdatedToast => 'تم تحديث الفعالية';

  @override
  String get eventCreateFailed =>
      'تعذّر إنشاء الفعالية. يرجى المحاولة مرة أخرى.';

  @override
  String get eventBadge => 'فعالية';

  @override
  String get eventPast => 'فعالية سابقة';

  @override
  String get eventGoing => 'سأحضر';

  @override
  String get eventInterested => 'مهتم';

  @override
  String get eventCantGo => 'لا أستطيع';

  @override
  String eventAttendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سيحضرون',
      one: 'شخص واحد سيحضر',
      zero: 'لا أحد سيحضر بعد',
    );
    return '$_temp0';
  }

  @override
  String eventInterestedCount(int count) {
    return '$count مهتم';
  }

  @override
  String get eventJoinToRsvp => 'انضم للرد على الدعوة';

  @override
  String get eventViewAttendees => 'عرض الحاضرين';

  @override
  String get eventAttendeesTitle => 'الحاضرون';

  @override
  String get eventRsvpFailed => 'تعذّر تحديث ردك';

  @override
  String get eventDeleteTitle => 'حذف الفعالية؟';

  @override
  String get eventDeleteMessage => 'سيؤدي هذا إلى إزالة الفعالية نهائياً.';

  @override
  String get eventDeletedToast => 'تم حذف الفعالية';

  @override
  String get eventEdit => 'تعديل الفعالية';

  @override
  String get eventTabAttending => 'سأحضر';

  @override
  String get eventTabInterested => 'مهتم';

  @override
  String get eventTabDeclined => 'معتذر';

  @override
  String get eventNoAttendees => 'لا ردود بعد';

  @override
  String get eventDirections => 'الاتجاهات';

  @override
  String get eventDirectionsFailed => 'تعذّر فتح الخرائط';

  @override
  String get pawhubManagePet => 'إدارة الحيوان';

  @override
  String get pawhubComposerAddToPost => 'أضِف إلى منشورك';

  @override
  String get pawhubComposerAddToPostSubtitle => 'اختر مصدر الصورة أو الفيديو';

  @override
  String get pawhubComposerCameraSubtitle => 'التقط صورة';

  @override
  String get pawhubComposerGallerySubtitle => 'اختر من المعرض';

  @override
  String get pawhubComposerAddPhotosOrVideos => 'أضِف صوراً أو فيديوهات';

  @override
  String get pawhubComposerAddMedia => 'إضافة وسائط';

  @override
  String get pawhubComposerMediaLimit => 'حتى ١٠ عناصر';

  @override
  String get pawhubComposerCoverBadge => 'الغلاف';

  @override
  String get pawhubComposerTagPetsSubtitle => 'أضِف حيواناتك إلى هذا المنشور';

  @override
  String get pawhubComposerAddLocationSubtitle => 'شارِك مكان حدوث ذلك';

  @override
  String get pawhubComposerPostingIn => 'النشر في';

  @override
  String get pawhubComposerVideoLengthError =>
      'تعذّر قراءة مدة أحد الفيديوهات المحددة. يرجى إزالته وإضافته من جديد.';

  @override
  String get pawhubErrorPickingImage => 'تعذّر اختيار الصورة';

  @override
  String get pawhubErrorPickingMedia => 'تعذّر اختيار الوسائط';

  @override
  String get pawhubMyPostsLink => 'منشوراتي';

  @override
  String get pawHubActingAs => 'التصرّف باسم';

  @override
  String pawhubAlertReward(int amount) {
    return 'مكافأة ‎\$$amount';
  }

  @override
  String get pawhubEditComment => 'تعديل التعليق';

  @override
  String pawhubCommentsCountLabel(int count) {
    return '$count تعليقات';
  }

  @override
  String get pawhubCouldNotLoadComments => 'تعذّر تحميل التعليقات';

  @override
  String get pawhubCommentOptionDeleteComment => 'حذف التعليق';

  @override
  String get pawhubCommentOptionReportComment => 'الإبلاغ عن التعليق';

  @override
  String get pawhubBlockedTitle => 'الحيوانات المحظورة';

  @override
  String get pawhubBlockedFailed => 'تعذّر تحميل الحيوانات المحظورة';

  @override
  String get pawhubBlockedEmptyTitle => 'لا توجد حيوانات محظورة';

  @override
  String get pawhubBlockedEmptyMessage =>
      'لن تظهر الحيوانات التي تحظرها في موجزك';

  @override
  String get pawhubUnblock => 'إلغاء الحظر';

  @override
  String pawhubUnblockConfirmTitle(String name) {
    return 'إلغاء حظر $name؟';
  }

  @override
  String get pawhubUnblockConfirmMessage => 'سيتمكنون من رؤية منشوراتك مجدداً.';

  @override
  String pawhubUnfollowConfirmTitle(String name) {
    return 'إلغاء متابعة $name؟';
  }

  @override
  String pawhubUnfollowConfirmMessage(String name) {
    return 'لن ترى منشورات $name في موجزك';
  }

  @override
  String get pawhubUnfollow => 'إلغاء المتابعة';

  @override
  String get pawhubMyPostsTitle => 'منشوراتي';

  @override
  String get pawhubMyPostsFailed => 'تعذّر تحميل منشوراتك';

  @override
  String get pawhubMyPostsEmptyTitle => 'لا توجد منشورات بعد';

  @override
  String get pawhubMyPostsEmptyMessage => 'شارِك أول منشور لك مع المجتمع';

  @override
  String get pawhubDeletePostTitle => 'حذف المنشور؟';

  @override
  String get pawhubDeletePostMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get pawhubSavedTitle => 'المحفوظات';

  @override
  String get pawhubSavedFailed => 'تعذّر تحميل المنشورات المحفوظة';

  @override
  String get pawhubSavedEmptyTitle => 'لا توجد منشورات محفوظة بعد';

  @override
  String get pawhubSavedEmptyMessage =>
      'اضغط على علامة الحفظ في أي منشور لحفظه';

  @override
  String get pawhubFollowersTitle => 'المتابِعون';

  @override
  String pawhubFollowersTitleCount(int count) {
    return 'المتابِعون ($count)';
  }

  @override
  String get pawhubFollowersFailed => 'تعذّر تحميل المتابِعين';

  @override
  String get pawhubFollowersEmptyTitle => 'لا يوجد متابِعون بعد';

  @override
  String get pawhubFollowingTitle => 'المتابَعون';

  @override
  String pawhubFollowingTitleCount(int count) {
    return 'المتابَعون ($count)';
  }

  @override
  String get pawhubFollowingFailed => 'تعذّر تحميل قائمة المتابَعين';

  @override
  String get pawhubFollowingEmptyTitle => 'لا تتابِع أحداً بعد';

  @override
  String get pawhubTrendingTitle => 'الرائج';

  @override
  String get pawhubTrendingFailed => 'تعذّر تحميل الرائج';

  @override
  String get pawhubTrendingHashtags => 'الوسوم الرائجة';

  @override
  String get pawhubTopPosts => 'أبرز المنشورات';

  @override
  String pawhubHashtagPostsCount(int count) {
    return '$count منشورات';
  }

  @override
  String get pawhubSearchTitle => 'ابحث في PawHub';

  @override
  String get pawhubSearchSubtitle => 'ابحث عن حيوانات أو منشورات أو وسوم';

  @override
  String get pawhubSearchScopeAll => 'الكل';

  @override
  String get pawhubSearchScopePosts => 'المنشورات';

  @override
  String get pawhubSearchScopeHashtags => 'الوسوم';

  @override
  String get pawhubSearchScopePets => 'الحيوانات';

  @override
  String pawhubSearchNoResults(String query) {
    return 'لا نتائج لـ \"$query\"';
  }

  @override
  String get pawhubSearchTryDifferent => 'جرّب كلمة مختلفة';

  @override
  String get pawhubSearchSectionPets => 'الحيوانات';

  @override
  String get pawhubSearchSectionHashtags => 'الوسوم';

  @override
  String get pawhubSearchSectionPosts => 'المنشورات';

  @override
  String pawhubSearchPostBy(String name) {
    return 'بواسطة $name';
  }

  @override
  String get pawhubHashtagFailed => 'تعذّر تحميل المنشورات';

  @override
  String pawhubHashtagEmpty(String hashtag) {
    return 'لا توجد منشورات بعد لـ #$hashtag';
  }

  @override
  String get pawhubPostTitle => 'المنشور';

  @override
  String get pawhubPostFailed => 'تعذّر تحميل المنشور';

  @override
  String get pawhubProfileFailedPosts => 'تعذّر تحميل المنشورات';

  @override
  String get pawhubProfileNoPosts => 'لا توجد منشورات بعد';

  @override
  String get pawhubTagPetsTitle => 'الإشارة إلى حيوانات';

  @override
  String get pawhubTagPetsSearchHint => 'ابحث عن الحيوانات بالاسم…';

  @override
  String get pawhubTagPetsNoMatch => 'لم يُعثر على أي حيوان.';

  @override
  String get pawhubTagPetsResults => 'النتائج';

  @override
  String pawhubTagPetsTaggedCount(int count) {
    return 'المُشار إليها ($count)';
  }

  @override
  String get pawhubTagPetsMyPets => 'حيواناتي';

  @override
  String get pawhubTagPetsEmpty => 'ليس لديك حيوانات للإشارة إليها بعد.';

  @override
  String get pawhubDiscoverEmptyTitle => 'لا شيء لاكتشافه بعد';

  @override
  String get pawhubDiscoverEmptyMessage =>
      'ستظهر منشورات جديدة من المجتمع هنا قريباً 🐾';

  @override
  String get pawhubSavedPostsTooltip => 'المنشورات المحفوظة';

  @override
  String get pawhubComposerLocationHint => 'ابحث أو انقر على الخريطة';

  @override
  String get locationResolving => 'جارٍ تحديد العنوان…';

  @override
  String get pawhubLike => 'إعجاب';

  @override
  String get pawhubComment => 'تعليق';

  @override
  String get communityMembersEmptyTitle => 'لا أعضاء بعد';

  @override
  String get communityMembersEmptyMessage => 'كن أول من ينضم إلى هذا المجتمع.';

  @override
  String get pawhubTrendingEmptyTitle => 'لا شيء رائج بعد';

  @override
  String get pawhubTrendingEmptyMessage =>
      'ستظهر الوسوم والمنشورات الرائجة هنا مع نمو المجتمع.';

  @override
  String get pawhubBack => 'رجوع';

  @override
  String get pawhubMoreOptions => 'خيارات أخرى';

  @override
  String get pawhubRemoveOption => 'إزالة الخيار';

  @override
  String get pawhubRemoveTag => 'إزالة الوسم';

  @override
  String get pawhubViewPost => 'عرض المنشور';

  @override
  String get pawhubViewProfile => 'عرض الملف الشخصي';

  @override
  String get pawhubExpandMap => 'توسيع الخريطة';

  @override
  String get pawhubComposerSetCover => 'تعيين غلاف';

  @override
  String get pawhubComposerChangeCover => 'تغيير الغلاف';

  @override
  String get pawhubComposerLocationFieldHint => 'مثال: بيروت، لبنان';

  @override
  String pawhubComposerTaggedSummary(String name, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count آخرين',
      one: '1 آخر',
    );
    return '$name و$_temp0';
  }
}
