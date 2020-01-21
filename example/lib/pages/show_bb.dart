import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter_here_maps/flutter_here_maps.dart';

import '../drawer.dart';

class _ShowBBPaddingFactorDialog extends StatefulWidget {
  @override
  _ShowBBPaddingFactorDialogState createState() =>
      _ShowBBPaddingFactorDialogState();
}

class _ShowBBPaddingFactorDialogState
    extends State<_ShowBBPaddingFactorDialog> {
  double paddingFactor = 10;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Please set padding factor"),
      children: <Widget>[
        Text("$paddingFactor"),
        Slider(
          value: paddingFactor,
          onChanged: (change) {
            setState(() {
              paddingFactor = change;
            });
          },
          min: 10,
          max: 50,
        ),
        SimpleDialogOption(
          child: Text("Yes"),
          onPressed: () => Navigator.pop(context, paddingFactor),
        ),
      ],
    );
  }
}

class ShowBB extends StatefulWidget {
  static const route = "/showBB";
  @override
  _ShowBBState createState() => _ShowBBState();
}

class _ShowBBState extends State<ShowBB> {
  Completer<HereMapsController> completer = Completer();

  @override
  void initState() {
    _showBB(_Data.points);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var result = await showDialog(
            context: context,
            builder: (context) {
              return _ShowBBPaddingFactorDialog();
            });

        _showBBWithFactor(_Data.points, result / 100);
      }),
      appBar: AppBar(title: Text("Show Bounding box")),
      drawer: buildDrawer(context, ShowBB.route),
      body: MapView(
        onMapCreated: (controller) {
          completer.complete(controller);
        },
      ),
    );
  }

  _showBBWithFactor(List<Coordinate> coordinates, double paddintFactor) async {
    final mapController = await completer.future;
    await mapController.zoomTo(ZoomTo()
      ..coordinates.addAll(coordinates)
      ..paddingFactor = (FloatValue()..value = paddintFactor));

    coordinates.forEach((coordinate) {
      mapController.setMapObject(MapObject()
        ..uniqueId = "${coordinate.lat}"
        ..marker = (MapMarker()
          ..coordinate = coordinate
          ..image = "assets/group_2.png"));
    });
  }

  _showBB(List<Coordinate> coordinates) async {
    final mapController = await completer.future;
    await mapController.zoomTo(ZoomTo()..coordinates.addAll(coordinates));

    coordinates.forEach((coordinate) {
      mapController.setMapObject(MapObject()
        ..uniqueId = "${coordinate.lat}"
        ..marker = (MapMarker()
          ..coordinate = coordinate
          ..image = "assets/group_2.png"));
    });
  }
}

