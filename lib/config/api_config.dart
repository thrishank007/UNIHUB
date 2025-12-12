// API Configuration for UniHub

class ApiConfig {
  // Your Gemini API key
  static const String geminiApiKey = 'AIzaSyDSOjBG0e-DwraEdQColDQN_6D5dZL-xVc';
  
  // API key is configured (always true now since you have a real key)
  static bool get isGeminiConfigured => geminiApiKey.isNotEmpty;
}
