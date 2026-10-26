import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/api_models.dart';
import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../../widgets/appointment_calendar_sheet.dart';
import '../ai/ai_assistant_screen.dart';
import '../appointments/appointments_screen.dart';
import '../documents/document_details_screen.dart';
import '../documents/ocr_analysis_screen.dart';
import '../medications/medications_screen.dart';
import 'main_shell.dart';

class _DashboardData {
  final List<ApiMedication> activeMedications;
  final List<ApiAppointment> upcomingAppointments;
  final List<ApiDocument> recentDocuments;
  _DashboardData({required this.activeMedications, required this.upcomingAppointments, required this.recentDocuments});
}

/// Main Home / Health Dashboard (spec section 5).
class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => HomeDashboardScreenState();
}

class HomeDashboardScreenState extends State<HomeDashboardScreen> {
  final ImagePicker _picker = ImagePicker();
  late Future<_DashboardData> _future;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_DashboardData> _load() async {
    final results = await Future.wait([
      apiService.listMedications(status: 'active'),
      apiService.listAppointments(status: 'upcoming'),
      apiService.listDocuments(),
    ]);
    return _DashboardData(
      activeMedications: results[0] as List<ApiMedication>,
      upcomingAppointments: results[1] as List<ApiAppointment>,
      recentDocuments: (results[2] as List<ApiDocument>).take(3).toList(),
    );
  }

  void refresh() => setState(() => _future = _load());

  Future<void> _pickAndScan(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(source: source, imageQuality: 90, maxWidth: 2000);
      if (picked == null) return;
      setState(() => _isUploading = true);
      final result = await apiService.scanDocument(picked);
      if (!mounted) return;
      final saved = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => OcrAnalysisScreen(scanResult: result)),
      );
      if (saved == true) refresh();
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Could not access camera/gallery: $e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.redAccent));
  }

  void _showScanUploadSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.lg),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(3)),
            ),
            const SizedBox(height: AppSpacing.lg),
            QuickActionTile(
              icon: Icons.photo_camera_outlined,
              label: 'Scan with camera',
              colors: AppGradients.teal,
              onTap: () {
                Navigator.pop(context);
                _pickAndScan(ImageSource.camera);
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            QuickActionTile(
              icon: Icons.image_outlined,
              label: 'Upload from gallery',
              colors: AppGradients.lilac,
              onTap: () {
                Navigator.pop(context);
                _pickAndScan(ImageSource.gallery);
              },
            ),
          ]),
        ),
      ),
    );
  }

  void _push(Widget screen) => Navigator.push(context, MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final firstName = user?.firstName.isNotEmpty == true ? user!.firstName : 'there';
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? 'Good morning' : (hour < 18 ? 'Good afternoon' : 'Good evening');
    final initial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '?';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.transparent, // shell paints the gradient
        body: Stack(children: [
          RefreshIndicator(
            onRefresh: () async => refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(
                    firstName: firstName,
                    subtitle: '$greeting · How are you feeling today?',
                    initial: initial,
                    onAvatarTap: () => MainShell.of(context)?.goToTab(4),
                  ),
                  // Content sheet (transparent over the gradient), pulled up by _sheetOverlap.
                  // Bottom padding includes the floating nav bar's height (from MediaQuery).
                  Transform.translate(
                    offset: const Offset(0, -_sheetOverlap),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                        math.max(_minBottomPadding, AppSpacing.xl + MediaQuery.paddingOf(context).bottom),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeSlideIn(
                            index: 0,
                            child: _AskBar(onTap: () => _push(const AiAssistantScreen())),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          FutureBuilder<_DashboardData>(
                            future: _future,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              }
                              if (snapshot.hasError) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                                  child: Text("Couldn't load your dashboard.\n${snapshot.error}",
                                      style: const TextStyle(color: AppColors.textSecondary)),
                                );
                              }
                              return _buildContent(snapshot.data!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isUploading)
            Container(
              color: Colors.black.withValues(alpha: 0.35),
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      CircularProgressIndicator(),
                      SizedBox(height: AppSpacing.md),
                      Text('Analyzing your document...'),
                    ]),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _buildContent(_DashboardData data) {
    final quickActions = [
      (Icons.document_scanner_outlined, 'Scan document', _isUploading ? null : _showScanUploadSheet),
      (Icons.auto_awesome_outlined, 'Ask AI', () => _push(const AiAssistantScreen())),
      (Icons.medication_outlined, 'Medications', () => _push(const MedicationsScreen())),
      (Icons.event_outlined, 'Appointments', () => _push(const AppointmentsScreen())),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Health overview: three compact stat cards
        FadeSlideIn(
          index: 1,
          child: IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                child: StatCard(
                  icon: Icons.medication_outlined,
                  label: 'Treatments',
                  value: '${data.activeMedications.length}',
                  colors: _cardFill,
                  onTap: () => _push(const MedicationsScreen()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  icon: Icons.event_outlined,
                  label: 'Appointments',
                  value: '${data.upcomingAppointments.length}',
                  colors: _cardFill,
                  onTap: () => _push(const AppointmentsScreen()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  icon: Icons.description_outlined,
                  label: 'Documents',
                  value: '${data.recentDocuments.length}',
                  colors: _cardFill,
                  onTap: () => MainShell.of(context)?.goToTab(1),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Health alerts (only from validated data)
        if (data.upcomingAppointments.isNotEmpty) ...[
          FadeSlideIn(
            index: 2,
            child: _AlertBanner(
              text: _appointmentText(data.upcomingAppointments.first),
              onTap: () => showAppointmentCalendarSheet(
                context,
                appointments: data.upcomingAppointments,
                onViewAll: () => _push(const AppointmentsScreen()),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        // Quick actions: four equal outlined-icon tiles
        const SectionTitle('Categories'),
        const SizedBox(height: AppSpacing.md),
        FadeSlideIn(
          index: 3,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final (icon, label, onTap) in quickActions)
              Expanded(child: _QuickAction(icon: icon, label: label, onTap: onTap)),
          ]),
        ),
        const SizedBox(height: AppSpacing.md),

        // Today's reminders (derived from active meds / upcoming appts)
        const SectionTitle("Today's reminders"),
        const SizedBox(height: AppSpacing.md),
        if (data.activeMedications.isEmpty && data.upcomingAppointments.isEmpty)
          const Text('Nothing scheduled for today.', style: TextStyle(color: AppColors.textSecondary))
        else ...[
          ...data.activeMedications.take(3).map((m) => AppTile(
                icon: Icons.medication_outlined,
                title: m.name,
                subtitle: '${m.timing} · ${m.frequency}',
              )),
          ...data.upcomingAppointments.take(2).map((a) => AppTile(
                icon: Icons.event_outlined,
                title: a.specialty.isEmpty ? 'Appointment' : a.specialty,
                subtitle: '${a.date} ${a.time}',
              )),
        ],
        const SizedBox(height: AppSpacing.lg),

        // Recent activity (recent documents)
        const SectionTitle('Recent activity'),
        const SizedBox(height: AppSpacing.md),
        if (data.recentDocuments.isEmpty)
          const Text('No recent activity yet — scan your first document to get started.',
              style: TextStyle(color: AppColors.textSecondary))
        else
          ...data.recentDocuments.map((d) => AppTile(
                icon: Icons.description_outlined,
                title: d.documentType.isNotEmpty ? d.documentType : 'Document',
                subtitle: d.aiSummary.isNotEmpty ? d.aiSummary : '${d.documentType} added',
                maxSubtitleLines: 2,
                onTap: () => _push(DocumentDetailsScreen(documentId: d.id)),
              )),
      ],
    );
  }
}

/// Stat card fill: white 85% (StatCard uses dark text and a teal icon on mint).
const List<Color> _cardFill = [Color(0xD9FFFFFF), Color(0xD9FFFFFF)];

/// Keeps the last content clear of the floating nav bar.
const double _minBottomPadding = 120;

/// e.g. "Your Cardiology is on Sat 12 Dec at 02:04." — falls back to the raw
/// date string if it isn't "YYYY-MM-DD".
String _appointmentText(ApiAppointment a) {
  final what = a.specialty.isEmpty ? 'appointment' : a.specialty;
  final parsed = DateTime.tryParse(a.date);
  final date = parsed != null ? DateFormat('EEE d MMM').format(parsed) : a.date;
  final at = a.time.isNotEmpty ? ' at ${a.time}' : '';
  return 'Your $what is on $date$at.';
}

/// How far the content sheet slides up over the teal header.
const double _sheetOverlap = 24;

/// Full-width teal header: welcome text, mint subtitle, avatar.
class _Header extends StatelessWidget {
  final String firstName;
  final String subtitle;
  final String initial;
  final VoidCallback onAvatarTap;
  const _Header({required this.firstName, required this.subtitle, required this.initial, required this.onAvatarTap});

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          MediaQuery.paddingOf(context).top + AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.md + _sheetOverlap, // ~30% less empty space than xl
        ),
        child: FadeSlideIn(
          child: Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Welcome, $firstName!',
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, height: 1.2)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.mint, fontSize: 13.5)),
              ]),
            ),
            const SizedBox(width: AppSpacing.md),
            PressableScale(
              onTap: onAvatarTap,
              borderRadius: 26,
              child: Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: AppColors.mint, width: 3),
                ),
                child: Text(initial,
                    style: const TextStyle(color: AppColors.deepTeal, fontSize: 20, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
      );
}

