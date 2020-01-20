package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapChannel
import FlutterHereMaps.MapObjects
import android.Manifest
import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import android.view.View
import androidx.core.app.ActivityCompat
import com.google.protobuf.MessageLite
import com.here.android.mpa.common.ApplicationContext
import com.here.android.mpa.common.MapEngine
import com.here.android.mpa.common.OnEngineInitListener
import com.here.android.mpa.mapping.Map
import com.here.android.mpa.mapping.MapMarker
import com.here.android.mpa.mapping.MapView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import java.nio.ByteBuffer


class Map(val mapView: MapView) {
    var markers = mutableMapOf<String, MapMarker>()
}

class FlutterMapView(private val registrar: PluginRegistry.Registrar, private val context: Context?, id: Int, private val args: Any?) :
        PlatformView,
        OnEngineInitListener,
        PluginRegistry.RequestPermissionsResultListener, MethodChannel.MethodCallHandler, Application.ActivityLifecycleCallbacks {

    private val map = Map(MapView(registrar.activeContext()))
    private var hereMap: Map? = null
    private var mapReadyResult: MethodChannel.Result? = null
    private val channel: MethodChannel
    private var registrarActivityHashCode: Int
    private var disposed = false

    companion object Static {
        const val WRITE_STORAGE_PERMISSION_CODE = 11232
    }

    init {
        if (ActivityCompat.checkSelfPermission(
                        registrar.context(), Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            // Needed only in android so will be requested in native level.
            registrar.addRequestPermissionsResultListener(this)
            ActivityCompat.requestPermissions(
                    registrar.activity(),
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.ACCESS_FINE_LOCATION),
                    WRITE_STORAGE_PERMISSION_CODE)
        } else {
            initMapEngine()
        }
        channel = MethodChannel(
                registrar.messenger(),
                "flugins.etzuk.flutter_here_maps/MapViewChannel_$id")
        registrar.activity().application.registerActivityLifecycleCallbacks(this)
        this.registrarActivityHashCode = registrar.activity().hashCode()
        channel.setMethodCallHandler(this)
    }


    override fun onRequestPermissionsResult(p0: Int, p1: Array<out String>?, p2: IntArray?): Boolean {
        if (p0 == WRITE_STORAGE_PERMISSION_CODE) {
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
            map.mapView.onResume()
            hereMap = Map()
            mapReadyResult?.let {
                it.success(null)
            }
            mapReadyResult = null
            map.mapView.map = hereMap
            map.mapView.map.mapScheme = map.mapView.map.mapSchemes[12]
            map.mapView.positionIndicator.isVisible = true
            args?.let { args ->
                (args as? ByteBuffer)?.let {
                    val mapCenter = MapObjects.MapCenter.parseFrom(it.array())
                    map.setMapCenter(mapCenter)
                }
            }
        } else {
            //TODO: Add error when error mechanism will be developed
        }
    }

    override fun getView(): View {
        return map.mapView
    }

    override fun onMethodCall(
            methodCall: MethodCall,
            result: MethodChannel.Result) {

        if (methodCall.method == "initMap") {
            if (hereMap != null) {
                result.success(null)
            } else {
                mapReadyResult = result
                return
            }
        }

        if (hereMap == null) {
            result.error(methodCall.method, "Map is null", null)
            return
        }

        methodCall.let { call ->
            (call.arguments as ByteArray).let {
                var responseObject: MessageLite? = null
                if (call.method == "request") {
                    responseObject = invokeRequest(MapChannel.MapChannelRequest.parseFrom(it))
                }
                if (call.method == "replay") {
                    responseObject = invokeReplay(MapChannel.MapChannelReplay.parseFrom(it))
                }
                result.success(responseObject?.toByteArray())
                return
            }
        }
    }

    private fun invokeReplay(replay: MapChannel.MapChannelReplay): MessageLite? {
        return replay.objectCase?.let { objectCase ->
            when (objectCase) {
                MapChannel.MapChannelReplay.ObjectCase.GETCENTER -> map.getMapCenter()
                MapChannel.MapChannelReplay.ObjectCase.OBJECT_NOT_SET -> null
            }
        }
    }

    private fun invokeRequest(request: MapChannel.MapChannelRequest): MessageLite? {
        var returnObj: Any? = null
        request.objectCase?.let { objectCase ->
            returnObj = when (objectCase) {
                MapChannel.MapChannelRequest.ObjectCase.SETCENTER ->
                    map.setMapCenter(request.setCenter)
                MapChannel.MapChannelRequest.ObjectCase.SETCONFIGURATION ->
                    map.setConfiguration(request.setConfiguration)
                MapChannel.MapChannelRequest.ObjectCase.SETMAPOBJECT -> {
                    map.setMapObject(request.setMapObject, registrar)
                }
                MapChannel.MapChannelRequest.ObjectCase.ZOOMTO -> {
                    map.zoomTo(request.zoomTo)
                }
                MapChannel.MapChannelRequest.ObjectCase.OBJECT_NOT_SET ->
                    null
            }
        }
        return returnObj as? MessageLite
    }

    override fun dispose() {
        if (disposed) {
            return
        }
        disposed = true
        map.mapView.onPause()
        map.clean()
        channel.setMethodCallHandler(null)
        registrar.activity().application.unregisterActivityLifecycleCallbacks(this)
    }

    override fun onActivityPaused(activity: Activity?) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        map.mapView.onPause()
    }

    override fun onActivityResumed(activity: Activity?) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return
        }
        map.mapView.onResume()
    }

    override fun onActivityStarted(activity: Activity?) {

    }

    override fun onActivityDestroyed(activity: Activity?) {

    }

    override fun onActivitySaveInstanceState(activity: Activity?, outState: Bundle?) {

    }

    override fun onActivityStopped(activity: Activity?) {

    }

    override fun onActivityCreated(activity: Activity?, savedInstanceState: Bundle?) {

    }
}


