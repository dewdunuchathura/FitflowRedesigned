# ── FitFlow ProGuard / R8 Rules ───────────────────────────────────────────────
#
# The Flutter Gradle Plugin automatically merges Flutter's own consumer ProGuard
# rules (covering the engine, Dart VM, and plugin interfaces) into this build.
# Only project-specific additions are listed here.
#
# Reference: https://flutter.dev/to/obfuscate

# ── Flutter Engine ────────────────────────────────────────────────────────────
# Keep all Flutter engine classes that may be referenced via JNI or reflection.
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# ── Dart FFI ──────────────────────────────────────────────────────────────────
# Preserve native method names so Dart FFI can resolve them at runtime.
-keepclasseswithmembernames,includedescriptorclasses class * {
    native <methods>;
}

# ── Kotlin ────────────────────────────────────────────────────────────────────
# Keep Kotlin metadata so reflection-based libraries work correctly.
-keep class kotlin.Metadata { *; }
-keepclassmembers class kotlin.Metadata { *; }

# ── Enums ─────────────────────────────────────────────────────────────────────
# Required by some Android platform APIs.
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ── Debugging ─────────────────────────────────────────────────────────────────
# Preserve source file names and line numbers in stack traces.
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# ── Play Core (deferred components) ───────────────────────────────────────────
# Flutter engine references Play Core split-install classes for dynamic delivery,
# but this app does not use deferred components.  Suppress the R8 warnings so
# the release build succeeds without adding an unused dependency.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
