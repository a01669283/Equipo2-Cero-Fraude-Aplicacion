//
//  AuthService.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 01/10/26.
//

import Foundation

/// Handles authentication operations with the API
struct AuthService {
    private let httpClient = HTTPClient()
    
    /// Authenticates a user and stores the recieved tokens
    func login(
        identifier: String,
        password: String
    )
    async throws -> LoginResponseDTO {
        let url = APIConfig.BASE_URL.appendingPathComponent("auth/login")
        
        let request = LoginRequestDTO(
            identifier: identifier,
            password: password
        )
        
        let response = try await httpClient.post(
            url: url,
            body: request,
            responseType: LoginResponseDTO.self
        )
        
        TokenStorage.saveAccessToken(response.accessToken)
        TokenStorage.saveRefreshToken(response.refreshToken)
        
        return response
    }
    
    /// Creates a new user account and stores the recieved tokens
    ///
    /// The API logs the new user in right away, so the response has the same tokens as a login.
    func register(
        username: String,
        email: String,
        password: String
    )
    async throws -> LoginResponseDTO {
        let url = APIConfig.BASE_URL.appendingPathComponent("auth/register")

        let request = RegisterRequestDTO(
            username: username,
            email: email,
            password: password
        )

        let response = try await httpClient.post(
            url: url,
            body: request,
            responseType: LoginResponseDTO.self
        )

        TokenStorage.saveAccessToken(response.accessToken)
        TokenStorage.saveRefreshToken(response.refreshToken)

        return response
    }

    /// Requests and stores a new access token using the refresh token
    func refreshAccessToken() async throws -> String {
        let url = APIConfig.BASE_URL.appendingPathComponent("auth/refresh")
        guard let refreshToken = TokenStorage.getRefreshToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let request = RefreshTokenRequestDTO(refreshToken: refreshToken)
        
        let response = try await httpClient.post(
            url: url,
            body: request,
            responseType: RefreshTokenResponseDTO.self
        )
        
        TokenStorage.saveAccessToken(response.accessToken)
        
        return response.accessToken
    }
    
    /// Ends the local session by removing the stored authentication tokens
    func logout() {
        TokenStorage.deleteTokens()
    }
}
