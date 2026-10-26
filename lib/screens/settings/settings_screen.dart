import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';

/// Settings page (spec section 27). NOTE: the toggles here are local UI
/// state for now — persisting them (and wiring notification toggles to
/// actual scheduled reminders) is a natural next step once push/local
/// notifications are set up.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _medicationReminders = true;
  bool _appointmentReminders = true;
  bool _generalNotifications = true;
  bool _biometricLock = false;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const SectionTitle('Notifications'),
            const SizedBox(height: AppSpacing.md),
            _Group(children: [
              _SwitchRow(
                icon: Icons.medication_outlined,
                title: 'Medication reminders',
                value: _medicationReminders,
                onChanged: (v) => setState(() => _medicationReminders = v),
              ),
              _SwitchRow(
                icon: Icons.event_outlined,
                title: 'Appointment reminders',
                value: _appointmentReminders,
                onChanged: (v) => setState(() => _appointmentReminders = v),
              ),
              _SwitchRow(
                icon: Icons.notifications_outlined,
                title: 'General notifications',
                value: _generalNotifications,
                onChanged: (v) => setState(() => _generalNotifications = v),
              ),
            ]),
            const SizedBox(height: AppSpacing.lg),
            const SectionTitle('Privacy & Security'),
            const SizedBox(height: AppSpacing.md),
            _Group(children: [
              _SwitchRow(
                icon: Icons.fingerprint,
                title: 'Biometric app lock',
                subtitle: 'Requires Face ID / fingerprint to open the app',
                value: _biometricLock,
                onChanged: (v) => setState(() => _biometricLock = v),
              ),
            ]),
            const SizedBox(height: AppSpacing.lg),
            const SectionTitle('Application'),
            const SizedBox(height: AppSpacing.md),
            _Group(children: [
              _SwitchRow(
                icon: Icons.dark_mode_outlined,
                title: 'Dark mode',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
            ]),
            const SizedBox(height: AppSpacing.md),
            AppTile(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'DAWI',
                applicationVersion: '1.0.0 (MVP)',
                children: const [Text('Your health, organized and understood.')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle _rowTitle = TextStyle(fontWeight: FontWeight.w600, fontSize: 14.5, color: AppColors.textPrimary);

/// Translucent white panel holding a group of rows.
class _Group extends StatelessWidget {
  final List<Widget> children;
  const _Group({required this.children});
  @override
  Widget build(BuildContext context) => AppPanel(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(children: children),
      );
}

/// Teal icon on a mint circle, as in AppTile.
class _Bubble extends StatelessWidget {
  final IconData icon;
  const _Bubble(this.icon);
  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(color: AppColors.mint, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.teal, size: 20),
      );
}

class _SwitchRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchRow({required this.icon, required this.title, this.subtitle, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) => SwitchListTile(
        value: value,
        onChanged: onChanged,
        secondary: _Bubble(icon),
        title: Text(title, style: _rowTitle),
        subtitle: subtitle == null
            ? null
            : Text(subtitle!, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
      );
}
