//
//  RefreshTokenResponseDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

/// Data returned by the APi after refreshing the access token
struct RefreshTokenResponseDTO: Decodable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
