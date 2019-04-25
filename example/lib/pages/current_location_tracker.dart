import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
import 'package:flutter_here_maps/map/map_view.dart';
import 'package:flutter_here_maps/gen/map_objects.pb.dart';
import 'package:flutter_here_maps_example/drawer.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter_here_maps_example/widgets/MapCenterSlidersDialog.dart';

class CurrentLocationTrackerPage extends StatefulWidget {

  static const String route = 'current_location_tracker';

  @override
  State<StatefulWidget> createState() => _CurrentLocationTrackerState();

}

class _CurrentLocationTrackerState extends State<CurrentLocationTrackerPage> {

  static const String route = 'current_location_tracker';
  var configuration;
  LocationData _currentLocation;

  FlutterHereMaps map = FlutterHereMaps();

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  @override
  void initState() {
    _initPlatformState();
    _initConfiguration();
    super.initState();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  Future<Configuration> _showConfigurationsDialog() async {
    var result = await showDialog<DialogResult>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleDialog(
              title: Text("Set configuration"),
              children: <Widget>[
                new SwitchListTile(
                  value: configuration.positionIndicator.isVisible.value,
                  onChanged: (change) {
                    setState(() {
                      configuration.positionIndicator.isVisible = boolValue(change);
                    });
                  },
                  title: new Text('PositionIndicator Visible'),
                ),
                new SwitchListTile(
                  value: configuration.positionIndicator.isAccuracyIndicatorVisible.value,
                  onChanged: (change) {
                    setState(() {
                      configuration.positionIndicator.isAccuracyIndicatorVisible = boolValue(change);
                    });
                  },
                  title: new Text('Accuracy Visible'),
                ),
                new SwitchListTile(
                  value: configuration.trafficVisible,
                  onChanged: (change) {
                    setState(() {
                      configuration.trafficVisible = change;
                    });
                  },
                  title: new Text('Traffic Visible'),
                ),
                SimpleDialogOption(
                  child: Text("Set"),
                  onPressed: () => Navigator.pop(context, DialogResult.YES),
                ),
                SimpleDialogOption(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context, DialogResult.NO),
                )
              ],
            ),
          );
        }
    );
    if (result == DialogResult.NO) {
      _initConfiguration();
    }
    return configuration;
  }

  void _setConfiguration(Configuration configuration) async {
      await map.setConfiguration(configuration);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: buildDrawer(context, route),
        appBar: AppBar(
          title: const Text('Map center'),
        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            MapView(),
            Text("Lat: ${_currentLocation?.latitude}, Lng: ${_currentLocation?.longitude}",
              style: TextStyle(color: Colors.red), textAlign: TextAlign.center,)
            ,
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showConfigurationsDialog()
              .then( (configuration) => _setConfiguration(configuration)),
          child: Icon(Icons.settings),
        ),
      ),
    );
  }

  void _initConfiguration() {
    configuration = Configuration()
      ..trafficVisible = false
      ..positionIndicator = (Configuration_PositionIndicator()
        ..isAccuracyIndicatorVisible = boolValue(true)
        ..isVisible = boolValue(true));
    _setConfiguration(configuration);
  }

  BoolValue boolValue(bool value) {
    return BoolValue()
        ..value = value;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initPlatformState() async {
    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {
            if (_currentLocation == null) {
              map.setCenter(
                  MapCenter()
                    ..coordinate = (
                        Coordinate()
                          ..lat = result.latitude
                          ..lng = result.longitude
                    )
                    ..zoomLevel = (FloatValue()..value = 16)
              );
            }
            if(mounted){
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if(serviceStatusResult){
          _initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
    }
  }

}
