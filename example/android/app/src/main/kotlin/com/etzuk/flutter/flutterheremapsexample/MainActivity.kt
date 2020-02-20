package com.etzuk.flutter.flutterheremapsexample

import android.os.Bundle
import com.etzuk.flutter.flutterheremaps.FlutterHereMapsPlugin

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}
