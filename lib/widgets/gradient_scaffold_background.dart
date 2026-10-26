import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Soft mint-to-cream gradient backdrop used behind the main screens.
class GradientScaffoldBackground extends StatelessWidget {
  final Widget child;
  const GradientScaffoldBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
        ),
      ),
      child: child,
    );
  }
}
