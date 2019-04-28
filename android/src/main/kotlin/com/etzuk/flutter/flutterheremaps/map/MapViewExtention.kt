package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapObjects
import com.here.android.mpa.common.Image
import com.here.android.mpa.mapping.Map
import com.here.android.mpa.mapping.MapMarker
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

internal fun MapView.setMapObject(mapObject: MapObjects.MapObject) {
    when (mapObject.objectCase) {
        MapObjects.MapObject.ObjectCase.MARKER -> setMapMarker(mapObject.marker)
        else -> return
    }
}

internal fun MapView.setMapMarker(mapMarker: MapObjects.MapMarker) {
    val image = Image()
    image.setImageResource(android.R.drawable.btn_star_big_off)
    val geo = mapMarker.coordinate.toGeo()
    val marker = MapMarker(geo, image)
    map.addMapObject(marker)
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
        map.setCenter(center.coordinate.toGeo(), Map.Animation.NONE)
    }
}
