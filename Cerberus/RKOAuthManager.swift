//
//  RKOAuthManager.swift
//  Demo
//
//  Created by gongruike on 2017/5/23.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import UIKit
import Alamofire

open class RKOAuthManager {

    let sessionManager: SessionManager
    
    let clientID: String = ""
    
    let basicAuth: Bool = false
    
    init() {
        
        sessionManager = SessionManager()
        
    }
    
    @discardableResult
    func authenticate(_ url: String, username: String, password: String) -> Request {
        
        let request = sessionManager.request(
            "",
            method: .post,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil
        )
        
        request.responseJSON { (dataResponse) in
            
        }
        
        return request
    }
    
    @discardableResult
    func refresh(_ url: String, refreshToken: String) -> Request {
        return sessionManager.request("", method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
    }
    
    func revoke() {
        
    }
    
}
