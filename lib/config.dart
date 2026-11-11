/// Central place for API keys and app-wide constants.
///
/// Keys are injected at build time so they never live in source control:
///   flutter run --dart-define=GEMINI_API_KEY=xxx --dart-define=OPENWEATHER_API_KEY=yyy
/// or keep them in a local `env.json` (git-ignored) and run:
///   flutter run --dart-define-from-file=env.json
class AppConfig {
  static const String appName = 'Travel Plan';
  static const String appVersion = '2.0.0';

  static const String geminiApiKey =
      String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  static const String openWeatherApiKey =
      String.fromEnvironment('OPENWEATHER_API_KEY', defaultValue: '');

  // Firebase (Web app config from Firebase Console -> Project settings).
  // One config works for both the Android APK and the Web build.
  static const String firebaseApiKey =
      String.fromEnvironment('FIREBASE_API_KEY', defaultValue: '');
  static const String firebaseAppId =
      String.fromEnvironment('FIREBASE_APP_ID', defaultValue: '');
  static const String firebaseSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID', defaultValue: '');
  static const String firebaseProjectId =
      String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: '');
  static const String firebaseAuthDomain =
      String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: '');
  static const String firebaseStorageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: '');

  static bool get hasFirebase =>
      firebaseApiKey.isNotEmpty &&
      firebaseAppId.isNotEmpty &&
      firebaseProjectId.isNotEmpty;

  static bool get hasGeminiKey => geminiApiKey.isNotEmpty;
  static bool get hasWeatherKey => openWeatherApiKey.isNotEmpty;
}
