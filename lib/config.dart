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

  static bool get hasGeminiKey => geminiApiKey.isNotEmpty;
  static bool get hasWeatherKey => openWeatherApiKey.isNotEmpty;
}
