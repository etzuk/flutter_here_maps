package com.etzuk.flutter.flutterheremaps.location

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
import com.here.android.mpa.common.ApplicationContext
import com.here.android.mpa.common.MapEngine
import com.here.android.mpa.common.OnEngineInitListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class LocationHandler(private val registrar: PluginRegistry.Registrar, private val channel: MethodChannel) : MethodChannel.MethodCallHandler {

    companion object {
        private const val LOCATION_READ_EVENT = "on_location_read"
        private const val ARGUMENT_SETTINGS_KEY = "settings"
    }

    private var isLocationTrackingOn: Boolean = false
    @Volatile
    private var lock = Object()

    private val context: Context
        get() = registrar.context()

    private val localBroadcastManager: LocalBroadcastManager by lazy {
        LocalBroadcastManager.getInstance(context)
    }
    private var settings: LocationObjects.AndroidLocationSettings? = null

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

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (!MapEngine.isInitialized()) {
            synchronized(this) {
                if (!MapEngine.isInitialized()) {
                    MapEngine.getInstance().init(ApplicationContext(context)) { error ->
                        if (error != OnEngineInitListener.Error.NONE) {
                            result.error("Map engine init error", error.details, error.stackTrace)
                        } else {
                            handleMethodCalls(call, result)
                        }
                    }
                }
            }
        } else {
            handleMethodCalls(call, result)
        }
    }

    private fun handleMethodCalls(call: MethodCall, result: MethodChannel.Result) {
        var safety = when (call.method) {
            "is_location_on" -> result.success(isLocationTrackingOn)
            "start_location_service" -> {
                if (!checkPermissions()) {
                    isLocationTrackingOn = false
                    result.error("location_permission_missing", "missing location permissions", null);
                }

                call.argument<ByteArray>(ARGUMENT_SETTINGS_KEY)?.let {
                    try {
                        LocationObjects.AndroidLocationSettings.parseFrom(it)?.let { androidSettings ->
                            settings = androidSettings
                        }
                    } catch (e: Exception) {
                        Log.e("Location Handler", "error extracting settings object")
                    }
                }

                settings.let { settings ->
                    if (settings != null) {
                        result.success("starting location tracking")
                        startBackgroundTracking(settings)
                        isLocationTrackingOn = false
                        result.success(true)
                    } else {
                        isLocationTrackingOn = false
                        result.error(
                                "configuration_missing",
                                "configure must be provided at least once before tracking can start",
                                null)
                    }
                }
            }
            "stop_location_service" -> {
                isLocationTrackingOn = false
                stopLocationTracking()
                result.success(true)
            }
            else -> {
                result.error("unknown command: ${call.method}", null, null)
            }
        }
    }


    private fun stopLocationTracking() {
        localBroadcastManager.unregisterReceiver(mReceiver)
        context.stopService(Intent(context, BackgroundLocationService::class.java))
    }


    private fun startBackgroundTracking(settings: LocationObjects.AndroidLocationSettings) {
        localBroadcastManager.unregisterReceiver(mReceiver)
        val filter = IntentFilter(BackgroundLocationService.BROADCAST_ACTION)

        localBroadcastManager.registerReceiver(mReceiver, filter)
        val intent = Intent(context, BackgroundLocationService::class.java).apply {
            putExtra(BackgroundLocationService.EXTRA_SETTINGS, settings.toByteArray())
        }

        ContextCompat.startForegroundService(context, intent)
    }

    private fun checkPermissions(): Boolean {
        return PackageManager.PERMISSION_GRANTED == ActivityCompat.checkSelfPermission(registrar.activeContext(),
                Manifest.permission.ACCESS_FINE_LOCATION)
    }

}

