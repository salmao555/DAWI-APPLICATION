import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Diagonal sky blue -> blush backdrop over off-white, behind the main screens.
class GradientScaffoldBackground extends StatelessWidget {
  final Widget child;
  const GradientScaffoldBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundBase,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
          ),
        ),
        child: child,
      ),
    );
  }
}
