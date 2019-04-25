import UIKit
import Flutter
import NMAKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let appID = ""
    let appCode = ""
    let licenseKey = ""

    let error =  NMAApplicationContext.setAppId(appID,
                                                appCode: appCode,
                                                licenseKey: licenseKey)
    assert(error == NMAApplicationContextError.none)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
