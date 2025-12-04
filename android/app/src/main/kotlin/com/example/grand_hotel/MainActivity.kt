package com.example.grand_hotel

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("2d15f3f8-1b57-44a6-970a-63d021444efe")
        super.configureFlutterEngine(flutterEngine)
    }
}