import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_here_maps/gen/map_objects.pb.dart';

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
    return await _mapChannel.invokeMethod(
        'setCenter', _mapCenter.writeToBuffer());
  }

  Future<void> setConfiguration(Configuration configuration) async {
    return await _mapChannel.invokeMethod(
        'setConfiguration', configuration.writeToBuffer());
  }
}
