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
  String goodMorning(String name) {
    return 'صباح الخير، $name 👋';
  }

  @override
  String goodAfternoon(String name) {
    return 'مساء الخير، $name 👋';
  }

  @override
  String goodEvening(String name) {
    return 'مساء الخير، $name 👋';
  }

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
}
