# UniHub

UniHub is an AI-powered study assistant application built with Flutter. It combines task management, study planning, and AI assistance into a single campus companion app.

## Features

- **Authentication**: Secure login via Email/Password and Google Sign-In (Firebase Auth).
- **AI Chat Assistant**: Integration with Gemini AI for educational Q&A. Supports text, images, and uploading PDF documents for context-aware answers.
- **Study Planner**: Generates personalized weekly study schedules using AI based on user topics and hours.
- **Notes Scanner**: Uses vision capabilities to scan handwritten notes, transcribe them, and generate summaries, flashcards, and quizzes. Can export results to PDF.
- **Smart Reminders**: Specialized content-aware reminders system (UI implemented).
- **Community Feed**: A space for students to share resources and updates (UI implemented).
- **Profile Management**: User details and convenient account management.

## Tech Stack

- **Flutter**: Dart-based cross-platform framework (Material Design 3).
- **Firebase**:
  - Auth: User identity management.
  - Firestore: Cloud database for storing user profiles and study data.
- **AI & ML**: Google Gemini (`google_generative_ai`) for generative text and vision tasks.
- **PDF & File Handling**:
  - `syncfusion_flutter_pdf`: For extracting text from uploaded PDFs.
  - `pdf` & `printing`: For generating downloadable study guides.
  - `file_picker` & `image_picker`: For local media selection.
- **Markdown**: `flutter_markdown` for rendering rich AI responses.

## Setup & Configuration

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Firebase Project with Auth and Firestore enabled
- Gemini API Key

### Installation

1. Clone the repository and install dependencies:
   ```bash
   flutter pub get
   ```

2. **Firebase Configuration**:
   - Ensure `android/app/google-services.json` is present.
   - Ensure `ios/Runner/GoogleService-Info.plist` is present (for iOS).

3. **Keystore (Release Builds)**:
   - Copy `android/keystore.properties.example` to `android/keystore.properties`.
   - Fill in your signing key details.

### Running the App

This project uses compile-time variables for API keys to improve security. You **must** provide your Gemini API key when running or building the app.

**Debug Mode:**
```bash
flutter run --dart-define=GEMINI_API_KEY=your_actual_api_key_here
```

**Release Build:**
```bash
flutter build apk --release --dart-define=GEMINI_API_KEY=your_actual_api_key_here
```

### Note on Security
- API keys are no longer hardcoded in the source.
- Debug logs are stripped in release mode.
- Android backups are disabled to prevent data leakage.
