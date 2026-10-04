//
//  HTTPClient.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 01/10/26.
//

import Foundation

/// Handles HTTP requests and decodes API responses
struct HTTPClient {
    
    /// Sends a POST request with a JSON body and decodes the response
    func post<Body: Encodable, Response: Decodable>
    (
        url: URL,
        body: Body,
        responseType: Response.Type
    )
    async throws -> Response {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response follows the HTTP protocol
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Accept only successful HTTP status codes
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorDTO = try JSONDecoder().decode(APIErrorDTO.self, from: data)
            throw APIError(statusCode: errorDTO.statusCode, message: errorDTO.message)
        }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    /// Sends an authenticated POST request with a JSON body and decodes the server response
    func authenticatedPost<Body: Encodable, Response: Decodable>
    (
        url: URL,
        body: Body,
        responseType: Response.Type,
        accessToken: String
    )
    async throws -> Response {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorizarion")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response follows the HTTP protocol
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Accept only successful HTTP status codes
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorDTO = try JSONDecoder().decode(APIErrorDTO.self, from: data)
            throw APIError(statusCode: errorDTO.statusCode, message: errorDTO.message)
        }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
    /// Sends an authenticated GET request and decodes the response
    func get<Response: Decodable>
    (
        url: URL,
        responseType: Response.Type,
        accessToken: String
    ) async throws -> Response {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response follows the HTTP protocol
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Accept only successful HTTP status codes
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorDTO = try JSONDecoder().decode(APIErrorDTO.self, from: data)
            throw APIError(statusCode: errorDTO.statusCode, message: errorDTO.message)
        }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
