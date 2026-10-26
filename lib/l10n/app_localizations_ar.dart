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

  @override
  String get back => 'رجوع';

  @override
  String get loginTitle => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'سجّل الدخول للوصول إلى لوحة صحتك.';

  @override
  String get fieldEmail => 'البريد الإلكتروني';

  @override
  String get fieldPassword => 'كلمة المرور';

  @override
  String get validationEmail => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get validationPasswordLength => '8 أحرف على الأقل';

  @override
  String get forgotPasswordLink => 'نسيت كلمة المرور؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginFailed => 'تعذّر تسجيل الدخول';

  @override
  String get noAccountLink => 'ليس لديك حساب؟ أنشئ حسابًا';

  @override
  String get registerTitle => 'إنشاء حساب';

  @override
  String get registerSubtitle => 'انضم إلى داوي لتنظيم معلوماتك الصحية.';

  @override
  String get fieldFirstName => 'الاسم الشخصي';

  @override
  String get fieldLastName => 'اسم العائلة';

  @override
  String get fieldPhone => 'الهاتف';

  @override
  String get fieldConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get fieldPreferredLanguage => 'اللغة المفضلة';

  @override
  String get validationRequired => 'حقل مطلوب';

  @override
  String get validationPasswordsMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get registerButton => 'إنشاء الحساب';

  @override
  String get registerFailed => 'تعذّر إنشاء الحساب';

  @override
  String get resetTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetSubtitle => 'سنساعدك على استعادة الوصول إلى حسابك.';

  @override
  String get resetIntro =>
      'أدخل بريدك الإلكتروني وسنرسل إليك رابطًا لإعادة تعيين كلمة المرور.';

  @override
  String get resetSendButton => 'إرسال الرابط';

  @override
  String resetSent(String email) {
    return 'إذا كان هناك حساب مرتبط بـ $email، فقد أرسلنا إليه رابط إعادة التعيين.';
  }

  @override
  String get backToLogin => 'العودة إلى تسجيل الدخول';

  @override
  String get docTypePrescription => 'وصفة طبية';

  @override
  String get docTypeLabReport => 'تحليل مخبري';

  @override
  String get docTypeMedicalReport => 'تقرير طبي';

  @override
  String get docTypeCertificate => 'شهادة طبية';

  @override
  String get docTypeImaging => 'تصوير طبي';

  @override
  String get docTypeOther => 'أخرى';

  @override
  String get medStatusActive => 'جارٍ';

  @override
  String get medStatusCompleted => 'منتهٍ';

  @override
  String get medStatusUpcoming => 'قادم';

  @override
  String get apptStatusUpcoming => 'قادم';

  @override
  String get apptStatusCompleted => 'منتهٍ';

  @override
  String get apptStatusCancelled => 'ملغى';

  @override
  String get scanWithCamera => 'المسح بالكاميرا';

  @override
  String get uploadFromGallery => 'الرفع من معرض الصور';

  @override
  String errorCameraAccess(String error) {
    return 'تعذّر الوصول إلى الكاميرا أو معرض الصور: $error';
  }

  @override
  String get analyzingDocument => 'جارٍ تحليل مستندك...';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'مساء الخير';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String homeSubtitle(String greeting) {
    return '$greeting · كيف تشعر اليوم؟';
  }

  @override
  String homeWelcomeName(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get homeWelcome => 'مرحبًا!';

  @override
  String homeLoadError(String error) {
    return 'تعذّر تحميل لوحة المعلومات.\n$error';
  }

  @override
  String get askBarHint => 'اسأل داوي عن أي شيء...';

  @override
  String get quickScanDocument => 'مسح مستند';

  @override
  String get quickAskAi => 'اسأل المساعد';

  @override
  String get quickMedications => 'الأدوية';

  @override
  String get quickAppointments => 'المواعيد';

  @override
  String statTreatments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'علاج',
      many: 'علاجًا',
      few: 'علاجات',
      two: 'علاجان',
      one: 'علاج',
      zero: 'علاجات',
    );
    return '$_temp0';
  }

  @override
  String statAppointments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'موعد',
      many: 'موعدًا',
      few: 'مواعيد',
      two: 'موعدان',
      one: 'موعد',
      zero: 'مواعيد',
    );
    return '$_temp0';
  }

  @override
  String statDocuments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'مستند',
      many: 'مستندًا',
      few: 'مستندات',
      two: 'مستندان',
      one: 'مستند',
      zero: 'مستندات',
    );
    return '$_temp0';
  }

  @override
  String get sectionCategories => 'الفئات';

  @override
  String get sectionTodaysReminders => 'تذكيرات اليوم';

  @override
  String get nothingScheduledToday => 'لا شيء مُجدول لليوم.';

  @override
  String get sectionRecentActivity => 'النشاط الأخير';

  @override
  String get noRecentActivity =>
      'لا يوجد نشاط حديث بعد. امسح مستندك الأول للبدء.';

  @override
  String get appointmentFallback => 'موعد';

  @override
  String documentAdded(String type) {
    return 'تمت إضافة $type';
  }

  @override
  String alertAppointment(String date) {
    return 'موعدك يوم $date.';
  }

  @override
  String alertAppointmentAt(String date, String time) {
    return 'موعدك يوم $date على الساعة $time.';
  }

  @override
  String alertSpecialty(String specialty, String date) {
    return 'موعدك ($specialty) يوم $date.';
  }

  @override
  String alertSpecialtyAt(String specialty, String date, String time) {
    return 'موعدك ($specialty) يوم $date على الساعة $time.';
  }

  @override
  String get previousMonth => 'الشهر السابق';

  @override
  String get nextMonth => 'الشهر التالي';

  @override
  String get viewAllAppointments => 'عرض كل المواعيد';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileFallbackName => 'ملفك الشخصي';

  @override
  String get sectionPersonalInfo => 'المعلومات الشخصية';

  @override
  String get sectionAccount => 'الحساب';

  @override
  String get notSet => 'غير محدد';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get privacySecurity => 'الخصوصية والأمان';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get chooseLanguage => 'اختر لغتك';

  @override
  String get documentsTitle => 'المستندات';

  @override
  String get scanDocument => 'مسح مستند';

  @override
  String get useYourCamera => 'استخدم الكاميرا';

  @override
  String get photosFormats => 'صور بصيغة JPG أو PNG';

  @override
  String get addDocument => 'إضافة مستند';

  @override
  String get filterAll => 'الكل';

  @override
  String documentsLoadError(String error) {
    return 'تعذّر تحميل المستندات.\n$error';
  }

  @override
  String get noDocumentsYet => 'لا توجد مستندات طبية بعد.';

  @override
  String get deleteDocumentTitle => 'حذف المستند؟';

  @override
  String get deleteDocumentBody => 'سيتم حذف المستند والأدوية المستخرجة منه.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get documentDetailsTitle => 'تفاصيل المستند';

  @override
  String documentLoadError(String error) {
    return 'تعذّر تحميل هذا المستند.\n$error';
  }

  @override
  String get labelType => 'النوع';

  @override
  String get labelDoctor => 'الطبيب';

  @override
  String get labelClinic => 'العيادة';

  @override
  String get labelDate => 'التاريخ';

  @override
  String get unknown => 'غير معروف';

  @override
  String get aiExplanation => 'الشرح الذكي';

  @override
  String get askAi => 'اسأل المساعد';

  @override
  String get sectionMedications => 'الأدوية';

  @override
  String couldNotSave(String error) {
    return 'تعذّر الحفظ: $error';
  }

  @override
  String get ocrTitle => 'تحليل مستندك';

  @override
  String get fieldDocumentType => 'نوع المستند';

  @override
  String get fieldClinic => 'العيادة / المستشفى';

  @override
  String get fieldDateOptional => 'التاريخ (اختياري، YYYY-MM-DD)';

  @override
  String get extractedMedications => 'الأدوية المستخرجة';

  @override
  String get noMedicationsDetected =>
      'لم يتم العثور على أدوية في هذا المستند. يمكنك حفظه مع ذلك.';

  @override
  String get confirmInformation => 'تأكيد المعلومات';

  @override
  String get fieldDose => 'الجرعة';

  @override
  String get fieldFrequency => 'عدد المرات';

  @override
  String get fieldTiming => 'توقيت الأخذ';

  @override
  String get medicationsTitle => 'الأدوية';

  @override
  String get addMedication => 'إضافة دواء';

  @override
  String get medicationsLoadError => 'تعذّر تحميل الأدوية.';

  @override
  String get noMedicationsHere => 'لا توجد أدوية هنا بعد.';

  @override
  String get fieldMedicationName => 'اسم الدواء';

  @override
  String get fieldStatus => 'الحالة';

  @override
  String get save => 'حفظ';

  @override
  String get medicationDetailsTitle => 'تفاصيل الدواء';

  @override
  String get medicationLoadError => 'تعذّر تحميل هذا الدواء.';

  @override
  String get labelPrescribedBy => 'وصفه';

  @override
  String get labelStartDate => 'تاريخ البدء';

  @override
  String get labelEndDate => 'تاريخ الانتهاء';

  @override
  String get reminderSchedule => 'مواعيد التذكير';

  @override
  String get slotMorning => 'الصباح';

  @override
  String get slotAfternoon => 'بعد الظهر';

  @override
  String get slotEvening => 'المساء';

  @override
  String get slotCustom => 'مخصص';

  @override
  String reminderSetFor(String slots) {
    return 'تم ضبط التذكير: $slots';
  }

  @override
  String get createReminder => 'إنشاء تذكير';

  @override
  String get appointmentsTitle => 'المواعيد';

  @override
  String get addAppointment => 'إضافة موعد';

  @override
  String get appointmentsLoadError => 'تعذّر تحميل المواعيد.';

  @override
  String get noUpcomingAppointments => 'لا توجد مواعيد قادمة.';

  @override
  String get fieldSpecialty => 'التخصص / سبب الزيارة';

  @override
  String get fieldDate => 'التاريخ (YYYY-MM-DD)';

  @override
  String get fieldTime => 'الوقت (HH:MM)';

  @override
  String get fieldLocation => 'المكان';

  @override
  String get fieldNotesOptional => 'ملاحظات (اختياري)';

  @override
  String get chatSuggest1 => 'اشرح لي هذا المستند.';

  @override
  String get chatSuggest2 => 'ما معنى هذا المصطلح الطبي؟';

  @override
  String get chatSuggest3 => 'لخّص آخر تحاليلي.';

  @override
  String get chatSuggest4 => 'ما هي مواعيدي القادمة؟';

  @override
  String get chatSuggest5 => 'ذكّرني بأدويتي.';

  @override
  String get chatSuggest6 => 'حضّر أسئلة لطبيبي.';

  @override
  String get chatGreeting => 'مرحبًا! كيف يمكنني مساعدتك اليوم؟';

  @override
  String chatUnavailable(String error) {
    return 'المساعد الذكي غير متاح مؤقتًا: $error';
  }

  @override
  String get chatTitle => 'المساعد الصحي';

  @override
  String get chatInputHint => 'اطرح سؤالك على المساعد الصحي...';

  @override
  String get myHealthTitle => 'صحتي';

  @override
  String get aiHealthSummary => 'الملخص الصحي الذكي';

  @override
  String medicalRecordLoadError(String error) {
    return 'تعذّر تحميل ملفك الطبي.\n$error';
  }

  @override
  String get sectionPersonalInformation => 'المعلومات الشخصية';

  @override
  String get edit => 'تعديل';

  @override
  String get noHealthProfile => 'لم تُضِف ملفًا صحيًا بعد.';

  @override
  String get labelDateOfBirth => 'تاريخ الميلاد';

  @override
  String get labelBloodGroup => 'فصيلة الدم';

  @override
  String get labelAllergies => 'الحساسية';

  @override
  String get labelConditions => 'الأمراض';

  @override
  String get labelEmergencyContact => 'جهة الاتصال في حالات الطوارئ';

  @override
  String get sectionActiveMedications => 'الأدوية الحالية';

  @override
  String get noActiveMedications => 'لا توجد أدوية حالية.';

  @override
  String get sectionDoctors => 'الأطباء';

  @override
  String get noDoctorsYet => 'لم تتم إضافة أطباء بعد.';

  @override
  String get sectionRecentDocuments => 'المستندات الأخيرة';

  @override
  String get noDocumentsShort => 'لا توجد مستندات بعد.';

  @override
  String documentSource(String type) {
    return 'المصدر: $type';
  }

  @override
  String documentSourceDated(String type, String date) {
    return 'المصدر: $type — $date';
  }

  @override
  String get askAssistant => 'اسأل المساعد';

  @override
  String get healthProfileTitle => 'الملف الصحي';

  @override
  String get fieldDateOfBirth => 'تاريخ الميلاد (YYYY-MM-DD)';

  @override
  String get fieldKnownConditions => 'الأمراض المعروفة';

  @override
  String get fieldEmergencyName => 'اسم جهة الاتصال في الطوارئ';

  @override
  String get fieldEmergencyPhone => 'هاتف جهة الاتصال في الطوارئ';

  @override
  String get saveAndContinue => 'حفظ ومتابعة';

  @override
  String aiSummaryUnavailable(String error) {
    return 'المساعد الذكي غير متاح مؤقتًا.\n$error';
  }

  @override
  String get summaryCurrentSituation => 'الوضع الحالي';

  @override
  String get summaryCurrentTreatments => 'العلاجات الحالية';

  @override
  String get summaryRecentAnalyses => 'التحاليل الأخيرة';

  @override
  String get summaryUpcomingAppointments => 'المواعيد القادمة';

  @override
  String get summaryImportantInfo => 'معلومات مهمة';

  @override
  String get summaryRecommendations => 'توصيات عامة';
}
