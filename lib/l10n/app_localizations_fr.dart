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

  @override
  String get back => 'Retour';

  @override
  String get loginTitle => 'Bon retour';

  @override
  String get loginSubtitle =>
      'Connectez-vous pour accéder à votre tableau de bord santé.';

  @override
  String get fieldEmail => 'E-mail';

  @override
  String get fieldPassword => 'Mot de passe';

  @override
  String get validationEmail => 'Saisissez un e-mail valide';

  @override
  String get validationPasswordLength => 'Au moins 8 caractères';

  @override
  String get forgotPasswordLink => 'Mot de passe oublié ?';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginFailed => 'Échec de la connexion';

  @override
  String get noAccountLink => 'Pas encore de compte ? Créez-en un';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerSubtitle =>
      'Rejoignez DAWI pour garder votre santé bien organisée.';

  @override
  String get fieldFirstName => 'Prénom';

  @override
  String get fieldLastName => 'Nom';

  @override
  String get fieldPhone => 'Téléphone';

  @override
  String get fieldConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get fieldPreferredLanguage => 'Langue préférée';

  @override
  String get validationRequired => 'Obligatoire';

  @override
  String get validationPasswordsMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get registerButton => 'Créer un compte';

  @override
  String get registerFailed => 'Échec de l\'inscription';

  @override
  String get resetTitle => 'Réinitialiser le mot de passe';

  @override
  String get resetSubtitle =>
      'Nous allons vous aider à retrouver l\'accès à votre compte.';

  @override
  String get resetIntro =>
      'Saisissez votre e-mail et nous vous enverrons un lien pour réinitialiser votre mot de passe.';

  @override
  String get resetSendButton => 'Envoyer le lien';

  @override
  String resetSent(String email) {
    return 'Si un compte existe pour $email, un lien de réinitialisation a été envoyé.';
  }

  @override
  String get backToLogin => 'Retour à la connexion';

  @override
  String get docTypePrescription => 'Ordonnance';

  @override
  String get docTypeLabReport => 'Analyse de laboratoire';

  @override
  String get docTypeMedicalReport => 'Compte rendu médical';

  @override
  String get docTypeCertificate => 'Certificat';

  @override
  String get docTypeImaging => 'Imagerie';

  @override
  String get docTypeOther => 'Autre';

  @override
  String get medStatusActive => 'En cours';

  @override
  String get medStatusCompleted => 'Terminé';

  @override
  String get medStatusUpcoming => 'À venir';

  @override
  String get apptStatusUpcoming => 'à venir';

  @override
  String get apptStatusCompleted => 'terminé';

  @override
  String get apptStatusCancelled => 'annulé';

  @override
  String get scanWithCamera => 'Scanner avec l\'appareil photo';

  @override
  String get uploadFromGallery => 'Importer depuis la galerie';

  @override
  String errorCameraAccess(String error) {
    return 'Impossible d\'accéder à l\'appareil photo ou à la galerie : $error';
  }

  @override
  String get analyzingDocument => 'Analyse de votre document…';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String homeSubtitle(String greeting) {
    return '$greeting · Comment vous sentez-vous aujourd\'hui ?';
  }

  @override
  String homeWelcomeName(String name) {
    return 'Bienvenue, $name !';
  }

  @override
  String get homeWelcome => 'Bienvenue !';

  @override
  String homeLoadError(String error) {
    return 'Impossible de charger votre tableau de bord.\n$error';
  }

  @override
  String get askBarHint => 'Posez votre question à DAWI…';

  @override
  String get quickScanDocument => 'Scanner un document';

  @override
  String get quickAskAi => 'Demander à l\'IA';

  @override
  String get quickMedications => 'Médicaments';

  @override
  String get quickAppointments => 'Rendez-vous';

  @override
  String statTreatments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Traitements',
      one: 'Traitement',
    );
    return '$_temp0';
  }

  @override
  String statAppointments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Rendez-vous',
      one: 'Rendez-vous',
    );
    return '$_temp0';
  }

  @override
  String statDocuments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Documents',
      one: 'Document',
    );
    return '$_temp0';
  }

  @override
  String get sectionCategories => 'Catégories';

  @override
  String get sectionTodaysReminders => 'Rappels du jour';

  @override
  String get nothingScheduledToday => 'Rien de prévu aujourd\'hui.';

  @override
  String get sectionRecentActivity => 'Activité récente';

  @override
  String get noRecentActivity =>
      'Aucune activité récente — scannez votre premier document pour commencer.';

  @override
  String get appointmentFallback => 'Rendez-vous';

  @override
  String documentAdded(String type) {
    return '$type ajouté';
  }

  @override
  String alertAppointment(String date) {
    return 'Votre rendez-vous est le $date.';
  }

  @override
  String alertAppointmentAt(String date, String time) {
    return 'Votre rendez-vous est le $date à $time.';
  }

  @override
  String alertSpecialty(String specialty, String date) {
    return 'Votre rendez-vous ($specialty) est le $date.';
  }

  @override
  String alertSpecialtyAt(String specialty, String date, String time) {
    return 'Votre rendez-vous ($specialty) est le $date à $time.';
  }

  @override
  String get previousMonth => 'Mois précédent';

  @override
  String get nextMonth => 'Mois suivant';

  @override
  String get viewAllAppointments => 'Voir tous les rendez-vous';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileFallbackName => 'Votre profil';

  @override
  String get sectionPersonalInfo => 'Informations personnelles';

  @override
  String get sectionAccount => 'Compte';

  @override
  String get notSet => 'Non renseigné';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get privacySecurity => 'Confidentialité et sécurité';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get chooseLanguage => 'Choisissez votre langue';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get scanDocument => 'Scanner un document';

  @override
  String get useYourCamera => 'Utilisez votre appareil photo';

  @override
  String get photosFormats => 'Photos, JPG ou PNG';

  @override
  String get addDocument => 'Ajouter un document';

  @override
  String get filterAll => 'Tous';

  @override
  String documentsLoadError(String error) {
    return 'Impossible de charger les documents.\n$error';
  }

  @override
  String get noDocumentsYet => 'Aucun document médical pour l\'instant.';

  @override
  String get deleteDocumentTitle => 'Supprimer le document ?';

  @override
  String get deleteDocumentBody =>
      'Le document et les médicaments extraits seront supprimés.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get documentDetailsTitle => 'Détails du document';

  @override
  String documentLoadError(String error) {
    return 'Impossible de charger ce document.\n$error';
  }

  @override
  String get labelType => 'Type';

  @override
  String get labelDoctor => 'Médecin';

  @override
  String get labelClinic => 'Clinique';

  @override
  String get labelDate => 'Date';

  @override
  String get unknown => 'Inconnu';

  @override
  String get aiExplanation => 'Explication IA';

  @override
  String get askAi => 'Demander à l\'IA';

  @override
  String get sectionMedications => 'Médicaments';

  @override
  String couldNotSave(String error) {
    return 'Enregistrement impossible : $error';
  }

  @override
  String get ocrTitle => 'Analyse de votre document';

  @override
  String get fieldDocumentType => 'Type de document';

  @override
  String get fieldClinic => 'Clinique / hôpital';

  @override
  String get fieldDateOptional => 'Date (facultative, AAAA-MM-JJ)';

  @override
  String get extractedMedications => 'Médicaments extraits';

  @override
  String get noMedicationsDetected =>
      'Aucun médicament n\'a été détecté dans ce document. Vous pouvez quand même l\'enregistrer.';

  @override
  String get confirmInformation => 'Confirmer les informations';

  @override
  String get fieldDose => 'Dose';

  @override
  String get fieldFrequency => 'Fréquence';

  @override
  String get fieldTiming => 'Moment de prise';

  @override
  String get medicationsTitle => 'Médicaments';

  @override
  String get addMedication => 'Ajouter un médicament';

  @override
  String get medicationsLoadError => 'Impossible de charger les médicaments.';

  @override
  String get noMedicationsHere => 'Aucun médicament ici pour l\'instant.';

  @override
  String get fieldMedicationName => 'Nom du médicament';

  @override
  String get fieldStatus => 'Statut';

  @override
  String get save => 'Enregistrer';

  @override
  String get medicationDetailsTitle => 'Détails du médicament';

  @override
  String get medicationLoadError => 'Impossible de charger ce médicament.';

  @override
  String get labelPrescribedBy => 'Prescrit par';

  @override
  String get labelStartDate => 'Date de début';

  @override
  String get labelEndDate => 'Date de fin';

  @override
  String get reminderSchedule => 'Horaires des rappels';

  @override
  String get slotMorning => 'Matin';

  @override
  String get slotAfternoon => 'Après-midi';

  @override
  String get slotEvening => 'Soir';

  @override
  String get slotCustom => 'Personnalisé';

  @override
  String reminderSetFor(String slots) {
    return 'Rappel programmé : $slots';
  }

  @override
  String get createReminder => 'Créer un rappel';

  @override
  String get appointmentsTitle => 'Rendez-vous';

  @override
  String get addAppointment => 'Ajouter un rendez-vous';

  @override
  String get appointmentsLoadError => 'Impossible de charger les rendez-vous.';

  @override
  String get noUpcomingAppointments => 'Aucun rendez-vous à venir.';

  @override
  String get fieldSpecialty => 'Spécialité / motif de la visite';

  @override
  String get fieldDate => 'Date (AAAA-MM-JJ)';

  @override
  String get fieldTime => 'Heure (HH:MM)';

  @override
  String get fieldLocation => 'Lieu';

  @override
  String get fieldNotesOptional => 'Notes (facultatif)';

  @override
  String get chatSuggest1 => 'Explique-moi ce document.';

  @override
  String get chatSuggest2 => 'Que signifie ce terme médical ?';

  @override
  String get chatSuggest3 => 'Résume mes dernières analyses.';

  @override
  String get chatSuggest4 => 'Quels sont mes prochains rendez-vous ?';

  @override
  String get chatSuggest5 => 'Rappelle-moi mes médicaments.';

  @override
  String get chatSuggest6 => 'Prépare des questions pour mon médecin.';

  @override
  String get chatGreeting =>
      'Bonjour ! Comment puis-je vous aider aujourd\'hui ?';

  @override
  String chatUnavailable(String error) {
    return 'L\'assistant IA est momentanément indisponible : $error';
  }

  @override
  String get chatTitle => 'Assistant santé';

  @override
  String get chatInputHint => 'Posez votre question à l\'assistant santé…';

  @override
  String get myHealthTitle => 'Ma santé';

  @override
  String get aiHealthSummary => 'Résumé santé IA';

  @override
  String medicalRecordLoadError(String error) {
    return 'Impossible de charger votre dossier médical.\n$error';
  }

  @override
  String get sectionPersonalInformation => 'Informations personnelles';

  @override
  String get edit => 'Modifier';

  @override
  String get noHealthProfile => 'Aucun profil santé ajouté pour l\'instant.';

  @override
  String get labelDateOfBirth => 'Date de naissance';

  @override
  String get labelBloodGroup => 'Groupe sanguin';

  @override
  String get labelAllergies => 'Allergies';

  @override
  String get labelConditions => 'Maladies';

  @override
  String get labelEmergencyContact => 'Contact d\'urgence';

  @override
  String get sectionActiveMedications => 'Médicaments en cours';

  @override
  String get noActiveMedications => 'Aucun médicament en cours.';

  @override
  String get sectionDoctors => 'Médecins';

  @override
  String get noDoctorsYet => 'Aucun médecin ajouté pour l\'instant.';

  @override
  String get sectionRecentDocuments => 'Documents récents';

  @override
  String get noDocumentsShort => 'Aucun document pour l\'instant.';

  @override
  String documentSource(String type) {
    return 'Source : $type';
  }

  @override
  String documentSourceDated(String type, String date) {
    return 'Source : $type — $date';
  }

  @override
  String get askAssistant => 'Demander à l\'assistant';

  @override
  String get healthProfileTitle => 'Profil santé';

  @override
  String get fieldDateOfBirth => 'Date de naissance (AAAA-MM-JJ)';

  @override
  String get fieldKnownConditions => 'Maladies connues';

  @override
  String get fieldEmergencyName => 'Nom du contact d\'urgence';

  @override
  String get fieldEmergencyPhone => 'Téléphone du contact d\'urgence';

  @override
  String get saveAndContinue => 'Enregistrer et continuer';

  @override
  String aiSummaryUnavailable(String error) {
    return 'L\'assistant IA est momentanément indisponible.\n$error';
  }

  @override
  String get summaryCurrentSituation => 'Situation actuelle';

  @override
  String get summaryCurrentTreatments => 'Traitements en cours';

  @override
  String get summaryRecentAnalyses => 'Analyses récentes';

  @override
  String get summaryUpcomingAppointments => 'Rendez-vous à venir';

  @override
  String get summaryImportantInfo => 'Informations importantes';

  @override
  String get summaryRecommendations => 'Recommandations générales';
}
