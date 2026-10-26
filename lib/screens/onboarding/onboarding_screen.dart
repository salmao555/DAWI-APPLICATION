import 'package:flutter/material.dart';

import '../../services/token_storage.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/pill_background.dart';
import '../auth/login_screen.dart';

class _OnboardingPageData {
  final IconData icon;
  final String Function(AppLocalizations) title;
  final String Function(AppLocalizations) description;
  const _OnboardingPageData({required this.icon, required this.title, required this.description});
}

final _pages = [
  _OnboardingPageData(
    icon: Icons.document_scanner_outlined,
    title: (l) => l.onboarding1Title,
    description: (l) => l.onboarding1Body,
  ),
  _OnboardingPageData(
    icon: Icons.folder_shared_outlined,
    title: (l) => l.onboarding2Title,
    description: (l) => l.onboarding2Body,
  ),
  _OnboardingPageData(
    icon: Icons.smart_toy_outlined,
    title: (l) => l.onboarding3Title,
    description: (l) => l.onboarding3Body,
  ),
  _OnboardingPageData(
    icon: Icons.notifications_active_outlined,
    title: (l) => l.onboarding4Title,
    description: (l) => l.onboarding4Body,
  ),
];

/// Spec section 2: 3–4 onboarding screens with Skip / Next / Get Started.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  Future<void> _finish() async {
    await tokenStorage.markOnboardingSeen();
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  void _next() {
    if (_index == _pages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _pages.length - 1;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          const Positioned.fill(child: PillBackground()),
          Column(
            children: [
              // Skip sits on the teal area, top right.
              SafeArea(
                bottom: false,
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: TextButton(
                      onPressed: _finish,
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                      child: Text(l10n.onboardingSkip),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) => _OnboardingPage(page: _pages[i]),
                ),
              ),
              // Fixed bottom of the white sheet: dots + button (the page above
              // supplies the sheet's rounded top and text).
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.lg + MediaQuery.paddingOf(context).bottom,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (i) {
                        final active = i == _index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active ? AppColors.primary : AppColors.divider,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ElevatedButton(onPressed: _next, child: Text(isLast ? l10n.onboardingGetStarted : l10n.onboardingNext)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Large icon in a mint circle over the teal area, then the white sheet
/// (28px rounded top) with the title and description.
class _OnboardingPage extends StatelessWidget {
  final _OnboardingPageData page;
  const _OnboardingPage({required this.page});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: Center(
          child: Container(
            width: 148,
            height: 148,
            decoration: BoxDecoration(
              color: AppColors.mint,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: Icon(page.icon, size: 68, color: AppColors.deepTeal),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, AppSpacing.md),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            Text(
              page.title(AppLocalizations.of(context)),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Fixed 5-line slot (French and Arabic run longer) so the sheet doesn't jump between pages.
            SizedBox(
              height: 110,
              child: Text(
                page.description(AppLocalizations.of(context)),
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14.5, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
