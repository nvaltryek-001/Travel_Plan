/// Central place for API keys and app-wide constants.
///
/// Billable keys are injected at build time so they never live in source control:
///   flutter run --dart-define=GEMINI_API_KEY=xxx --dart-define=OPENWEATHER_API_KEY=yyy
/// or keep them in a local `env.json` (git-ignored) and run:
///   flutter run --dart-define-from-file=env.json
///
/// The Firebase web config is safe to ship (it is public by design) so it is
/// baked in below. A `--dart-define` can still override any value, but an EMPTY
/// override is ignored via [_orDefault] so a blank secret can never wipe the
/// config and break startup.
class AppConfig {
  static const String appName = 'Travel Plan';
  static const String appVersion = '2.1.0';

  /// Returns [value] when it is non-empty, otherwise [fallback].
  static String _orDefault(String value, String fallback) =>
      value.trim().isEmpty ? fallback : value;

  static const String geminiApiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  static const String openWeatherApiKey =
      String.fromEnvironment('OPENWEATHER_API_KEY', defaultValue: '');

  // Firebase (Web app config from Firebase Console -> Project settings).
  // One config works for both the Android APK and the Web build.
  static const String _fbApiKey =
      String.fromEnvironment('FIREBASE_API_KEY');
  static const String _fbAppId =
      String.fromEnvironment('FIREBASE_APP_ID');
  static const String _fbSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const String _fbProjectId =
      String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const String _fbAuthDomain =
      String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
  static const String _fbStorageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET');

  static String get firebaseApiKey =>
      _orDefault(_fbApiKey, 'AIzaSyDVc6JhWisB6U9Cti8-hT_43yDemiljkUw');
  static String get firebaseAppId =>
      _orDefault(_fbAppId, '1:779912072136:web:7f1981aed7cd5b51c34efd');
  static String get firebaseSenderId =>
      _orDefault(_fbSenderId, '779912072136');
  static String get firebaseProjectId =>
      _orDefault(_fbProjectId, 'travel-plan001');
  static String get firebaseAuthDomain =>
      _orDefault(_fbAuthDomain, 'travel-plan001.firebaseapp.com');
  static String get firebaseStorageBucket =>
      _orDefault(_fbStorageBucket, 'travel-plan001.firebasestorage.app');

  static bool get hasFirebase =>
      firebaseApiKey.isNotEmpty &&
      firebaseAppId.isNotEmpty &&
      firebaseProjectId.isNotEmpty;

  static bool get hasGeminiKey => geminiApiKey.trim().isNotEmpty;
  static bool get hasWeatherKey => openWeatherApiKey.trim().isNotEmpty;
}
