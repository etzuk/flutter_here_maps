import UIKit
import Flutter
import NMAKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {

    let error =  NMAApplicationContext.setAppId(kHelloMapAppID,
                                                appCode: kHelloMapAppCode,
                                                licenseKey: kHelloMapLicenseKey)
    assert(error == NMAApplicationContextError.none)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
