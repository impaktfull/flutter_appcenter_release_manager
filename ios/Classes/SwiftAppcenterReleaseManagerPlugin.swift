import Flutter
import UIKit

public class SwiftAppcenterReleaseManagerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "appcenter_release_manager", binaryMessenger: registrar.messenger())
    let instance = SwiftAppcenterReleaseManagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(true)
  }
}
