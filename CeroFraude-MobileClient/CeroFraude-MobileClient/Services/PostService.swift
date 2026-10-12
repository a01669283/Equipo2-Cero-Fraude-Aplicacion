//
//  PostService.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import Foundation

struct PostService {
    private let httpClient = HTTPClient()
    
    func getPosts(page: Int) async throws -> ResponsePostsDTO {
        let baseURL = APIConfig.BASE_URL.appendingPathComponent("posts")
        
        var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        )
        
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        
        guard let accessToken = TokenStorage.getAccessToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        let response = try await httpClient.get(
            url: url,
            responseType: ResponsePostsDTO.self,
            accessToken: accessToken
        )
        return response
    }
}