/// Search-style pill that opens the AI assistant.
class _AskBar extends StatelessWidget {
  final VoidCallback onTap;
  const _AskBar({required this.onTap});

  @override
  Widget build(BuildContext context) => PressableScale(
        onTap: onTap,
        borderRadius: AppRadius.button,
        scale: 0.98,
        hoverScale: 1.02,
        child: Container(
          height: 54,
          padding: const EdgeInsets.only(left: 18, right: 6),
          decoration: BoxDecoration(
            color: AppColors.chipBackground,
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          child: Row(children: [
            const Icon(Icons.search_rounded, color: AppColors.textSecondary),
            const SizedBox(width: 10),
            const Expanded(
              child: Text('Ask DAWI anything...', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 20),
            ),
          ]),
        ),
      );
}

/// 64x64 translucent rounded tile with an outlined teal icon, label below.
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _QuickAction({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) => Column(children: [
        PressableScale(
          onTap: onTap,
          borderRadius: 20,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12.5, height: 1.3, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
        ),
      ]);
}

/// Amber banner for the next appointment (the only non-teal accent).
/// Tapping opens the appointment calendar.
class _AlertBanner extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _AlertBanner({required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) => GradientCard(
        colors: const [AppColors.alertAmber, AppColors.alertAmber],
        onTap: onTap,
        radius: AppRadius.card,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.6), shape: BoxShape.circle),
            child: const Icon(Icons.notifications_active_outlined, color: AppColors.textPrimary, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 13.5, height: 1.4, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
        ]),
      );
}
