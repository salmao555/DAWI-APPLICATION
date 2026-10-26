// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navDocuments => 'Documents';

  @override
  String get navHealth => 'Santé';

  @override
  String get navAssistant => 'Assistant';

  @override
  String get navProfile => 'Profil';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get onboarding1Title => 'Comprenez vos documents';

  @override
  String get onboarding1Body =>
      'Scannez ou importez vos ordonnances, analyses et dossiers médicaux — nous vous aidons à les comprendre.';

  @override
  String get onboarding2Title => 'Centralisez votre santé';

  @override
  String get onboarding2Body =>
      'Documents, médicaments, rendez-vous et médecins, tout est organisé au même endroit.';

  @override
  String get onboarding3Title => 'Assistant santé IA';

  @override
  String get onboarding3Body =>
      'Posez vos questions simplement et obtenez des explications sur les termes médicaux et des résumés de vos informations validées.';

  @override
  String get onboarding4Title => 'Rappels et suivi';

  @override
  String get onboarding4Body =>
      'Ne manquez plus aucune prise ni aucun rendez-vous grâce à des rappels et des conseils de santé adaptés à vous.';
}
