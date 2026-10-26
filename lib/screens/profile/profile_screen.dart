import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final name = user?.fullName.isNotEmpty == true ? user!.fullName : 'Your profile';
    final initial = user?.firstName.isNotEmpty == true ? user!.firstName[0].toUpperCase() : '?';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            FadeSlideIn(child: _ProfileHero(name: name, email: user?.email ?? '', initial: initial)),
            const SizedBox(height: AppSpacing.lg),
            const SectionTitle('Personal info'),
            const SizedBox(height: AppSpacing.md),
            AppTile(icon: Icons.phone_outlined, title: 'Phone', trailing: _Value(user?.phone.isEmpty ?? true ? 'Not set' : user!.phone)),
            AppTile(icon: Icons.language_outlined, title: 'Preferred language', trailing: _Value(user?.preferredLanguage ?? 'English')),
            const SizedBox(height: AppSpacing.sm),
            const SectionTitle('Account'),
            const SizedBox(height: AppSpacing.md),
            AppTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
            AppTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy & Security',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyScreen())),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout, color: Colors.redAccent),
                label: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
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
