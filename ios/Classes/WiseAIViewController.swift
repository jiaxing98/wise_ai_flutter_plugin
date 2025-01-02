//
//  WiseAIViewController.swift
//  wise_ai_ekyc
//
//  Created by WAN JIA XING on 29/02/2024.
//

import Foundation
import Flutter
import WiseAISDK

class WiseAIViewController: UIViewController, WiseAIAppDelegate {
    var config: PEkycConfig!
    
    private var wiseAiApp: WiseAiApp!
    private var onCompleted : ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        wiseAiApp = WiseAiApp(apiToken: config.token, andApiURL: config.endpoint)
        wiseAiApp.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func performEkyc(request: PEkycRequest, completion: @escaping (String) -> Void) {
        wiseAiApp.startNewSession()

        // Start a new eKYC Flow
        request.backCamera ?
        wiseAiApp.performEkyc(forCountry: request.countryCode, idType: request.idType, withExportDoc: true, andExportFace: false, andCameraFacing: "BACK") :
        wiseAiApp.performEkyc(forCountry: request.countryCode, idType: request.idType, withExportDoc: true, andExportFace: false)
        
        // withExportDoc - Set to FALSE to not getting the base64 document image
        // andExportFace - Set to FALSE to not getting the base64 face image
        
        // save the completion callback
        onCompleted = completion
    }
        
    func onEkycComplete(_ jsonResult: String) {
        guard let completion = onCompleted else { return }
        
        completion(jsonResult)
        onCompleted = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    func onEkycCancelled() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onEkycException(_ jsonResult: String) {
        guard let completion = onCompleted else { return }
        
        completion(jsonResult)
        onCompleted = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    func onLivenessComplete(_ jsonResult: String) {
        guard let completion = onCompleted else { return }
        
        completion(jsonResult)
        onCompleted = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    func onLivenessException(_ jsonResult: String) {
        guard let completion = onCompleted else { return }
        
        completion(jsonResult)
        onCompleted = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSessionIdAndEncryptionConfig(_ sessionIDandConfig: String) {
        
    }
}
