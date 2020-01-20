import 'package:flutter/material.dart';
import 'package:flutter_here_maps/flutter_here_maps.dart';

enum DialogResult { YES, NO }

class MapCenterSlidersDialog extends StatefulWidget {
  final MapCenter mapCenter;

  const MapCenterSlidersDialog({Key key, this.mapCenter})
      : assert(mapCenter != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _MapCenterSlidersState();
}

class _MapCenterSlidersState extends State<MapCenterSlidersDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text("Map center"),
        children: <Widget>[
          Text("zoom"),
          Slider(
            value: widget.mapCenter.zoomLevel.value,
            onChanged: (change) {
              setState(() {
                widget.mapCenter.zoomLevel.value = change;
              });
            },
            max: 21,
          ),
          Text("tilt"),
          Slider(
            label: widget.mapCenter.tilt.value.toString(),
            value: widget.mapCenter.tilt.value,
            onChanged: (change) {
              setState(() {
                widget.mapCenter.tilt.value = change;
              });
            },
            max: 100,
          ),
          Text("orientation"),
          Slider(
            value: widget.mapCenter.orientation.value,
            onChanged: (change) {
              setState(() {
                widget.mapCenter.orientation.value = change;
              });
            },
            max: 360,
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
}
