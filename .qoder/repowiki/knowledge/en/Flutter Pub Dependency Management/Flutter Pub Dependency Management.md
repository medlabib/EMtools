---
kind: dependency_management
name: Flutter Pub Dependency Management
category: dependency_management
scope:
    - '**'
source_files:
    - pubspec.yaml
    - pubspec.lock
    - .dart_tool/package_config.json
---

This repository uses the standard Flutter/Dart dependency management system via pub with a single-root monorepo layout. All third-party and SDK dependencies are declared in one place at the repository root, and there is no vendoring or private registry configuration — everything resolves from the public pub.dev registry.

System and approach:
- Package manager: Dart pub (invoked through flutter pub).
- Single package manifest: pubspec.yaml at the repo root declares both direct runtime and dev-only dependencies for the shared Flutter app.
- Deterministic builds: pubspec.lock pins every transitive dependency to an exact version plus sha256 checksum, ensuring reproducible CI and local builds.
- No vendoring: Dependencies are resolved into the user-local Dart cache (~/.pub-cache/hosted/pub.dev/...) and mapped by .dart_tool/package_config.json; nothing is checked into source control.
- Private-by-default: publish_to: 'none' prevents accidental publication of this app package to pub.dev.

Key files:
- pubspec.yaml — declares environment.sdk, all dependencies: and dev_dependencies:, and Flutter-specific settings (icons, fonts).
- pubspec.lock — generated lockfile pinning every transitive dependency to a specific version and sha256.
- .dart_tool/package_config.json — generated resolution map used by the Dart analyzer and tooling; not committed to VCS.

Architecture and conventions:
- Version ranges use caret semantics (^x.y.z) in pubspec.yaml, allowing compatible minor/patch updates while constraining major versions.
- The SDK constraint is pinned to ^3.9.2, so any Dart 3.x release within that range is acceptable.
- Runtime vs. development split is explicit: UI/state packages (flutter_riverpod, go_router, shared_preferences, google_fonts, audioplayers, etc.) live under dependencies:; codegen/build tools (build_runner, json_serializable, flutter_lints, flutter_launcher_icons) live under dev_dependencies:.
- Platform-specific native plugins are pulled in transitively through their host packages (e.g., audioplayers_android, audioplayers_windows, audioplayers_darwin, audioplayers_web) — no per-platform dependency blocks are needed.

Rules developers should follow:
- Add new runtime libraries under dependencies: and dev/build tools under dev_dependencies: in pubspec.yaml.
- Use caret version ranges (^major.minor.patch) rather than exact pins in pubspec.yaml; rely on pubspec.lock for determinism.
- After changing pubspec.yaml, run flutter pub get to regenerate pubspec.lock and commit the updated lockfile alongside your changes.
- Do not edit .dart_tool/package_config.json or anything under .dart_tool/ — it is regenerated automatically.
- Do not vendor or check in cached packages; keep the Dart cache out of VCS (already ignored by default).
- If introducing a private/internal Dart package, configure a custom hosted repository via pubspec_overrides.yaml or environment variables rather than editing the lockfile manually.