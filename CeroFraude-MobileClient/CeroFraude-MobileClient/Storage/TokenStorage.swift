//
//  TokenStorage.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 01/10/26.
//

import Foundation

/// Manages the local storage of authentication tokens
struct TokenStorage {
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    
    static func saveAccessToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: accessTokenKey)
    }
    
    static func saveRefreshToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: refreshTokenKey)
    }
    
    static func getAccessToken() -> String? {
        UserDefaults.standard.string(forKey: accessTokenKey)
    }
    
    static func getRefreshToken() -> String? {
        UserDefaults.standard.string(forKey: refreshTokenKey)
    }
    
    static func deleteTokens() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
    }
}
