//
//  UserDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 03/10/26.
//

import Foundation

struct UserDTO: Decodable {
    let id: UUID
    let username: String
    let email: String
    let createdAt: String
    let isActive: Int
    let roleId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case createdAt = "created_at"
        case isActive = "is_active"
        case roleId = "role_id"
    }
}
