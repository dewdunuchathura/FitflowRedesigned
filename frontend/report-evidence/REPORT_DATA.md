# FitFlow – Lab 06 Report Data
## IT3060 HCI | Build, Release & Internal Testing Evidence
_Generated: 2026-10-03_

---

## 1. Release Summary

| Field | Value |
|---|---|
| App Name | FitFlow |
| Package / Application ID | `com.fitflow.fitflow` |
| Version Name | 1.0.1 |
| Version Code (pubspec build#) | 3 (encoded by Flutter as **2003** in the APK) |
| pubspec.yaml version string | `1.0.1+3` |
| Flutter Framework | 3.47.5 (stable) |
| Dart SDK | 3.13.4 |
| Screens Implemented | 6 (Login, Home, AI Workout, Progress, Nutrition, Social Feed) |
| Repository URL | https://github.com/dewdunuchathura/FitflowRedesigned |

---

## 2. Development Environment

| Component | Version / Detail |
|---|---|
| Flutter | 3.47.5 • channel stable |
| Dart | 3.13.4 |
| DevTools | 2.60.0 |
| Java (JDK) | 25.0.1 (build 25.0.1+8-LTS-27) |
| JAVA_HOME | `C:\Program Files\Java\jdk-25` |
| Android SDK | 36.0.0 (API 36) |
| Android Build-Tools | 36.0.0 (latest installed) |
| Android NDK | 28.2.13676358 |
| OS | Windows 11 Home Single Language 25H2 (10.0.26200) |
| IDE | VS Code (with Flutter extension) |

### flutter doctor summary
```
[√] Flutter (Channel stable, 3.47.5)
[!] Android toolchain – cmdline-tools component MISSING (does not block build)
    Android license status unknown
[√] Chrome
[!] Visual Studio – missing "Desktop development with C++" workload (not needed for Android)
[√] Connected device (Windows desktop, Chrome, Edge – no Android device/emulator)
[√] Network resources
```

---

## 3. Build Configuration (android/app/build.gradle.kts)

| Setting | Value |
|---|---|
| `namespace` / `applicationId` | `com.fitflow.fitflow` |
| `compileSdk` | `flutter.compileSdkVersion` → **36** |
| `ndkVersion` | `flutter.ndkVersion` → **28.2.13676358** |
| `minSdk` | `flutter.minSdkVersion` → **24** (API 24 = Android 7.0) |
| `targetSdk` | `flutter.targetSdkVersion` → **36** |
| `versionCode` | `flutter.versionCode` (from pubspec: 1.0.1+3 → **2003**) |
| `versionName` | `flutter.versionName` (from pubspec: **1.0.1**) |
| `sourceCompatibility` / `targetCompatibility` | `JavaVersion.VERSION_17` |
| Kotlin JVM target | `JVM_17` |

### Signing Config – `release`
| Field | Value |
|---|---|
| `keyAlias` | `fitflow` (read from `key.properties`) |
| `keyPassword` | _(read from `key.properties` – not shown)_ |
| `storePassword` | _(read from `key.properties` – not shown)_ |
| `storeFile` | `key.properties → storeFile=fitflow-release.jks` → resolves to `android/fitflow-release.jks` |

### Build Type – `release`
| Setting | Value |
|---|---|
| `signingConfig` | `signingConfigs.getByName("release")` ✅ (NOT debug) |
| `isMinifyEnabled` | `true` (R8 full-mode) |
| `isShrinkResources` | `true` |
| ProGuard files | `proguard-android-optimize.txt` + `proguard-rules.pro` |

---

## 4. Keystore Details

_Evidence file: `03_keytool_list.txt`_

| Field | Value |
|---|---|
| Alias | `fitflow` |
| Creation Date | Sep 30, 2026 |
| Entry Type | PrivateKeyEntry |
| CN | FitFlow App |
| OU | Mobile Development |
| O | FitFlow |
| L | Colombo |
| ST | Western Province |
| C | LK |
| Signature Algorithm | SHA384withRSA |
| Key Algorithm | RSA, 2048-bit |
| Valid From | Wed Sep 30 12:15:38 IST 2026 |
| Valid Until | Sun Feb 15 12:15:38 IST 2054 |
| SHA-1 | `68:33:DF:05:8B:D2:3F:A5:07:14:3A:68:7D:2E:7F:E3:E3:87:1A:EF` |
| SHA-256 | `FB:0C:56:80:C4:21:C1:C5:AA:30:86:05:CC:79:36:E8:34:1B:FC:1E:CD:6F:64:C2:B9:E8:9F:9E:F9:56:50:1E` |

> **Note:** Keystore is at `frontend/android/fitflow-release.jks` (not `android/app/` — `rootProject.file()` in Gradle resolves relative to the `android/` directory).

---

## 5. Build Commands Used & Artifact Paths

```bash
# From: d:/FITFLOW ASSIGNMENT/FitflowRedesigned/frontend/

flutter clean
flutter pub get
flutter analyze

# Release AAB (Play Store upload format, with obfuscation)
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols

# Release APKs (per ABI – Play Store internal testing or direct install)
flutter build apk --release --split-per-abi

# Fat release APK (all ABIs in one)
flutter build apk --release

# Debug APK
flutter build apk --debug
```

### Output Paths
| Artifact | Path |
|---|---|
| Release AAB | `build/app/outputs/bundle/release/app-release.aab` |
| arm64-v8a release APK | `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` |
| armeabi-v7a release APK | `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` |
| x86_64 release APK | `build/app/outputs/flutter-apk/app-x86_64-release.apk` |
| Fat release APK | `build/app/outputs/flutter-apk/app-release.apk` |
| Debug APK | `build/app/outputs/flutter-apk/app-debug.apk` |
| Debug symbols | `build/symbols/` |

---

## 6. Signature Verification

_Evidence files: `06_apksigner_verify.txt`, `06_keytool_printcert_aab.txt`_

### APK (arm64-v8a) – apksigner verify
```
Verified using v2 scheme (APK Signature Scheme v2): true
Number of signers: 1
Signer #1 certificate DN: CN=FitFlow App, OU=Mobile Development, O=FitFlow,
                           L=Colombo, ST=Western Province, C=LK
Signer #1 certificate SHA-256: fb0c5680c421c1c5aa308605cc7936e8341bfc1ecd6f64c2b9e89f9ef956501e
Signer #1 certificate SHA-1:   6833df058bd23fa507143a687d2e7fe3e3871aef
Signer #1 key algorithm: RSA  |  key size: 2048 bits
```

### AAB – keytool -printcert -jarfile
```
Owner: CN=FitFlow App, OU=Mobile Development, O=FitFlow, L=Colombo, ST=Western Province, C=LK
Valid: Sep 30, 2026 → Feb 15, 2054
SHA256: FB:0C:56:80:C4:21:C1:C5:AA:30:86:05:CC:79:36:E8:34:1B:FC:1E:CD:6F:64:C2:B9:E8:9F:9E:F9:56:50:1E
```

### Verification Result
| Check | Result |
|---|---|
| Certificate is NOT "Android Debug" | ✅ PASS – CN=FitFlow App |
| APK SHA-256 matches keystore SHA-256 | ✅ PASS – `fb0c5680...56501e` matches |
| AAB SHA-256 matches keystore SHA-256 | ✅ PASS – `FB:0C:56:80...56:50:1E` matches |
| Release signingConfig used (not debug) | ✅ PASS – build.gradle.kts confirmed |

---

## 7. aapt dump badging (arm64 release APK)

| Field | Value |
|---|---|
| Package name | `com.fitflow.fitflow` |
| versionCode | `2003` |
| versionName | `1.0.1` |
| minSdkVersion | `24` (Android 7.0) |
| targetSdkVersion | `36` (Android 16) |
| compileSdkVersion | `36` |
| Application label | `fitflow` |
| Launch activity | `com.fitflow.fitflow.MainActivity` |

---

## 8. Artifact Size Table

_Evidence file: `07_artifact_sizes.txt`_

| Artifact | Bytes | Size (MB) |
|---|---|---|
| `bundle/release/app-release.aab` | 46,441,449 | **44.29 MB** |
| `flutter-apk/app-arm64-v8a-release.apk` | 17,445,426 | **16.64 MB** |
| `flutter-apk/app-armeabi-v7a-release.apk` | 14,804,986 | **14.12 MB** |
| `flutter-apk/app-x86_64-release.apk` | 18,880,052 | **18.01 MB** |
| `flutter-apk/app-release.apk` (fat) | 49,747,796 | **47.44 MB** |
| `flutter-apk/app-debug.apk` | 150,555,236 | **143.58 MB** |

> **Note:** `apk/release/app-release.apk` and `flutter-apk/app-release.apk` are identical (Gradle copies); shown once above.

---

## 9. Version / Update History

| Version | versionCode | Date | Notes |
|---|---|---|---|
| 1.0.0+1 | — | Sep 2026 | Initial build |
| 1.0.1+2 | 2002 | Oct 3, 2026 | Pre-lab build |
| **1.0.1+3** | **2003** | **Oct 3, 2026** | **Lab 06 release build (this report)** |

---

## 10. Git Safety Check

_Evidence file: `08_git_safety.txt`_

| File | Gitignored? | Tracked in repo? |
|---|---|---|
| `frontend/android/key.properties` | ✅ YES – `frontend/android/.gitignore` line 12: `key.properties` | ✅ NOT TRACKED (safe) |
| `frontend/android/fitflow-release.jks` | ✅ YES – `frontend/android/.gitignore` line 14: `**/*.jks` | ✅ NOT TRACKED (safe) |

---

## 11. Store Assets Checklist

_Evidence file: `09_store_assets_audit.txt`_

### Launcher Icons
| Item | Status |
|---|---|
| `flutter_launcher_icons` in pubspec.yaml | ❌ MISSING – not configured |
| `mipmap-hdpi/ic_launcher.png` | ✅ Present (default Flutter icon) |
| `mipmap-mdpi/ic_launcher.png` | ✅ Present (default Flutter icon) |
| `mipmap-xhdpi/ic_launcher.png` | ✅ Present (default Flutter icon) |
| `mipmap-xxhdpi/ic_launcher.png` | ✅ Present (default Flutter icon) |
| `mipmap-xxxhdpi/ic_launcher.png` | ✅ Present (default Flutter icon) |
| Adaptive icon (`ic_launcher_foreground.png`) | ❌ MISSING |
| Round icon (`ic_launcher_round.png`) | ❌ MISSING |

> **Note:** Only the basic `ic_launcher.png` exists in each density. This appears to be the default Flutter blue icon, not a custom FitFlow icon. No `flutter_launcher_icons` package is configured.

### Google Play Store Assets
| Asset | Requirement | Status |
|---|---|---|
| `store-assets/` folder | Required | ❌ DOES NOT EXIST |
| Hi-res app icon (512×512 PNG) | Required | ❌ MISSING |
| Feature graphic (1024×500 PNG) | Required | ❌ MISSING |
| Phone screenshots (min 2, up to 8) | Required | ❌ MISSING |
| Tablet screenshots (7-inch) | Optional | ❌ MISSING |
| Short description (≤80 chars) | Required | ❌ MISSING |
| Full description | Required | ❌ MISSING |

---

## 12. Privacy Policy

_Evidence file: `11_privacy_policy_audit.txt`_

| Item | Status |
|---|---|
| `docs/privacy-policy.html` | ❌ DOES NOT EXIST |
| `url_launcher` in pubspec.yaml | ❌ NOT added |
| Privacy Policy button/link in app code | ❌ NOT found in `lib/` |
| GitHub Pages URL (if page existed) | `https://dewdunuchathura.github.io/FitflowRedesigned/privacy-policy.html` |

---

## 13. Connected Devices / Testing Evidence

| Item | Status |
|---|---|
| ADB devices (`adb devices`) | No devices/emulators connected |
| Screenshots via adb | ❌ Not captured (no device) |
| `dumpsys meminfo` | ❌ Not captured (no device) |
| `dumpsys gfxinfo` | ❌ Not captured (no device) |
| Logcat errors | ❌ Not captured (no device) |

---

## 14. Problems Encountered & Solutions

| # | Problem | Cause | Solution / Status |
|---|---|---|---|
| 1 | **AAB build: "failed to strip debug symbols from native libraries"** | `cmdline-tools` component missing from Android SDK → Flutter cannot locate NDK's `llvm-strip` tool | Non-fatal warning. AAB was built successfully (46.4 MB). To fix: install cmdline-tools via Android Studio → SDK Manager → SDK Tools → Android SDK Command-line Tools. |
| 2 | **`keytool` failed with wrong keystore path** | Task brief stated `storeFile=fitflow-release.jks` resolves to `android\app\`. Gradle's `rootProject.file()` actually resolves relative to the `android/` folder (where `settings.gradle.kts` lives), not `android/app/` | Located JKS at `frontend/android/fitflow-release.jks` using `find`. Used correct path. |
| 3 | **`bc` not available for MB calculation** | `bc` is not installed in Git Bash on this Windows machine | Used `awk` for floating-point arithmetic instead. |
| 4 | **`adb` not in PATH** | Android SDK `platform-tools` not added to system PATH | Located `adb.exe` at `C:/Users/User/AppData/Local/Android/sdk/platform-tools/adb.exe`. No device connected anyway, so tasks 10 & 12 were skipped. |
| 5 | **KGP (Kotlin Gradle Plugin) warning** | `build.gradle.kts` applies KGP explicitly; Flutter warns this will break in a future Flutter version | Non-fatal for now. Future fix: migrate to Flutter's built-in Kotlin support per https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers |
| 6 | **`flutter doctor` reports Android license status unknown** | `cmdline-tools` missing; `sdkmanager` (used for license acceptance) is part of cmdline-tools | Non-fatal for build. Fix with: `flutter doctor --android-licenses` after installing cmdline-tools. |

---

## 15. Screenshots Still Needed (Manual Steps)

No Android emulator or physical device was connected during evidence collection. You must connect a device/emulator and run the following commands.

**Setup — run once:**
```bash
# Add platform-tools to PATH (PowerShell) — or use full path below
$env:PATH += ";C:\Users\User\AppData\Local\Android\sdk\platform-tools"

# Install the x86_64 release APK on emulator
adb install "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\frontend\build\app\outputs\flutter-apk\app-x86_64-release.apk"

# Launch the app
adb shell am start -n com.fitflow.fitflow/.MainActivity

# Create screenshot output folder
mkdir -p "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone"
```

**Per-screen screenshot commands (navigate to each screen first, then run):**
```bash
# 01 – Login / Splash screen
adb shell screencap -p /sdcard/01_login.png && adb pull /sdcard/01_login.png "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone\01_login.png"

# 02 – Home screen
adb shell screencap -p /sdcard/02_home.png && adb pull /sdcard/02_home.png "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone\02_home.png"

# 03 – AI Workout screen
adb shell screencap -p /sdcard/03_ai_workout.png && adb pull /sdcard/03_ai_workout.png "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone\03_ai_workout.png"

# 04 – Progress screen
adb shell screencap -p /sdcard/04_progress.png && adb pull /sdcard/04_progress.png "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone\04_progress.png"

# 05 – Nutrition screen
adb shell screencap -p /sdcard/05_nutrition.png && adb pull /sdcard/05_nutrition.png "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone\05_nutrition.png"

# 06 – Social Feed screen
adb shell screencap -p /sdcard/06_social_feed.png && adb pull /sdcard/06_social_feed.png "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\store-assets\screenshots\phone\06_social_feed.png"
```

**Testing evidence (with app running):**
```bash
# Memory usage
adb shell dumpsys meminfo com.fitflow.fitflow > "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\frontend\report-evidence\12_meminfo.txt"

# GPU frame rendering
adb shell dumpsys gfxinfo com.fitflow.fitflow > "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\frontend\report-evidence\12_gfxinfo.txt"

# Error-level logcat (use app, then Ctrl+C)
adb logcat -d *:E > "d:\FITFLOW ASSIGNMENT\FitflowRedesigned\frontend\report-evidence\12_logcat_errors.txt"
```

---

## 16. Items Still Missing (Required by Lab Sheet)

| # | Missing Item | Action Required |
|---|---|---|
| 1 | **Privacy policy HTML** | Create `docs/privacy-policy.html`; enable GitHub Pages on the repo |
| 2 | **`url_launcher` dependency + Privacy Policy button in app** | Add `url_launcher` to `pubspec.yaml`; add a Privacy Policy link/button in the app UI |
| 3 | **Custom launcher icon** | Design a FitFlow icon (1024×1024 PNG); add `flutter_launcher_icons` package to pubspec; run `dart run flutter_launcher_icons` |
| 4 | **`store-assets/` folder** | Create folder with: 512×512 icon, 1024×500 feature graphic, ≥2 phone screenshots, short description (≤80 chars), full description |
| 5 | **Phone screenshots (6 screens)** | Connect device/emulator; run the adb commands in §15 above |
| 6 | **Testing evidence** (meminfo, gfxinfo, logcat) | Connect device; run the commands in §15 above |
| 7 | **Internal testing track upload** | Upload `app-release.aab` to Google Play Console → Internal Testing; add tester email(s) |
| 8 | **Android license accepted** | Run `flutter doctor --android-licenses` after installing Android cmdline-tools |

---

## 17. Evidence File Index

| File | Contents | Report Figure |
|---|---|---|
| `01_flutter_version.txt` | `flutter --version`, Java version, SDK/NDK versions | Environment table |
| `02_flutter_doctor.txt` | `flutter doctor -v` full output | Environment / Doctor output |
| `03_keytool_list.txt` | `keytool -list -v` for fitflow alias | Keystore table |
| `04_build_gradle_kts.txt` | Full `build.gradle.kts` source | Build config figure |
| `05_build_log.txt` | flutter clean → pub get → analyze → all 4 builds | Build steps figure |
| `06_apksigner_verify.txt` | `apksigner verify --verbose --print-certs` on arm64 APK | Signature verification figure |
| `06_keytool_printcert_aab.txt` | `keytool -printcert -jarfile` on AAB | AAB certificate figure |
| `06_aapt_badging.txt` | `aapt dump badging` on arm64 APK | Package info figure |
| `07_artifact_sizes.txt` | All APK/AAB sizes in bytes and MB | Size table |
| `08_git_safety.txt` | `git check-ignore` + `git ls-files` for key files | Security section |
| `09_store_assets_audit.txt` | Mipmap files, store-assets folder tree | Store assets checklist |
| `11_privacy_policy_audit.txt` | Privacy policy file check, url_launcher, GitHub URL | Privacy policy section |


---

## 18. Lab 06 Task 2 Changes (2026-10-04)

### 18.1 Brand Colour Used for Adaptive Icon Background

| Field | Value |
|---|---|
| Hex | `#1B5775` |
| Source | Dominant midpoint of the icon dark-teal gradient background (sampled from the user-supplied icon PNG) |
| Applied in | `pubspec.yaml` flutter_launcher_icons config and `android/app/src/main/res/values/colors.xml ic_launcher_background` |

> The app code-defined primary green is `#00C853` (AppTheme.primaryGreen). The icon itself uses a separate dark teal gradient background, so the adaptive background was matched to the icon, not the code theme colour.

---

### 18.2 Launcher Icons

**Package added:** `flutter_launcher_icons: ^0.14.3` (resolved 0.14.4) in dev_dependencies.

**Source files:**

| File | Description |
|---|---|
| `assets/icon/icon.png` | 1024x1024 px, RGB -- full FitFlow brand icon (user-supplied) |
| `assets/icon/icon_foreground.png` | 1024x1024 px, RGBA -- logo centred at 75% on transparent background (safe-zone padded for adaptive icons) |

**Generated output (dart run flutter_launcher_icons):**

| Directory | File(s) | Purpose |
|---|---|---|
| `mipmap-hdpi/` | `ic_launcher.png` | Standard icon 72x72 |
| `mipmap-mdpi/` | `ic_launcher.png` | Standard icon 48x48 |
| `mipmap-xhdpi/` | `ic_launcher.png` | Standard icon 96x96 |
| `mipmap-xxhdpi/` | `ic_launcher.png` | Standard icon 144x144 |
| `mipmap-xxxhdpi/` | `ic_launcher.png` | Standard icon 192x192 |
| `mipmap-anydpi-v26/` | `ic_launcher.xml` | Adaptive icon XML (Android 8.0+, API 26+) |
| `drawable/` | `ic_launcher_foreground.png` | Foreground layer for adaptive icon |
| `values/` | `colors.xml` | ic_launcher_background = #1B5775 |
| iOS `AppIcon.appiconset/` | All sizes | iOS launcher icons |

**AndroidManifest.xml label** changed from `"fitflow"` to `"FitFlow"`.

---

### 18.3 Privacy Policy

| Item | Detail |
|---|---|
| File created | `docs/privacy-policy.html` |
| `.nojekyll` | `docs/.nojekyll` created |
| GitHub Pages URL | `https://dewdunuchathura.github.io/FitflowRedesigned/privacy-policy.html` |
| Effective date | 2026-10-03 |
| Sections | Who we are; Information collected (account, health/fitness, nutrition, social, device); How we use it; AI processing (not medical advice); Social features (visibility controls, report/block); Storage and security (TLS, Firebase, no data selling); Retention and deletion (30-day deletion); Your rights (GDPR + CCPA); Health regulations (HIPAA note: consumer app); Children (not for under 13/16); Changes; Contact (dewdunuc1990@gmail.com placeholder) |

**Still required:** Replace dewdunuc1990@gmail.com with real contact email; enable GitHub Pages (Settings > Pages > main branch, /docs folder).

---

### 18.4 In-App Privacy Policy Link

- **File modified:** `lib/features/workout/home_screen.dart`
- **Location:** Bottom of the Home screen scroll content, after the Streak Card
- **Widget:** `_PrivacyPolicyLink` -- a `TextButton.icon` with `Icons.shield_outlined`, styled in `AppTheme.textMedium` (muted grey, matches existing app style)
- **Behaviour:** Calls `launchUrl(uri, mode: LaunchMode.externalApplication)` to open the privacy policy in the default browser
- **Package:** `url_launcher: ^6.3.1` added to dependencies
- **AndroidManifest queries** added for https/http VIEW intents (required for url_launcher on Android API 30+)

---

### 18.5 Store Assets

**Root folder:** `store-assets/` (repo root)



**short_desc.txt (79/80 chars):**
AI-powered workouts, nutrition tracking and community -- all in one fitness app.

---

### 18.6 Version 1.0.1+4 Build

**pubspec.yaml:** version 1.0.1+4

**flutter analyze:** No issues found

**Gradle fix:** Added `kotlin.incremental=false` to `android/gradle.properties`

#### Artifact Size Table (v1.0.1+4)

| Artifact | Bytes | MB |
|---|---|---|
| `bundle/release/app-release.aab` | 47,158,818 | **44.97 MB** |
| `apk/release/app-arm64-v8a-release.apk` | 18,143,627 | **17.30 MB** |
| `apk/release/app-armeabi-v7a-release.apk` | 15,519,575 | **14.80 MB** |
| `apk/release/app-x86_64-release.apk` | 19,643,789 | **18.73 MB** |
| `flutter-apk/app-release.apk` (fat) | 49,747,796 | **47.44 MB** |
| `flutter-apk/app-debug.apk` | 150,555,236 | **143.58 MB** |

Size increase vs v1.0.1+3 is approximately +0.7 MB per ABI -- from url_launcher native shim and new icon assets.

---

### 18.7 Updated Version History

| Version | versionCode | Date | Notes |
|---|---|---|---|
| 1.0.0+1 | -- | Sep 2026 | Initial build |
| 1.0.1+2 | 2002 | Oct 3, 2026 | Pre-lab build |
| 1.0.1+3 | 2003 | Oct 3, 2026 | Lab 06 Task 1 -- first signed release build |
| **1.0.1+4** | **2004** | **Oct 4, 2026** | **Custom icon, adaptive icons, privacy policy, url_launcher, store assets** |

---

### 18.8 New Problems and Solutions (Task 2)

| # | Problem | Cause | Solution |
|---|---|---|---|
| 7 | Gradle network timeout adding url_launcher | Bash shell network stack timed out reaching Maven Central / Google Maven for url_launcher_android Gradle artifacts | Switched to PowerShell (powershell.exe -NoProfile -Command) which uses the full Windows network stack. |
| 8 | url_launcher_android:compileReleaseKotlin AssertionError on Windows | Kotlin incremental compilation uses RelocatableFileToPathConverter to store relative paths. Pub cache (C:) and project (D:) are on different Windows drive letters -- relative paths are impossible, causing IllegalArgumentException: this and base files have different roots. | Added kotlin.incremental=false to android/gradle.properties. Deleted corrupt build/url_launcher_android/ cache. Rebuild succeeded. |
| 9 | First failed build left corrupt Kotlin incremental cache | Partial cache written by the failed compilation | Deleted build/url_launcher_android/ before retry. |

---

### 18.9 Still Missing After Task 2

| # | Item | Action Required |
|---|---|---|
| 1 | Feature graphic (1024x500 PNG) | Design and save to store-assets/feature-graphic/feature_graphic.png |
| 2 | Phone screenshots (6 screens) | Connect emulator; run adb commands from section 15 |
| 3 | Contact email | Replace dewdunuc1990@gmail.com in docs/privacy-policy.html and store-assets/text/release_notes.txt |
| 4 | GitHub Pages | Repo Settings > Pages > Source: main branch, /docs folder |
| 5 | Testing evidence (meminfo/gfxinfo/logcat) | Connect device; run commands from section 15 |
| 6 | Internal testing track | Upload app-release.aab to Google Play Console > Internal Testing |
