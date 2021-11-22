import UIKit
import Flutter
import GoogleMaps
import flutter_config


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // dev key only, waiting for this issue https://github.com/ByneappLLC/flutter_config/issues/36
    GMSServices.provideAPIKey("AIzaSyBDz8BClGoJP9OPRfk72zpFbiB94HPMUJY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
