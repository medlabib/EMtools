---
kind: error_handling
name: Minimal Error Handling — Ad-hoc Exceptions and Localized Strings
category: error_handling
scope:
    - '**'
source_files:
    - lib/core/l10n/app_strings.dart
    - lib/presentation/screens/tools/protocols/protocol_detail_screen.dart
---

This repository does not implement a structured error-handling system. Across the Dart/Flutter codebase there are no dedicated error types, sentinel errors, or exception classes; the only programmatic error path found is a single `throw Exception('Protocole non trouvé')` in a presentation screen. User-facing error messages exist as localized string keys (`errorGeneric`, `errorNetwork`, `errorServer`, `errorAuth`, `errorNotFound`, `errorValidation`, etc.) under `lib/core/l10n/app_strings.dart`, but these are plain i18n entries consumed by UI rather than being wrapped around typed exceptions. There is no central error middleware, no `Result`/`Either`-style return pattern, no panic/recover strategy, and no shared error propagation layer between domain/data/presentation. In short, error handling is ad-hoc: callers throw bare `Exception`s where needed and rely on localized strings for display.