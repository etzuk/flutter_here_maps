///
//  Generated code. Do not modify.
//  source: map_channel.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'map_objects.pb.dart' as $0;

enum MapChannelRequest_Object {
  setCenter, 
  setConfiguration, 
  zoomTo, 
  setMapObject, 
  notSet
}

class MapChannelRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, MapChannelRequest_Object> _MapChannelRequest_ObjectByTag = {
    1 : MapChannelRequest_Object.setCenter,
    2 : MapChannelRequest_Object.setConfiguration,
    3 : MapChannelRequest_Object.zoomTo,
    20 : MapChannelRequest_Object.setMapObject,
    0 : MapChannelRequest_Object.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapChannelRequest', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 20])
    ..aOM<$0.MapCenter>(1, 'setCenter', protoName: 'setCenter', subBuilder: $0.MapCenter.create)
    ..aOM<$0.Configuration>(2, 'setConfiguration', protoName: 'setConfiguration', subBuilder: $0.Configuration.create)
    ..aOM<$0.ZoomTo>(3, 'zoomTo', protoName: 'zoomTo', subBuilder: $0.ZoomTo.create)
    ..aOM<$0.MapObject>(20, 'setMapObject', protoName: 'setMapObject', subBuilder: $0.MapObject.create)
    ..hasRequiredFields = false
  ;

