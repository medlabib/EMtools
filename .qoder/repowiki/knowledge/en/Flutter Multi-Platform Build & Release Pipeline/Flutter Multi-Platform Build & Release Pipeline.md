---
kind: build_system
name: Flutter Multi-Platform Build & Release Pipeline
category: build_system
scope:
    - '**'
source_files:
    - pubspec.yaml
    - analysis_options.yaml
    - .github/workflows/deploy.yml
    - android/build.gradle.kts
    - android/app/build.gradle.kts
    - windows/CMakeLists.txt
    - windows_installer.iss
---

EMtools uses Flutter as the single source of truth for a multi-platform application (Android, Windows, Web) with platform-specific build toolchains and a GitHub Actions pipeline for automated testing and web deployment. There is no custom Makefile or Docker-based build; instead the project relies on Flutter's native Gradle (Android), CMake (Windows), and GitHub Pages integration (Web).

Build system overview:
- Single Dart/Flutter codebase under lib/ shared across all targets.
- Android: Gradle Kotlin DSL (android/app/build.gradle.kts) driven by the Flutter Gradle plugin; signing via key.properties; ProGuard/R8 enabled in release.
- Windows: CMake (windows/CMakeLists.txt) + Inno Setup script (windows_installer.iss) producing an .exe installer from build/windows/x64/runner/Release.
- Web: flutter build web --release --base-href "/EMtools/" produces a PWA under build/web, deployed to GitHub Pages via Actions.
- CI: .github/workflows/deploy.yml runs on push to master — sets up Flutter 3.29 stable, flutter pub get, flutter test, builds web, then publishes to GitHub Pages using actions/configure-pages / actions/upload-pages-artifact / actions/deploy-pages.

Versioning strategy:
- Version declared once in pubspec.yaml as version: 0.1.2+3 (semver + build number).
- Android reads flutter.versionName / flutter.versionCode at build time.
- Windows installer hardcodes its own version string in windows_installer.iss (#define MyAppVersion "0.1.1") — currently out of sync with pubspec.yaml.

Key files:
- pubspec.yaml — package metadata, dependency versions, Flutter launcher icons config, SDK constraint.
- analysis_options.yaml — Flutter lints baseline (flutter_lints/flutter.yaml).
- android/build.gradle.kts — root Gradle config redirecting all subproject outputs into a shared build/ directory.
- android/app/build.gradle.kts — app-level Gradle config: compile/target SDK, Java/Kotlin 11, signing, minify/shrink resources, Flutter source path.
- windows/CMakeLists.txt — Windows host app CMake rules, AOT install, asset bundling.
- windows_installer.iss — Inno Setup packaging of the Release binary and data bundle.
- .github/workflows/deploy.yml — CI: checkout -> setup Flutter 3.29 -> pub get -> flutter test -> flutter build web -> deploy to GitHub Pages.

Conventions & constraints:
- Keep pubspec.yaml version in sync with windows_installer.iss when cutting releases.
- Android release signing requires key.properties at android/key.properties; without it the build falls back to debug signing.
- Web base href must match the repo name (/EMtools/) so the Pages URL resolves correctly.
- All build artifacts are written under the repository root build/ directory (shared between Android and Flutter); keep it ignored from git.