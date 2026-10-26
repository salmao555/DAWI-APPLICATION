import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'providers/auth_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/splash/splash_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Saved language is read before the first frame, so the splash already
  // shows in the right language and direction.
  final localeProvider = LocaleProvider();
  await localeProvider.load();
  runApp(HealthKeepApp(localeProvider: localeProvider));
}

/// Root widget for the personal health app.
///
/// Flow: [SplashScreen] restores any saved session, then routes to
/// onboarding (first launch), login (returning, logged out), or
/// [MainShell] (logged in) — see splash_screen.dart for the exact logic.
class HealthKeepApp extends StatelessWidget {
  const HealthKeepApp({super.key, required this.localeProvider});

  final LocaleProvider localeProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Follows the logged-in user's preferred_language unless the user
        // picked a language on this device.
        ChangeNotifierProxyProvider<AuthProvider, LocaleProvider>(
          create: (_) => localeProvider,
          update: (_, auth, locale) => locale!..onUserChanged(auth.user),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, locale, _) => MaterialApp(
          onGenerateTitle: (context) => 'DAWI',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          locale: locale.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
