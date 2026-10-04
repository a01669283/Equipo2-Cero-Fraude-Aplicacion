//
//  APIError.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

/// Represents an error recieved from the API
struct APIError: Error {
    let statusCode: Int
    let message: String
}
