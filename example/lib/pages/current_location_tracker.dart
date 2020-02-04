import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';
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
  LocationReading _currentLocation;
  Completer<HereMapsController> _controller = Completer();

  StreamSubscription<LocationReading> _locationSubscription;

  Location _locationService = new Location();
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
                      configuration.positionIndicator.isVisible =
                          boolValue(change);
                    });
                  },
                  title: new Text('PositionIndicator Visible'),
                ),
                new SwitchListTile(
                  value: configuration
                      .positionIndicator.isAccuracyIndicatorVisible.value,
                  onChanged: (change) {
                    setState(() {
                      configuration.positionIndicator
                          .isAccuracyIndicatorVisible = boolValue(change);
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
        });
    if (result == DialogResult.NO) {
      _initConfiguration();
    }
    return configuration;
  }

  void _setConfiguration(Configuration configuration) async {
    final map = await _controller.future;
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
            MapView(
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
            Text(
              "Lat: ${_currentLocation?.coordinate?.lat}, Lng: ${_currentLocation?.coordinate?.lng}",
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showConfigurationsDialog()
              .then((configuration) => _setConfiguration(configuration)),
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
    return BoolValue()..value = value;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initPlatformState() async {
    if (Platform.isIOS) {
      await oldLocationProvider();
    } else {
      BackgroundLocationPlugin.getLocationUpdates((location) {
        if (mounted) {
          setState(() {
            _currentLocation = location;
          });
        }
      });

      var icon = AndroidIconData()
        ..iconName = "ic_launcher"
        ..iconType = AndroidIconData_Type.MIPMAP;
      var notificationSettings =
          AndroidLocationSettings_LocationNotificationSettings()
            ..channelId = "Location Channel_id"
            ..channelName = "Location Channel"
            ..title = "Location is on"
            ..body = "Thanks for sharing";
      var androidSettings = AndroidLocationSettings()
        ..locationServiceId = 1
        ..locationMethod = AndroidLocationSettings_LocationMethod.GPS_NETWORK
        ..notificationSettings = notificationSettings;

      BackgroundLocationPlugin.startLocationService(androidSettings);
    }
  }

  Future oldLocationProvider() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          _locationSubscription = _locationService
              .onLocationChanged()
              .map((locationData) => locationData.toLocationReading())
              .listen((LocationReading result) async {
            if (_currentLocation == null) {
              final map = await _controller.future;
              map.setCenter(MapCenter()
                ..coordinate = (Coordinate()
                  ..lat = result.coordinate.lat
                  ..lng = result.coordinate.lng)
                ..zoomLevel = (FloatValue()..value = 16));
            }
            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
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

extension LocationDataExtention on LocationData {
  LocationReading toLocationReading() {
    var coordinate = Coordinate()
      ..lat = this.latitude
      ..lng = this.longitude;

    return LocationReading()
      ..coordinate = coordinate
      ..accuracy = this.accuracy
      ..altitude = this.altitude
      ..speed = this.speed
      ..heading = this.heading;
  }
}
