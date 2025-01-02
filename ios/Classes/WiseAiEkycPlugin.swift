import Flutter
import UIKit
import WiseAISDK

extension FlutterError: Error {}

public class WiseAiEkycPlugin: NSObject, FlutterPlugin, EkycHostApi {
    private var config: PEkycConfig!

    private var navigationController: UINavigationController!
    private var wiseVC: WiseAIViewController!

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : EkycHostApi & NSObjectProtocol = WiseAiEkycPlugin.init()
        EkycHostApiSetup.setUp(binaryMessenger: messenger, api: api)
    }

    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("iOS " + UIDevice.current.systemVersion))
    }

    func initialize(config: PEkycConfig, completion: @escaping (Result<Void, Error>) -> Void) {
        self.config = config
        completion(.success(()))
    }

    func performEkyc(request: PEkycRequest, completion: @escaping (Result<String, Error>) -> Void) {
        if let viewController =  UIApplication.shared.keyWindow?.rootViewController {
            if let config = config {
                wiseVC = WiseAIViewController()
                wiseVC.config = config
                viewController.present(wiseVC, animated: true, completion: { self.wiseVC.performEkyc(request: request, completion: { jsonResult in
                    completion(.success((jsonResult)))
                }) })
            } else {
                completion(.failure(FlutterError(code: "CONFIG_NOT_FOUND", message: "Failed to find eKYC config", details: nil)))
            }
        } else {
            completion(.failure(FlutterError(code: "NO_VIEW_CONTROLLER", message: "Failed to find root view controller", details: nil)))
        }
    }
}
