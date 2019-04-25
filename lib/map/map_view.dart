import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatefulWidget {
  /// The center of the map.
  final LatLng center;

  const MapView({Key key, this.center}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MapViewState();
  }
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'initialCameraPosition': widget.center.toString()
    };

    return UiKitView(
        viewType: 'MapView',
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec());
  }
}
