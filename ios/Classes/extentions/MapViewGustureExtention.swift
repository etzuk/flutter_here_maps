import Foundation
import NMAKit
import SwiftProtobuf

extension MapView : NMAMapGestureDelegate {
    
    private func invokeSimpleGesture(event: FlutterHereMaps_MapGestureEvents) {
        var replay = FlutterHereMaps_MapChannelReplay()
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = event
        replay.mapGesture = mapGesture
        try? channel.invokeMethod("replay", arguments: replay.serializedData())
    }
    
    private func invokeDataGestureEvent(event: FlutterHereMaps_MapGesture) {
        var replay = FlutterHereMaps_MapChannelReplay()
        replay.mapGesture = event
        try? channel.invokeMethod("replay", arguments: replay.serializedData())
    }
    
    public func mapView(_ mapView: NMAMapView, didReceiveTapAt location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveTapAt: location)
        }
        guard mapConfiguration.gestureTapEnable else {
            return
        }
        
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = .onEventData
        var tapEvent = FlutterHereMaps_TapEvent()
        tapEvent.point = location.toPoint()
        mapGesture.tapEvent = tapEvent
        invokeDataGestureEvent(event:mapGesture)
    }
    public func mapView(_ mapView: NMAMapView, didReceiveLongPressAt location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveLongPressAt: location)
        }
        guard mapConfiguration.gestureLongPressEnable else {
            return
        }
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = .onEventData
        var longPress = FlutterHereMaps_LongPressEvent()
        longPress.point = location.toPoint()
        mapGesture.longPressEvent = longPress
        invokeDataGestureEvent(event:mapGesture)
    }
    
    public func mapView(_ mapView: NMAMapView, didReceivePinch pinch: Float, at location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceivePinch:pinch, at:location)
        }
        guard mapConfiguration.gesturePinchEnable else {
            return
        }
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = .onEventData
        var pinchZoom = FlutterHereMaps_PinchZoom()
        pinchZoom.point = location.toPoint()
        pinchZoom.zoom = pinch
        mapGesture.pinchZoom = pinchZoom
        invokeDataGestureEvent(event:mapGesture)
    }
    
    public func mapView(_ mapView: NMAMapView, didReceiveTwoFingerTapAt location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveTwoFingerTapAt: location)
        }
        guard mapConfiguration.gestureTwoFingerTapEnable else {
            return
        }
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = .onEventData
        var twoFingerTap = FlutterHereMaps_TwoFingerTap()
        twoFingerTap.point = location.toPoint()
        mapGesture.twoFingerTap = twoFingerTap
        invokeDataGestureEvent(event:mapGesture)
    }
    
    public func mapView(_ mapView: NMAMapView, didReceiveDoubleTapAt location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveDoubleTapAt: location)
        }
        guard mapConfiguration.gestureDoubleTapEnable else {
            return
        }
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = .onEventData
        var doubleTap = FlutterHereMaps_DoubleTap()
        doubleTap.point = location.toPoint()
        mapGesture.doubleTap = doubleTap
        invokeDataGestureEvent(event:mapGesture)
    }
    
    public func mapView(_ mapView: NMAMapView, didReceiveRotation rotation: Float, at location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveRotation: rotation, at: location)
        }
        guard mapConfiguration.gestureRotationEnable else {
            return
        }
        var mapGesture = FlutterHereMaps_MapGesture()
        mapGesture.event = .onEventData
        var rotate = FlutterHereMaps_Rotate()
        rotate.rotate = rotation
        mapGesture.rotate = rotate
        invokeDataGestureEvent(event:mapGesture)
    }
    
    public func mapView(_ mapView: NMAMapView, didReceivePan translation: CGPoint, at location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceivePan: translation, at: location)
        }
        guard mapConfiguration.gesturePanEnable else {
            return
        }
        invokeSimpleGesture(event: .onPanEnd)
    }
    
    public func mapView(_ mapView: NMAMapView, didReceiveTwoFingerPan translation: CGPoint, at location: CGPoint) {
        if let defaultHandler = mapView.defaultGestureHandler {
            defaultHandler.mapView!(mapView, didReceiveTwoFingerPan: translation, at: location)
        }
        guard mapConfiguration.gestureTwoFingerPanEnable else {
            return
        }
        invokeSimpleGesture(event: .onMultiFingerManipulationEnd)
    }
}
