//
//  RKError.swift
//  Demo
//
//  Created by gongruike on 2017/5/26.
//  Copyright © 2017年 gongruike. All rights reserved.
//

import Foundation

enum RKOAuthError: Error {
    
    case invalidResponseType
    case misssingResponseParameter
    
    case invalidRequest
    case invalidClient
    case invalidGrant
    case unauthorizedClient
    case unsupportedGrantType
    
    case unknown
    
    static func errorFrom(response: [String: Any]) -> RKOAuthError {
        
        guard let error = response["error"] as? String else { return .unknown }
        
        if error == "invalid_request" {
            return .invalidRequest
        } else if error == "invalid_client" {
            return .invalidClient
        } else if error == "invalid_grant" {
            return .invalidGrant
        } else if error == "unauthorized_client" {
            return .unauthorizedClient
        } else if error == "unsupported_grant_type" {
            return .unsupportedGrantType
        }
        
        return .unknown
    }
}

extension RKOAuthError: LocalizedError {

    // Copy from AFOAuth2Manager
    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "The request is missing a required parameter, includes an unsupported parameter value (other than grant type), repeats a parameter, includes multiple credentials, utilizes more than one mechanism for authenticating the client, or is otherwise malformed."
        case .invalidClient:
            return "Client authentication failed (e.g., unknown client, no client authentication included, or unsupported authentication method).  The authorization server MAY return an HTTP 401 (Unauthorized) status code to indicate which HTTP authentication schemes are supported.  If the client attempted to authenticate via the \"Authorization\" request header field, the authorization server MUST respond with an HTTP 401 (Unauthorized) status code and include the \"WWW-Authenticate\" response header field matching the authentication scheme used by the client."
        case .invalidGrant:
            return "The provided authorization grant (e.g., authorization code, resource owner credentials) or refresh token is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client."
        case .unauthorizedClient:
            return "The authenticated client is not authorized to use this authorization grant type."
        case .unsupportedGrantType:
            return "The authorization grant type is not supported by the authorization server."
        case .invalidResponseType:
            return "The response type is not json"
        case .misssingResponseParameter:
            return "Required parameter is missing"
        default:
            return "unknown error"
        }
    }
    
}
