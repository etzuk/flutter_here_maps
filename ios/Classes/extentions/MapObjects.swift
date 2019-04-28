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
