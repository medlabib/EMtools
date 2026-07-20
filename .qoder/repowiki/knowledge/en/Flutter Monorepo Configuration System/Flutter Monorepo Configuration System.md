---
kind: configuration_system
name: Flutter Monorepo Configuration System
category: configuration_system
scope:
    - '**'
source_files:
    - pubspec.yaml
    - analysis_options.yaml
    - android/build.gradle.kts
    - android/key.properties
---

This repository does not contain a dedicated configuration system. The EMtools Flutter monorepo uses standard Flutter conventions for configuration:

- **Build-time configuration**: `pubspec.yaml` (dependencies, app metadata), `analysis_options.yaml` (linting rules), and per-platform Gradle/CMake configs in `android/`, `windows/`, and `web/` directories.
- **Runtime configuration**: No centralized runtime config loader was found — the application appears to use hardcoded values or platform-specific resources rather than a unified configuration abstraction layer.
- **Environment/secrets**: Android keystore properties are stored in `android/key.properties`; no `.env` files or secret management framework is present.
- **Feature flags / build variants**: Android debug/profile/release flavors are configured via Gradle (`build.gradle.kts`); no Dart-side feature flag system was detected.

There is no `config/` directory, no environment variable loader, no JSON/YAML config file parser, and no shared configuration service in `lib/core`. Configuration is therefore scattered across platform build scripts and source code rather than managed through a cohesive system.