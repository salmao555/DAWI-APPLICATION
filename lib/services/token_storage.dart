import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the JWT auth token (and a couple of small flags) across app
/// restarts. Backed by the OS keychain/keystore on mobile, and by an
/// encrypted-at-rest browser storage shim on web.
class TokenStorage {
  static const _tokenKey = 'auth_token';
  static const _onboardingSeenKey = 'onboarding_seen';
  static const _localeKey = 'app_locale';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) => _storage.write(key: _tokenKey, value: token);

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<void> clearToken() => _storage.delete(key: _tokenKey);

  Future<void> markOnboardingSeen() => _storage.write(key: _onboardingSeenKey, value: 'true');

  Future<bool> hasSeenOnboarding() async => (await _storage.read(key: _onboardingSeenKey)) == 'true';

  /// App language chosen by the user ('en' / 'fr' / 'ar'), or null if never chosen.
  Future<void> saveLocale(String languageCode) => _storage.write(key: _localeKey, value: languageCode);

  Future<String?> readLocale() => _storage.read(key: _localeKey);
}

final TokenStorage tokenStorage = TokenStorage();
