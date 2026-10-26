import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for colors, spacing and the app's [ThemeData].
/// Style: clean teal medical UI — pale mint background, white cards with
/// 24px radii and soft teal-tinted shadows, a single teal accent.
class AppColors {
  AppColors._();

  // Palette
  static const Color teal = Color(0xFF1FB5A6);
  static const Color deepTeal = Color(0xFF0E8C85);
  static const Color mint = Color(0xFFE3F6F3);
  static const Color alertAmber = Color(0xFFFFE9B5); // appointment banner only
  static const Color navDark = Color(0xFF14211F); // floating nav pill
  static const Color darkCard = Color(0xD914211F); // navDark 85%: home stat cards, profile hero

  // Main-screen background gradient (top -> bottom)
  static const Color backgroundTop = Color(0xFFCDEBE6);
  static const Color backgroundBottom = Color(0xFFF3F1EA);

  // Core (names kept so existing screens keep compiling)
  static const Color primary = teal; // buttons, nav, accents
  static const Color primaryLight = mint;
  static const Color secondary = deepTeal;
  static const Color scaffoldBackground = mint;
  static const Color cardBackground = Color(0xCCFFFFFF); // white 80%, lets the gradient through

  static const Color mintBackground = mint;

  // Text
  static const Color textPrimary = Color(0xFF17303A);
  static const Color textSecondary = Color(0xFF6B8790);

  // Status / misc
  static const Color success = Color(0xFF2FB273);
  static const Color divider = Color(0xFFDCEDEA);
  static const Color chipBackground = Color(0xFFEEF8F6);

  // Old accent panel names, all mapped to the single teal accent.
  static const Color tealPanel = mint;
  static const Color lilacPanel = mint;
  static const Color lilacDark = deepTeal;
  static const Color peachPanel = mint;

  // Kept for compatibility; flat (no gradients in this theme).
  static const Color gradientTop = deepTeal;
  static const Color gradientBottom = deepTeal;
  static const LinearGradient heroGradient = LinearGradient(
    colors: [gradientTop, gradientBottom],
  );
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppRadius {
  AppRadius._();
  static const double card = 24;
  static const double button = 30; // pill
  static const double field = 20;
}

/// Dark pill for secondary actions (the nav-pill look): white label, teal icon.
class AppButtons {
  AppButtons._();

  static final ButtonStyle dark = OutlinedButton.styleFrom(
    backgroundColor: AppColors.darkCard,
    foregroundColor: Colors.white,
    iconColor: AppColors.teal,
    side: BorderSide.none,
  );
}

class AppShadows {
  AppShadows._();

  /// Use in Container(decoration: BoxDecoration(boxShadow: AppShadows.soft))
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x0F0E8C85),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];
}

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    // Poppins for Latin text; Cairo fallback for Arabic/Darija.
    final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
      fontFamilyFallback: [GoogleFonts.cairo().fontFamily!],
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.mint,
        onPrimaryContainer: AppColors.deepTeal,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.mint,
        onSecondaryContainer: AppColors.deepTeal,
        surface: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.mint,
      ),
      textTheme: textTheme.copyWith(
        headlineMedium:
            textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
        headlineSmall:
            textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        titleMedium:
            textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 1,
        shadowColor: const Color(0x140E8C85),
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          backgroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          side: const BorderSide(color: AppColors.divider, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkCard,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: StadiumBorder(),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.chipBackground,
        selectedColor: AppColors.darkCard,
        checkmarkColor: AppColors.teal,
        side: BorderSide.none,
        shape: const StadiumBorder(),
        labelStyle: TextStyle(
          color: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected) ? Colors.white : AppColors.textPrimary),
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.secondary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: const Color(0x220E8C85),
        height: 72,
        indicatorColor: AppColors.primary,
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? Colors.white
                : AppColors.textSecondary,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? AppColors.deepTeal
                : AppColors.textSecondary,
          );
        }),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.teal,
        dividerColor: Colors.transparent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.teal : AppColors.textSecondary),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.navDark : AppColors.chipBackground),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }
}
