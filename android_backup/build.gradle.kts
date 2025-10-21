plugins {
    id("com.android.application") version "8.5.2" apply false
    id("org.jetbrains.kotlin.android") version "1.9.24" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Limpeza padrão
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
