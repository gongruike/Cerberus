//
//  RKCredentialTests.swift
//  Demo
//
//  Created by gongruike on 2017/5/26.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import XCTest
@testable import Demo

class RKCredentialTests: DemoTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTokenString()  {
        let credential = RKCredential(accessToken: "access_token", tokenType: "Bearer")
        
        XCTAssert(credential.tokenString() == "Bearer access_token", "tokenString method doesn't work corrently")
    }
    
    
    func testIsExpired() {
        let credential = RKCredential(accessToken: "access_token", tokenType: "Bearer")
        
        XCTAssertFalse(credential.isExpired(), "isExpired method doesn't work corrently")

        credential.expirationDate = Date(timeIntervalSinceNow: -60 * 60)
        XCTAssertTrue(credential.isExpired(), "isExpired method doesn't work corrently")
        
        credential.expirationDate = Date(timeIntervalSinceNow: 60 * 60)
        XCTAssertFalse(credential.isExpired(), "isExpired method doesn't work corrently")
    }
    
    func testRetrieveCredential() {
        
        RKCredential.storeCredential(RKCredential(accessToken: "access_token", tokenType: "Bearer"))
        
        let credential = RKCredential.retrieveCredential()
        
        XCTAssertNotNil(credential, "credential can't be nil")
        XCTAssertNotNil(credential?.accessToken, "access_token can't be nil")
        XCTAssertNotNil(credential?.tokenType, "token_type can't be nil")
    }
    
    func testDeleteCredential() {
        
        testRetrieveCredential()
        
        RKCredential.deleteCredential()
        
        let credential = RKCredential.retrieveCredential()
        
        XCTAssertNil(credential, "credential should be nil")
    }
    
}
