import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
import 'package:flutter_here_maps/map/map_view.dart';
import 'package:flutter_here_maps/proto_gen/map_objects.pb.dart';
import 'package:flutter_here_maps/proto_gen/map_objects.pbenum.dart' as pref;
import 'package:flutter_here_maps_example/drawer.dart';

enum DialogResult { YES, NO }

class MapCenterPage extends StatefulWidget {
  static const String route = 'map_center';

  @override
  State<StatefulWidget> createState() => _MapCenterPageState();
}

class _MapCenterPageState extends State<MapCenterPage> {
  Completer<HereMapsController> _controller = Completer();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setMapCenter(Coordinate coordinate) async {
    final map = await _controller.future;
    var mapCenter = MapCenter();
    mapCenter.animation = pref.Animation.Bow;
    mapCenter.coordinate = coordinate;
    await map.setCenter(mapCenter);
  }

  final latController = TextEditingController();
  final lngController = TextEditingController();

  Future<Coordinate> _showLocationsDialog() async {
    switch (await showDialog<DialogResult>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleDialog(
              title: Text("Set lat and lng"),
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: "lat"),
                  controller: latController,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(hintText: "lng"),
                  controller: lngController,
                ),
                SimpleDialogOption(
                  child: Text("Yes"),
                  onPressed: () => Navigator.pop(context, DialogResult.YES),
                ),
                SimpleDialogOption(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, DialogResult.NO),
                )
              ],
            ),
          );
        })) {
      case DialogResult.YES:
        return Coordinate()
          ..lat = double.parse(latController.text)
          ..lng = double.parse(lngController.text);

      case DialogResult.NO:
        return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: buildDrawer(context, MapCenterPage.route),
        appBar: AppBar(
          title: const Text('Map center'),
        ),
        body: MapView(
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showLocationsDialog()
              .then((coordinate) => setMapCenter(coordinate)),
          child: Icon(Icons.add_location),
        ),
      ),
    );
  }
}
