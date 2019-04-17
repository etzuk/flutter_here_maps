import 'package:flutter/material.dart';
import 'package:flutter_here_maps_example/pages/current_location_tracker.dart';
import 'pages/show_map.dart';
import 'pages/map_center.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return new Drawer(
    child: new ListView(
      children: <Widget>[
        const DrawerHeader(
          child: const Center(
            child: const Text("Flutter Here Maps Examples"),
          ),
        ),
        new ListTile(
          title: const Text('Show map'),
          selected: currentRoute == ShowMapPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, ShowMapPage.route);
          },
        ),
        new ListTile(
          title: const Text('Map center'),
          selected: currentRoute == MapCenterPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, MapCenterPage.route);
          },
        ),
        new ListTile(
          title: const Text('Curretn Location Trakcer'),
          selected: currentRoute == CurrentLocationTrackerPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, CurrentLocationTrackerPage.route);
          },
        ),
      ],
    ),
  );
}
