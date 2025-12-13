// API Configuration for UniHub

class ApiConfig {
  // Your Gemini API key
  static const String geminiApiKey = 'AIzaSyAMWXoAfH4HQZyhHo_ek3S-Mbke6RY9QcE';
  
  // API key is configured (always true now since you have a real key)
  static bool get isGeminiConfigured => geminiApiKey.isNotEmpty;
}
