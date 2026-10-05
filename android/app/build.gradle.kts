import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android plugin.
    // KGP is injected automatically by dev.flutter.flutter-gradle-plugin (Flutter 3.27+);
    // declaring id("kotlin-android") here would cause a double-application build failure.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

// Google Maps API key, kept out of version control. Read from a gitignored
// `secrets.properties` at the android/ root (falls back to an empty string so
// non-map builds/CI still configure). Copy `secrets.properties.example` to
// `secrets.properties` and fill in ANDROID_MAPS_API_KEY.
val secretsProperties = Properties().apply {
    val file = rootProject.file("secrets.properties")
    if (file.exists()) file.inputStream().use { load(it) }
}
val androidMapsApiKey: String =
    secretsProperties.getProperty("ANDROID_MAPS_API_KEY") ?: ""

// Release signing config, kept out of version control. Read from a gitignored
// `key.properties` at the android/ root. On CI (Codemagic) this file is written
// from secure environment variables before the build. When it's absent (e.g. a
// local `flutter run --release`), the release build falls back to debug keys.
val keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) file.inputStream().use { load(it) }
}
val hasReleaseSigning = keystoreProperties.getProperty("storeFile") != null

android {
    namespace = "com.petaverse.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Required by flutter_local_notifications (java.time backport).
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.petaverse.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // google_maps_flutter requires minSdk 21; Flutter's default is already
        // >= 21, but pin it here so a lower Flutter default can't break Maps.
        minSdk = maxOf(flutter.minSdkVersion, 21)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Consumed by the com.google.android.geo.API_KEY meta-data in the
        // manifest. Sourced from the gitignored secrets.properties above.
        manifestPlaceholders["MAPS_API_KEY"] = androidMapsApiKey
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                storeFile = rootProject.file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // Use the real release keystore when `key.properties` is present
            // (CI / signed builds); otherwise fall back to debug keys so a local
            // `flutter run --release` still works without a keystore.
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }

}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
