package com.etzuk.flutter.flutterheremaps

import com.etzuk.flutter.flutterheremaps.location.LocationHandler
import com.etzuk.flutter.flutterheremaps.map.MapViewFactory
import com.here.android.mpa.common.MapSettings
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

class FlutterHereMapsPlugin {

    companion object {
        private const val pluginPrefix = "flugins.etzuk.flutter_here_maps"
        private const val METHOD_CHANNEL_NAME = "here_locations/methods"


        @JvmStatic
        fun registerWith(registrar: Registrar) {
            registrar.platformViewRegistry()
                    .registerViewFactory("$pluginPrefix/MapView", MapViewFactory(registrar))
            registerLocationPlugin(registrar)
        }

        private fun registerLocationPlugin(registrar: Registrar) {
            if (registrar.activity() != null) {
                val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
                val handler = LocationHandler(registrar, channel)
                channel.setMethodCallHandler(handler)
            }
        }
    }
}
