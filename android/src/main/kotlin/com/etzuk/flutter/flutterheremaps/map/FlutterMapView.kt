package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapChannel
import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.view.View
import androidx.core.app.ActivityCompat
import com.google.protobuf.MessageLite
import com.here.android.mpa.common.ApplicationContext
import com.here.android.mpa.common.MapEngine
import com.here.android.mpa.common.OnEngineInitListener
import com.here.android.mpa.mapping.Map
import com.here.android.mpa.mapping.MapView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView

class FlutterMapView(registrar: PluginRegistry.Registrar, val context: Context?, id: Int, args: Any?) :
        PlatformView,
        OnEngineInitListener,
        PluginRegistry.RequestPermissionsResultListener, MethodChannel.MethodCallHandler {

    private val mapView = MapView(registrar.activeContext())
    private var map: Map? = null

    companion object Static {
        const val WRITE_STORAGE_PERMISSION_CODE = 11232
        fun <T> ByteArray.toProto(coder: (parseFrom: ByteArray) -> T): T {
            return coder(this)
        }
    }

    init {
        if (ActivityCompat.checkSelfPermission(
                        registrar.context(), Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            // Needed only in android so will be requested in native level.
            registrar.addRequestPermissionsResultListener(this)
            ActivityCompat.requestPermissions(
                    registrar.activity(),
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    WRITE_STORAGE_PERMISSION_CODE)
        } else {
            initMapEngine()
        }
        val channel = MethodChannel(
                registrar.messenger(),
                "flugins.etzuk.flutter_here_maps/MapViewChannel")
        channel.setMethodCallHandler(this)
    }

    override fun onRequestPermissionsResult(p0: Int, p1: Array<out String>?, p2: IntArray?): Boolean {
        if (p0  == WRITE_STORAGE_PERMISSION_CODE) {
            if (p1?.first().equals(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    && p2?.first() == PackageManager.PERMISSION_GRANTED) {
                initMapEngine()
            }
        }
        return true
    }

    private fun initMapEngine() {
        MapEngine.getInstance().init(ApplicationContext(context), this)
    }

    override fun onEngineInitializationCompleted(error: OnEngineInitListener.Error?) {

        if (error?.ordinal == OnEngineInitListener.Error.NONE.ordinal) {
            mapView.onResume()
            map = Map()
            mapView.map = map
            mapView.positionIndicator.isVisible = true
        } else {
            //TODO: Add error when error mechanism will be developed
        }
    }

    override fun getView(): View {
        return mapView
    }

    override fun dispose() {
        mapView.onPause()
    }

    override fun onMethodCall(
            methodCall: MethodCall?,
            result: MethodChannel.Result?) {
        if (map == null) {
            result?.error(methodCall?.method, "Map is null", null)
            return
        }

        methodCall.let { call ->
            (call!!.arguments as ByteArray).let {
                var responseObject : MessageLite? = null
                if (call.method == "request") {
                    responseObject = invokeRequest(MapChannel.MapChannelRequest.parseFrom(it))
                }
                if (call.method == "replay") {
                    responseObject = invokeReplay(MapChannel.MapChannelReplay.parseFrom(it))
                }
                result?.success(responseObject?.toByteArray())
                return
            }
        }
        result?.notImplemented()
    }

    private fun invokeReplay(replay: MapChannel.MapChannelReplay): MessageLite? {
        var returnObj:Any? = null
        replay.objectCase.let { objectCase ->
            returnObj = when(objectCase) {
                MapChannel.MapChannelReplay.ObjectCase.GETCENTER -> mapView.getMapCenter()
                MapChannel.MapChannelReplay.ObjectCase.OBJECT_NOT_SET -> null
            }
        }
        return returnObj as? MessageLite
    }

    private fun invokeRequest(request: MapChannel.MapChannelRequest): MessageLite? {
        var returnObj:Any? = null
        request.objectCase.let { objectCase ->
            returnObj = when(objectCase) {
                MapChannel.MapChannelRequest.ObjectCase.SETCENTER ->
                    mapView.setMapCenter(request.setCenter)
                MapChannel.MapChannelRequest.ObjectCase.SETCONFIGURATION ->
                    mapView.setConfiguration(request.setConfiguration)
                MapChannel.MapChannelRequest.ObjectCase.SETMAPOBJECT ->
                    mapView.setMapObject(request.setMapObject)
                MapChannel.MapChannelRequest.ObjectCase.OBJECT_NOT_SET ->
                    null
            }
        }
        return returnObj as? MessageLite
    }
}