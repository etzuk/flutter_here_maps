import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import '../../flutter_here_maps.dart';
import '../proto_gen/map_objects.pb.dart';
import '../proto_gen/map_channel.pb.dart';

class HereMapsController {
  HereMapsController._(
    this._mapChannel,
    this._mapCenter,
    this._mapViewGestures,
  ) : assert(_mapChannel != null) {
    _mapChannel.setMethodCallHandler(_handleMethodCall);
  }

  static Future<HereMapsController> init({
    int id,
    MapCenter mapCenter,
    MapViewGestures mapViewGestures,
  }) async {
    assert(id != null);
    final channel =
        MethodChannel('flugins.etzuk.flutter_here_maps/MapViewChannel_$id');
    await channel.invokeMethod("initMap");
    return HereMapsController._(
      channel,
      mapCenter ?? MapCenter()
        ..zoomLevel = (FloatValue()..value = 17.0)
        ..orientation = (FloatValue()..value = 0.0)
        ..tilt = (FloatValue()..value = 0.0),
      mapViewGestures,
    );
  }

  final MethodChannel _mapChannel;
  final MapViewGestures _mapViewGestures;
  MapCenter _mapCenter;

  MapCenter get center => _mapCenter;

  Future<void> setCenter(MapCenter mapCenter) async {
    _mapCenter.mergeFromMessage(mapCenter);
    print(_mapCenter.toDebugString());
    var request = MapChannelRequest()..setCenter = mapCenter;
    return await _invokeRequest(request).then((value) {
      getMapCenter().then((value) {
        print(value.toDebugString());
      });
    });
  }

  Future<void> setConfiguration(Configuration configuration) async =>
      await _invokeRequest(
          MapChannelRequest()..setConfiguration = configuration);

  Future<void> setMapObject(MapObject mapObject) async =>
      await _invokeRequest(MapChannelRequest()..setMapObject = mapObject);

  Future zoomTo(ZoomTo zoomTo) async {
    return await _invokeRequest(MapChannelRequest()..zoomTo = zoomTo);
  }

  Future<MapCenter> getMapCenter() async {
    return MapCenter.fromBuffer(
        await _invokeReplay(MapChannelReplay()..getCenter = MapCenter()));
  }

  Future _invokeRequest(MapChannelRequest request) async {
    return await _mapChannel.invokeMethod('request', request.writeToBuffer());
  }

  Future<Uint8List> _invokeReplay(MapChannelReplay replay) async {
    return await _mapChannel.invokeMethod('replay', replay.writeToBuffer());
  }
}

extension on HereMapsController {
  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == "replay") {
      Uint8List params = call.arguments;
      final mapReplay = MapChannelReplay.fromBuffer(params);
      if (mapReplay.hasMapGesture()) {
        if (mapReplay.mapGesture.event == MapGestureEvents.OnEventData) {
          this
              ._mapViewGestures
              .onMapGestureEventDateReceived(mapReplay.mapGesture);
        } else {
          this
              ._mapViewGestures
              .onMapGestureEventReceived(mapReplay.mapGesture.event);
        }
      }
    }
  }
}
