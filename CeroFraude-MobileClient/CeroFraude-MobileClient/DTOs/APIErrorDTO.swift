//
//  APIErrorDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

/// Represents the error response returned by the API
struct APIErrorDTO: Decodable {
    let message: String
    let error: String
    let statusCode: Int
}
