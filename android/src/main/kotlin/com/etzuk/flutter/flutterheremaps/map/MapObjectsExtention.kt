package com.etzuk.flutter.flutterheremaps.map

import FlutterHereMaps.MapObjects
import com.here.android.mpa.common.GeoCoordinate

internal fun MapObjects.Coordinate.toGeo() : GeoCoordinate {
    return GeoCoordinate(this.lat, this.lng)
}