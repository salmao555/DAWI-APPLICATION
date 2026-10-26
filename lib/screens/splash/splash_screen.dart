import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/token_storage.dart';
import '../../theme/app_theme.dart';
import '../../widgets/pill_background.dart';
import '../auth/login_screen.dart';
import '../home/main_shell.dart';
import '../onboarding/onboarding_screen.dart';

/// Minimal splash screen (spec section 1): DAWI wordmark, medical icon and
/// Arabic name on deep teal, then automatic navigation to onboarding,
/// login, or the main app shell depending on whether onboarding was seen
/// and whether a saved session restores successfully.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final auth = context.read<AuthProvider>();
    final seenOnboarding = await tokenStorage.hasSeenOnboarding();
    await auth.tryAutoLogin();
    // Small minimum delay so the splash doesn't just flash by.
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    Widget next;
    if (auth.status == AuthStatus.authenticated) {
      next = const MainShell();
    } else if (!seenOnboarding) {
      next = const OnboardingScreen();
    } else {
      next = const LoginScreen();
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepTeal,
      body: Stack(
        children: [
          const Positioned.fill(child: PillBackground(opacity: 0.1)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'DAWI',
                  style: TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.w800, letterSpacing: 6),
                ),
                const SizedBox(height: AppSpacing.lg),
                Container(
                  width: 104,
                  height: 104,
                  decoration: const BoxDecoration(color: AppColors.mint, shape: BoxShape.circle),
                  child: const Icon(Icons.health_and_safety_rounded, color: AppColors.deepTeal, size: 52),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'داوي',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
