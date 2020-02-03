///
//  Generated code. Do not modify.
//  source: location_objects.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const LocationReading$json = const {
  '1': 'LocationReading',
  '2': const [
    const {'1': 'coordinate', '3': 1, '4': 1, '5': 11, '6': '.FlutterHereMaps.Coordinate', '10': 'coordinate'},
    const {'1': 'altitude', '3': 3, '4': 1, '5': 1, '10': 'altitude'},
    const {'1': 'heading', '3': 4, '4': 1, '5': 1, '10': 'heading'},
    const {'1': 'accuracy', '3': 5, '4': 1, '5': 1, '10': 'accuracy'},
    const {'1': 'speed', '3': 6, '4': 1, '5': 1, '10': 'speed'},
  ],
};

const AndroidLocationSettings$json = const {
  '1': 'AndroidLocationSettings',
  '2': const [
    const {'1': 'notification_settings', '3': 1, '4': 1, '5': 11, '6': '.FlutterHereMaps.AndroidLocationSettings.LocationNotificationSettings', '10': 'notificationSettings'},
    const {'1': 'location_method', '3': 2, '4': 1, '5': 14, '6': '.FlutterHereMaps.AndroidLocationSettings.LocationMethod', '10': 'locationMethod'},
  ],
  '3': const [AndroidLocationSettings_LocationNotificationSettings$json],
  '4': const [AndroidLocationSettings_LocationMethod$json],
};

const AndroidLocationSettings_LocationNotificationSettings$json = const {
  '1': 'LocationNotificationSettings',
  '2': const [
    const {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    const {'1': 'channel_name', '3': 2, '4': 1, '5': 9, '10': 'channelName'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'body', '3': 4, '4': 1, '5': 9, '10': 'body'},
  ],
};

const AndroidLocationSettings_LocationMethod$json = const {
  '1': 'LocationMethod',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'GPS', '2': 1},
    const {'1': 'NETWORK', '2': 2},
    const {'1': 'GPS_NETWORK', '2': 3},
    const {'1': 'GPS_NETWORK_INDOOR', '2': 4},
    const {'1': 'INDOOR', '2': 5},
  ],
};

