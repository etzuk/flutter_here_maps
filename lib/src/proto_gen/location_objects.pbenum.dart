///
//  Generated code. Do not modify.
//  source: location_objects.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class AndroidLocationSettings_LocationMethod extends $pb.ProtobufEnum {
  static const AndroidLocationSettings_LocationMethod NONE = AndroidLocationSettings_LocationMethod._(0, 'NONE');
  static const AndroidLocationSettings_LocationMethod GPS = AndroidLocationSettings_LocationMethod._(1, 'GPS');
  static const AndroidLocationSettings_LocationMethod NETWORK = AndroidLocationSettings_LocationMethod._(2, 'NETWORK');
  static const AndroidLocationSettings_LocationMethod GPS_NETWORK = AndroidLocationSettings_LocationMethod._(3, 'GPS_NETWORK');
  static const AndroidLocationSettings_LocationMethod GPS_NETWORK_INDOOR = AndroidLocationSettings_LocationMethod._(4, 'GPS_NETWORK_INDOOR');
  static const AndroidLocationSettings_LocationMethod INDOOR = AndroidLocationSettings_LocationMethod._(5, 'INDOOR');

  static const $core.List<AndroidLocationSettings_LocationMethod> values = <AndroidLocationSettings_LocationMethod> [
    NONE,
    GPS,
    NETWORK,
    GPS_NETWORK,
    GPS_NETWORK_INDOOR,
    INDOOR,
  ];

  static final $core.Map<$core.int, AndroidLocationSettings_LocationMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AndroidLocationSettings_LocationMethod valueOf($core.int value) => _byValue[value];

  const AndroidLocationSettings_LocationMethod._($core.int v, $core.String n) : super(v, n);
}

