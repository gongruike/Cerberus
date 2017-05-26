//
//  RKOAuthManager.swift
//  Demo
//
//  Created by gongruike on 2017/5/23.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import UIKit
import Alamofire

public typealias RKCompletionHandler = (Result<RKCredential>) -> Void

open class RKOAuthManager {

    open let session: SessionManager
    
    open let clientID: String
    
    open var clientSecret: String?
    
    open var useHTTPBasicAuthentication: Bool = false
    
    public convenience init(clientID: String) {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        self.init(clientID: clientID, configuration: configuration)
    }
    
    public init(clientID: String, configuration: URLSessionConfiguration) {
        
        self.clientID = clientID
        self.session = SessionManager(configuration: configuration)
    }
    
    @discardableResult
    open func authenticate(
        _ url: String,
        username: String,
        password: String,
        scope: String,
        completion: @escaping RKCompletionHandler)
        -> Request
    {
        let parameters = [
            "username": username,
            "password": password,
            "scope": scope,
            "grant_type": "password"
        ]
        return authenticate(url, parameters: parameters, completion: completion)
    }
    
    @discardableResult
    open func authenticate(
        _ url: String,
        refreshToken: String,
        completion: @escaping RKCompletionHandler)
        -> Request
    {
        let parameters = [
            "refresh_token": refreshToken,
            "grant_type": "refresh_token"
        ]
        return authenticate(url, parameters: parameters, completion: completion)
    }
    
    open func authenticate(
        _ url: String,
        parameters: Parameters,
        completion: @escaping RKCompletionHandler)
        -> Request
    {
        var headers = [
            "Accept": "application/json"
        ]
        if useHTTPBasicAuthentication,
           let authorization = Request.authorizationHeader(user: clientID, password: clientSecret ?? "") {
            // Authorization header
            headers[authorization.key] = authorization.value
        }
        
        let request = session.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        )
        request.responseJSON { (dataResponse) in
            
            print(dataResponse.debugDescription)
            
            switch dataResponse.result {
            case .success(let value):
                
                if let json = value as? [String: Any] {

                    if let _ = json["error"] as? String {
                        completion(Result.failure(RKError.errorFrom(response: json)))
                        return
                    }
                    
                    if let accessToken = json["access_token"] as? String, let tokenType = json["token_type"] as? String {
                        
                        let credential = RKCredential(accessToken: accessToken, tokenType: tokenType)
                        
                        credential.refreshToken = json["refresh_token"] as? String
                        credential.scope = json["scope"] as? String
                        
                        if let timeInterval = json["expires_in"] as? TimeInterval {
                            credential.expirationDate = Date(timeIntervalSinceNow: timeInterval)
                        }
                        
                        completion(Result.success(credential))
                    } else {
                        completion(Result.failure(RKError.misssingResponseParameter))
                    }
                } else {
                    completion(Result.failure(RKError.invalidResponseType))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
        
        return request
    }
    
}
