import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../../widgets/gradient_scaffold_background.dart';
import '../ai/ai_assistant_screen.dart';
import '../documents/documents_screen.dart';
import '../health/medical_record_screen.dart';
import '../profile/profile_screen.dart';
import 'home_dashboard_screen.dart';

/// Main navigation shell (spec section 31): bottom nav with 5 sections —
/// Home, Documents, Health, AI Assistant, Profile. Uses an IndexedStack so
/// each tab keeps its own scroll position / state when switching.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  static _MainShellState? of(BuildContext context) => context.findAncestorStateOfType<_MainShellState>();

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      (Icons.home_outlined, Icons.home_rounded, l10n.navHome),
      (Icons.folder_outlined, Icons.folder_rounded, l10n.navDocuments),
      (Icons.favorite_outline_rounded, Icons.favorite_rounded, l10n.navHealth),
      (Icons.auto_awesome_outlined, Icons.auto_awesome_rounded, l10n.navAssistant),
      (Icons.person_outline_rounded, Icons.person_rounded, l10n.navProfile),
    ];
    return Scaffold(
      // Body extends behind the floating bar; Scaffold adds the bar's height
      // to the body's bottom MediaQuery padding, so SafeArea/lists and FABs
      // in the tabs stay clear of it.
      extendBody: true,
      body: GradientScaffoldBackground(
        // Tab scaffolds go transparent so the shared gradient shows through.
        child: Theme(
          data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.transparent),
          child: IndexedStack(
            index: _index,
            children: const [
              HomeDashboardScreen(),
              DocumentsScreen(),
              MedicalRecordScreen(),
              AiAssistantScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.navDark,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [BoxShadow(color: Color(0x33072D44), blurRadius: 24, offset: Offset(0, 10))],
            ),
            child: Row(children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavItem(
                    icon: items[i].$1,
                    selectedIcon: items[i].$2,
                    label: items[i].$3,
                    selected: i == _index,
                    onTap: () => goToTab(i),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Icon-only nav button: white circle with deep blue icon when selected.
class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Semantics(
        label: label,
        selected: selected,
        button: true,
        child: Tooltip(
          message: label,
          child: Center(
            child: PressableScale(
              onTap: onTap,
              borderRadius: 24,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  selected ? selectedIcon : icon,
                  color: selected ? AppColors.primary : Colors.white.withValues(alpha: 0.6),
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      );
}
