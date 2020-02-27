package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapChannel
import FlutterHereMaps.MapObjects
import android.Manifest
import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.PointF
import android.os.Build
import android.os.Bundle
import android.view.View
import androidx.core.app.ActivityCompat
import com.google.protobuf.MessageLite
import com.here.android.mpa.common.*
import com.here.android.mpa.mapping.Map
import com.here.android.mpa.mapping.MapGesture
import com.here.android.mpa.mapping.MapMarker
import com.here.android.mpa.mapping.MapView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.File
import java.nio.ByteBuffer


class Map(val mapView: MapView) {
    var markers = mutableMapOf<String, MapMarker>()
}

class FlutterMapView(private val registrar: PluginRegistry.Registrar, private val context: Context?, id: Int, private val args: Any?) :
        PlatformView,
        OnEngineInitListener,
        PluginRegistry.RequestPermissionsResultListener, MethodChannel.MethodCallHandler, Application.ActivityLifecycleCallbacks, MapGesture.OnGestureListener {

    private val map = Map(MapView(registrar.activeContext()))
    private var hereMap: Map? = null
    private var mapReadyResult: MethodChannel.Result? = null
    private val channel: MethodChannel
    private var registrarActivityHashCode: Int
    private var disposed = false
    private var mapConfiguration: MapChannel.InitMapConfigutation = MapChannel.InitMapConfigutation.getDefaultInstance()

    companion object Static {
        const val WRITE_STORAGE_PERMISSION_CODE = 11232
    }

    init {
        if (Build.VERSION.SDK_INT < 19
                && ActivityCompat.checkSelfPermission(
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

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
        if (requestCode == WRITE_STORAGE_PERMISSION_CODE) {
            if (permissions?.firstOrNull().equals(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    && grantResults?.firstOrNull() == PackageManager.PERMISSION_GRANTED) {
                initMapEngine()
            }
            return true
        }
        return false
    }

    private fun initMapEngine() {
        val diskCacheRoot = registrar.context().filesDir.path + File.separator + ".isolated-here-maps"
        MapSettings.setIsolatedDiskCacheRootPath(diskCacheRoot,
                registrar.context().packageName)
        if (!MapEngine.isInitialized()) {
            MapEngine.getInstance().init(ApplicationContext(context), this)
        } else {
            initMapView()
        }
    }

    override fun onEngineInitializationCompleted(error: OnEngineInitListener.Error?) {

        if (error?.ordinal == OnEngineInitListener.Error.NONE.ordinal) {
            initMapView()
        } else {
            error?.let {
                mapReadyResult?.error("Map engine init error", error.details, error.stackTrace)
            }
        }
    }

    private fun initMapView() {
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
                mapConfiguration = MapChannel.InitMapConfigutation.parseFrom(it.array())
                if (mapConfiguration.hasInitialMapCenter()) {
                    map.setMapCenter(mapConfiguration.initialMapCenter)
                }
            }
        }
        map.mapView.mapGesture.addOnGestureListener(this, 0, true)
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
            (call.arguments as? ByteArray)?.let {
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
                else -> null
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
        map.mapView.mapGesture?.removeOnGestureListener(this)
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

    private fun invokeSimpleGesture(event: MapObjects.MapGestureEvents) {
        val response = MapChannel.MapChannelReplay.newBuilder().let {
            it.mapGesture = MapObjects.MapGesture.newBuilder().let { mapGesture ->
                mapGesture.event = event
                mapGesture.build()
            }
            it.build()
        }.toByteArray()

        GlobalScope.launch(Dispatchers.Main) {
            channel.invokeMethod("replay", response)
        }
    }

    private fun invokeDataEvent(event: MapObjects.MapGesture) {
        val response = MapChannel.MapChannelReplay.newBuilder().let {
            it.mapGesture = event
            it.build()
        }.toByteArray()
        GlobalScope.launch(Dispatchers.Main) {
            channel.invokeMethod("replay", response)
        }
    }

    override fun onTapEvent(p0: PointF?): Boolean {
        if (!mapConfiguration.gestureTapEnable) {
            return false
        }
        p0?.let { point ->
            invokeDataEvent(MapObjects.MapGesture.newBuilder().let {
                it.event = MapObjects.MapGestureEvents.OnEventData
                it.tapEvent = MapObjects.TapEvent.newBuilder().let { zoom ->
                    zoom.point = point.toMapPoint(map)
                    zoom.build()
                }
                it.build()
            })
        }
        return false
    }

    override fun onLongPressEvent(p0: PointF?): Boolean {
        if (!mapConfiguration.gestureLongPressEnable) {
            return false
        }
        p0?.let { point ->
            invokeDataEvent(MapObjects.MapGesture.newBuilder().let {
                it.event = MapObjects.MapGestureEvents.OnEventData
                it.longPressEvent = MapObjects.LongPressEvent.newBuilder().let { zoom ->
                    zoom.mapPoint = point.toMapPoint(map)
                    zoom.build()
                }
                it.build()
            })
        }
        return false
    }

    override fun onPinchZoomEvent(p0: Float, p1: PointF?): Boolean {
        if (!mapConfiguration.gesturePinchEnable) {
            return false
        }
        p1?.let { point ->
            invokeDataEvent(MapObjects.MapGesture.newBuilder().let {
                it.event = MapObjects.MapGestureEvents.OnEventData
                it.pinchZoom = MapObjects.PinchZoom.newBuilder().let { zoom ->
                    zoom.zoom = p0
                    zoom.point = point.toMapPoint(map)
                    zoom.build()
                }
                it.build()
            })
        }

        return false
    }

    override fun onTwoFingerTapEvent(p0: PointF?): Boolean {
        if (!mapConfiguration.gestureTwoFingerTapEnable) {
            return false
        }
        p0?.let { point ->
            invokeDataEvent(MapObjects.MapGesture.newBuilder().let {
                it.event = MapObjects.MapGestureEvents.OnEventData
                it.twoFingerTap = MapObjects.TwoFingerTap.newBuilder().let { zoom ->
                    zoom.point = point.toMapPoint(map)
                    zoom.build()
                }
                it.build()
            })
        }
        return false
    }

    override fun onDoubleTapEvent(p0: PointF?): Boolean {
        if (!mapConfiguration.gestureDoubleTapEnable) {
            return false
        }
        p0?.let { point ->
            invokeDataEvent(MapObjects.MapGesture.newBuilder().let {
                it.event = MapObjects.MapGestureEvents.OnEventData
                it.doubleTap = MapObjects.DoubleTap.newBuilder().let { zoom ->
                    zoom.point = point.toMapPoint(map)
                    zoom.build()
                }
                it.build()
            })
        }
        return false
    }

    override fun onRotateEvent(p0: Float): Boolean {
        if (!mapConfiguration.gestureRotationEnable) {
            return false
        }
        invokeDataEvent(MapObjects.MapGesture.newBuilder().let {
            it.event = MapObjects.MapGestureEvents.OnEventData
            it.rotate = MapObjects.Rotate.newBuilder().let { rotate ->
                rotate.rotate = p0
                rotate.build()
            }
            it.build()
        })
        return false
    }

    override fun onMultiFingerManipulationEnd() {
        if (!mapConfiguration.gestureTwoFingerPanEnable) {
            return
        }
        invokeSimpleGesture(MapObjects.MapGestureEvents.OnMultiFingerManipulationEnd)
    }

    override fun onPanEnd() {
        if (!mapConfiguration.gesturePanEnable) {
            return
        }
        invokeSimpleGesture(MapObjects.MapGestureEvents.OnPanEnd)
    }

    override fun onMapObjectsSelected(p0: MutableList<ViewObject>?): Boolean {
        return false
    }


    //Not implemented, not supported in iOS
    override fun onTiltEvent(p0: Float): Boolean {
        return false
    }

    override fun onRotateLocked() {}
    override fun onLongPressRelease() {}
    override fun onMultiFingerManipulationStart() {}
    override fun onPanStart() {}
    override fun onPinchLocked() {}
}

private fun PointF.toPoint(): MapObjects.PointF {
    return MapObjects.PointF.newBuilder().let {
        it.x = this.x
        it.y = this.y
        it.build()
    }
}

private fun PointF.toMapPoint(map: com.etzuk.flutter.flutterheremaps.map.Map): MapObjects.MapPoint {
    val geoCoordinate = map.mapView.map.pixelToGeo(this)

    return MapObjects.MapPoint.newBuilder().apply {
        this.point = toPoint()
        this.coordinate = MapObjects.Coordinate.newBuilder().apply {
            this.lat = geoCoordinate.latitude
            this.lng = geoCoordinate.longitude
        }.build()
    }.build()
}

