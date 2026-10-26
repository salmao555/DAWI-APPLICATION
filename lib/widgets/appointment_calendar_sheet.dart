import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/api_models.dart';
import '../theme/app_theme.dart';
import 'alive.dart';

/// Opens the appointment calendar as a rounded bottom sheet.
Future<void> showAppointmentCalendarSheet(
  BuildContext context, {
  required List<ApiAppointment> appointments,
  required VoidCallback onViewAll,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
    builder: (_) => AppointmentCalendarSheet(appointments: appointments, onViewAll: onViewAll),
  );
}

/// Month calendar (upcoming appointment days filled teal, today outlined)
/// above a card for the selected appointment. Tapping a highlighted day
/// selects its appointment. [onViewAll] runs after the sheet closes.
class AppointmentCalendarSheet extends StatefulWidget {
  const AppointmentCalendarSheet({super.key, required this.appointments, required this.onViewAll});

  /// Upcoming appointments; the first one is selected initially.
  final List<ApiAppointment> appointments;
  final VoidCallback onViewAll;

  @override
  State<AppointmentCalendarSheet> createState() => _AppointmentCalendarSheetState();
}

class _AppointmentCalendarSheetState extends State<AppointmentCalendarSheet> {
  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  /// Appointments keyed by calendar day; ones with an unparseable date are
  /// left out of the grid but can still show in the card.
  final Map<DateTime, List<ApiAppointment>> _byDay = {};
  late ApiAppointment? _selected = widget.appointments.isEmpty ? null : widget.appointments.first;
  late DateTime _month;

  static DateTime? _dayOf(ApiAppointment a) {
    final d = DateTime.tryParse(a.date);
    return d == null ? null : DateTime(d.year, d.month, d.day);
  }

  @override
  void initState() {
    super.initState();
    for (final a in widget.appointments) {
      final day = _dayOf(a);
      if (day != null) _byDay.putIfAbsent(day, () => []).add(a);
    }
    final start = (_selected == null ? null : _dayOf(_selected!)) ?? DateTime.now();
    _month = DateTime(start.year, start.month);
  }

  void _shiftMonth(int delta) => setState(() => _month = DateTime(_month.year, _month.month + delta));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(3)),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(children: [
            IconButton(
              icon: const Icon(Icons.chevron_left_rounded, color: AppColors.primary),
              tooltip: 'Previous month',
              onPressed: () => _shiftMonth(-1),
            ),
            Expanded(
              child: Text(
                DateFormat('MMMM yyyy').format(_month),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: AppColors.textPrimary),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
              tooltip: 'Next month',
              onPressed: () => _shiftMonth(1),
            ),
          ]),
          const SizedBox(height: AppSpacing.sm),
          _buildGrid(),
          const SizedBox(height: AppSpacing.lg),
          if (_selected != null) _AppointmentCard(appointment: _selected!),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            icon: const Icon(Icons.event_note_outlined),
            label: const Text('View all appointments'),
            onPressed: () {
              Navigator.pop(context);
              widget.onViewAll();
            },
          ),
        ]),
      ),
    );
  }

  Widget _buildGrid() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final leading = _month.weekday - 1; // Monday first
    final selectedDay = _selected == null ? null : _dayOf(_selected!);

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        for (final w in _weekdays)
          Center(
            child: Text(w,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          ),
        for (var i = 0; i < leading; i++) const SizedBox.shrink(),
        for (var d = 1; d <= daysInMonth; d++)
          _buildDay(DateTime(_month.year, _month.month, d), today, selectedDay),
      ],
    );
  }

  Widget _buildDay(DateTime day, DateTime today, DateTime? selectedDay) {
    final appts = _byDay[day];
    final hasAppt = appts != null && appts.isNotEmpty;
    final isToday = day == today;
    final isSelected = day == selectedDay;

    final cell = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: hasAppt ? (isSelected ? AppColors.deepTeal : AppColors.primary) : null,
        border: isToday ? Border.all(color: AppColors.primary, width: 2) : null,
        boxShadow: isSelected ? AppShadows.soft : null,
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: hasAppt || isToday ? FontWeight.w700 : FontWeight.w500,
          color: hasAppt ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );

    if (!hasAppt) return cell;
    return PressableScale(
      onTap: () => setState(() => _selected = appts.first),
      borderRadius: 40,
      child: cell,
    );
  }
}

/// Mint card with the appointment's specialty, date/time, and location and
/// notes when present.
class _AppointmentCard extends StatelessWidget {
  final ApiAppointment appointment;
  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final parsed = DateTime.tryParse(appointment.date);
    final date = parsed != null ? DateFormat('EEE d MMM').format(parsed) : appointment.date;
    final when = [date, appointment.time].where((s) => s.isNotEmpty).join(' · ');

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Container(
        key: ValueKey(appointment.id ?? '${appointment.date}${appointment.time}'),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.mint, borderRadius: BorderRadius.circular(AppRadius.card)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.event_outlined, color: AppColors.teal, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                appointment.specialty.isEmpty ? 'Appointment' : appointment.specialty,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15.5, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 2),
              Text(when, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.deepTeal)),
              if (appointment.location.isNotEmpty)
                _Detail(icon: Icons.location_on_outlined, text: appointment.location),
              if (appointment.reason.isNotEmpty) _Detail(icon: Icons.notes_rounded, text: appointment.reason),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Detail({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.3))),
        ]),
      );
}
