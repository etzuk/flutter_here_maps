import Flutter
import UIKit

public class SwiftFlutterHereMapsPlugin: NSObject, FlutterPlugin {

  static let pluginPrefix = "flugins.etzuk.flutter_here_maps"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_here_maps", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterHereMapsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let native = MapViewFactory(with: registrar)
    registrar.register(native, withId: "\(pluginPrefix)/MapView")
  }
}
