# Mahabhulekh WebView App (Flutter template)

This repository contains a Flutter WebView app template that wraps the official Maharashtra Mahabhulekh site (https://bhulekh.mahabhumi.gov.in/) and provides polished UI for quick access to ७/१२ (7/12) and ८अ (8A) services.

## Features
- Clean, mobile-first UI (Material).
- WebView integration for the official site.
- Quick entry tiles for 7/12 and 8A services.
- Share and open-in-browser options.
- Placeholder graphics and assets included.

## Requirements
- Flutter SDK (stable)
- Android SDK (for building APK)
- Basic Git & GitHub account (to upload repository)

## How to use (quick)
1. Download and unzip this project.
2. From the project root, run:
   ```bash
   flutter pub get
   flutter run           # to test on a device/emulator
   flutter build apk --release
   ```
3. The generated APK will be in `build/app/outputs/flutter-apk/app-release.apk`.

## Notes & Limitations
- This is a WebView wrapper — the app does not scrape or host land records. It opens the official Mahabhulekh site inside the app.
- For Play Store publishing you must:
  - Create a keystore and sign your APK / App bundle.
  - Prepare store listing images, privacy policy URL, and contact info.
  - Follow Google Play policies for apps that wrap third-party websites (disclose and ensure you have permission if required).

## Recommended improvements (optional)
- Add in-app PDF-generation of current page using native print APIs.
- Add search shortcuts / saved searches with local storage.
- Implement offline caching for frequently used pages (careful with legal restrictions).

## Files included
- `lib/main.dart` — main Flutter source
- `pubspec.yaml` — dependencies
- `assets/logo.png` — app logo placeholder
- `docs/Documentation.md` — developer documentation and Play Store checklist
- `README.md` — this file

## Building for GitHub Actions (CI)
Add a workflow that runs `flutter pub get` and `flutter build apk --release`. You can use `subosito/flutter-action` or similar; ensure the runner has sufficient memory.

---

Good luck — upload this repository to GitHub, follow the Play Store publishing checklist, and you'll be ready to monetize via ads, freemium features, or paid downloads.
