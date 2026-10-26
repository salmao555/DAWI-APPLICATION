import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../screens/auth/login_screen.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../settings/privacy_screen.dart';
import '../settings/settings_screen.dart';

/// Profile page (spec section 25).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await context.read<AuthProvider>().logout();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
  }

  /// Bottom sheet with the three app languages. Picking one switches the
  /// UI immediately and saves it on this device. (There's no backend
  /// endpoint to update preferred_language after sign-up yet.)
  void _pickLanguage(BuildContext context) {
    final localeProvider = context.read<LocaleProvider>();
    final current = localeProvider.locale.languageCode;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.lg),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(3)),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SectionTitle(AppLocalizations.of(sheetContext).chooseLanguage),
            const SizedBox(height: AppSpacing.md),
            for (final (code, name) in LocaleProvider.pickerOptions)
              AppTile(
                icon: Icons.language_outlined,
                title: name,
                trailing: code == current ? const Icon(Icons.check_circle_rounded, color: AppColors.primary) : null,
                onTap: () {
                  Navigator.pop(sheetContext);
                  localeProvider.setLocale(Locale(code));
                },
              ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = context.watch<AuthProvider>().user;
    final languageName = context.watch<LocaleProvider>().displayName(user);
    final name = user?.fullName.isNotEmpty == true ? user!.fullName : l10n.profileFallbackName;
    final initial = user?.firstName.isNotEmpty == true ? user!.firstName[0].toUpperCase() : '?';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            FadeSlideIn(child: _ProfileHero(name: name, email: user?.email ?? '', initial: initial)),
            const SizedBox(height: AppSpacing.lg),
            SectionTitle(l10n.sectionPersonalInfo),
            const SizedBox(height: AppSpacing.md),
            AppTile(
              icon: Icons.phone_outlined,
              title: l10n.fieldPhone,
              trailing: _Value(user?.phone.isEmpty ?? true ? l10n.notSet : user!.phone),
            ),
            AppTile(
              icon: Icons.language_outlined,
              title: l10n.fieldPreferredLanguage,
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                _Value(languageName),
                const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
              ]),
              onTap: () => _pickLanguage(context),
            ),
            const SizedBox(height: AppSpacing.sm),
            SectionTitle(l10n.sectionAccount),
            const SizedBox(height: AppSpacing.md),
            AppTile(
              icon: Icons.settings_outlined,
              title: l10n.settingsTitle,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
            AppTile(
              icon: Icons.privacy_tip_outlined,
              title: l10n.privacySecurity,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen())),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout, color: Colors.redAccent),
                label: Text(l10n.logout, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.cardBackground,
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dark card (same fill as the home stat cards): avatar, name, email.
class _ProfileHero extends StatelessWidget {
  final String name;
  final String email;
  final String initial;
  const _ProfileHero({required this.name, required this.email, required this.initial});

  @override
  Widget build(BuildContext context) => GradientCard(
        colors: const [AppColors.darkCard, AppColors.darkCard],
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(children: [
          // Same avatar as the home header.
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: AppColors.teal, width: 3),
            ),
            child: Text(initial,
                style: const TextStyle(color: AppColors.deepTeal, fontSize: 24, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
              if (email.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
              ],
            ]),
          ),
        ]),
      );
}

class _Value extends StatelessWidget {
  final String text;
  const _Value(this.text);
  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary));
}
