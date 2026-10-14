//
//  LoginViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 06/10/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    // LoginRequestDTO
    @Published var identifier = ""
    @Published var password = ""

    @Published var didAttemptSubmit = false
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let authService = AuthService()

    var isFormValid: Bool {
        ![identifier, password].contains(where: \.isBlank)
    }

    /// Authenticates the user and, if it succeeds, opens the session
    func login(session: SessionViewModel) async {
        didAttemptSubmit = true
        guard isFormValid, !isLoading else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            _ = try await authService.login(
                identifier: identifier.trimmingCharacters(in: .whitespaces),
                password: password
            )
            try await session.didAuthenticate()
        } catch let error as APIError {
            errorMessage = error.statusCode == 401
                ? "Correo, usuario o contraseña incorrectos"
                : error.message
        } catch is URLError {
            errorMessage = "No se pudo conectar con el servidor. Revisa tu conexión."
        } catch {
            errorMessage = "Ocurrió un error inesperado. Inténtalo de nuevo."
        }
    }
}
