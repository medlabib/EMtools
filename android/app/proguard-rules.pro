# Add rules for any libraries you use that may cause issues with ProGuard/R8
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**
