///
//  Generated code. Do not modify.
//  source: map_objects.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Animation$json = const {
  '1': 'Animation',
  '2': const [
    const {'1': 'Bow', '2': 0},
    const {'1': 'Linear', '2': 1},
    const {'1': 'None', '2': 2},
    const {'1': 'Rocket', '2': 3},
  ],
};

const Coordinate$json = const {
  '1': 'Coordinate',
  '2': const [
    const {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    const {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
  ],
};

const Size$json = const {
  '1': 'Size',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 2, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 2, '10': 'height'},
  ],
};

const ViewRect$json = const {
  '1': 'ViewRect',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 5, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 5, '10': 'y'},
    const {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    const {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
  ],
};

const MapMarker$json = const {
  '1': 'MapMarker',
  '2': const [
    const {'1': 'coordinate', '3': 1, '4': 1, '5': 11, '6': '.FlutterHereMaps.Coordinate', '10': 'coordinate'},
    const {'1': 'size', '3': 2, '4': 1, '5': 11, '6': '.FlutterHereMaps.Size', '10': 'size'},
    const {'1': 'image', '3': 3, '4': 1, '5': 9, '10': 'image'},
  ],
};

const MapObject$json = const {
  '1': 'MapObject',
  '2': const [
    const {'1': 'uniqueId', '3': 1, '4': 1, '5': 9, '10': 'uniqueId'},
    const {'1': 'zIndex', '3': 2, '4': 1, '5': 5, '10': 'zIndex'},
    const {'1': 'visible', '3': 3, '4': 1, '5': 8, '10': 'visible'},
    const {'1': 'marker', '3': 4, '4': 1, '5': 11, '6': '.FlutterHereMaps.MapMarker', '9': 0, '10': 'marker'},
  ],
  '8': const [
    const {'1': 'Object'},
  ],
};

const MapCenter$json = const {
  '1': 'MapCenter',
  '2': const [
    const {'1': 'Coordinate', '3': 1, '4': 1, '5': 11, '6': '.FlutterHereMaps.Coordinate', '10': 'Coordinate'},
    const {'1': 'zoomLevel', '3': 2, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'zoomLevel'},
    const {'1': 'orientation', '3': 3, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'orientation'},
    const {'1': 'tilt', '3': 4, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'tilt'},
    const {'1': 'animation', '3': 5, '4': 1, '5': 14, '6': '.FlutterHereMaps.Animation', '10': 'animation'},
  ],
};

const Configuration$json = const {
  '1': 'Configuration',
  '2': const [
    const {'1': 'trafficVisible', '3': 1, '4': 1, '5': 8, '10': 'trafficVisible'},
    const {'1': 'positionIndicator', '3': 2, '4': 1, '5': 11, '6': '.FlutterHereMaps.Configuration.PositionIndicator', '10': 'positionIndicator'},
  ],
  '3': const [Configuration_PositionIndicator$json],
};

const Configuration_PositionIndicator$json = const {
  '1': 'PositionIndicator',
  '2': const [
    const {'1': 'isVisible', '3': 1, '4': 1, '5': 11, '6': '.FlutterHereMaps.BoolValue', '10': 'isVisible'},
    const {'1': 'isAccuracyIndicatorVisible', '3': 2, '4': 1, '5': 11, '6': '.FlutterHereMaps.BoolValue', '10': 'isAccuracyIndicatorVisible'},
    const {'1': 'accuracyIndicatorColor', '3': 3, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'accuracyIndicatorColor'},
    const {'1': 'hue', '3': 4, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'hue'},
    const {'1': 'orientationOffset', '3': 5, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'orientationOffset'},
    const {'1': 'tracksCourse', '3': 6, '4': 1, '5': 11, '6': '.FlutterHereMaps.BoolValue', '10': 'tracksCourse'},
  ],
};

const ZoomTo$json = const {
  '1': 'ZoomTo',
  '2': const [
    const {'1': 'coordinates', '3': 1, '4': 3, '5': 11, '6': '.FlutterHereMaps.Coordinate', '10': 'coordinates'},
    const {'1': 'animation', '3': 2, '4': 1, '5': 14, '6': '.FlutterHereMaps.Animation', '10': 'animation'},
    const {'1': 'orientation', '3': 3, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'orientation'},
    const {'1': 'perspective', '3': 4, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'perspective'},
    const {'1': 'viewRect', '3': 5, '4': 1, '5': 11, '6': '.FlutterHereMaps.ViewRect', '10': 'viewRect'},
    const {'1': 'paddingFactor', '3': 6, '4': 1, '5': 11, '6': '.FlutterHereMaps.FloatValue', '10': 'paddingFactor'},
  ],
};

const FloatValue$json = const {
  '1': 'FloatValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 2, '10': 'value'},
  ],
};

const BoolValue$json = const {
  '1': 'BoolValue',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 8, '10': 'value'},
  ],
};

