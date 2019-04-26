package com.etzuk.flutter.flutterheremaps.map

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.view.View
import androidx.core.app.ActivityCompat
import com.here.android.mpa.common.ApplicationContext
import com.here.android.mpa.common.MapEngine
import com.here.android.mpa.common.OnEngineInitListener
import com.here.android.mpa.mapping.Map
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
        return MapView(registrar, context, id, args)
    }
}

class MapView(registrar: PluginRegistry.Registrar, val context: Context?, id: Int, args: Any?) :
        PlatformView,
        OnEngineInitListener,
        PluginRegistry.RequestPermissionsResultListener {

    private val mapView = com.here.android.mpa.mapping.MapView(registrar.activeContext())
    private var map: Map? = null

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
                    arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    WRITE_STORAGE_PERMISSION_CODE)
        } else {
            initMapEngine()
        }
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
            map?.projectionMode = Map.Projection.GLOBE
            map?.setExtrudedBuildingsVisible(true)
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

}