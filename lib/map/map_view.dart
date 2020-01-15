import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';

typedef void MapCreatedCallback(HereMapsController controller);

class MapView extends StatefulWidget {
  const MapView({
    Key key,
    this.onMapCreated,
  }) : super(key: key);
  final MapCreatedCallback onMapCreated;
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
          creationParamsCodec: const StandardMessageCodec());
    } else {
      return UiKitView(
          viewType: 'flugins.etzuk.flutter_here_maps/MapView',
          onPlatformViewCreated: onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec());
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
