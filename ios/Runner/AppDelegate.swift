import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Google Maps SDK key, read from Info.plist (GoogleMapsApiKey), which is
    // fed by the $(GOOGLE_MAPS_API_KEY) build variable from the gitignored
    // ios/Flutter/Secrets.xcconfig. See ios/Flutter/Secrets.xcconfig.example.
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String ?? ""
    if !apiKey.isEmpty {
      GMSServices.provideAPIKey(apiKey)
    }

    // Set up method channel for Flutter to retrieve the API key
    let controller = window?.rootViewController as! FlutterViewController
    let mapsChannel = FlutterMethodChannel(
      name: "com.petaverse.app/maps",
      binaryMessenger: controller.binaryMessenger
    )
    mapsChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "getGoogleMapsApiKey":
        result(apiKey)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
