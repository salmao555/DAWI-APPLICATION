import 'dart:async';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../models/api_models.dart';
import '../services/token_storage.dart';

/// The app's UI language (English, French or Arabic). Arabic flips the
/// whole UI to right-to-left via MaterialApp.
///
/// Which language is used, in order:
///  1. the one the user picked (register dropdown or Profile), saved locally;
///  2. the logged-in user's `preferred_language` from the backend;
///  3. the device language, if supported;
///  4. English.
class LocaleProvider extends ChangeNotifier {
  static const supportedLocales = [Locale('en'), Locale('fr'), Locale('ar')];

  /// Language options shown in the Profile picker, in their own language.
  static const pickerOptions = [('en', 'English'), ('fr', 'Français'), ('ar', 'العربية')];

  Locale _locale = _deviceLocale();
  bool _userChose = false;
  String? _appliedUserId;

  Locale get locale => _locale;

  /// Reads the saved choice. Call once before the first frame.
  Future<void> load() async {
    final saved = await tokenStorage.readLocale();
    if (saved != null && _isSupported(saved)) {
      _locale = Locale(saved);
      _userChose = true;
    }
    _applyIntl();
  }

  /// Explicit choice from the user: applies right away and is saved.
  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale.languageCode)) return;
    _userChose = true;
    await tokenStorage.saveLocale(locale.languageCode);
    if (locale.languageCode == _locale.languageCode) return;
    _locale = Locale(locale.languageCode);
    _applyIntl();
    notifyListeners();
  }

  /// Called whenever the auth user changes: uses the backend preference
  /// unless the user already picked a language on this device.
  void onUserChanged(ApiUser? user) {
    if (user == null || user.id == _appliedUserId) return;
    _appliedUserId = user.id;
    if (_userChose) return;
    final code = codeForBackendLabel(user.preferredLanguage);
    if (code == _locale.languageCode) return;
    _locale = Locale(code);
    _applyIntl();
    // May be called during a provider update (build phase).
    scheduleMicrotask(notifyListeners);
  }

  /// Name of the current language for display, e.g. in Profile. Shows the
  /// backend label (e.g. "Darija") while it is what drives the UI.
  String displayName(ApiUser? user) {
    final backend = user?.preferredLanguage;
    if (!_userChose && backend != null && codeForBackendLabel(backend) == _locale.languageCode) {
      return backend;
    }
    return pickerOptions.firstWhere((o) => o.$1 == _locale.languageCode).$2;
  }

  /// Maps the backend/register labels to an app language. Darija and
  /// Tamazight have no UI translation yet and fall back to Arabic.
  static String codeForBackendLabel(String label) {
    switch (label) {
      case 'Français':
        return 'fr';
      case 'العربية':
      case 'Darija':
      case 'Tamazight':
        return 'ar';
      default:
        return 'en';
    }
  }

  static bool _isSupported(String code) => supportedLocales.any((l) => l.languageCode == code);

  static Locale _deviceLocale() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    return _isSupported(code) ? Locale(code) : const Locale('en');
  }

  void _applyIntl() => Intl.defaultLocale = _locale.languageCode;
}
