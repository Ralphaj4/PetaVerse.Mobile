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
