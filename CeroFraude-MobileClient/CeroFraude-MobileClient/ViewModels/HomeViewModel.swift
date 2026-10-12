//
//  HomeViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var user: UserDTO?
    @Published var errorMessage: String?
    
    private let userService = UserService()
    
    func loadUser() async {
        do {
            user = try await userService.getCurrentUser()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
