import java.util.Properties

// ── Load release signing properties ──────────────────────────────────────────
// key.properties is gitignored and must never be committed.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    if (keystorePropertiesFile.exists()) {
        load(keystorePropertiesFile.inputStream())
    }
}

plugins {
    id("com.android.application")
    // KGP must be applied before the Flutter Gradle Plugin.
    // android.builtInKotlin=false, so the plugin is applied explicitly here.
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.fitflow.fitflow"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.fitflow.fitflow"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ── Release signing ───────────────────────────────────────────────────────
    signingConfigs {
        create("release") {
            keyAlias     = keystoreProperties["keyAlias"]     as? String
            keyPassword  = keystoreProperties["keyPassword"]  as? String
            storePassword = keystoreProperties["storePassword"] as? String
            storeFile    = keystoreProperties["storeFile"]?.let {
                rootProject.file(it as String)
            }
        }
    }

    // ── Build types ───────────────────────────────────────────────────────────
    buildTypes {
        release {
            // Use the dedicated release keystore — not the debug keystore.
            signingConfig = signingConfigs.getByName("release")

            // R8 full-mode minification and resource shrinking.
            isMinifyEnabled = true
            isShrinkResources = true

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

// ── Kotlin compiler options ───────────────────────────────────────────────────
kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
