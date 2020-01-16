import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
import 'package:flutter_here_maps/proto_gen/map_objects.pb.dart';

typedef void MapCreatedCallback(HereMapsController controller);

class MapView extends StatefulWidget {
  const MapView({
    Key key,
    this.onMapCreated,
    this.initialMapCenter,
  }) : super(key: key);
  final MapCreatedCallback onMapCreated;
  final MapCenter initialMapCenter;
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
    final Map<String, String> creationParams = <String, String>{
      'initialMapCenter': widget.initialMapCenter.writeToJson(),
    };
    print(creationParams);
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'flugins.etzuk.flutter_here_maps/MapView',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams:
            ByteData.view(widget.initialMapCenter.writeToBuffer().buffer),
        creationParamsCodec: const BinaryCodec(),
      );
    } else {
      return UiKitView(
          viewType: 'flugins.etzuk.flutter_here_maps/MapView',
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams:
              ByteData.view(widget.initialMapCenter.writeToBuffer().buffer),
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
