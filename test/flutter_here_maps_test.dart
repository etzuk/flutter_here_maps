// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_here_maps/src/proto_gen/map_objects.pb.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_here_maps/flutter_here_maps.dart';

void main() {
  test("Init map correctly", () async {
    var map = await HereMapsController.init(id: 1);
    expect(map.center.zoomLevel.value, 17.0);
    expect(map.center.orientation.value, 0.0);
    expect(map.center.tilt.value, 0.0);
  });

  test("set center merge correctly", () async {
    var map = await HereMapsController.init(id: 1);
    MapCenter mapCenter = MapCenter()
      ..coordinate = (Coordinate()
        ..lat = 2.2
        ..lng = 2.2)
      ..zoomLevel = (FloatValue()..value = 14);
    map.setCenter(mapCenter);
    expect(map.center.coordinate.lat, 2.2);
    expect(map.center.coordinate.lng, 2.2);
    expect(map.center.zoomLevel.value, 14);
  });
}
