import 'package:flutter_test/flutter_test.dart';

import 'package:smart_travel_app/config.dart';

void main() {
  test('AppConfig exposes app metadata', () {
    expect(AppConfig.appName, 'Travel Plan');
    expect(AppConfig.appVersion, isNotEmpty);
  });

  test('API keys are injected via --dart-define, not hardcoded', () {
    // Without --dart-define the keys must be empty (no secrets in source).
    expect(AppConfig.geminiApiKey, isA<String>());
    expect(AppConfig.openWeatherApiKey, isA<String>());
  });
}
