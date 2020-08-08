import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        //mhb
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let mhb = CustomMHB(controller)
        let mbhChannel = FlutterMethodChannel(name:  ChannelName.channel,
                                              binaryMessenger: controller.binaryMessenger)
        mbhChannel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "getMHBoperation" || call.method == "checkMHBFiles" else {
                result(FlutterMethodNotImplemented)
                return
            }
            if (call.method == "getMHBoperation"){
                mhb.getMHBoperation()
            } else if (call.method == "checkMHBFiles"){
                mhb.checkMHBFiles(result: result)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
