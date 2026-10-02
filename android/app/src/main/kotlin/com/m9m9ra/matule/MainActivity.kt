package com.m9m9ra.matule

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import io.flutter.embedding.android.FlutterActivity
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Исправленный вызов: явно указываем context через расширение
        val splashScreen = this.installSplashScreen()
        
        super.onCreate(savedInstanceState)
    }
}
