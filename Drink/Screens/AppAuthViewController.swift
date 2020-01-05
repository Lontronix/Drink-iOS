//
//  ViewController.swift
//  Drink
//
//  Created by Lonnie Gerol on 12/30/19.
//  Copyright © 2019 Lonnie Gerol. All rights reserved.
//

import UIKit
import SwiftUI
import AppAuth


protocol WelcomeViewDelegate{
    func userTappedSignInButton()
}

class AppAuthViewController: UIViewController, WelcomeViewDelegate {
    private var authState: OIDAuthState?
    var hostingController: UIHostingController<WelcomeView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var view = WelcomeView()
        view.delegate = self
        hostingController = UIHostingController(rootView: view)
        self.view.addSubview(hostingController.view)
        
        hostingController.view.frame = self.view.frame
        
    }
    
    func userTappedSignInButton() {
        OIDAuthorizationService.discoverConfiguration(forIssuer: AppAuthConstants.kIssuer) { (configuration, error) in
                                guard let config = configuration else{
                                    print("Error retrieving discovery document: \(error?.localizedDescription ?? "unknown error")")
                                    return
                                }
                                // builds authentication request
                                let request = OIDAuthorizationRequest(configuration: config,
                                                                      clientId: AppAuthConstants.kClientID,
                                                                      clientSecret: AppAuthConstants.clientSecret,
                                                                      scopes: [OIDScopeOpenID, OIDScopeProfile],
                                                                      redirectURL: AppAuthConstants.kRedirectURL,
                                                                      responseType: OIDResponseTypeCode,
                                                                      additionalParameters: nil)
                                //performs authentication request
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                
                   appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self) { (authState, error) in
                                    if let authState = authState{
                                        self.authState = authState
                                    } else {
                                        self.authState = nil
                                    }
                                }
                            }
    }
    
}
