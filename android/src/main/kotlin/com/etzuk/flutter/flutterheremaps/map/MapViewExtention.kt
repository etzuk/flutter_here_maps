package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapObjects
import com.here.android.mpa.common.GeoCoordinate
import com.here.android.mpa.mapping.Map
import com.here.android.mpa.mapping.MapView

internal fun MapView.setConfiguration(configuration: MapObjects.Configuration) {
    if (configuration.hasPositionIndicator()) {
        if (configuration.positionIndicator.hasIsVisible()) {
            this.positionIndicator.isVisible = true
            this.positionIndicator.isVisible = configuration.positionIndicator.isVisible.value
        }

        if (configuration.positionIndicator.hasIsAccuracyIndicatorVisible()) {
            this.positionIndicator.isAccuracyIndicatorVisible = configuration.positionIndicator.isAccuracyIndicatorVisible.value
        }

        this.map.isTrafficInfoVisible = configuration.trafficVisible
    }
}

internal fun MapView.setMapCenter(center: MapObjects.MapCenter) {
    val map = this.map
    if (center.hasTilt()) {
        map.tilt = center.tilt.value
    }

    if (center.hasOrientation()) {
        map.orientation = center.orientation.value
    }

    if (center.hasZoomLevel()) {
        map.zoomLevel = center.zoomLevel.value.toDouble()
    }

    if (center.hasCoordinate()) {
        map.setCenter(GeoCoordinate(center.coordinate.lat, center.coordinate.lng), Map.Animation.BOW)
    }
}
