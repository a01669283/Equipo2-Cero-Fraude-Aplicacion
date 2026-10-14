//
//  APIErrorDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

/// Represents the error response returned by the API
///
/// NestJS returns `message` as a string for most errors and as an array
/// of strings for validation errors, so both shapes are accepted.
struct APIErrorDTO: Decodable {
    let message: String
    let error: String?
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message
        case error
        case statusCode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let messages = try? container.decode([String].self, forKey: .message) {
            message = messages.joined(separator: "\n")
        } else {
            message = try container.decode(String.self, forKey: .message)
        }

        error = try container.decodeIfPresent(String.self, forKey: .error)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
    }
}
