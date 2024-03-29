package com.example.deep_linking.deep_linking

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "deepLinkChannel"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val data: Uri? = intent.data
        if (data != null) {
            handleDeepLink(intent)
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleDeepLink(intent)
    }

    private fun handleDeepLink(intent: Intent) {
        if (Intent.ACTION_VIEW == intent.action) {
            intent.data?.let { data ->
                val host = data.host
                if ("deeplinkingexample.com" == host) {
                    val value = data.path // Extract the value from the deep link
                    val methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                    methodChannel.invokeMethod("receiveDeepLink", value)
                }
            }
        }
    }


    override fun onResume() {
        super.onResume()
        // If the activity was launched from a recent task and not from a deep link,
        // then check the intent to see if it contains a deep link
        if (!isTaskRoot && intent.action == Intent.ACTION_VIEW) {
            handleDeepLink(intent)
        }
    }
}


