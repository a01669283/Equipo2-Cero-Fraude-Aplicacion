//
//  RegisterRequestDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 12/10/26.
//

// Data sent to the API to create a new user account, the API responds with the same tokens as a login (`LoginResponseDTO`).

struct RegisterRequestDTO: Codable {
    let username: String
    let email: String
    let password: String
}
