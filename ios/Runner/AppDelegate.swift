import UIKit
import Flutter
import OktaOidc

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var oktaOidc: OktaOidc!
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "okta_flutter_bridge", binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "initOkta":
                do {
                    let config = try OktaOidcConfig(with: call.arguments as! [String : String])


                    if #available(iOS 13.0, *) {
                        config.noSSO = true
                    }

                    self?.oktaOidc = try OktaOidc(configuration: config)
                    result("true")
                } catch {
                    result("false")
                }
            case "authenticate":
                var additionalParameters: [String:String] = [:]
                if let email = (call.arguments as? [String: String])?["loginHint"] {
                    additionalParameters["login_hint"] = email
                }
                
                let isNewAccount: String? = (call.arguments as? [String: String])?["isNewAccount"]
                
                if(isNewAccount != nil && isNewAccount! == "true" && self?.oktaOidc.hasActiveBrowserSession() == true){
                    self?.oktaOidc.cancelBrowserSession()
                }
                
                self?.oktaOidc.signInWithBrowser(from: controller, additionalParameters: additionalParameters, callback: { stateManager, error in
                    if error != nil {
                        result(["error":  "\(error)"])
                    } else {
                        result(["access": stateManager?.accessToken ?? "", "refresh": stateManager?.refreshToken ?? ""])
                    }
 
                })
            case "openSettingsPage":
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                }
            default:
                break
            }
        })

        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
