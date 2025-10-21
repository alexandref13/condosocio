plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // o plugin do Flutter vem depois dos de Android e Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "br.com.condosocio"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "br.com.condosocio"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
        vectorDrawables.useSupportLibrary = true
    }

    buildTypes {
        release {
            // ajuste sua keystore depois; por ora usa a debug pra não travar o build
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            // sem getDefaultProguardFile aqui
        }
        debug { }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }

    packaging {
        resources.excludes += setOf("META-INF/AL2.0", "META-INF/LGPL2.1")
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
}
