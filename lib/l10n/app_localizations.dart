import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get navDocuments;

  /// No description provided for @navHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get navHealth;

  /// No description provided for @navAssistant.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get navAssistant;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboardingGetStarted;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Understand your documents'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Scan or import your prescriptions, lab reports, and medical records — we help you make sense of them.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Centralize your health'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Documents, medications, appointments, and doctors, all organized in one place.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'AI Health Assistant'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'Ask questions in plain language and get explanations of medical terms and summaries of your validated information.'**
  String get onboarding3Body;

  /// No description provided for @onboarding4Title.
  ///
  /// In en, this message translates to:
  /// **'Reminders & Monitoring'**
  String get onboarding4Title;

  /// No description provided for @onboarding4Body.
  ///
  /// In en, this message translates to:
  /// **'Never miss a dose or an appointment, with reminders and general health guidance tailored to you.'**
  String get onboarding4Body;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to access your health dashboard.'**
  String get loginSubtitle;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @validationEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validationEmail;

  /// No description provided for @validationPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get validationPasswordLength;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLink;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @noAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Create one'**
  String get noAccountLink;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join DAWI to keep your health organized.'**
  String get registerSubtitle;

  /// No description provided for @fieldFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get fieldFirstName;

  /// No description provided for @fieldLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get fieldLastName;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get fieldPhone;

  /// No description provided for @fieldConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get fieldConfirmPassword;

  /// No description provided for @fieldPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Preferred language'**
  String get fieldPreferredLanguage;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get validationRequired;

  /// No description provided for @validationPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsMismatch;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerButton;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerFailed;

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetTitle;

  /// No description provided for @resetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll help you get back into your account.'**
  String get resetSubtitle;

  /// No description provided for @resetIntro.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a link to reset your password.'**
  String get resetIntro;

  /// No description provided for @resetSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get resetSendButton;

  /// No description provided for @resetSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for {email}, a reset link has been sent.'**
  String resetSent(String email);

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @docTypePrescription.
  ///
  /// In en, this message translates to:
  /// **'Prescription'**
  String get docTypePrescription;

  /// No description provided for @docTypeLabReport.
  ///
  /// In en, this message translates to:
  /// **'Lab Report'**
  String get docTypeLabReport;

  /// No description provided for @docTypeMedicalReport.
  ///
  /// In en, this message translates to:
  /// **'Medical Report'**
  String get docTypeMedicalReport;

  /// No description provided for @docTypeCertificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get docTypeCertificate;

  /// No description provided for @docTypeImaging.
  ///
  /// In en, this message translates to:
  /// **'Imaging'**
  String get docTypeImaging;

  /// No description provided for @docTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get docTypeOther;

  /// No description provided for @medStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get medStatusActive;

  /// No description provided for @medStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get medStatusCompleted;

  /// No description provided for @medStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get medStatusUpcoming;

  /// No description provided for @apptStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'upcoming'**
  String get apptStatusUpcoming;

  /// No description provided for @apptStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get apptStatusCompleted;

  /// No description provided for @apptStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'cancelled'**
  String get apptStatusCancelled;

  /// No description provided for @scanWithCamera.
  ///
  /// In en, this message translates to:
  /// **'Scan with camera'**
  String get scanWithCamera;

  /// No description provided for @uploadFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from gallery'**
  String get uploadFromGallery;

  /// No description provided for @errorCameraAccess.
  ///
  /// In en, this message translates to:
  /// **'Could not access camera/gallery: {error}'**
  String errorCameraAccess(String error);

  /// No description provided for @analyzingDocument.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your document...'**
  String get analyzingDocument;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{greeting} · How are you feeling today?'**
  String homeSubtitle(String greeting);

  /// No description provided for @homeWelcomeName.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String homeWelcomeName(String name);

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get homeWelcome;

  /// No description provided for @homeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your dashboard.\n{error}'**
  String homeLoadError(String error);

  /// No description provided for @askBarHint.
  ///
  /// In en, this message translates to:
  /// **'Ask DAWI anything...'**
  String get askBarHint;

  /// No description provided for @quickScanDocument.
  ///
  /// In en, this message translates to:
  /// **'Scan document'**
  String get quickScanDocument;

  /// No description provided for @quickAskAi.
  ///
  /// In en, this message translates to:
  /// **'Ask AI'**
  String get quickAskAi;

  /// No description provided for @quickMedications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get quickMedications;

  /// No description provided for @quickAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get quickAppointments;

  /// No description provided for @statTreatments.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Treatment} other{Treatments}}'**
  String statTreatments(int count);

  /// No description provided for @statAppointments.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Appointment} other{Appointments}}'**
  String statAppointments(int count);

  /// No description provided for @statDocuments.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Document} other{Documents}}'**
  String statDocuments(int count);

  /// No description provided for @sectionCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get sectionCategories;

  /// No description provided for @sectionTodaysReminders.
  ///
  /// In en, this message translates to:
  /// **'Today\'s reminders'**
  String get sectionTodaysReminders;

  /// No description provided for @nothingScheduledToday.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled for today.'**
  String get nothingScheduledToday;

  /// No description provided for @sectionRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get sectionRecentActivity;

  /// No description provided for @noRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'No recent activity yet — scan your first document to get started.'**
  String get noRecentActivity;

  /// No description provided for @appointmentFallback.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointmentFallback;

  /// No description provided for @documentAdded.
  ///
  /// In en, this message translates to:
  /// **'{type} added'**
  String documentAdded(String type);

  /// No description provided for @alertAppointment.
  ///
  /// In en, this message translates to:
  /// **'Your appointment is on {date}.'**
  String alertAppointment(String date);

  /// No description provided for @alertAppointmentAt.
  ///
  /// In en, this message translates to:
  /// **'Your appointment is on {date} at {time}.'**
  String alertAppointmentAt(String date, String time);

  /// No description provided for @alertSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Your {specialty} appointment is on {date}.'**
  String alertSpecialty(String specialty, String date);

  /// No description provided for @alertSpecialtyAt.
  ///
  /// In en, this message translates to:
  /// **'Your {specialty} appointment is on {date} at {time}.'**
  String alertSpecialtyAt(String specialty, String date, String time);

  /// No description provided for @previousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get previousMonth;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// No description provided for @viewAllAppointments.
  ///
  /// In en, this message translates to:
  /// **'View all appointments'**
  String get viewAllAppointments;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileFallbackName.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get profileFallbackName;

  /// No description provided for @sectionPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal info'**
  String get sectionPersonalInfo;

  /// No description provided for @sectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get sectionAccount;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @scanDocument.
  ///
  /// In en, this message translates to:
  /// **'Scan document'**
  String get scanDocument;

  /// No description provided for @useYourCamera.
  ///
  /// In en, this message translates to:
  /// **'Use your camera'**
  String get useYourCamera;

  /// No description provided for @photosFormats.
  ///
  /// In en, this message translates to:
  /// **'Photos, JPG or PNG'**
  String get photosFormats;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocument;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @documentsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load documents.\n{error}'**
  String documentsLoadError(String error);

  /// No description provided for @noDocumentsYet.
  ///
  /// In en, this message translates to:
  /// **'No medical documents yet.'**
  String get noDocumentsYet;

  /// No description provided for @deleteDocumentTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete document?'**
  String get deleteDocumentTitle;

  /// No description provided for @deleteDocumentBody.
  ///
  /// In en, this message translates to:
  /// **'This will remove the document and its extracted medications.'**
  String get deleteDocumentBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @documentDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Document details'**
  String get documentDetailsTitle;

  /// No description provided for @documentLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this document.\n{error}'**
  String documentLoadError(String error);

  /// No description provided for @labelType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get labelType;

  /// No description provided for @labelDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get labelDoctor;

  /// No description provided for @labelClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get labelClinic;

  /// No description provided for @labelDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get labelDate;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @aiExplanation.
  ///
  /// In en, this message translates to:
  /// **'AI Explanation'**
  String get aiExplanation;

  /// No description provided for @askAi.
  ///
  /// In en, this message translates to:
  /// **'Ask AI'**
  String get askAi;

  /// No description provided for @sectionMedications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get sectionMedications;

  /// No description provided for @couldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save: {error}'**
  String couldNotSave(String error);

  /// No description provided for @ocrTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your document'**
  String get ocrTitle;

  /// No description provided for @fieldDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Document type'**
  String get fieldDocumentType;

  /// No description provided for @fieldClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic / hospital'**
  String get fieldClinic;

  /// No description provided for @fieldDateOptional.
  ///
  /// In en, this message translates to:
  /// **'Date (optional, YYYY-MM-DD)'**
  String get fieldDateOptional;

  /// No description provided for @extractedMedications.
  ///
  /// In en, this message translates to:
  /// **'Extracted medications'**
  String get extractedMedications;

  /// No description provided for @noMedicationsDetected.
  ///
  /// In en, this message translates to:
  /// **'No medications were detected in this document. You can still save it.'**
  String get noMedicationsDetected;

  /// No description provided for @confirmInformation.
  ///
  /// In en, this message translates to:
  /// **'Confirm information'**
  String get confirmInformation;

  /// No description provided for @fieldDose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get fieldDose;

  /// No description provided for @fieldFrequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get fieldFrequency;

  /// No description provided for @fieldTiming.
  ///
  /// In en, this message translates to:
  /// **'Timing'**
  String get fieldTiming;

  /// No description provided for @medicationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get medicationsTitle;

  /// No description provided for @addMedication.
  ///
  /// In en, this message translates to:
  /// **'Add medication'**
  String get addMedication;

  /// No description provided for @medicationsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load medications.'**
  String get medicationsLoadError;

  /// No description provided for @noMedicationsHere.
  ///
  /// In en, this message translates to:
  /// **'No medications here yet.'**
  String get noMedicationsHere;

  /// No description provided for @fieldMedicationName.
  ///
  /// In en, this message translates to:
  /// **'Medication name'**
  String get fieldMedicationName;

  /// No description provided for @fieldStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get fieldStatus;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @medicationDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Medication details'**
  String get medicationDetailsTitle;

  /// No description provided for @medicationLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this medication.'**
  String get medicationLoadError;

  /// No description provided for @labelPrescribedBy.
  ///
  /// In en, this message translates to:
  /// **'Prescribed by'**
  String get labelPrescribedBy;

  /// No description provided for @labelStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get labelStartDate;

  /// No description provided for @labelEndDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get labelEndDate;

  /// No description provided for @reminderSchedule.
  ///
  /// In en, this message translates to:
  /// **'Reminder schedule'**
  String get reminderSchedule;

  /// No description provided for @slotMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get slotMorning;

  /// No description provided for @slotAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get slotAfternoon;

  /// No description provided for @slotEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get slotEvening;

  /// No description provided for @slotCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get slotCustom;

  /// No description provided for @reminderSetFor.
  ///
  /// In en, this message translates to:
  /// **'Reminder set for: {slots}'**
  String reminderSetFor(String slots);

  /// No description provided for @createReminder.
  ///
  /// In en, this message translates to:
  /// **'Create reminder'**
  String get createReminder;

  /// No description provided for @appointmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointmentsTitle;

  /// No description provided for @addAppointment.
  ///
  /// In en, this message translates to:
  /// **'Add appointment'**
  String get addAppointment;

  /// No description provided for @appointmentsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load appointments.'**
  String get appointmentsLoadError;

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'No upcoming appointments.'**
  String get noUpcomingAppointments;

  /// No description provided for @fieldSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty / reason for visit'**
  String get fieldSpecialty;

  /// No description provided for @fieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date (YYYY-MM-DD)'**
  String get fieldDate;

  /// No description provided for @fieldTime.
  ///
  /// In en, this message translates to:
  /// **'Time (HH:MM)'**
  String get fieldTime;

  /// No description provided for @fieldLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get fieldLocation;

  /// No description provided for @fieldNotesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get fieldNotesOptional;

  /// No description provided for @chatSuggest1.
  ///
  /// In en, this message translates to:
  /// **'Explain this document to me.'**
  String get chatSuggest1;

  /// No description provided for @chatSuggest2.
  ///
  /// In en, this message translates to:
  /// **'What does this medical term mean?'**
  String get chatSuggest2;

  /// No description provided for @chatSuggest3.
  ///
  /// In en, this message translates to:
  /// **'Summarize my latest analyses.'**
  String get chatSuggest3;

  /// No description provided for @chatSuggest4.
  ///
  /// In en, this message translates to:
  /// **'What are my next appointments?'**
  String get chatSuggest4;

  /// No description provided for @chatSuggest5.
  ///
  /// In en, this message translates to:
  /// **'Remind me about my medications.'**
  String get chatSuggest5;

  /// No description provided for @chatSuggest6.
  ///
  /// In en, this message translates to:
  /// **'Prepare questions for my doctor.'**
  String get chatSuggest6;

  /// No description provided for @chatGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello! How can I help you today?'**
  String get chatGreeting;

  /// No description provided for @chatUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The AI assistant is temporarily unavailable: {error}'**
  String chatUnavailable(String error);

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'Health Assistant'**
  String get chatTitle;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask your Health Assistant...'**
  String get chatInputHint;

  /// No description provided for @myHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'My Health'**
  String get myHealthTitle;

  /// No description provided for @aiHealthSummary.
  ///
  /// In en, this message translates to:
  /// **'AI Health Summary'**
  String get aiHealthSummary;

  /// No description provided for @medicalRecordLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your medical record.\n{error}'**
  String medicalRecordLoadError(String error);

  /// No description provided for @sectionPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get sectionPersonalInformation;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @noHealthProfile.
  ///
  /// In en, this message translates to:
  /// **'No health profile added yet.'**
  String get noHealthProfile;

  /// No description provided for @labelDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get labelDateOfBirth;

  /// No description provided for @labelBloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood group'**
  String get labelBloodGroup;

  /// No description provided for @labelAllergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get labelAllergies;

  /// No description provided for @labelConditions.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get labelConditions;

  /// No description provided for @labelEmergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact'**
  String get labelEmergencyContact;

  /// No description provided for @sectionActiveMedications.
  ///
  /// In en, this message translates to:
  /// **'Active medications'**
  String get sectionActiveMedications;

  /// No description provided for @noActiveMedications.
  ///
  /// In en, this message translates to:
  /// **'No active medications.'**
  String get noActiveMedications;

  /// No description provided for @sectionDoctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get sectionDoctors;

  /// No description provided for @noDoctorsYet.
  ///
  /// In en, this message translates to:
  /// **'No doctors added yet.'**
  String get noDoctorsYet;

  /// No description provided for @sectionRecentDocuments.
  ///
  /// In en, this message translates to:
  /// **'Recent documents'**
  String get sectionRecentDocuments;

  /// No description provided for @noDocumentsShort.
  ///
  /// In en, this message translates to:
  /// **'No documents yet.'**
  String get noDocumentsShort;

  /// No description provided for @documentSource.
  ///
  /// In en, this message translates to:
  /// **'Source: {type}'**
  String documentSource(String type);

  /// No description provided for @documentSourceDated.
  ///
  /// In en, this message translates to:
  /// **'Source: {type} — {date}'**
  String documentSourceDated(String type, String date);

  /// No description provided for @askAssistant.
  ///
  /// In en, this message translates to:
  /// **'Ask Assistant'**
  String get askAssistant;

  /// No description provided for @healthProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Health profile'**
  String get healthProfileTitle;

  /// No description provided for @fieldDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth (YYYY-MM-DD)'**
  String get fieldDateOfBirth;

  /// No description provided for @fieldKnownConditions.
  ///
  /// In en, this message translates to:
  /// **'Known conditions'**
  String get fieldKnownConditions;

  /// No description provided for @fieldEmergencyName.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact name'**
  String get fieldEmergencyName;

  /// No description provided for @fieldEmergencyPhone.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact phone'**
  String get fieldEmergencyPhone;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save and continue'**
  String get saveAndContinue;

  /// No description provided for @aiSummaryUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The AI assistant is temporarily unavailable.\n{error}'**
  String aiSummaryUnavailable(String error);

  /// No description provided for @summaryCurrentSituation.
  ///
  /// In en, this message translates to:
  /// **'Current situation'**
  String get summaryCurrentSituation;

  /// No description provided for @summaryCurrentTreatments.
  ///
  /// In en, this message translates to:
  /// **'Current treatments'**
  String get summaryCurrentTreatments;

  /// No description provided for @summaryRecentAnalyses.
  ///
  /// In en, this message translates to:
  /// **'Recent analyses'**
  String get summaryRecentAnalyses;

  /// No description provided for @summaryUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming appointments'**
  String get summaryUpcomingAppointments;

  /// No description provided for @summaryImportantInfo.
  ///
  /// In en, this message translates to:
  /// **'Important information'**
  String get summaryImportantInfo;

  /// No description provided for @summaryRecommendations.
  ///
  /// In en, this message translates to:
  /// **'General recommendations'**
  String get summaryRecommendations;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
