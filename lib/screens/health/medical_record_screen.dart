import 'package:flutter/material.dart';

import '../../core/l10n_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../../models/api_models.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../ai/ai_assistant_screen.dart';
import '../appointments/appointments_screen.dart';
import '../medications/medications_screen.dart';

/// "Medical Record / My Health" page (spec section 12): personal info,
/// conditions, medications, doctors — all sourced from validated data.
/// Also links to the AI Health Summary (section 21), generated on demand.
class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  late Future<MedicalRecord> _future;

  @override
  void initState() {
    super.initState();
    _future = apiService.getMedicalRecord();
  }

  Future<void> _editHealthProfile(ApiHealthProfile? current) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _HealthProfileSheet(current: current),
    );
    if (result == true) setState(() => _future = apiService.getMedicalRecord());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myHealthTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_outlined),
            tooltip: l10n.aiHealthSummary,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _AiHealthSummarySheet())),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<MedicalRecord>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(l10n.medicalRecordLoadError('${snapshot.error}'), textAlign: TextAlign.center));
            }
            final record = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Row(children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.medication_outlined, size: 18),
                      label: Text(l10n.quickMedications),
                      style: AppButtons.dark,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicationsScreen())),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.event_outlined, size: 18),
                      label: Text(l10n.quickAppointments),
                      style: AppButtons.dark,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentsScreen())),
                    ),
                  ),
                ]),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionTitle(l10n.sectionPersonalInformation),
                    TextButton(onPressed: () => _editHealthProfile(record.healthProfile), child: Text(l10n.edit)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                AppPanel(
                  child: record.healthProfile == null
                      ? Text(l10n.noHealthProfile, style: const TextStyle(color: AppColors.textSecondary))
                      : Column(children: [
                          _InfoRow(l10n.labelDateOfBirth, formatLongDate(record.healthProfile!.dateOfBirth)),
                          _InfoRow(l10n.labelBloodGroup, record.healthProfile!.bloodGroup),
                          _InfoRow(l10n.labelAllergies, record.healthProfile!.allergies),
                          _InfoRow(l10n.labelConditions, record.healthProfile!.conditions),
                          _InfoRow(l10n.labelEmergencyContact, [
                            record.healthProfile!.emergencyContactName,
                            record.healthProfile!.emergencyContactPhone,
                          ].where((s) => s.isNotEmpty).join(' · ')),
                        ]),
                ),
                const SizedBox(height: AppSpacing.lg),
                SectionTitle(l10n.sectionActiveMedications),
                const SizedBox(height: AppSpacing.md),
                if (record.activeMedications.isEmpty)
                  Text(l10n.noActiveMedications, style: const TextStyle(color: AppColors.textSecondary))
                else
                  ...record.activeMedications.map((m) => AppTile(icon: Icons.medication_outlined, title: m.name, subtitle: '${m.dose} · ${m.frequency}')),
                const SizedBox(height: AppSpacing.lg),
                SectionTitle(l10n.sectionDoctors),
                const SizedBox(height: AppSpacing.md),
                if (record.doctors.isEmpty)
                  Text(l10n.noDoctorsYet, style: const TextStyle(color: AppColors.textSecondary))
                else
                  ...record.doctors.map((d) => AppTile(icon: Icons.badge_outlined, title: d.name, subtitle: d.specialty)),
                const SizedBox(height: AppSpacing.lg),
                SectionTitle(l10n.sectionRecentDocuments),
                const SizedBox(height: AppSpacing.md),
                if (record.recentDocuments.isEmpty)
                  Text(l10n.noDocumentsShort, style: const TextStyle(color: AppColors.textSecondary))
                else
                  ...record.recentDocuments.map((d) => AppTile(
                        icon: Icons.description_outlined,
                        maxSubtitleLines: 2,
                        title: d.aiSummary.isNotEmpty ? d.aiSummary : d.documentType,
                        subtitle: d.documentDate.isNotEmpty
                            ? l10n.documentSourceDated(documentTypeLabel(l10n, d.documentType), formatLongDate(d.documentDate))
                            : l10n.documentSource(documentTypeLabel(l10n, d.documentType)),
                      )),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AiAssistantScreen())),
        icon: const Icon(Icons.smart_toy_outlined, color: AppColors.lightBlue),
        label: Text(l10n.askAssistant),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.textSecondary))),
          Flexible(child: Text(value.isEmpty ? '—' : value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w600))),
        ]),
      );
}

