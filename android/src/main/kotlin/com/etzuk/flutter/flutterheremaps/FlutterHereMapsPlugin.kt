package com.etzuk.flutter.flutterheremaps

import FlutterHereMaps.LocationObjects
import android.Manifest
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.etzuk.flutter.flutterheremaps.location.BackgroundLocationService
import com.etzuk.flutter.flutterheremaps.map.MapViewFactory
import com.here.android.mpa.common.MapSettings
import io.flutter.embedding.engine.systemchannels.LifecycleChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.File

class FlutterHereMapsPlugin(private val registrar: Registrar, private val channel: MethodChannel) : MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {


    private val localBroadcastManager = LocalBroadcastManager.getInstance(context)
    private lateinit var settings: LocationObjects.AndroidLocationSettings

    private val context: Context
        get() = registrar.activeContext()

    companion object {
        private const val LOCATION_READ_EVENT = "on_location_read"
        private const val REQUEST_PERMISSIONS_REQUEST_CODE = 435

        private const val pluginPrefix = "flugins.etzuk.flutter_here_maps"
        private const val METHOD_CHANNEL_NAME = "here_locations/methods"
        private const val ARGUMENT_SETTINGS_KEY = "settings"

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val success = MapSettings.setIsolatedDiskCacheRootPath("${registrar.context().getExternalFilesDir(null)}${File.separator}.here-maps",
                    registrar.context().packageName)
            if (success) {

                registrar.platformViewRegistry()
                        .registerViewFactory("$pluginPrefix/MapView", MapViewFactory(registrar))
                if (registrar.activity() != null) {
                    //method channel
                    val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
                    val hereMapsPlugin = FlutterHereMapsPlugin(registrar, channel)

                    registrar.addRequestPermissionsResultListener(hereMapsPlugin)
                    channel.setMethodCallHandler(hereMapsPlugin)
                }
            }
        }
    }


    /**
     * Broadcast receiver to receive the data
     */
    private val mReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            GlobalScope.launch(Dispatchers.Main) {
                intent.getByteArrayExtra(BackgroundLocationService.EXTRA_DATA)?.let { byteArrayExtra ->

                    channel.invokeMethod(LOCATION_READ_EVENT, byteArrayExtra)
                }
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {

            "start_location_service" -> {
                call.argument<ByteArray>(ARGUMENT_SETTINGS_KEY)?.let {
                    settings = LocationObjects.AndroidLocationSettings.parseFrom(it)
                }

                if (!::settings.isInitialized) {
                    result.error("configuration_missing", "configure must be provided at least once before tracking can start", null)
                } else {
                    startBackgroundTracking(settings)
                }
            }
            "stop_location_service" -> {
                stopLocationTracking()
            }
        }
    }

    private fun stopLocationTracking() {
        localBroadcastManager.unregisterReceiver(mReceiver)
        context.stopService(Intent(context, BackgroundLocationService::class.java))
    }


    private fun startBackgroundTracking(settings: LocationObjects.AndroidLocationSettings) {

        if (!checkPermissions()) {
            requestPermissions()
        } else {
            localBroadcastManager.unregisterReceiver(mReceiver)
            val filter = IntentFilter(BackgroundLocationService.BROADCAST_ACTION)

            localBroadcastManager.registerReceiver(mReceiver, filter)
            val intent = Intent(context, BackgroundLocationService::class.java).apply {
                putExtra(BackgroundLocationService.EXTRA_SETTINGS, settings.toByteArray())
            }

            ContextCompat.startForegroundService(context, intent)
        }
    }

    private fun checkPermissions(): Boolean {
        return PackageManager.PERMISSION_GRANTED == ActivityCompat.checkSelfPermission(registrar.activeContext(),
                Manifest.permission.ACCESS_FINE_LOCATION)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
        if (requestCode == REQUEST_PERMISSIONS_REQUEST_CODE) {
            when {
                grantResults!!.isEmpty() -> {
                    Log.i("BackgroundLocation", "User interaction was cancelled.")
                }
                grantResults[0] == PackageManager.PERMISSION_GRANTED -> startBackgroundTracking(settings)
                else -> {
                    //TODO
                }
            }
        }
        return true
    }


    private fun requestPermissions() {
        //TODO
        val shouldProvideRationale = ActivityCompat.shouldShowRequestPermissionRationale(registrar.activity(), Manifest.permission.ACCESS_FINE_LOCATION)
//        if (shouldProvideRationale) {
//            Log.i(TAG, "Displaying permission rationale to provide additional context.")
//        } else {
        ActivityCompat.requestPermissions(registrar.activity(),
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                REQUEST_PERMISSIONS_REQUEST_CODE)
//    }
    }
}
