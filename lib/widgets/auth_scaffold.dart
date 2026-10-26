import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'gradient_scaffold_background.dart';
import 'pill_background.dart';

/// How far the form sheet slides up over the teal header.
const double _sheetOverlap = 24;

/// Shared layout for login / register / forgot password: teal header with
/// the DAWI logo and a welcome line, then a white rounded sheet holding
/// [child]. The whole page scrolls, so the form stays reachable with the
/// keyboard open. A back button shows when there's a route to pop.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return Scaffold(
      body: GradientScaffoldBackground(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                child: Container(
                  color: AppColors.primary,
                  child: Stack(
                    children: [
                      const Positioned.fill(child: PillBackground(opacity: 0.08)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          AppSpacing.lg,
                          MediaQuery.paddingOf(context).top + AppSpacing.md,
                          AppSpacing.lg,
                          AppSpacing.xl + _sheetOverlap,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 40,
                                child: canPop
                                    ? IconButton(
                                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                                        tooltip: 'Back',
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
                      ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -_sheetOverlap),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: AppShadows.soft,
                  ),
                  child: child,
                ),
              ),
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
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
