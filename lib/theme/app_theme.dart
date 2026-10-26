import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for colors, spacing and the app's [ThemeData].
/// Style: navy/blue medical UI — dark navy anchors (header, nav, splash),
/// pale blue page background, translucent white cards with 24px radii and
/// soft blue-tinted shadows, deep blue for buttons and selected states.
class AppColors {
  AppColors._();

  // Palette
  static const Color navy = Color(0xFF072D44);
  static const Color deepBlue = Color(0xFF064469);
  static const Color midBlue = Color(0xFF5790AB);
  static const Color lightBlue = Color(0xFF9CCDDB);
  static const Color greyBlue = Color(0xFFD0D7E1);

  // Warm accents
  static const Color dustyBlue = Color(0xFF6E7F9A); // header glow
  static const Color skyBlue = Color(0xFF93B5C6);
  static const Color grey = Color(0xFFC9CCD5);
  static const Color mauve = Color(0xFFE4D8DC);
  static const Color blush = Color(0xFFFFE3E3);
  static const Color roseDark = Color(0xFF8C3B4A); // icon/text on blush (6:1)

  /// Appointment banner fill. Name kept from the old amber; now blush.
  static const Color alertAmber = blush;

  /// Icon circle fill: lightBlue at 45% (flat fallback; see [iconBubbleGradient]).
  static const Color iconBubble = Color(0x739CCDDB);

  /// Icon circles: soft diagonal sky blue -> mauve. Use deepBlue icons on it.
  static const LinearGradient iconBubbleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x9993B5C6), mauve], // skyBlue 60% -> mauve
  );

  // Old names kept so existing screens compile; values are the blue palette.
  static const Color teal = midBlue; // accent icons
  static const Color deepTeal = deepBlue;
  static const Color mint = Color(0xFFD2E8EF); // lightBlue 45% over white, as a solid
  static const Color navDark = navy; // floating nav pill, splash
  static const Color darkCard = deepBlue; // dark pills, selected chips, profile hero

  // Main-screen background: diagonal gradient from backgroundTop
  // (top-left) to backgroundBottom (bottom-right), over backgroundBase.
  static const Color backgroundBase = Color(0xFFF5F8FA);
  static const Color backgroundTop = Color(0x5993B5C6); // skyBlue 35%
  static const Color backgroundBottom = Color(0x99FFE3E3); // blush 60%

  // Core
  static const Color primary = deepBlue; // buttons, selected states
  static const Color primaryLight = mint;
  static const Color secondary = midBlue; // links, secondary text buttons
  static const Color scaffoldBackground = backgroundBase;
  static const Color cardBackground = Color(0xE6FFFFFF); // white 90%, lets the gradient through

  static const Color mintBackground = mint;

  // Text
  static const Color textPrimary = navy;
  // Darker than the spec's #5E7A8C so it passes AA (4.5:1) on the
  // sky blue / blush background as well as on white.
  static const Color textSecondary = Color(0xFF4A6072);

  // Status / misc
  static const Color success = Color(0xFF2FB273);
  static const Color divider = greyBlue;
  static const Color chipBackground = Color(0xFFEEF2F6);

  // Old accent panel names, all mapped to the single blue accent.
  static const Color tealPanel = mint;
  static const Color lilacPanel = mint;
  static const Color lilacDark = deepBlue;
  static const Color peachPanel = mint;

  // Header gradient: navy -> deep blue.
  static const Color gradientTop = navy;
  static const Color gradientBottom = deepBlue;
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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

/// Deep blue pill for secondary actions: white label, light blue icon.
class AppButtons {
  AppButtons._();

  static final ButtonStyle dark = OutlinedButton.styleFrom(
    backgroundColor: AppColors.darkCard,
    foregroundColor: Colors.white,
    iconColor: AppColors.lightBlue,
    side: BorderSide.none,
  );
}

class AppShadows {
  AppShadows._();

  /// Use in Container(decoration: BoxDecoration(boxShadow: AppShadows.soft))
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x1A064469), // deepBlue 10%
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
        shadowColor: const Color(0x1A064469),
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
        checkmarkColor: AppColors.lightBlue,
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
          borderSide: const BorderSide(color: AppColors.greyBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: const Color(0x1A064469),
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
        indicatorColor: AppColors.primary,
        dividerColor: Colors.transparent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : AppColors.textSecondary),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.primary : AppColors.greyBlue),
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
