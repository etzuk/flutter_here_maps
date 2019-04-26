package com.etzuk.flutter.flutterheremaps

import com.etzuk.flutter.flutterheremaps.map.MapViewFactory
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterHereMapsPlugin: MethodCallHandler {

  companion object {

    private const val pluginPrefix = "flugins.etzuk.flutter_here_maps"

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_here_maps")
      channel.setMethodCallHandler(FlutterHereMapsPlugin())
      registrar.platformViewRegistry()
              .registerViewFactory("$pluginPrefix/MapView", MapViewFactory(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }
}
