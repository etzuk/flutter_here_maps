import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'here_map_contorller.dart';
import '../proto_gen/map_objects.pb.dart';

typedef void MapCreatedCallback(HereMapsController controller);

class MapView extends StatefulWidget {
  const MapView({
    Key key,
    this.onMapCreated,
    this.initialMapCenter,
    this.onLongPressRelease,
    this.onMultiFingerManipulationStart,
    this.onPinchLocked,
    this.onPanStart,
    this.onMultiFingerManipulationEnd,
    this.onPanEnd,
    this.onRotateLocked,
  }) : super(key: key);

  final MapCreatedCallback onMapCreated;
  final MapCenter initialMapCenter;

  final VoidCallback onLongPressRelease;
  final VoidCallback onMultiFingerManipulationStart;
  final VoidCallback onPinchLocked;
  final VoidCallback onPanStart;
  final VoidCallback onMultiFingerManipulationEnd;
  final VoidCallback onPanEnd;
  final VoidCallback onRotateLocked;

  MapCenter get _initialMapCenter => initialMapCenter ?? MapCenter()
    ..zoomLevel = (FloatValue()..value = 17.0)
    ..orientation = (FloatValue()..value = 0.0)
    ..tilt = (FloatValue()..value = 0.0);

  @override
  State<StatefulWidget> createState() {
    return _MapViewState();
  }
}

abstract class MapViewGestures {
  onMapGestureEventReceived(MapGestureEvents mapViewGestures);
}

class _MapViewState extends State<MapView> with MapViewGestures {
  final Completer<HereMapsController> _controller =
      Completer<HereMapsController>();
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'flugins.etzuk.flutter_here_maps/MapView',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams:
            ByteData.view(widget._initialMapCenter.writeToBuffer().buffer),
        creationParamsCodec: const BinaryCodec(),
      );
    } else {
      return UiKitView(
          viewType: 'flugins.etzuk.flutter_here_maps/MapView',
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams:
              ByteData.view(widget._initialMapCenter.writeToBuffer().buffer),
          creationParamsCodec: const BinaryCodec());
    }
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
      case MapGestureEvents.OnLongPressRelease:
        function = widget.onLongPressRelease;
        break;
      case MapGestureEvents.OnMultiFingerManipulationEnd:
        function = widget.onMultiFingerManipulationEnd;
        break;
      case MapGestureEvents.OnMultiFingerManipulationStart:
        function = widget.onMultiFingerManipulationStart;
        break;
      case MapGestureEvents.OnPanEnd:
        function = widget.onPanEnd;
        break;
      case MapGestureEvents.OnPanStart:
        function = widget.onPanStart;
        break;
      case MapGestureEvents.OnLongPressRelease:
        function = widget.onLongPressRelease;
        break;
      case MapGestureEvents.OnRotateLocked:
        function = widget.onRotateLocked;
        break;
      default:
    }
    if (function != null) {
      function();
    }
  }
}
