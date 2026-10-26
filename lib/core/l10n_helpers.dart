import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/api_models.dart';
import 'constants.dart';

/// Localized labels for API machine values, and locale-aware dates. The
/// values sent to and from the API stay unchanged.

String documentTypeLabel(AppLocalizations l10n, String value) {
  switch (value) {
    case DocumentTypes.prescription:
      return l10n.docTypePrescription;
    case DocumentTypes.labReport:
      return l10n.docTypeLabReport;
    case DocumentTypes.medicalReport:
      return l10n.docTypeMedicalReport;
    case DocumentTypes.certificate:
      return l10n.docTypeCertificate;
    case DocumentTypes.imaging:
      return l10n.docTypeImaging;
    default:
      return l10n.docTypeOther;
  }
}

String medicationStatusLabel(AppLocalizations l10n, String value) {
  switch (value) {
    case MedicationStatus.active:
      return l10n.medStatusActive;
    case MedicationStatus.completed:
      return l10n.medStatusCompleted;
    case MedicationStatus.upcoming:
      return l10n.medStatusUpcoming;
    default:
      return value;
  }
}

String appointmentStatusLabel(AppLocalizations l10n, String value) {
  switch (value) {
    case AppointmentStatus.upcoming:
      return l10n.apptStatusUpcoming;
    case AppointmentStatus.completed:
      return l10n.apptStatusCompleted;
    case AppointmentStatus.cancelled:
      return l10n.apptStatusCancelled;
    default:
      return value;
  }
}

/// "Sat 12 Dec" in the active locale; the raw string if it isn't a date.
String formatShortDate(String date) {
  final parsed = DateTime.tryParse(date);
  return parsed != null ? DateFormat('EEE d MMM').format(parsed) : date;
}

/// "Sat 12 Dec · 02:04" (date and/or time, whichever exist).
String appointmentWhen(ApiAppointment a) =>
    [if (a.date.isNotEmpty) formatShortDate(a.date), if (a.time.isNotEmpty) a.time].join(' · ');

/// A document's date in [pattern] for the active locale: its own
/// `document_date` when it parses, else the raw string, else [createdAt].
String formatDocumentDate(String documentDate, DateTime createdAt, String pattern) {
  if (documentDate.isEmpty) return DateFormat(pattern).format(createdAt);
  final parsed = DateTime.tryParse(documentDate);
  return parsed != null ? DateFormat(pattern).format(parsed) : documentDate;
}

/// "12 Dec 2026" in the active locale; the raw string if it isn't a date.
String formatLongDate(String date) {
  final parsed = DateTime.tryParse(date);
  return parsed != null ? DateFormat('d MMM yyyy').format(parsed) : date;
}
