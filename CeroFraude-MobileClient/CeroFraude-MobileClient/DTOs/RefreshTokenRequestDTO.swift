//
//  RefreshTokenRequestDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

/// Data returned by the API to request a new access token
struct RefreshTokenRequestDTO: Encodable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
