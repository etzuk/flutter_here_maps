package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapObjects
import android.content.res.AssetManager
import android.graphics.BitmapFactory
import com.here.android.mpa.common.GeoBoundingBox
import com.here.android.mpa.common.Image
import com.here.android.mpa.common.ViewRect

import com.here.android.mpa.mapping.MapMarker
import io.flutter.plugin.common.PluginRegistry


internal fun Map.setConfiguration(configuration: MapObjects.Configuration) {
    if (configuration.hasPositionIndicator()) {
        if (configuration.positionIndicator.hasIsVisible()) {
            mapView.positionIndicator.isVisible = true
            mapView.positionIndicator.isVisible = configuration.positionIndicator.isVisible.value
        }

        if (configuration.positionIndicator.hasIsAccuracyIndicatorVisible()) {
            mapView.positionIndicator.isAccuracyIndicatorVisible = configuration.positionIndicator.isAccuracyIndicatorVisible.value
        }

        mapView.map.isTrafficInfoVisible = configuration.trafficVisible
    }
}

internal fun Map.setMapObject(mapObject: MapObjects.MapObject, registrar: PluginRegistry.Registrar) {
    when (mapObject.objectCase) {
        MapObjects.MapObject.ObjectCase.MARKER -> setMapMarker(mapObject, registrar)
        else -> return
    }
}

internal fun Map.clean() {
    if(markers.values.isNotEmpty()) {
        mapView.map.removeMapObjects(markers.values.toList())
    }
}

internal fun Map.setMapMarker(mapObject: MapObjects.MapObject, registrar: PluginRegistry.Registrar) {

    markers[mapObject.uniqueId]?.let {
        it.coordinate = mapObject.marker.coordinate.toGeo()
        return
    }

    val assetManager: AssetManager = registrar.context().assets
    val key: String = registrar.lookupKeyForAsset(mapObject.marker.image)
    val fd = assetManager.openFd(key)


    val image = Image()
    image.bitmap = BitmapFactory.decodeStream(fd.createInputStream())
    val geo = mapObject.marker.coordinate.toGeo()
    val marker = MapMarker(geo, image)

    markers[mapObject.uniqueId] = marker
    mapView.map.addMapObject(marker)
}

internal fun Map.setMapCenter(center: MapObjects.MapCenter) {
    val map : com.here.android.mpa.mapping.Map = mapView.map
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
        map.setCenter(center.coordinate.toGeo(), com.here.android.mpa.mapping.Map.Animation.NONE)
    }
}

internal fun Map.zoomTo(zoomTo: MapObjects.ZoomTo) {
    val map : com.here.android.mpa.mapping.Map = mapView.map
    val bb = GeoBoundingBox.getBoundingBoxContainingGeoCoordinates(zoomTo.coordinatesList.map { it.toGeo() })
    val orientation = if(zoomTo.hasOrientation()) zoomTo.orientation.value else com.here.android.mpa.mapping.Map.MOVE_PRESERVE_ORIENTATION
    val perspective = if(zoomTo.hasPerspective()) zoomTo.perspective.value else com.here.android.mpa.mapping.Map.MOVE_PRESERVE_TILT

    when {
        zoomTo.hasPaddingFactor() -> {
            val paddingVertical = (mapView.measuredHeight * zoomTo.paddingFactor.value).toInt()
            val paddingHorizontal = (mapView.measuredWidth * zoomTo.paddingFactor.value).toInt()
            map.zoomTo(bb, ViewRect(paddingHorizontal,paddingVertical,mapView.measuredWidth - (2 * paddingHorizontal), mapView.measuredHeight - (2 * paddingVertical) ),com.here.android.mpa.mapping.Map.Animation.NONE, orientation)
        }
        zoomTo.hasViewRect() -> {
            map.zoomTo(bb, zoomTo.viewRect.toViewRect(),com.here.android.mpa.mapping.Map.Animation.NONE, orientation)
        }
        else -> {
            map.zoomTo(bb, com.here.android.mpa.mapping.Map.Animation.NONE, orientation, perspective)
        }
    }
}

private fun MapObjects.ViewRect.toViewRect(): ViewRect {
    return ViewRect(x, y, width, height)
}

internal fun Map.getMapCenter() =
        MapObjects.MapCenter.newBuilder().let {
            it.zoomLevel = MapObjects.FloatValue.newBuilder().setValue(mapView.map.zoomLevel.toFloat()).build()
            it.tilt = MapObjects.FloatValue.newBuilder().setValue(mapView.map.tilt).build()
            it.orientation = MapObjects.FloatValue.newBuilder().setValue(mapView.map.orientation).build()
            it.coordinate = MapObjects.Coordinate.newBuilder()
                    .setLat(mapView.map.center.latitude)
                    .setLng(mapView.map.center.longitude).build()
            it.build()
        }
