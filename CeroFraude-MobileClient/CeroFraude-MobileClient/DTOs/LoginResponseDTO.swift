//
//  LoginResponseDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 01/10/26.
//

/// Data returned by the API after a successful login
struct LoginResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
