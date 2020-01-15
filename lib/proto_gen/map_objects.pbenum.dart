///
//  Generated code. Do not modify.
//  source: map_objects.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MapCenter_Animation extends $pb.ProtobufEnum {
  static const MapCenter_Animation Bow = MapCenter_Animation._(0, 'Bow');
  static const MapCenter_Animation Linear = MapCenter_Animation._(1, 'Linear');
  static const MapCenter_Animation None = MapCenter_Animation._(2, 'None');
  static const MapCenter_Animation Rocket = MapCenter_Animation._(3, 'Rocket');

  static const $core.List<MapCenter_Animation> values = <MapCenter_Animation> [
    Bow,
    Linear,
    None,
    Rocket,
  ];

  static final $core.Map<$core.int, MapCenter_Animation> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MapCenter_Animation valueOf($core.int value) => _byValue[value];

  const MapCenter_Animation._($core.int v, $core.String n) : super(v, n);
}

