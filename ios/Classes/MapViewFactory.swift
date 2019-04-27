//
//  NativeViewFactory.swift
//  Runner
//
//  Created by Rohit Nisal on 12/24/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import NMAKit

class MapViewFactory : NSObject, FlutterPlatformViewFactory {

    var registerar: FlutterPluginRegistrar!


    init(with registerar: FlutterPluginRegistrar) {
        self.registerar = registerar
    }

    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?) -> FlutterPlatformView {
        return MapView(frame, viewId:viewId, args:args, registerar: registerar)
    }
}

public class MapView : NSObject, FlutterPlatformView {
    let frame : CGRect
    let viewId : Int64
    let registerar: FlutterPluginRegistrar

    var map: NMAMapView!

    init(_ frame:CGRect, viewId:Int64, args: Any?, registerar: FlutterPluginRegistrar){
        self.frame = frame
        self.viewId = viewId
        self.registerar = registerar
        if let argsDict = args as? Dictionary<String, AnyObject> {
            let cameraPosition = argsDict["initialCameraPosition"]
            print(cameraPosition ?? "No camera position")
        } else {
            print(args.debugDescription)
        }
        map = NMAMapView(frame: self.frame)
    }

    func initMethodCallHanlder() {
        let chanel = FlutterMethodChannel(name: "flugins.etzuk.flutter_here_maps/MapViewChannel", binaryMessenger: registerar.messenger())
        chanel.setMethodCallHandler { [weak self] (call, result) in
            self?.onMethodCallHanler(call, result: result)
        }
    }

    public func view() -> UIView {
        initMethodCallHanlder()
        return map
    }


    public func onMethodCallHanler(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        guard let arg = call.arguments as? FlutterStandardTypedData else { fatalError("Non standart type")}
        //TODO: Optimize this by sending in the function name the decoder and split into
        // two .proto file. one for objects and one for chanel method.
        switch call.method {
        case "setCenter":
            try? map.setCenter(center: FlutterHereMaps_MapCenter(serializedData: arg.data))
        case "setConfiguration":
            try? map.setConfiguration(configuration: FlutterHereMaps_Configuration(serializedData: arg.data))
        default: break;
        }
    }

}

protocol FlutterHereMapView : class {
    func setCenter(center: FlutterHereMaps_MapCenter);
    func setConfiguration(configuration: FlutterHereMaps_Configuration)
}

extension NMAMapView : FlutterHereMapView {

    func setConfiguration(configuration: FlutterHereMaps_Configuration) {
        self.isTrafficVisible = configuration.trafficVisible;
        self.positionIndicator.isVisible = configuration.positionIndicator.isVisible.value;
        self.positionIndicator.isAccuracyIndicatorVisible = configuration.positionIndicator.isAccuracyIndicatorVisible.value;
    }

    func setCenter(center: FlutterHereMaps_MapCenter) {

        if center.hasZoomLevel {
            self.set(zoomLevel: center.zoomLevel.value, animation: .none);
        }

        if center.hasTilt {
            self.set(tilt: center.tilt.value, animation: .none);
        }

        if center.hasOrientation {
            self.set(orientation: center.orientation.value, animation: .none);
        }

        if center.hasCoordinate {
            self.set(geoCenter: NMAGeoCoordinates(latitude: center.coordinate.lat, longitude: center.coordinate.lng), animation: .bow)
        }
    }
}
