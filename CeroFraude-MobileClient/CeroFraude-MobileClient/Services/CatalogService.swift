//
//  CatalogService.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 09/10/26.
//

import Foundation

struct CatalogService {
    private let httpClient = HTTPClient()
    
    func getCatalogs(endpoint: String) async throws -> [CatalogDTO] {
        let url = APIConfig.BASE_URL.appendingPathComponent(endpoint)
        
        guard let accessToken = TokenStorage.getAccessToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        let response = try await httpClient.get(
            url: url,
            responseType: [CatalogDTO].self,
            accessToken: accessToken
        )
        
        return response
    }
    
    func loadCatalogs() async throws {
        let catalogs = [
            "categories",
            "types"
        ]
        
        for endpoint in catalogs {
            let response = try await getCatalogs(endpoint: endpoint)
            CatalogStorage.saveCatalogs(response, key: endpoint)
        }
    }
}
