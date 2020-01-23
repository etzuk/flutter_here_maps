///
//  Generated code. Do not modify.
//  source: map_objects.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Animation extends $pb.ProtobufEnum {
  static const Animation Bow = Animation._(0, 'Bow');
  static const Animation Linear = Animation._(1, 'Linear');
  static const Animation None = Animation._(2, 'None');
  static const Animation Rocket = Animation._(3, 'Rocket');

  static const $core.List<Animation> values = <Animation> [
    Bow,
    Linear,
    None,
    Rocket,
  ];

  static final $core.Map<$core.int, Animation> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Animation valueOf($core.int value) => _byValue[value];

  const Animation._($core.int v, $core.String n) : super(v, n);
}

class MapGestureEvents extends $pb.ProtobufEnum {
  static const MapGestureEvents OnMultiFingerManipulationEnd = MapGestureEvents._(0, 'OnMultiFingerManipulationEnd');
  static const MapGestureEvents OnPanEnd = MapGestureEvents._(1, 'OnPanEnd');
  static const MapGestureEvents OnEventData = MapGestureEvents._(2, 'OnEventData');

  static const $core.List<MapGestureEvents> values = <MapGestureEvents> [
    OnMultiFingerManipulationEnd,
    OnPanEnd,
    OnEventData,
  ];

  static final $core.Map<$core.int, MapGestureEvents> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MapGestureEvents valueOf($core.int value) => _byValue[value];

  const MapGestureEvents._($core.int v, $core.String n) : super(v, n);
}

