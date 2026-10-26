import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/l10n_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../../models/api_models.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../../widgets/empty_state.dart';
import 'medication_details_screen.dart';

/// Medications page (spec section 13): active / completed / upcoming tabs,
/// plus a standalone "Add medication" flow not tied to a scanned document.
class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => MedicationsScreenState();
}

class MedicationsScreenState extends State<MedicationsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);
  late Future<List<ApiMedication>> _future;

  @override
  void initState() {
    super.initState();
    _future = apiService.listMedications();
  }

  void refresh() => setState(() => _future = apiService.listMedications());

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _addMedication() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => const _AddMedicationSheet(),
    );
    if (result == true) refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicationsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: l10n.medStatusActive), Tab(text: l10n.medStatusCompleted), Tab(text: l10n.medStatusUpcoming)],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMedication,
        icon: const Icon(Icons.add, color: AppColors.lightBlue),
        label: Text(l10n.addMedication),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => refresh(),
          child: FutureBuilder<List<ApiMedication>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return ListView(children: [EmptyState(icon: Icons.cloud_off, message: l10n.medicationsLoadError)]);
              }
              final all = snapshot.data ?? [];
              return TabBarView(
                controller: _tabController,
                children: [
                  _MedicationList(medications: all.where((m) => m.status == MedicationStatus.active).toList()),
                  _MedicationList(medications: all.where((m) => m.status == MedicationStatus.completed).toList()),
                  _MedicationList(medications: all.where((m) => m.status == MedicationStatus.upcoming).toList()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MedicationList extends StatelessWidget {
  final List<ApiMedication> medications;
  const _MedicationList({required this.medications});

  @override
  Widget build(BuildContext context) {
    if (medications.isEmpty) {
      return ListView(children: [
        EmptyState(icon: Icons.medication_outlined, message: AppLocalizations.of(context).noMedicationsHere),
      ]);
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 96),
      itemCount: medications.length,
      itemBuilder: (context, i) {
        final m = medications[i];
        return AppTile(
          icon: Icons.medication_outlined,
          title: m.name,
          subtitle: '${m.dose} · ${m.frequency}',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MedicationDetailsScreen(medicationId: m.id!)),
          ),
        );
      },
    );
  }
}

class _AddMedicationSheet extends StatefulWidget {
  const _AddMedicationSheet();

  @override
  State<_AddMedicationSheet> createState() => _AddMedicationSheetState();
}

class _AddMedicationSheetState extends State<_AddMedicationSheet> {
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _timingController = TextEditingController();
  String _status = MedicationStatus.active;
  bool _isSaving = false;

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() => _isSaving = true);
    try {
      await apiService.createMedication(ApiMedication(
        name: _nameController.text.trim(),
        form: '',
        dose: _doseController.text.trim(),
        frequency: _frequencyController.text.trim(),
        timing: _timingController.text.trim(),
        status: _status,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.addMedication, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: AppSpacing.md),
          TextField(controller: _nameController, decoration: InputDecoration(labelText: l10n.fieldMedicationName)),
          const SizedBox(height: AppSpacing.sm),
          TextField(controller: _doseController, decoration: InputDecoration(labelText: l10n.fieldDose)),
          const SizedBox(height: AppSpacing.sm),
          TextField(controller: _frequencyController, decoration: InputDecoration(labelText: l10n.fieldFrequency)),
          const SizedBox(height: AppSpacing.sm),
          TextField(controller: _timingController, decoration: InputDecoration(labelText: l10n.fieldTiming)),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<String>(
            value: _status,
            decoration: InputDecoration(labelText: l10n.fieldStatus),
            items: MedicationStatus.all
                .map((s) => DropdownMenuItem(value: s, child: Text(medicationStatusLabel(l10n, s))))
                .toList(),
            onChanged: (v) => setState(() => _status = v ?? _status),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _isSaving ? null : _save,
            child: _isSaving
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
