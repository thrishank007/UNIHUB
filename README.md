# UniHub

UniHub is a Flutter app that functions as an AI powered study assistant.

It includes:

- AI chat assistant (Gemini) with document upload (PDF, images, text files)
- AI study planner that generates a structured weekly plan
- Notes scanner that transcribes handwritten notes from an image and turns them into structured notes (summary, key points, flashcards, quiz questions) with PDF export
- Smart reminders UI
- Community feed UI

## What is implemented today

- Auth: Email/password and Google Sign-In via Firebase Auth
- User profile: stored in Firestore on signup or first Google sign-in
- Study plans: FirestoreService supports saving and streaming study plans
- Chat: AI chat is implemented in the app UI
- Community and Smart Reminders screens currently use in-app sample data (UI is real, persistence is not wired up)

## Tech stack

- Flutter (Material)
- Firebase: Auth, Firestore, Core
- Gemini via `google_generative_ai`
- File and media: `file_picker`, `image_picker`
- PDF: `syncfusion_flutter_pdf` (text extraction), `pdf` + `printing` (export)
- Markdown and math rendering in chat

## Setup

Prerequisites:

- Flutter SDK installed
- A Firebase project (Auth enabled, Firestore enabled)
- A Gemini API key

Install dependencies:

```bash
flutter pub get
```

Firebase:

1. Configure Firebase for your platforms using FlutterFire (recommended).
2. Ensure `android/app/google-services.json` is present.
3. iOS uses `ios/Runner/GoogleService-Info.plist`. If it is missing, iOS builds will not have Firebase configured.

Gemini:

This repo expects the Gemini key at build time.

Run the app:

```bash
flutter run --dart-define=GEMINI_API_KEY=YOUR_KEY
```

Build a release APK:

```bash
flutter build apk --release --dart-define=GEMINI_API_KEY=YOUR_KEY
```

## Android release signing

Release builds require a real signing key.

1. Create a keystore (`.jks`).
2. Fill `android/keystore.properties` with your keystore details.
3. Build release.

`android/keystore.properties` and keystore files should never be committed.

## Project structure

- `lib/main.dart`: app entry, Firebase init, auth wrapper
- `lib/screens/`: main screens (Home, Login, AI Chat, Notes Scanner, Community, Profile)
- `lib/pages/`: feature pages (Study Planner and results, focus session, settings)
- `lib/services/`: Firebase auth, Firestore, Gemini, PDF generation
- `lib/config/`: runtime and build-time configuration (Gemini key)

## Notes for developers

- Google Sign-In requires the correct SHA-1 fingerprint in Firebase Console for Android.
- If Gemini is not configured, AI features will return a configuration error.
- Firestore security rules are not stored in this repo. Lock down rules in Firebase Console before production.
