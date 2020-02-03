import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
import 'package:flutter_here_maps/src/proto_gen/location_objects.pb.dart';

class BackgroundLocationPlugin {
  static const MethodChannel _channel =
      const MethodChannel('here_locations/methods');

  /// Stop receiving location updates
  static Future<void> stopLocationService() async {
    return _channel.invokeMethod("stop_location_service");
  }

  /// Start receiving location updated
  static Future<void> startLocationService(
      AndroidLocationSettings androidLocationSettings) async {
    return _channel.invokeMethod("start_location_service",
        <String, dynamic>{"settings": androidLocationSettings.writeToBuffer()});
  }

  /// Register a function to receive location updates as long as the location
  /// service has started
  static getLocationUpdates(Function(LocationReading) onLocationCallback) {
    // add a handler on the channel to receive updates from the native classes
    _channel.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "on_location_read") {
        Uint8List params = methodCall.arguments;
        final location = LocationReading.fromBuffer(params);
        // Call the user passed function
        onLocationCallback(location);
      }
    });
  }
}
