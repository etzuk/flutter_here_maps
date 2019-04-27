package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapObjects
import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.view.View
import androidx.core.app.ActivityCompat
import com.here.android.mpa.common.ApplicationContext
import com.here.android.mpa.common.MapEngine
import com.here.android.mpa.common.OnEngineInitListener
import com.here.android.mpa.mapping.Map
import com.here.android.mpa.mapping.MapView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.platform.PlatformView
import kotlin.reflect.KFunction2


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
            return
        }

        methodCall.let { call ->
            (call!!.arguments as ByteArray).let {
                when(call.method) {
                    "setCenter" ->
                        MethodWrapper(MapView::setMapCenter, MapObjects.MapCenter::parseFrom).apply(mapView, it)
                    "setConfiguration" ->
                        MethodWrapper(MapView::setConfiguration, MapObjects.Configuration::parseFrom).apply(mapView, it)
                    else -> print("method not found")
                }
            }
        }
    }

    data class MethodWrapper<T>(
            val method: KFunction2<MapView, T,
                    Unit>, val coder: (parseFrom: ByteArray) -> T ) {
        fun apply(mapView: MapView, data: ByteArray) {
            method(mapView, coder(data))
        }
    }
}