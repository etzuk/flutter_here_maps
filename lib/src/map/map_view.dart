import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../flutter_here_maps.dart';
import 'here_map_contorller.dart';
import '../proto_gen/map_objects.pb.dart';

typedef void MapCreatedCallback(HereMapsController controller);
typedef PointCallback = void Function(PointF point);
typedef PinchCallback = void Function(PointF point, double pinch);
typedef RotationCallback = void Function(double rotate);

class MapView extends StatefulWidget {
  const MapView({
    Key key,
    this.onMapCreated,
    this.initialMapCenter,
    this.initialMapConfiguration,
    this.onTap,
    this.onLongPress,
    this.onPinch,
    this.onTwoFingerTap,
    this.onDoubleTap,
    this.onPan,
    this.onRotation,
    this.onTwoFingerPan,
  }) : super(key: key);

  final MapCreatedCallback onMapCreated;
  final MapCenter initialMapCenter;
  final Configuration initialMapConfiguration;
  final VoidCallback onTwoFingerPan;
  final VoidCallback onPan;
  final PointCallback onTap;
  final PointCallback onLongPress;
  final PinchCallback onPinch;
  final PointCallback onTwoFingerTap;
  final PointCallback onDoubleTap;
  final RotationCallback onRotation;

  @override
  State<StatefulWidget> createState() {
    return _MapViewState();
  }
}

abstract class MapViewGestures {
  onMapGestureEventReceived(MapGestureEvents mapViewGestures);
  onMapGestureEventDateReceived(MapGesture mapGesture);
}

class _MapViewState extends State<MapView> with MapViewGestures {
  MapCenter get _initialMapCenter => widget.initialMapCenter ?? MapCenter()
    ..zoomLevel = (FloatValue()..value = 17.0)
    ..orientation = (FloatValue()..value = 0.0)
    ..tilt = (FloatValue()..value = 0.0);

  Configuration get _initialMapConfiguration =>
      widget.initialMapConfiguration ?? Configuration()
        ..trafficVisible = false
        ..positionIndicator = (Configuration_PositionIndicator()
          ..isVisible = (BoolValue()..value = true));

  final Completer<HereMapsController> _controller =
      Completer<HereMapsController>();
  @override
  Widget build(BuildContext context) {
    InitMapConfigutation mapConfigutation = _mapConfiguration();

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'flugins.etzuk.flutter_here_maps/MapView',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: ByteData.view(mapConfigutation.writeToBuffer().buffer),
        creationParamsCodec: const BinaryCodec(),
      );
    } else {
      return UiKitView(
          viewType: 'flugins.etzuk.flutter_here_maps/MapView',
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams:
              ByteData.view(mapConfigutation.writeToBuffer().buffer),
          creationParamsCodec: const BinaryCodec());
    }
  }

  InitMapConfigutation _mapConfiguration() {
    return InitMapConfigutation()
      ..initialMapCenter = _initialMapCenter
      ..configuration = _initialMapConfiguration
      ..gestureDoubleTapEnable = widget.onDoubleTap != null
      ..gestureLongPressEnable = widget.onLongPress != null
      ..gesturePanEnable = widget.onPan != null
      ..gesturePinchEnable = widget.onPinch != null
      ..gestureRotationEnable = widget.onRotation != null
      ..gestureTapEnable = widget.onTap != null
      ..gestureTwoFingerPanEnable = widget.onTwoFingerPan != null
      ..gestureTwoFingerTapEnable = widget.onTwoFingerTap != null;
  }

  Future<void> onPlatformViewCreated(int id) async {
    final HereMapsController controller = await HereMapsController.init(
      id: id,
      mapViewGestures: this,
    );
    _controller.complete(controller);
    if (widget.onMapCreated != null) {
      widget.onMapCreated(controller);
    }
  }

  @override
  onMapGestureEventReceived(MapGestureEvents mapViewGestures) {
    var function;
    switch (mapViewGestures) {
      case MapGestureEvents.OnPanEnd:
        function = widget.onPan;
        break;
      case MapGestureEvents.OnMultiFingerManipulationEnd:
        function = widget.onTwoFingerPan;
        break;
      default:
    }
    if (function != null) {
      function();
    }
  }

  onMapGestureEventDateReceived(MapGesture mapGesture) {
    if (mapGesture.hasTapEvent()) {
      widget.onTap(mapGesture.tapEvent.point);
    }
    if (mapGesture.hasLongPressEvent()) {
      widget.onLongPress(mapGesture.longPressEvent.point);
    }
    if (mapGesture.hasPinchZoom()) {
      widget.onPinch(mapGesture.pinchZoom.point, mapGesture.pinchZoom.zoom);
    }
    if (mapGesture.hasTwoFingerTap()) {
      widget.onTwoFingerTap(mapGesture.twoFingerTap.point);
    }
    if (mapGesture.hasDoubleTap()) {
      widget.onDoubleTap(mapGesture.doubleTap.point);
    }
    if (mapGesture.hasRotate()) {
      widget.onRotation(mapGesture.rotate.rotate);
    }
  }
}
