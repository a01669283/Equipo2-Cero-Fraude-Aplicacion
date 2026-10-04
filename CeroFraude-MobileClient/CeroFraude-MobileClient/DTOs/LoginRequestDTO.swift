//
//  LoginRequestDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 01/10/26.
//

/// Data sent to the API to authenticate a user
struct LoginRequestDTO: Codable {
    let identifier: String
    let password: String
}
