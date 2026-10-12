//
//  User.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 29/09/26.
//

import Foundation

struct User {
    let id: UUID
    let username: String
    let email: String
    let createdAt: String
    let isActive: Bool
    let roleId: Int
}

extension User {
    init(from dto: UserDTO) {
        self.id = dto.id
        self.username = dto.username
        self.email = dto.email
        self.createdAt = dto.createdAt
        self.isActive = dto.isActive == 1
        self.roleId = dto.roleId
    }
}
