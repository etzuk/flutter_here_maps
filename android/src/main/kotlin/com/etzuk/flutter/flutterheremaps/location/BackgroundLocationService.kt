package com.etzuk.flutter.flutterheremaps.location

import FlutterHereMaps.LocationObjects
import FlutterHereMaps.MapObjects
import android.app.*
import android.content.Intent
import android.os.Binder
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.here.android.mpa.common.GeoCoordinate
import com.here.android.mpa.common.GeoPosition
import com.here.android.mpa.common.LocationDataSourceHERE
import com.here.android.mpa.common.PositioningManager
import java.lang.ref.WeakReference
import kotlin.math.max


class BackgroundLocationService : Service(), PositioningManager.OnPositionChangedListener {

    private val binder: Binder = Binder()
    private lateinit var localBroadcastReceiver: LocalBroadcastManager
    private lateinit var positioningManager: PositioningManager

    companion object {
        const val CHANNEL_ID = "ForegroundServiceChannel"
        const val BROADCAST_ACTION = "Location_Broadcast_Actions"
        const val EXTRA_DATA = "Location_Read_Data"
        const val EXTRA_SETTINGS = "Location_Settings"

    }


    override fun onCreate() {
        super.onCreate()
        localBroadcastReceiver = LocalBroadcastManager.getInstance(this)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return binder
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        val androidSettings = intent?.getByteArrayExtra(EXTRA_SETTINGS)!!.let {
            LocationObjects.AndroidLocationSettings.parseFrom(it)
        }

        createNotificationChannel(androidSettings)

        val notification: Notification = NotificationCompat.Builder(this, androidSettings.notificationSettings.channelId)
                .setContentTitle(androidSettings.notificationSettings.title)
                .setContentText(androidSettings.notificationSettings.body)
                //TODO resolve icon setting in proto
                .setSmallIcon(android.R.drawable.ic_menu_add)
                .build()

        //TODO resolve service id?
        startForeground(1, notification)
        startTracking(androidSettings.locationMethod)
        return START_NOT_STICKY
    }

    private fun createNotificationChannel(androidSettings: LocationObjects.AndroidLocationSettings) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel = NotificationChannel(
                    androidSettings.notificationSettings.channelId,
                    androidSettings.notificationSettings.channelName,
                    NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
        }
    }


    private fun startTracking(locationMethod: LocationObjects.AndroidLocationSettings.LocationMethod) {
        positioningManager = PositioningManager.getInstance()

        val hereDataSource = LocationDataSourceHERE.getInstance()
        if (hereDataSource != null) {

            positioningManager.dataSource = hereDataSource
            positioningManager.addListener(WeakReference<PositioningManager.OnPositionChangedListener>(this))
            if (positioningManager.start(PositioningManager.LocationMethod.values()[locationMethod.ordinal])) {
                Log.d("Background locations", "tracking started")
                // Position updates started successfully.
            }
        }
    }

    override fun onDestroy() {
        if (::positioningManager.isInitialized) {
            positioningManager.stop()
            positioningManager.removeListener(this)
        }

        super.onDestroy()
    }

    override fun onPositionFixChanged(p0: PositioningManager.LocationMethod?, p1: PositioningManager.LocationStatus?) {

    }

    override fun onPositionUpdated(p0: PositioningManager.LocationMethod?, geoPosition: GeoPosition, p2: Boolean) {
        val data = Intent().setAction(BROADCAST_ACTION).putExtra(EXTRA_DATA, geoPosition.toLocation().toByteArray())
        localBroadcastReceiver.sendBroadcast(data)
    }


}

private fun GeoPosition.toLocation(): LocationObjects.LocationReading {
    return LocationObjects.LocationReading.newBuilder().apply {
        this.coordinate = this@toLocation.coordinate.toCoordinate()
        this.heading = this@toLocation.heading
        this.altitude = this@toLocation.coordinate.altitude
        this.speed = this@toLocation.speed
        this.accuracy = max(this@toLocation.latitudeAccuracy, this@toLocation.longitudeAccuracy).toDouble()
    }.build()

}

private fun GeoCoordinate.toCoordinate(): MapObjects.Coordinate {
    return MapObjects.Coordinate.newBuilder().apply {
        this.lng = this@toCoordinate.longitude
        this.lat = this@toCoordinate.latitude
    }.build()
}
