import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'curved_header_page.dart';
import 'pill_background.dart';

/// Shared layout for login / register / forgot password: navy header with
/// the DAWI logo and a welcome line, and the rounded content sheet
/// ([CurvedHeaderPage]) holding [child] on a white card. The sheet scrolls,
/// so the form stays reachable with the keyboard open. A back button shows
/// when there's a route to pop.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return Scaffold(
      body: CurvedHeaderPage(
        headerBackground: const PillBackground(opacity: 0.08),
        header: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                height: 40,
                child: canPop
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                        tooltip: AppLocalizations.of(context).back,
                        onPressed: () => Navigator.maybePop(context),
                      )
                    : null,
              ),
            ),
            const _Logo(),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.mint, fontSize: 13.5, height: 1.4),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: AppShadows.soft,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Mint circle with the medical icon, then the DAWI wordmark.
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.mint,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: const Icon(Icons.health_and_safety_rounded, color: AppColors.deepTeal, size: 36),
      ),
      const SizedBox(height: AppSpacing.sm),
      const Text(
        'DAWI',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 4),
      ),
    ],
  );
}
