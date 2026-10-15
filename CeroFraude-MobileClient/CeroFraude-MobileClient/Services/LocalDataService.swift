//
//  LocalDataService.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 05/10/26.
//

import Foundation

struct LocalDataService {
    func load<T: Decodable>(
        _ filename: String,
        as _: T.Type
    ) throws -> T {
        
        guard let url = Bundle.main.url(
            forResource: filename,
            withExtension: "json"
        ) else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
