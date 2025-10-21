// android/settings.gradle.kts

// Lê o caminho do Flutter no local.properties (dentro de android/)
val localPropsFile = File(rootDir, "local.properties")
val localProps = java.util.Properties().apply {
    if (localPropsFile.exists()) localPropsFile.inputStream().use { load(it) }
}
val flutterSdk = (localProps["flutter.sdk"] as String?)
    ?: error("Defina flutter.sdk no local.properties (ex.: flutter.sdk=/Users/adm/Documents/flutter)")

pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    // carrega os scripts do Flutter
    includeBuild("$flutterSdk/packages/flutter_tools/gradle")
}

plugins {
    id("dev.flutter.flutter-plugin-loader")
}

include(":app")
