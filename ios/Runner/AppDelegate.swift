import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var methodChannel: FlutterMethodChannel?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("rootViewController is not type FlutterViewController")
    }
    methodChannel = FlutterMethodChannel(name: "com.flashNews.backgroundfetch",
                                         binaryMessenger: controller.binaryMessenger)
    
    application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    // Here, call your Dart code to execute background fetch.
    methodChannel?.invokeMethod("backgroundFetch", arguments: nil, result: { (result) in
      // Handle the result from the Dart side here.
      if let fetchResult = result as? Bool, fetchResult == true {
          completionHandler(.newData)
      } else {
          completionHandler(.noData)
      }
    })
  }
}
