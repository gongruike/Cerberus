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
    
    let authManager: RKOAuthManager = RKOAuthManager(clientID: "")
    
    var credential: RKCredential?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authManager.clientSecret = ""
        authManager.useHTTPBasicAuthentication = true
    }
    
    @IBAction func authenticate(_ sender: Any) {
        
        guard usernameField.text?.isEmpty == false, passwordField.text?.isEmpty == false else {
            return
        }
        
        let url = ""
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
        
        let url = ""
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

