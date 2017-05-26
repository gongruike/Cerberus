//
//  RKCredential.swift
//  Demo
//
//  Created by gongruike on 2017/5/23.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import UIKit

open class RKCredential: NSObject, NSSecureCoding {

    struct SerializationKeys {
        static let credentialKey       = "k.oauth2.credential.key"
        
        static let accessTokenKey      = "k.access.token.key"
        static let tokenTypeKey        = "k.token.type.key"
        static let refreshTokenKey     = "k.refresh.token.key"
        static let expirationDateKey   = "k.expiry.key"
        static let scopeKey            = "k.scope.key"
    }
    
    open let accessToken: String
    
    open let tokenType: String
    
    open var refreshToken: String?
    
    open var expirationDate: Date?
    
    open var scope: String?
    
    public init(accessToken: String, tokenType: String) {
        self.accessToken = accessToken
        self.tokenType   = tokenType
    }
    
    open func isExpired() -> Bool {
        guard let expirationDate = expirationDate else {
            return false
        }
        return expirationDate.compare(Date()) == .orderedAscending
    }
    
    open func tokenString() -> String {
        return tokenType + " " + accessToken
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        accessToken     = aDecoder.decodeObject(forKey: SerializationKeys.accessTokenKey) as! String
        tokenType       = aDecoder.decodeObject(forKey: SerializationKeys.tokenTypeKey) as! String
        refreshToken    = aDecoder.decodeObject(forKey: SerializationKeys.refreshTokenKey) as? String
        expirationDate  = aDecoder.decodeObject(forKey: SerializationKeys.expirationDateKey) as? Date
        scope           = aDecoder.decodeObject(forKey: SerializationKeys.scopeKey) as? String
        
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: SerializationKeys.accessTokenKey)
        aCoder.encode(tokenType, forKey: SerializationKeys.tokenTypeKey)
        aCoder.encode(refreshToken, forKey: SerializationKeys.refreshTokenKey)
        aCoder.encode(expirationDate, forKey: SerializationKeys.expirationDateKey)
        aCoder.encode(scope, forKey: SerializationKeys.scopeKey)
    }
    
    open class func storeCredential(_ credential: RKCredential) {
        UserDefaults.standard.set(
            NSKeyedArchiver.archivedData(withRootObject: credential),
            forKey: SerializationKeys.credentialKey
        )
    }
    
    open class func retrieveCredential() -> RKCredential? {
        guard let data = UserDefaults.standard.data(forKey: SerializationKeys.credentialKey) else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? RKCredential
    }
    
    open class func deleteCredential() {
        UserDefaults.standard.removeObject(forKey: SerializationKeys.credentialKey)
    }
    
}
