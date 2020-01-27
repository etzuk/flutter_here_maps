import Foundation
import NMAKit
import SwiftProtobuf

class MapViewFactory : NSObject, FlutterPlatformViewFactory {
    
    var registerar: FlutterPluginRegistrar!
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterBinaryCodec.sharedInstance()
    }
    
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
    private let frame : CGRect
    private let viewId : Int64
    private let registerar: FlutterPluginRegistrar
    private var map: Map!
    internal var channel: FlutterMethodChannel!
    internal var mapConfiguration = FlutterHereMaps_InitMapConfigutation()
    
    init(_ frame:CGRect, viewId:Int64, args: Any?, registerar: FlutterPluginRegistrar){
        self.frame = frame
        self.viewId = viewId
        self.registerar = registerar
        map = Map(mapView: NMAMapView(frame: frame))
        map.mapView.mapScheme = map.mapView.availableMapSchemes[12]
        if let argsDict = args as? Data {
            if let configuration = try? FlutterHereMaps_InitMapConfigutation(serializedData: argsDict) {
                mapConfiguration = configuration
                map.set(center: configuration.initialMapCenter)
            }
        }
        
        channel = FlutterMethodChannel(name: "flugins.etzuk.flutter_here_maps/MapViewChannel_\(viewId)", binaryMessenger: registerar.messenger())
    }
    
    func initMethodCallHanlder() {
        channel.setMethodCallHandler { [weak self] (call, result) in
            self?.onMethodCallHanler(call, result: result)
        }
    }
    
    public func view() -> UIView {
        initMethodCallHanlder()
        map.mapView.gestureDelegate = self
        return map.mapView
    }
    
    
    public func onMethodCallHanler(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if(call.method == "initMap") {
            //Wait for map ready. (Support Set Bounding box)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                result(nil)
            }
            return
        }
        
        guard let arg = call.arguments as? FlutterStandardTypedData else { fatalError("Non standart type")}
        //TODO: Optimize this by sending in the function name the decoder and split into
        // two .proto file. one for objects and one for chanel method.
        
        
        var responseObject: Any? = nil
        switch call.method {
        case "request":
            if let request = try? FlutterHereMaps_MapChannelRequest(serializedData: arg.data) {
                responseObject = invoke(request: request)
            }
        case "replay":
            if let replay = try? FlutterHereMaps_MapChannelReplay(serializedData: arg.data) {
                responseObject = invoke(replay: replay)
            }
        default: break;
        }
        
        if let replay = responseObject as? Message {
            do {
                result(try replay.serializedData())
            } catch {
                result("Error when try to serialized data")
            }
        } else {
            result(nil)
        }
        
    }
    
    private func invoke(request: FlutterHereMaps_MapChannelRequest) -> Any?{
        switch request.object {
        case .setMapObject(let mapObject)?:
            return map.add(mapObject: mapObject, registerar: registerar)
        case .setConfiguration(let configuration)?:
            return map.set(configuration: configuration)
        case .setCenter(let center)?:
            return map.set(center: center)
        case .zoomTo(let zoomTo)?:
            return map.set(zoomTo: zoomTo)
        default:break
        }
        return nil
    }
    
    private func invoke(replay: FlutterHereMaps_MapChannelReplay) -> Any? {
        switch replay.object {
        case .getCenter?:
            return map.getCenter()
        default:
            break
        }
        return nil
    }
}



protocol FlutterHereMapView : class {
    func set(center: FlutterHereMaps_MapCenter);
    func set(configuration: FlutterHereMaps_Configuration)
    func set(zoomTo: FlutterHereMaps_ZoomTo)
    func add(mapObject: FlutterHereMaps_MapObject, registerar: FlutterPluginRegistrar)
    func getCenter() -> FlutterHereMaps_MapCenter
}

class Map {
    var mapView: NMAMapView!
    var markers: Dictionary<String,NMAMapMarker> = [:]
    
    init(mapView: NMAMapView) {
        self.mapView = mapView
    }
}

extension Map : FlutterHereMapView {
    
    //MARK -ZoomTo
    
