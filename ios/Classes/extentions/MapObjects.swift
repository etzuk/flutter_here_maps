//
//  MapObjects.swift
//  flutter_here_maps
//
//  Created by Gueta, Itzhak on 27/04/2019.
//
import NMAKit

extension FlutterHereMaps_Coordinate {
    func toGeo() -> NMAGeoCoordinates {
        return NMAGeoCoordinates(latitude: self.lat, longitude: self.lng)
    }
}

extension FlutterHereMaps_ViewRect {
    func toRect() -> CGRect {
        return CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
    }
}

extension CGPoint {
    func toPoint() -> FlutterHereMaps_PointF {
        var point = FlutterHereMaps_PointF()
        point.x = Float(self.x)
        point.y = Float(self.y)
        return point
    }
}
