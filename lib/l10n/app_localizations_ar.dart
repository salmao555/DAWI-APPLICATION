// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navDocuments => 'المستندات';

  @override
  String get navHealth => 'صحتي';

  @override
  String get navAssistant => 'المساعد';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get onboardingSkip => 'تخطٍّ';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboarding1Title => 'افهم مستنداتك الطبية';

  @override
  String get onboarding1Body =>
      'امسح أو استورد وصفاتك الطبية ونتائج تحاليلك وملفاتك الطبية، وسنساعدك على فهمها.';

  @override
  String get onboarding2Title => 'صحتك في مكان واحد';

  @override
  String get onboarding2Body =>
      'المستندات والأدوية والمواعيد والأطباء، كلها منظمة في مكان واحد.';

  @override
  String get onboarding3Title => 'المساعد الصحي الذكي';

  @override
  String get onboarding3Body =>
      'اطرح أسئلتك بلغة بسيطة، واحصل على شرح للمصطلحات الطبية وملخصات لمعلوماتك المؤكَّدة.';

  @override
  String get onboarding4Title => 'التذكيرات والمتابعة';

  @override
  String get onboarding4Body =>
      'لا تفوّت أي جرعة أو موعد، مع تذكيرات وإرشادات صحية عامة تناسبك.';
}
