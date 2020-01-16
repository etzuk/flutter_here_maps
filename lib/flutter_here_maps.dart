import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_here_maps/proto_gen/map_objects.pb.dart';
import 'package:flutter_here_maps/proto_gen/map_channel.pb.dart';

class HereMapsController {
  HereMapsController._(
    this._mapChannel,
    this._mapCenter,
  ) : assert(_mapChannel != null);

  static Future<HereMapsController> init({int id, MapCenter mapCenter}) async {
    assert(id != null);
    final channel =
        MethodChannel('flugins.etzuk.flutter_here_maps/MapViewChannel_$id');
    await channel.invokeMethod("initMap");
    return HereMapsController._(
        channel,
        mapCenter ?? MapCenter()
          ..zoomLevel = (FloatValue()..value = 17.0)
          ..orientation = (FloatValue()..value = 0.0)
          ..tilt = (FloatValue()..value = 0.0));
  }

  final MethodChannel _mapChannel;
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
