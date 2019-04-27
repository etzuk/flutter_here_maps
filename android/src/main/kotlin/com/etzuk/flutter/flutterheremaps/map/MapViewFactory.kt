package com.etzuk.flutter.flutterheremaps.map

import android.content.Context
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MapViewFactory(private val registrar: PluginRegistry.Registrar)
    : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(
            context: Context?,
            id: Int,
            args: Any?): PlatformView {
        return FlutterMapView(registrar, context, id, args)
    }
}