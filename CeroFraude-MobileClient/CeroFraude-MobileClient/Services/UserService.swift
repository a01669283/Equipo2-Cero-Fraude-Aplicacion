//
//  UserService.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

import Foundation

struct UserService {
    private let httpClient = HTTPClient()
    
    func getCurrentUser() async throws -> UserDTO {
        let url = APIConfig.BASE_URL.appendingPathComponent("users/me")
        
        guard let accessToken = TokenStorage.getAccessToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let response = try await httpClient.get(
            url: url,
            responseType: UserDTO.self,
            accessToken: accessToken
        )
        
        return response
    }
}
