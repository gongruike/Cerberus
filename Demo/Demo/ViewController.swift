//
//  ViewController.swift
//  Demo
//
//  Created by gongruike on 2017/5/23.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var authenticateBtn: UIButton!
    
    @IBOutlet weak var refreshBtn: UIButton!
    
    let authManager: RKOAuthManager = RKOAuthManager(clientID: "mobile.tiup.cn")
    
    var credential: RKCredential?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authManager.clientSecret = "6f52db21ce5c52c180f04b298d974f779d854147173658b5ba51b6db950028f8"
        authManager.useHTTPBasicAuthentication = true
    }
    
    @IBAction func authenticate(_ sender: Any) {
        
        guard usernameField.text?.isEmpty == false, passwordField.text?.isEmpty == false else {
            return
        }
        
        let url = "https://test.tiup.cn/oauth2/token"
        authManager.authenticate(url, username: usernameField.text!, password: passwordField.text!, scope: "all") { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.credential = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        guard let refreshToken = credential?.refreshToken else { return }
        
        let url = "https://test.tiup.cn/oauth2/token"
        authManager.authenticate(url, refreshToken: refreshToken) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.credential = value
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

}

