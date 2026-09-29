package com.petaverse.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.petaverse.app/maps"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getGoogleMapsApiKey" -> {
                        // Read from AndroidManifest meta-data (injected from secrets.properties)
                        val apiKey = getGoogleMapsApiKey()
                        if (apiKey != null) {
                            result.success(apiKey)
                        } else {
                            result.error("NO_API_KEY", "Google Maps API key not found", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getGoogleMapsApiKey(): String? {
        try {
            val metaData = packageManager.getApplicationInfo(
                packageName,
                android.content.pm.PackageManager.GET_META_DATA
            ).metaData ?: return null
            return metaData.getString("com.google.android.geo.API_KEY")
        } catch (e: Exception) {
            return null
        }
    }
}