class _Data {
  static final points = <Coordinate>[
    Coordinate()
      ..lng = 34.773963928222656
      ..lat = 32.06356430053711,
    Coordinate()
      ..lng = 34.773963928222656
      ..lat = 32.06356430053711,
    Coordinate()
      ..lng = 34.77452087402344
      ..lat = 32.063934326171875,
    Coordinate()
      ..lng = 34.77452087402344
      ..lat = 32.063934326171875,
    Coordinate()
      ..lng = 34.77520751953125
      ..lat = 32.06439208984375,
    Coordinate()
      ..lng = 34.77520751953125
      ..lat = 32.06439208984375,
    Coordinate()
      ..lng = 34.77600860595703
      ..lat = 32.06492614746094,
    Coordinate()
      ..lng = 34.77600860595703
      ..lat = 32.06492614746094,
    Coordinate()
      ..lng = 34.77667999267578
      ..lat = 32.065372467041016,
    Coordinate()
      ..lng = 34.77667999267578
      ..lat = 32.065372467041016,
    Coordinate()
      ..lng = 34.77735137939453
      ..lat = 32.06582260131836,
    Coordinate()
      ..lng = 34.77735137939453
      ..lat = 32.06582260131836,
    Coordinate()
      ..lng = 34.77752685546875
      ..lat = 32.06623458862305,
    Coordinate()
      ..lng = 34.77752685546875
      ..lat = 32.06623458862305,
    Coordinate()
      ..lng = 34.777801513671875
      ..lat = 32.067073822021484,
    Coordinate()
      ..lng = 34.777801513671875
      ..lat = 32.067073822021484,
    Coordinate()
      ..lng = 34.77803039550781
      ..lat = 32.067771911621094,
    Coordinate()
      ..lng = 34.77803039550781
      ..lat = 32.067771911621094,
    Coordinate()
      ..lng = 34.77827453613281
      ..lat = 32.06846237182617,
    Coordinate()
      ..lng = 34.77827453613281
      ..lat = 32.06846237182617,
    Coordinate()
      ..lng = 34.778507232666016
      ..lat = 32.069156646728516,
    Coordinate()
      ..lng = 34.778507232666016
      ..lat = 32.069156646728516,
    Coordinate()
      ..lng = 34.77872085571289
      ..lat = 32.06985855102539,
    Coordinate()
      ..lng = 34.77872085571289
      ..lat = 32.06985855102539,
    Coordinate()
      ..lng = 34.77894592285156
      ..lat = 32.070556640625,
    Coordinate()
      ..lng = 34.77894592285156
      ..lat = 32.070556640625,
    Coordinate()
      ..lng = 34.779170989990234
      ..lat = 32.071231842041016,
    Coordinate()
      ..lng = 34.779170989990234
      ..lat = 32.071231842041016,
    Coordinate()
      ..lng = 34.780067443847656
      ..lat = 32.07108688354492,
    Coordinate()
      ..lng = 34.780067443847656
      ..lat = 32.07108688354492,
    Coordinate()
      ..lng = 34.78087615966797
      ..lat = 32.07087326049805,
    Coordinate()
      ..lng = 34.78087615966797
      ..lat = 32.07087326049805,
    Coordinate()
      ..lng = 34.7816047668457
      ..lat = 32.07062911987305,
    Coordinate()
      ..lng = 34.7816047668457
      ..lat = 32.07062911987305,
    Coordinate()
      ..lng = 34.78123092651367
      ..lat = 32.069976806640625,
    Coordinate()
      ..lng = 34.78123092651367
      ..lat = 32.069976806640625,
    Coordinate()
      ..lng = 34.7818489074707
      ..lat = 32.069705963134766,
    Coordinate()
      ..lng = 34.7818489074707
      ..lat = 32.069705963134766,
    Coordinate()
      ..lng = 34.78284454345703
      ..lat = 32.069549560546875,
    Coordinate()
      ..lng = 34.78284454345703
      ..lat = 32.069549560546875,
    Coordinate()
      ..lng = 34.783687591552734
      ..lat = 32.069488525390625,
    Coordinate()
      ..lng = 34.783687591552734
      ..lat = 32.069488525390625,
    Coordinate()
      ..lng = 34.784523010253906
      ..lat = 32.06943130493164,
    Coordinate()
      ..lng = 34.784523010253906
      ..lat = 32.06943130493164,
    Coordinate()
      ..lng = 34.785362243652344
      ..lat = 32.06937789916992,
    Coordinate()
      ..lng = 34.785362243652344
      ..lat = 32.06937789916992,
    Coordinate()
      ..lng = 34.78638458251953
      ..lat = 32.06930160522461,
    Coordinate()
      ..lng = 34.78638458251953
      ..lat = 32.06930160522461,
    Coordinate()
      ..lng = 34.7872314453125
      ..lat = 32.06924057006836,
    Coordinate()
      ..lng = 34.7872314453125
      ..lat = 32.06924057006836,
    Coordinate()
      ..lng = 34.7878532409668
      ..lat = 32.06955337524414,
    Coordinate()
      ..lng = 34.7878532409668
      ..lat = 32.06955337524414,
    Coordinate()
      ..lng = 34.78836441040039
      ..lat = 32.07029724121094,
    Coordinate()
      ..lng = 34.78836441040039
      ..lat = 32.07029724121094,
    Coordinate()
      ..lng = 34.78899002075195
      ..lat = 32.07077407836914,
    Coordinate()
      ..lng = 34.78899002075195
      ..lat = 32.07077407836914,
    Coordinate()
      ..lng = 34.789512634277344
      ..lat = 32.0713005065918,
    Coordinate()
      ..lng = 34.789512634277344
      ..lat = 32.0713005065918,
    Coordinate()
      ..lng = 34.78980255126953
      ..lat = 32.07197952270508,
    Coordinate()
      ..lng = 34.78980255126953
      ..lat = 32.07197952270508,
    Coordinate()
      ..lng = 34.79015350341797
      ..lat = 32.072792053222656,
    Coordinate()
      ..lng = 34.79015350341797
      ..lat = 32.072792053222656,
    Coordinate()
      ..lng = 34.790443420410156
      ..lat = 32.07347106933594,
    Coordinate()
      ..lng = 34.790443420410156
      ..lat = 32.07347106933594,
    Coordinate()
      ..lng = 34.790794372558594
      ..lat = 32.074283599853516,
    Coordinate()
      ..lng = 34.790794372558594
      ..lat = 32.074283599853516,
    Coordinate()
      ..lng = 34.79108428955078
      ..lat = 32.07495880126953,
    Coordinate()
      ..lng = 34.79108428955078
      ..lat = 32.07495880126953,
    Coordinate()
      ..lng = 34.791446685791016
      ..lat = 32.07561111450195,
    Coordinate()
      ..lng = 34.791446685791016
      ..lat = 32.07561111450195,
  ];
}