  MapChannelRequest._() : super();
  factory MapChannelRequest() => create();
  factory MapChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapChannelRequest clone() => MapChannelRequest()..mergeFromMessage(this);
  MapChannelRequest copyWith(void Function(MapChannelRequest) updates) => super.copyWith((message) => updates(message as MapChannelRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapChannelRequest create() => MapChannelRequest._();
  MapChannelRequest createEmptyInstance() => create();
  static $pb.PbList<MapChannelRequest> createRepeated() => $pb.PbList<MapChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static MapChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapChannelRequest>(create);
  static MapChannelRequest _defaultInstance;

  MapChannelRequest_Object whichObject() => _MapChannelRequest_ObjectByTag[$_whichOneof(0)];
  void clearObject() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.MapCenter get setCenter => $_getN(0);
  @$pb.TagNumber(1)
  set setCenter($0.MapCenter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSetCenter() => $_has(0);
  @$pb.TagNumber(1)
  void clearSetCenter() => clearField(1);
  @$pb.TagNumber(1)
  $0.MapCenter ensureSetCenter() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.Configuration get setConfiguration => $_getN(1);
  @$pb.TagNumber(2)
  set setConfiguration($0.Configuration v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetConfiguration() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetConfiguration() => clearField(2);
  @$pb.TagNumber(2)
  $0.Configuration ensureSetConfiguration() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.ZoomTo get zoomTo => $_getN(2);
  @$pb.TagNumber(3)
  set zoomTo($0.ZoomTo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasZoomTo() => $_has(2);
  @$pb.TagNumber(3)
  void clearZoomTo() => clearField(3);
  @$pb.TagNumber(3)
  $0.ZoomTo ensureZoomTo() => $_ensure(2);

  @$pb.TagNumber(20)
  $0.MapObject get setMapObject => $_getN(3);
  @$pb.TagNumber(20)
  set setMapObject($0.MapObject v) { setField(20, v); }
  @$pb.TagNumber(20)
  $core.bool hasSetMapObject() => $_has(3);
  @$pb.TagNumber(20)
  void clearSetMapObject() => clearField(20);
  @$pb.TagNumber(20)
  $0.MapObject ensureSetMapObject() => $_ensure(3);
}

enum MapChannelReplay_Object {
  getCenter, 
  mapGesture, 
  notSet
}

class MapChannelReplay extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, MapChannelReplay_Object> _MapChannelReplay_ObjectByTag = {
    1 : MapChannelReplay_Object.getCenter,
    2 : MapChannelReplay_Object.mapGesture,
    0 : MapChannelReplay_Object.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MapChannelReplay', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<$0.MapCenter>(1, 'getCenter', protoName: 'getCenter', subBuilder: $0.MapCenter.create)
    ..aOM<$0.MapGesture>(2, 'mapGesture', protoName: 'mapGesture', subBuilder: $0.MapGesture.create)
    ..hasRequiredFields = false
  ;

  MapChannelReplay._() : super();
  factory MapChannelReplay() => create();
  factory MapChannelReplay.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MapChannelReplay.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MapChannelReplay clone() => MapChannelReplay()..mergeFromMessage(this);
  MapChannelReplay copyWith(void Function(MapChannelReplay) updates) => super.copyWith((message) => updates(message as MapChannelReplay));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MapChannelReplay create() => MapChannelReplay._();
  MapChannelReplay createEmptyInstance() => create();
  static $pb.PbList<MapChannelReplay> createRepeated() => $pb.PbList<MapChannelReplay>();
  @$core.pragma('dart2js:noInline')
  static MapChannelReplay getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapChannelReplay>(create);
  static MapChannelReplay _defaultInstance;

  MapChannelReplay_Object whichObject() => _MapChannelReplay_ObjectByTag[$_whichOneof(0)];
  void clearObject() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $0.MapCenter get getCenter => $_getN(0);
  @$pb.TagNumber(1)
  set getCenter($0.MapCenter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGetCenter() => $_has(0);
  @$pb.TagNumber(1)
  void clearGetCenter() => clearField(1);
  @$pb.TagNumber(1)
  $0.MapCenter ensureGetCenter() => $_ensure(0);

  @$pb.TagNumber(2)
  $0.MapGesture get mapGesture => $_getN(1);
  @$pb.TagNumber(2)
  set mapGesture($0.MapGesture v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMapGesture() => $_has(1);
  @$pb.TagNumber(2)
  void clearMapGesture() => clearField(2);
  @$pb.TagNumber(2)
  $0.MapGesture ensureMapGesture() => $_ensure(1);
}

class InitMapConfigutation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InitMapConfigutation', package: const $pb.PackageName('FlutterHereMaps'), createEmptyInstance: create)
    ..aOM<$0.MapCenter>(1, 'initialMapCenter', protoName: 'initialMapCenter', subBuilder: $0.MapCenter.create)
    ..aOB(10, 'gestureTapEnable', protoName: 'gestureTapEnable')
    ..aOB(11, 'gestureLongPressEnable', protoName: 'gestureLongPressEnable')
    ..aOB(12, 'gesturePinchEnable', protoName: 'gesturePinchEnable')
    ..aOB(13, 'gestureTwoFingerTapEnable', protoName: 'gestureTwoFingerTapEnable')
    ..aOB(14, 'gestureDoubleTapEnable', protoName: 'gestureDoubleTapEnable')
    ..aOB(15, 'gesturePanEnable', protoName: 'gesturePanEnable')
    ..aOB(16, 'gestureRotationEnable', protoName: 'gestureRotationEnable')
    ..aOB(17, 'gestureTwoFingerPanEnable', protoName: 'gestureTwoFingerPanEnable')
    ..hasRequiredFields = false
  ;

  InitMapConfigutation._() : super();
  factory InitMapConfigutation() => create();
  factory InitMapConfigutation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitMapConfigutation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InitMapConfigutation clone() => InitMapConfigutation()..mergeFromMessage(this);
  InitMapConfigutation copyWith(void Function(InitMapConfigutation) updates) => super.copyWith((message) => updates(message as InitMapConfigutation));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitMapConfigutation create() => InitMapConfigutation._();
  InitMapConfigutation createEmptyInstance() => create();
  static $pb.PbList<InitMapConfigutation> createRepeated() => $pb.PbList<InitMapConfigutation>();
  @$core.pragma('dart2js:noInline')
  static InitMapConfigutation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitMapConfigutation>(create);
  static InitMapConfigutation _defaultInstance;

  @$pb.TagNumber(1)
  $0.MapCenter get initialMapCenter => $_getN(0);
  @$pb.TagNumber(1)
  set initialMapCenter($0.MapCenter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInitialMapCenter() => $_has(0);
  @$pb.TagNumber(1)
  void clearInitialMapCenter() => clearField(1);
  @$pb.TagNumber(1)
  $0.MapCenter ensureInitialMapCenter() => $_ensure(0);

  @$pb.TagNumber(10)
  $core.bool get gestureTapEnable => $_getBF(1);
  @$pb.TagNumber(10)
  set gestureTapEnable($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(10)
  $core.bool hasGestureTapEnable() => $_has(1);
  @$pb.TagNumber(10)
  void clearGestureTapEnable() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get gestureLongPressEnable => $_getBF(2);
  @$pb.TagNumber(11)
  set gestureLongPressEnable($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(11)
  $core.bool hasGestureLongPressEnable() => $_has(2);
  @$pb.TagNumber(11)
  void clearGestureLongPressEnable() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get gesturePinchEnable => $_getBF(3);
  @$pb.TagNumber(12)
  set gesturePinchEnable($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(12)
  $core.bool hasGesturePinchEnable() => $_has(3);
  @$pb.TagNumber(12)
  void clearGesturePinchEnable() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get gestureTwoFingerTapEnable => $_getBF(4);
  @$pb.TagNumber(13)
  set gestureTwoFingerTapEnable($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(13)
  $core.bool hasGestureTwoFingerTapEnable() => $_has(4);
  @$pb.TagNumber(13)
  void clearGestureTwoFingerTapEnable() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get gestureDoubleTapEnable => $_getBF(5);
  @$pb.TagNumber(14)
  set gestureDoubleTapEnable($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(14)
  $core.bool hasGestureDoubleTapEnable() => $_has(5);
  @$pb.TagNumber(14)
  void clearGestureDoubleTapEnable() => clearField(14);

  @$pb.TagNumber(15)
  $core.bool get gesturePanEnable => $_getBF(6);
  @$pb.TagNumber(15)
  set gesturePanEnable($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(15)
  $core.bool hasGesturePanEnable() => $_has(6);
  @$pb.TagNumber(15)
  void clearGesturePanEnable() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get gestureRotationEnable => $_getBF(7);
  @$pb.TagNumber(16)
  set gestureRotationEnable($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(16)
  $core.bool hasGestureRotationEnable() => $_has(7);
  @$pb.TagNumber(16)
  void clearGestureRotationEnable() => clearField(16);

  @$pb.TagNumber(17)
  $core.bool get gestureTwoFingerPanEnable => $_getBF(8);
  @$pb.TagNumber(17)
  set gestureTwoFingerPanEnable($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(17)
  $core.bool hasGestureTwoFingerPanEnable() => $_has(8);
  @$pb.TagNumber(17)
  void clearGestureTwoFingerPanEnable() => clearField(17);
}

