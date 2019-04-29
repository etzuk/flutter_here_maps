import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_here_maps/gen/map_objects.pb.dart';
import 'package:flutter_here_maps/gen/map_channel.pb.dart';

class FlutterHereMaps {
  static const MethodChannel _mapChannel =
      MethodChannel('flugins.etzuk.flutter_here_maps/MapViewChannel');

  FlutterHereMaps() {
    _mapCenter = MapCenter()
      ..zoomLevel = (FloatValue()..value = 17.0)
      ..orientation = (FloatValue()..value = 0.0)
      ..tilt = (FloatValue()..value = 0.0);
  }

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
