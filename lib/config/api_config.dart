// API Configuration for UniHub

class ApiConfig {
  // Gemini API key must be provided at build time:
  // flutter run --dart-define=GEMINI_API_KEY=YOUR_KEY
  static const String geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

  static bool get isGeminiConfigured => geminiApiKey.isNotEmpty;
}
