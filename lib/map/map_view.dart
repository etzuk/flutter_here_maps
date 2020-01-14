import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapView extends StatefulWidget {
  const MapView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MapViewState();
  }
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
          viewType: 'flugins.etzuk.flutter_here_maps/MapView',
          creationParamsCodec: const StandardMessageCodec());
    } else {
      return UiKitView(
          viewType: 'flugins.etzuk.flutter_here_maps/MapView',
          creationParamsCodec: const StandardMessageCodec());
    }
  }
}
