import 'package:flutter/material.dart';

import '../../core/l10n_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../../models/api_models.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';

/// Medication details page (spec section 14): dosage/instructions plus a
/// reminder-time picker. NOTE: reminder scheduling here is UI-only for now
/// — wiring up local notifications (e.g. via `flutter_local_notifications`)
/// is a natural next step once this screen is in place.
class MedicationDetailsScreen extends StatefulWidget {
  final String medicationId;
  const MedicationDetailsScreen({super.key, required this.medicationId});

  @override
  State<MedicationDetailsScreen> createState() => _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen> {
  late Future<ApiMedication> _future;
  final Set<String> _reminderTimes = {};

  @override
  void initState() {
    super.initState();
    _future = apiService.getMedication(widget.medicationId);
  }

  Future<void> _delete() async {
    try {
      await apiService.deleteMedication(widget.medicationId);
      if (!mounted) return;
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final slotLabels = {
      'Morning': l10n.slotMorning,
      'Afternoon': l10n.slotAfternoon,
      'Evening': l10n.slotEvening,
      'Custom': l10n.slotCustom,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicationDetailsTitle),
        actions: [IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete)],
      ),
      body: SafeArea(
        child: FutureBuilder<ApiMedication>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(child: Text(l10n.medicationLoadError));
            }
            final m = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(medicationStatusLabel(l10n, m.status), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.lg),
                  AppPanel(
                    child: Column(children: [
                      _Row(label: l10n.fieldDose, value: m.dose),
                      const SizedBox(height: 10),
                      _Row(label: l10n.fieldFrequency, value: m.frequency),
                      const SizedBox(height: 10),
                      _Row(label: l10n.fieldTiming, value: m.timing),
                      if (m.doctorName.isNotEmpty) ...[const SizedBox(height: 10), _Row(label: l10n.labelPrescribedBy, value: m.doctorName)],
                      if (m.startDate.isNotEmpty) ...[const SizedBox(height: 10), _Row(label: l10n.labelStartDate, value: formatLongDate(m.startDate))],
                      if (m.endDate.isNotEmpty) ...[const SizedBox(height: 10), _Row(label: l10n.labelEndDate, value: formatLongDate(m.endDate))],
                    ]),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SectionTitle(l10n.reminderSchedule),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: 8,
                    children: slotLabels.keys.map((slot) {
                      final selected = _reminderTimes.contains(slot);
                      return FilterChip(
                        label: Text(slotLabels[slot]!),
                        selected: selected,
                        onSelected: (v) => setState(() => v ? _reminderTimes.add(slot) : _reminderTimes.remove(slot)),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton.icon(
                    onPressed: _reminderTimes.isEmpty
                        ? null
                        : () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.reminderSetFor(_reminderTimes.map((t) => slotLabels[t]!).join(', ')))),
                            ),
                    icon: const Icon(Icons.alarm_add_outlined),
                    label: Text(l10n.createReminder),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(child: Text(label, style: const TextStyle(color: AppColors.textSecondary))),
        Text(value.isEmpty ? '—' : value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ]);
}
