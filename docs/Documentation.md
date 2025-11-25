# Documentation: Mahabhulekh WebView App

## Purpose
This app provides a clean, user-friendly mobile wrapper around the official Mahabhulekh website (https://bhulekh.mahabhumi.gov.in/), focused on the key services:
- ७/१२ (7/12) extract
- ८अ (8A) extract

## Project structure
- `lib/` — Dart code
- `assets/` — images & icons
- `pubspec.yaml` — dependencies
- `docs/` — extra documentation

## How the app works
- Home screen shows two service tiles. Tapping a tile opens the official site inside a WebView.
- The WebView page includes "Open in browser" and "Share" actions.
- No scraping or API calls — the app delegates all data and downloads to the source website.

## Play Store publishing checklist
1. App icon (store assets) — create 512x512 and 1024x500 images.
2. Privacy policy — link to hosted privacy policy (required if you collect data or use analytics).
3. Keystore and app signing — follow Flutter docs to sign the app.
4. Content rating and target audience.
5. Monetization setup (ads/in-app purchases) — ensure SDKs are integrated and privacy-compliant.
6. Test on real devices (Android 8+) and run Play Console pre-launch tests.

## Advanced features you may add
- Save/PDF: Use Android Print Manager to save current WebView page as PDF.
- Favorites: Store previous searches locally using `shared_preferences`.
- Ads: Integrate AdMob with proper consent flow for EU users.

## Troubleshooting
- WebView fails to load: ensure device has internet and the URL is reachable; enable cleartext if using http.
- Build errors: run `flutter doctor` and resolve missing SDK components.

