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

  @override
  String get back => 'Back';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to access your health dashboard.';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPassword => 'Password';

  @override
  String get validationEmail => 'Enter a valid email';

  @override
  String get validationPasswordLength => 'At least 8 characters';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String get loginButton => 'Login';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get noAccountLink => 'Don\'t have an account? Create one';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerSubtitle => 'Join DAWI to keep your health organized.';

  @override
  String get fieldFirstName => 'First name';

  @override
  String get fieldLastName => 'Last name';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get fieldConfirmPassword => 'Confirm password';

  @override
  String get fieldPreferredLanguage => 'Preferred language';

  @override
  String get validationRequired => 'Required';

  @override
  String get validationPasswordsMismatch => 'Passwords do not match';

  @override
  String get registerButton => 'Create account';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get resetTitle => 'Reset password';

  @override
  String get resetSubtitle => 'We\'ll help you get back into your account.';

  @override
  String get resetIntro =>
      'Enter your email and we\'ll send you a link to reset your password.';

  @override
  String get resetSendButton => 'Send reset link';

  @override
  String resetSent(String email) {
    return 'If an account exists for $email, a reset link has been sent.';
  }

  @override
  String get backToLogin => 'Back to login';

  @override
  String get docTypePrescription => 'Prescription';

  @override
  String get docTypeLabReport => 'Lab Report';

  @override
  String get docTypeMedicalReport => 'Medical Report';

  @override
  String get docTypeCertificate => 'Certificate';

  @override
  String get docTypeImaging => 'Imaging';

  @override
  String get docTypeOther => 'Other';

  @override
  String get medStatusActive => 'Active';

  @override
  String get medStatusCompleted => 'Completed';

  @override
  String get medStatusUpcoming => 'Upcoming';

  @override
  String get apptStatusUpcoming => 'upcoming';

  @override
  String get apptStatusCompleted => 'completed';

  @override
  String get apptStatusCancelled => 'cancelled';

  @override
  String get scanWithCamera => 'Scan with camera';

  @override
  String get uploadFromGallery => 'Upload from gallery';

  @override
  String errorCameraAccess(String error) {
    return 'Could not access camera/gallery: $error';
  }

  @override
  String get analyzingDocument => 'Analyzing your document...';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String homeSubtitle(String greeting) {
    return '$greeting · How are you feeling today?';
  }

  @override
  String homeWelcomeName(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get homeWelcome => 'Welcome!';

  @override
  String homeLoadError(String error) {
    return 'Couldn\'t load your dashboard.\n$error';
  }

  @override
  String get askBarHint => 'Ask DAWI anything...';

  @override
  String get quickScanDocument => 'Scan document';

  @override
  String get quickAskAi => 'Ask AI';

  @override
  String get quickMedications => 'Medications';

  @override
  String get quickAppointments => 'Appointments';

  @override
  String statTreatments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Treatments',
      one: 'Treatment',
    );
    return '$_temp0';
  }

  @override
  String statAppointments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Appointments',
      one: 'Appointment',
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
  String get sectionCategories => 'Categories';

  @override
  String get sectionTodaysReminders => 'Today\'s reminders';

  @override
  String get nothingScheduledToday => 'Nothing scheduled for today.';

  @override
  String get sectionRecentActivity => 'Recent activity';

  @override
  String get noRecentActivity =>
      'No recent activity yet — scan your first document to get started.';

  @override
  String get appointmentFallback => 'Appointment';

  @override
  String documentAdded(String type) {
    return '$type added';
  }

  @override
  String alertAppointment(String date) {
    return 'Your appointment is on $date.';
  }

  @override
  String alertAppointmentAt(String date, String time) {
    return 'Your appointment is on $date at $time.';
  }

  @override
  String alertSpecialty(String specialty, String date) {
    return 'Your $specialty appointment is on $date.';
  }

  @override
  String alertSpecialtyAt(String specialty, String date, String time) {
    return 'Your $specialty appointment is on $date at $time.';
  }

  @override
  String get previousMonth => 'Previous month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get viewAllAppointments => 'View all appointments';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileFallbackName => 'Your profile';

  @override
  String get sectionPersonalInfo => 'Personal info';

  @override
  String get sectionAccount => 'Account';

  @override
  String get notSet => 'Not set';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get privacySecurity => 'Privacy & Security';

  @override
  String get logout => 'Logout';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get scanDocument => 'Scan document';

  @override
  String get useYourCamera => 'Use your camera';

  @override
  String get photosFormats => 'Photos, JPG or PNG';

  @override
  String get addDocument => 'Add document';

  @override
  String get filterAll => 'All';

  @override
  String documentsLoadError(String error) {
    return 'Couldn\'t load documents.\n$error';
  }

  @override
  String get noDocumentsYet => 'No medical documents yet.';

  @override
  String get deleteDocumentTitle => 'Delete document?';

  @override
  String get deleteDocumentBody =>
      'This will remove the document and its extracted medications.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get documentDetailsTitle => 'Document details';

  @override
  String documentLoadError(String error) {
    return 'Couldn\'t load this document.\n$error';
  }

  @override
  String get labelType => 'Type';

  @override
  String get labelDoctor => 'Doctor';

  @override
  String get labelClinic => 'Clinic';

  @override
  String get labelDate => 'Date';

  @override
  String get unknown => 'Unknown';

  @override
  String get aiExplanation => 'AI Explanation';

  @override
  String get askAi => 'Ask AI';

  @override
  String get sectionMedications => 'Medications';

  @override
  String couldNotSave(String error) {
    return 'Could not save: $error';
  }

  @override
  String get ocrTitle => 'Analyzing your document';

  @override
  String get fieldDocumentType => 'Document type';

  @override
  String get fieldClinic => 'Clinic / hospital';

  @override
  String get fieldDateOptional => 'Date (optional, YYYY-MM-DD)';

  @override
  String get extractedMedications => 'Extracted medications';

  @override
  String get noMedicationsDetected =>
      'No medications were detected in this document. You can still save it.';

  @override
  String get confirmInformation => 'Confirm information';

  @override
  String get fieldDose => 'Dose';

  @override
  String get fieldFrequency => 'Frequency';

  @override
  String get fieldTiming => 'Timing';

  @override
  String get medicationsTitle => 'Medications';

  @override
  String get addMedication => 'Add medication';

  @override
  String get medicationsLoadError => 'Couldn\'t load medications.';

  @override
  String get noMedicationsHere => 'No medications here yet.';

  @override
  String get fieldMedicationName => 'Medication name';

  @override
  String get fieldStatus => 'Status';

  @override
  String get save => 'Save';

  @override
  String get medicationDetailsTitle => 'Medication details';

  @override
  String get medicationLoadError => 'Couldn\'t load this medication.';

  @override
  String get labelPrescribedBy => 'Prescribed by';

  @override
  String get labelStartDate => 'Start date';

  @override
  String get labelEndDate => 'End date';

  @override
  String get reminderSchedule => 'Reminder schedule';

  @override
  String get slotMorning => 'Morning';

  @override
  String get slotAfternoon => 'Afternoon';

  @override
  String get slotEvening => 'Evening';

  @override
  String get slotCustom => 'Custom';

  @override
  String reminderSetFor(String slots) {
    return 'Reminder set for: $slots';
  }

  @override
  String get createReminder => 'Create reminder';

  @override
  String get appointmentsTitle => 'Appointments';

  @override
  String get addAppointment => 'Add appointment';

  @override
  String get appointmentsLoadError => 'Couldn\'t load appointments.';

  @override
  String get noUpcomingAppointments => 'No upcoming appointments.';

  @override
  String get fieldSpecialty => 'Specialty / reason for visit';

  @override
  String get fieldDate => 'Date (YYYY-MM-DD)';

  @override
  String get fieldTime => 'Time (HH:MM)';

  @override
  String get fieldLocation => 'Location';

  @override
  String get fieldNotesOptional => 'Notes (optional)';

  @override
  String get chatSuggest1 => 'Explain this document to me.';

  @override
  String get chatSuggest2 => 'What does this medical term mean?';

  @override
  String get chatSuggest3 => 'Summarize my latest analyses.';

  @override
  String get chatSuggest4 => 'What are my next appointments?';

  @override
  String get chatSuggest5 => 'Remind me about my medications.';

  @override
  String get chatSuggest6 => 'Prepare questions for my doctor.';

  @override
  String get chatGreeting => 'Hello! How can I help you today?';

  @override
  String chatUnavailable(String error) {
    return 'The AI assistant is temporarily unavailable: $error';
  }

  @override
  String get chatTitle => 'Health Assistant';

  @override
  String get chatInputHint => 'Ask your Health Assistant...';

  @override
  String get myHealthTitle => 'My Health';

  @override
  String get aiHealthSummary => 'AI Health Summary';

  @override
  String medicalRecordLoadError(String error) {
    return 'Couldn\'t load your medical record.\n$error';
  }

  @override
  String get sectionPersonalInformation => 'Personal information';

  @override
  String get edit => 'Edit';

  @override
  String get noHealthProfile => 'No health profile added yet.';

  @override
  String get labelDateOfBirth => 'Date of birth';

  @override
  String get labelBloodGroup => 'Blood group';

  @override
  String get labelAllergies => 'Allergies';

  @override
  String get labelConditions => 'Conditions';

  @override
  String get labelEmergencyContact => 'Emergency contact';

  @override
  String get sectionActiveMedications => 'Active medications';

  @override
  String get noActiveMedications => 'No active medications.';

  @override
  String get sectionDoctors => 'Doctors';

  @override
  String get noDoctorsYet => 'No doctors added yet.';

  @override
  String get sectionRecentDocuments => 'Recent documents';

  @override
  String get noDocumentsShort => 'No documents yet.';

  @override
  String documentSource(String type) {
    return 'Source: $type';
  }

  @override
  String documentSourceDated(String type, String date) {
    return 'Source: $type — $date';
  }

  @override
  String get askAssistant => 'Ask Assistant';

  @override
  String get healthProfileTitle => 'Health profile';

  @override
  String get fieldDateOfBirth => 'Date of birth (YYYY-MM-DD)';

  @override
  String get fieldKnownConditions => 'Known conditions';

  @override
  String get fieldEmergencyName => 'Emergency contact name';

  @override
  String get fieldEmergencyPhone => 'Emergency contact phone';

  @override
  String get saveAndContinue => 'Save and continue';

  @override
  String aiSummaryUnavailable(String error) {
    return 'The AI assistant is temporarily unavailable.\n$error';
  }

  @override
  String get summaryCurrentSituation => 'Current situation';

  @override
  String get summaryCurrentTreatments => 'Current treatments';

  @override
  String get summaryRecentAnalyses => 'Recent analyses';

  @override
  String get summaryUpcomingAppointments => 'Upcoming appointments';

  @override
  String get summaryImportantInfo => 'Important information';

  @override
  String get summaryRecommendations => 'General recommendations';
}
