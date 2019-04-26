import UIKit
import Flutter
import NMAKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
        let dictRoot = NSDictionary(contentsOfFile: path)
        if let appID = dictRoot?["here_maps_app_id"] as? String,
            let appCode = dictRoot?["here_maps_app_token"] as? String,
            let licenseKey = dictRoot?["here_maps_app_license"] as? String {

            let error =  NMAApplicationContext.setAppId(appID,
                                                        appCode: appCode,
                                                        licenseKey: licenseKey)
            assert(error == NMAApplicationContextError.none)
        }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
