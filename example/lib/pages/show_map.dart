import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
import 'package:flutter_here_maps/map/map_view.dart';
import 'package:flutter_here_maps_example/drawer.dart';
import 'package:flutter_here_maps_example/widgets/MapCenterSlidersDialog.dart';

class ShowMapPage extends StatelessWidget {
  static const String route = 'show_map';

  Completer<HereMapsController> _controller = Completer();

  Future<void> _showMapCenterDialog(BuildContext context) async {
    final map = await _controller.future;
    var mapCenter = map.center;
    var result = await showDialog<DialogResult>(
        context: context,
        builder: (BuildContext context) {
          return MapCenterSlidersDialog(
            mapCenter: mapCenter,
          );
        });
    if (result == DialogResult.YES) {
      print(mapCenter.writeToJson());
      map.setCenter(mapCenter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: buildDrawer(context, route),
        appBar: AppBar(
          title: const Text('Here maps'),
        ),
        body: MapView(
          onMapCreated: (contrller) {
            _controller.complete(contrller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showMapCenterDialog(context),
          child: Icon(Icons.map),
        ),
      ),
    );
  }
}
