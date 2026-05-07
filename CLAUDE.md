# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

**CondoSócio** is a Flutter mobile app (Portuguese) for condominium management. Residents access features like access control, facial recognition, visitor/vehicle management, reservations, communications, documents, and push notifications.

- **Version**: 13.0.0 | **Dart SDK**: >=3.5.0 <4.0.0 | **iOS**: 15.5+ | **Android**: NDK r28
- **Backend**: `https://www.condosocio.com.br` (hardcoded base URL)

---

## Commands

```bash
flutter pub get          # Install dependencies
flutter run              # Run on connected device/simulator
flutter analyze          # Static analysis (flutter_lints)
flutter test             # Run tests
flutter build apk        # Android APK
flutter build appbundle  # Android App Bundle
flutter build ios        # iOS release
```

---

## Architecture

### Structure (`lib/src/`)

```
controllers/   # GetxControllers — state + business logic
services/      # API calls (api_*.dart) + data models (mapa_*.dart)
pages/         # UI screens
components/    # Reusable widgets (organized by feature)
themes/        # 8 color themes (admin, blue, magenta, turquoise, etc.)
```

### State Management — GetX

All state lives in `GetxController` subclasses with `.obs` reactive variables. Controllers are registered via `Get.put()` (eager) or `Get.lazyPut()` (lazy). Navigation uses `Get.toNamed()` / `Get.offAllNamed()`.

- **`login_controller.dart`**: Auth state, user session, `GetStorage` persistence (keys: `id`, `email`, `idcondController`)
- **`auth_controller.dart`**: Biometric auth (`local_auth`), network retry logic, OneSignal setup
- **`theme_controller.dart`**: Dynamic theme switching per condo (`condoTheme` field)

### Service Layer Pattern

Each feature has two files:
- `api_*.dart` — static methods with `http.get()`/`http.post()` calls
- `mapa_*.dart` — data models with `fromJson()` factory and `toJson()`

Controllers call API methods directly and own the reactive state. No interceptor layer — errors are handled inline.

### Authentication Flow

1. Login screen → email + password POST to backend
2. Optional biometric (face/fingerprint) via `local_auth`
3. Multi-condo support: `ListOfCondo` allows switching between units
4. Session stored in `GetStorage`; initial route `/login`

### Push Notifications

OneSignal (v5.5.1) initialized in `main.dart`. Click handlers route to specific pages via named routes based on notification payload.

### Pull-to-Refresh Pattern

Lists use `SmartRefresher` (pull_to_refresh) with `RefreshController`. **`ListView` must be a direct child of `SmartRefresher`** — wrapping with `Obx` between them breaks `RefreshPhysics`.

### Themes

8 theme variants selected per condo. `ThemeController` reads `condoTheme` from login response and applies the matching `ThemeData`.

---

## Key Dependencies

| Package | Purpose |
|---|---|
| `get` | State management, routing, DI |
| `get_storage` | Persistent local storage |
| `pull_to_refresh` | List refresh + pagination |
| `onesignal_flutter` | Push notifications |
| `local_auth` | Biometric authentication |
| `camera` + `google_mlkit_face_detection` | Facial recognition for access |
| `image_picker` + `image_cropper` | Profile photo upload |
| `table_calendar` | Reservation calendar |
| `google_fonts` | Typography |
| `qr_flutter` | QR code generation |

---

## iOS Notes

- Minimum platform: iOS 15.5 (set in Podfile and build settings)
- `IPHONEOS_DEPLOYMENT_TARGET = 15.5` must be consistent across all targets
- Resource bundle signing disabled for Xcode 26 compatibility

## Android Notes

- `namespace`: `com.condosocionovo`
- NDK version `28.0.12433566` required (16KB page alignment)
- `multiDexEnabled: true`
- Java 17 / Kotlin 2.1
