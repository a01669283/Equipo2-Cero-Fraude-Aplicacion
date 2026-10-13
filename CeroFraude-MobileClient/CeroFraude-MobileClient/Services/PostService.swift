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
    
    func searchPosts(findPosts: FindPostsDto) async throws -> ResponsePostsDTO {
        let baseUrl = APIConfig.BASE_URL.appendingPathComponent("posts")
    
        var queryItems: [URLQueryItem] = []
        
        if findPosts.page != nil {
            queryItems.append(
                URLQueryItem(
                    name: FindPostsDto.CodingKeys.page.rawValue,
                    value: String(findPosts.page!)
                )
            )
        }
        
        if findPosts.text != nil {
            queryItems.append(
                URLQueryItem(
                    name: FindPostsDto.CodingKeys.text.rawValue,
                    value: findPosts.text
                )
            )
        }
        
        if let categories = findPosts.categories, !categories.isEmpty {
            queryItems.append(contentsOf: categories.map {
                URLQueryItem(
                    name: FindPostsDto.CodingKeys.categories.rawValue,
                    value: String($0)
                )
            })
        }
        
        if let types = findPosts.types, !types.isEmpty {
            queryItems.append(contentsOf: types.map {
                URLQueryItem(
                    name: FindPostsDto.CodingKeys.types.rawValue,
                    value: String($0)
                )
            })
        }

        var components = URLComponents(
            url: baseUrl,
            resolvingAgainstBaseURL: false
        )
        
        components?.queryItems = queryItems.isEmpty ? nil : queryItems
        
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
