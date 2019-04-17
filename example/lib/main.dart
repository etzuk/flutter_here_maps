import 'package:flutter/material.dart';
import 'package:flutter_here_maps_example/pages/current_location_tracker.dart';
import 'package:flutter_here_maps_example/pages/show_map.dart';
import 'package:flutter_here_maps_example/pages/map_center.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HereMaps Example',
      theme: new ThemeData(
        primarySwatch: mapBoxBlue,
      ),
      home: new ShowMapPage(),
      routes: <String, WidgetBuilder>{
        ShowMapPage.route: (context) => new ShowMapPage(),
        MapCenterPage.route: (context) => new MapCenterPage(),
        CurrentLocationTrackerPage.route: (context) => new CurrentLocationTrackerPage()
      },
    );
  }
}

const int _bluePrimary = 0xFF395afa;
const MaterialColor mapBoxBlue = const MaterialColor(
  _bluePrimary,
  const <int, Color>{
    50: const Color(0xFFE7EBFE),
    100: const Color(0xFFC4CEFE),
    200: const Color(0xFF9CADFD),
    300: const Color(0xFF748CFC),
    400: const Color(0xFF5773FB),
    500: const Color(_bluePrimary),
    600: const Color(0xFF3352F9),
    700: const Color(0xFF2C48F9),
    800: const Color(0xFF243FF8),
    900: const Color(0xFF172EF6),
  },
);