class _HealthProfileSheet extends StatefulWidget {
  final ApiHealthProfile? current;
  const _HealthProfileSheet({required this.current});
  @override
  State<_HealthProfileSheet> createState() => _HealthProfileSheetState();
}

class _HealthProfileSheetState extends State<_HealthProfileSheet> {
  late final _dobController = TextEditingController(text: widget.current?.dateOfBirth ?? '');
  late final _bloodController = TextEditingController(text: widget.current?.bloodGroup ?? '');
  late final _allergiesController = TextEditingController(text: widget.current?.allergies ?? '');
  late final _conditionsController = TextEditingController(text: widget.current?.conditions ?? '');
  late final _emergencyNameController = TextEditingController(text: widget.current?.emergencyContactName ?? '');
  late final _emergencyPhoneController = TextEditingController(text: widget.current?.emergencyContactPhone ?? '');
  bool _isSaving = false;

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await apiService.saveHealthProfile(ApiHealthProfile(
        dateOfBirth: _dobController.text.trim(),
        bloodGroup: _bloodController.text.trim(),
        allergies: _allergiesController.text.trim(),
        conditions: _conditionsController.text.trim(),
        emergencyContactName: _emergencyNameController.text.trim(),
        emergencyContactPhone: _emergencyPhoneController.text.trim(),
      ));
      if (!mounted) return;
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.healthProfileTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: AppSpacing.md),
            TextField(controller: _dobController, decoration: InputDecoration(labelText: l10n.fieldDateOfBirth)),
            const SizedBox(height: AppSpacing.sm),
            TextField(controller: _bloodController, decoration: InputDecoration(labelText: l10n.labelBloodGroup)),
            const SizedBox(height: AppSpacing.sm),
            TextField(controller: _allergiesController, decoration: InputDecoration(labelText: l10n.labelAllergies)),
            const SizedBox(height: AppSpacing.sm),
            TextField(controller: _conditionsController, decoration: InputDecoration(labelText: l10n.fieldKnownConditions)),
            const SizedBox(height: AppSpacing.sm),
            TextField(controller: _emergencyNameController, decoration: InputDecoration(labelText: l10n.fieldEmergencyName)),
            const SizedBox(height: AppSpacing.sm),
            TextField(controller: _emergencyPhoneController, decoration: InputDecoration(labelText: l10n.fieldEmergencyPhone)),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(l10n.saveAndContinue),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiHealthSummarySheet extends StatefulWidget {
  const _AiHealthSummarySheet();
  @override
  State<_AiHealthSummarySheet> createState() => _AiHealthSummarySheetState();
}

class _AiHealthSummarySheetState extends State<_AiHealthSummarySheet> {
  late Future<AiHealthSummary> _future;

  @override
  void initState() {
    super.initState();
    _future = apiService.getAiHealthSummary();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.aiHealthSummary)),
      body: SafeArea(
        child: FutureBuilder<AiHealthSummary>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(l10n.aiSummaryUnavailable('${snapshot.error}'), textAlign: TextAlign.center));
            }
            final s = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text(l10n.summaryCurrentSituation, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: AppSpacing.sm),
                Text(s.currentSituation, style: const TextStyle(fontSize: 14, height: 1.5)),
                const SizedBox(height: AppSpacing.lg),
                if (s.currentTreatments.isNotEmpty) _bulletSection(l10n.summaryCurrentTreatments, s.currentTreatments),
                if (s.recentAnalyses.isNotEmpty) _bulletSection(l10n.summaryRecentAnalyses, s.recentAnalyses),
                if (s.upcomingAppointments.isNotEmpty) _bulletSection(l10n.summaryUpcomingAppointments, s.upcomingAppointments),
                if (s.importantInformation.isNotEmpty) _bulletSection(l10n.summaryImportantInfo, s.importantInformation),
                if (s.generalRecommendations.isNotEmpty) _bulletSection(l10n.summaryRecommendations, s.generalRecommendations),
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Text(s.generatedNote, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _bulletSection(String title, List<String> items) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: AppSpacing.sm),
          ...items.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.circle, size: 6, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(s, style: const TextStyle(fontSize: 13.5, height: 1.4))),
                ]),
              )),
        ]),
      );
}
