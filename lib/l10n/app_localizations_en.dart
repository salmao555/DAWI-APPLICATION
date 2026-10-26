// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Home';

  @override
  String get navDocuments => 'Documents';

  @override
  String get navHealth => 'Health';

  @override
  String get navAssistant => 'Assistant';

  @override
  String get navProfile => 'Profile';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Get started';

  @override
  String get onboarding1Title => 'Understand your documents';

  @override
  String get onboarding1Body =>
      'Scan or import your prescriptions, lab reports, and medical records — we help you make sense of them.';

  @override
  String get onboarding2Title => 'Centralize your health';

  @override
  String get onboarding2Body =>
      'Documents, medications, appointments, and doctors, all organized in one place.';

  @override
  String get onboarding3Title => 'AI Health Assistant';

  @override
  String get onboarding3Body =>
      'Ask questions in plain language and get explanations of medical terms and summaries of your validated information.';

  @override
  String get onboarding4Title => 'Reminders & Monitoring';

  @override
  String get onboarding4Body =>
      'Never miss a dose or an appointment, with reminders and general health guidance tailored to you.';
}