    func set(zoomTo: FlutterHereMaps_ZoomTo) {
        if let bb:NMAGeoBoundingBox = NMAGeoBoundingBox.init(coordinates: zoomTo.coordinates.map({ (coordinate) -> NMAGeoCoordinates in
            coordinate.toGeo()
        })) {
            if zoomTo.hasPaddingFactor {
                let mapWidth = self.mapView.frame.width
                let mapHeight = self.mapView.frame.height
                let horizontalFactor = mapWidth * CGFloat(zoomTo.paddingFactor.value)
                let verticalFactor = mapHeight * CGFloat(zoomTo.paddingFactor.value)
                self.mapView.set(boundingBox: bb,
                                 inside: CGRect(x: horizontalFactor, y: verticalFactor, width: mapWidth - (2 * horizontalFactor), height: mapHeight - (2 * verticalFactor)),
                                 animation: .none)
            }
            else if zoomTo.hasViewRect {
                self.mapView.set(boundingBox: bb, inside: zoomTo.viewRect.toRect(), animation: .none)
            } else {
                self.mapView.set(boundingBox: bb, animation: .none)
            }
        }
    }
    
    //MARK -MapObjects
    
    internal func add(mapObject: FlutterHereMaps_MapObject, registerar: FlutterPluginRegistrar) {
        switch mapObject.object {
        case .marker?: self.add(mapMarker: mapObject, registerar: registerar)
        default: break
        }
    }
    
    private func add(mapMarker: FlutterHereMaps_MapObject, registerar: FlutterPluginRegistrar) {
        
        if let marker = markers[mapMarker.uniqueID] {
            marker.coordinates = mapMarker.marker.coordinate.toGeo()
        } else {
            let hereMapMarker = NMAMapMarker(geoCoordinates: mapMarker.marker.coordinate.toGeo())
            let key = registerar.lookupKey(forAsset: mapMarker.marker.image)
            if let path = Bundle.main.path(forResource: key, ofType: nil) {
                if let image = UIImage(named: path){
                    hereMapMarker.icon = NMAImage(uiImage: image)
                }
            }
            markers[mapMarker.uniqueID]  = hereMapMarker
            mapView.add(mapObject: hereMapMarker)
        }
    }
    
    internal func set(configuration: FlutterHereMaps_Configuration) {
        self.mapView.isTrafficVisible = configuration.trafficVisible;
        self.mapView.positionIndicator.isVisible = configuration.positionIndicator.isVisible.value;
        self.mapView.positionIndicator.isAccuracyIndicatorVisible = configuration.positionIndicator.isAccuracyIndicatorVisible.value;
    }
    
    internal func set(center: FlutterHereMaps_MapCenter) {
        
        if center.hasZoomLevel {
            self.mapView.set(zoomLevel: center.zoomLevel.value, animation: .none);
        }
        
        if center.hasTilt {
            self.mapView.set(tilt: center.tilt.value, animation: .none);
        }
        
        if center.hasOrientation {
            self.mapView.set(orientation: center.orientation.value, animation: .none);
        }
        
        if center.hasCoordinate {
            self.mapView.set(geoCenter: NMAGeoCoordinates(latitude: center.coordinate.lat, longitude: center.coordinate.lng), animation: .none)
        }
    }
    
    internal func getCenter() -> FlutterHereMaps_MapCenter {
        var center = FlutterHereMaps_MapCenter()
        var coordinate = FlutterHereMaps_Coordinate()
        coordinate.lat = self.mapView.geoCenter.latitude
        coordinate.lng = self.mapView.geoCenter.longitude
        center.coordinate = coordinate
        var zoomLevel = FlutterHereMaps_FloatValue()
        zoomLevel.value = self.mapView.zoomLevel
        center.zoomLevel = zoomLevel
        var orientation = FlutterHereMaps_FloatValue()
        orientation.value = self.mapView.orientation
        center.orientation = orientation
        var tilt = FlutterHereMaps_FloatValue()
        tilt.value = self.mapView.tilt
        center.tilt = tilt
        return center
    }
}
