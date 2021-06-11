package com.example.flutter_test_app

import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onPostResume() {
        super.onPostResume()
        WindowCompat.setDecorFitsSystemWindows(window, false)
        window.apply {
            navigationBarColor = 0
            statusBarColor = 0
        }
    }
}
