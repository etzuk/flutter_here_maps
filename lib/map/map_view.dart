import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_here_maps/proto_gen/map_objects.pb.dart';

import 'here_map_contorller.dart';

typedef void MapCreatedCallback(HereMapsController controller);

class MapView extends StatefulWidget {
  const MapView({
    Key key,
    this.onMapCreated,
    this.initialMapCenter,
  }) : super(key: key);

  final MapCreatedCallback onMapCreated;
  final MapCenter initialMapCenter;
  MapCenter get _initialMapCenter => initialMapCenter ?? MapCenter()
    ..zoomLevel = (FloatValue()..value = 17.0)
    ..orientation = (FloatValue()..value = 0.0)
    ..tilt = (FloatValue()..value = 0.0);

  @override
  State<StatefulWidget> createState() {
    return _MapViewState();
  }
}

class _MapViewState extends State<MapView> {
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
    );
    _controller.complete(controller);
    if (widget.onMapCreated != null) {
      widget.onMapCreated(controller);
    }
  }
}
