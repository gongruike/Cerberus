//
//  RKCredential.swift
//  Demo
//
//  Created by gongruike on 2017/5/23.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import UIKit

open class RKCredential {

    struct SerializationKeys {
        static let credentialKey       = "k.oauth2.credential.key"
        
        static let accessTokenKey      = "k.access.token.key"
        static let tokenTypeKey        = "k.token.type.key"
        static let refreshTokenKey     = "k.refresh.token.key"
        static let expirationDateeKey  = "k.expiry.key"
        static let scopeKey            = "k.scope.key"
    }
    
    let accessToken: String
    
    let tokenType: String
    
    var refreshToken: String?
    
    var expirationDate: Date?
    
    var scope: String?
    
    var tokenString: String {
        return tokenType + " " + accessToken
    }
    
    var isExpired: Bool {
        return expirationDate?.compare(Date()) != .orderedAscending
    }
    
    init(accessToken: String, tokenType: String, refreshToken: String?) {
        self.accessToken = accessToken
        self.tokenType   = tokenType
    }
    
    class func store() {
        
    }
    
    class func retreive() {
    
    }
    
    class func delete() {
    
    }
    
}
