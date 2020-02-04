///
//  Generated code. Do not modify.
//  source: location_objects.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'map_objects.pb.dart' as $0;

import 'location_objects.pbenum.dart';

export 'location_objects.pbenum.dart';

class LocationReading extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LocationReading', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..aOM<$0.Coordinate>(1, 'coordinate', subBuilder: $0.Coordinate.create)
    ..a<$core.double>(3, 'altitude', $pb.PbFieldType.OD)
    ..a<$core.double>(4, 'heading', $pb.PbFieldType.OD)
    ..a<$core.double>(5, 'accuracy', $pb.PbFieldType.OD)
    ..a<$core.double>(6, 'speed', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  LocationReading._() : super();
  factory LocationReading() => create();
  factory LocationReading.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LocationReading.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LocationReading clone() => LocationReading()..mergeFromMessage(this);
  LocationReading copyWith(void Function(LocationReading) updates) => super.copyWith((message) => updates(message as LocationReading));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LocationReading create() => LocationReading._();
  LocationReading createEmptyInstance() => create();
  static $pb.PbList<LocationReading> createRepeated() => $pb.PbList<LocationReading>();
  @$core.pragma('dart2js:noInline')
  static LocationReading getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LocationReading>(create);
  static LocationReading _defaultInstance;

  @$pb.TagNumber(1)
  $0.Coordinate get coordinate => $_getN(0);
  @$pb.TagNumber(1)
  set coordinate($0.Coordinate v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCoordinate() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoordinate() => clearField(1);
  @$pb.TagNumber(1)
  $0.Coordinate ensureCoordinate() => $_ensure(0);

  @$pb.TagNumber(3)
  $core.double get altitude => $_getN(1);
  @$pb.TagNumber(3)
  set altitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasAltitude() => $_has(1);
  @$pb.TagNumber(3)
  void clearAltitude() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get heading => $_getN(2);
  @$pb.TagNumber(4)
  set heading($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasHeading() => $_has(2);
  @$pb.TagNumber(4)
  void clearHeading() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get accuracy => $_getN(3);
  @$pb.TagNumber(5)
  set accuracy($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccuracy() => $_has(3);
  @$pb.TagNumber(5)
  void clearAccuracy() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get speed => $_getN(4);
  @$pb.TagNumber(6)
  set speed($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasSpeed() => $_has(4);
  @$pb.TagNumber(6)
  void clearSpeed() => clearField(6);
}

class AndroidIconData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AndroidIconData', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..aOS(1, 'iconName')
    ..e<AndroidIconData_Type>(2, 'iconType', $pb.PbFieldType.OE, defaultOrMaker: AndroidIconData_Type.UNKNOWN, valueOf: AndroidIconData_Type.valueOf, enumValues: AndroidIconData_Type.values)
    ..hasRequiredFields = false
  ;

  AndroidIconData._() : super();
  factory AndroidIconData() => create();
  factory AndroidIconData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AndroidIconData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AndroidIconData clone() => AndroidIconData()..mergeFromMessage(this);
  AndroidIconData copyWith(void Function(AndroidIconData) updates) => super.copyWith((message) => updates(message as AndroidIconData));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AndroidIconData create() => AndroidIconData._();
  AndroidIconData createEmptyInstance() => create();
  static $pb.PbList<AndroidIconData> createRepeated() => $pb.PbList<AndroidIconData>();
  @$core.pragma('dart2js:noInline')
  static AndroidIconData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AndroidIconData>(create);
  static AndroidIconData _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iconName => $_getSZ(0);
  @$pb.TagNumber(1)
  set iconName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIconName() => $_has(0);
  @$pb.TagNumber(1)
  void clearIconName() => clearField(1);

  @$pb.TagNumber(2)
  AndroidIconData_Type get iconType => $_getN(1);
  @$pb.TagNumber(2)
  set iconType(AndroidIconData_Type v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasIconType() => $_has(1);
  @$pb.TagNumber(2)
  void clearIconType() => clearField(2);
}

class AndroidLocationSettings_LocationNotificationSettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AndroidLocationSettings.LocationNotificationSettings', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..aOS(1, 'channelId')
    ..aOS(2, 'channelName')
    ..aOS(3, 'title')
    ..aOS(4, 'body')
    ..aOM<AndroidIconData>(5, 'iconData', subBuilder: AndroidIconData.create)
    ..hasRequiredFields = false
  ;

  AndroidLocationSettings_LocationNotificationSettings._() : super();
  factory AndroidLocationSettings_LocationNotificationSettings() => create();
  factory AndroidLocationSettings_LocationNotificationSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AndroidLocationSettings_LocationNotificationSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AndroidLocationSettings_LocationNotificationSettings clone() => AndroidLocationSettings_LocationNotificationSettings()..mergeFromMessage(this);
  AndroidLocationSettings_LocationNotificationSettings copyWith(void Function(AndroidLocationSettings_LocationNotificationSettings) updates) => super.copyWith((message) => updates(message as AndroidLocationSettings_LocationNotificationSettings));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AndroidLocationSettings_LocationNotificationSettings create() => AndroidLocationSettings_LocationNotificationSettings._();
  AndroidLocationSettings_LocationNotificationSettings createEmptyInstance() => create();
  static $pb.PbList<AndroidLocationSettings_LocationNotificationSettings> createRepeated() => $pb.PbList<AndroidLocationSettings_LocationNotificationSettings>();
  @$core.pragma('dart2js:noInline')
  static AndroidLocationSettings_LocationNotificationSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AndroidLocationSettings_LocationNotificationSettings>(create);
  static AndroidLocationSettings_LocationNotificationSettings _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelName => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelName() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get body => $_getSZ(3);
  @$pb.TagNumber(4)
  set body($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBody() => $_has(3);
  @$pb.TagNumber(4)
  void clearBody() => clearField(4);

  @$pb.TagNumber(5)
  AndroidIconData get iconData => $_getN(4);
  @$pb.TagNumber(5)
  set iconData(AndroidIconData v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasIconData() => $_has(4);
  @$pb.TagNumber(5)
  void clearIconData() => clearField(5);
  @$pb.TagNumber(5)
  AndroidIconData ensureIconData() => $_ensure(4);
}

class AndroidLocationSettings extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AndroidLocationSettings', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..aOM<AndroidLocationSettings_LocationNotificationSettings>(1, 'notificationSettings', subBuilder: AndroidLocationSettings_LocationNotificationSettings.create)
    ..e<AndroidLocationSettings_LocationMethod>(2, 'locationMethod', $pb.PbFieldType.OE, defaultOrMaker: AndroidLocationSettings_LocationMethod.NONE, valueOf: AndroidLocationSettings_LocationMethod.valueOf, enumValues: AndroidLocationSettings_LocationMethod.values)
    ..a<$core.int>(3, 'locationServiceId', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AndroidLocationSettings._() : super();
  factory AndroidLocationSettings() => create();
  factory AndroidLocationSettings.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AndroidLocationSettings.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  AndroidLocationSettings clone() => AndroidLocationSettings()..mergeFromMessage(this);
  AndroidLocationSettings copyWith(void Function(AndroidLocationSettings) updates) => super.copyWith((message) => updates(message as AndroidLocationSettings));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AndroidLocationSettings create() => AndroidLocationSettings._();
  AndroidLocationSettings createEmptyInstance() => create();
  static $pb.PbList<AndroidLocationSettings> createRepeated() => $pb.PbList<AndroidLocationSettings>();
  @$core.pragma('dart2js:noInline')
  static AndroidLocationSettings getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AndroidLocationSettings>(create);
  static AndroidLocationSettings _defaultInstance;

  @$pb.TagNumber(1)
  AndroidLocationSettings_LocationNotificationSettings get notificationSettings => $_getN(0);
  @$pb.TagNumber(1)
  set notificationSettings(AndroidLocationSettings_LocationNotificationSettings v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNotificationSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationSettings() => clearField(1);
  @$pb.TagNumber(1)
  AndroidLocationSettings_LocationNotificationSettings ensureNotificationSettings() => $_ensure(0);

  @$pb.TagNumber(2)
  AndroidLocationSettings_LocationMethod get locationMethod => $_getN(1);
  @$pb.TagNumber(2)
  set locationMethod(AndroidLocationSettings_LocationMethod v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocationMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocationMethod() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get locationServiceId => $_getIZ(2);
  @$pb.TagNumber(3)
  set locationServiceId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocationServiceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocationServiceId() => clearField(3);
}

