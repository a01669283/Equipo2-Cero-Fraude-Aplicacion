//
//  RegisterViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 12/10/26.
//

import Foundation
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {

    // RegisterRequestDTO
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirmation = ""

    @Published var didAttemptSubmit = false
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let authService = AuthService()

    /// Same minimum length the API requires
    static let minimumPasswordLength = 10

    // MARK: - Validación
    // Las reglas coinciden con las del RegisterDto de la API.
    // Los campos vacíos los marca RequiredTextField; aquí solo se validan los campos con texto.

    private var trimmedUsername: String { username.trimmingCharacters(in: .whitespaces) }
    private var trimmedEmail: String { email.trimmingCharacters(in: .whitespaces) }

    var usernameError: String? {
        guard !username.isBlank else { return nil }
        return Self.matches(trimmedUsername, pattern: "^[A-Za-z0-9_]+$")
            ? nil
            : "Usa solo letras, números y guion bajo (_)"
    }

    var emailError: String? {
        guard !email.isBlank else { return nil }
        return Self.matches(trimmedEmail, pattern: "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")
            ? nil
            : "Ingresa un correo válido"
    }

    var passwordError: String? {
        guard !password.isBlank else { return nil }
        return password.count >= Self.minimumPasswordLength
            ? nil
            : "La contraseña debe tener al menos \(Self.minimumPasswordLength) caracteres"
    }

    var passwordConfirmationError: String? {
        guard !passwordConfirmation.isBlank else { return nil }
        return password == passwordConfirmation ? nil : "Las contraseñas no coinciden"
    }

    var isFormValid: Bool {
        let hasEmptyFields = [username, email, password, passwordConfirmation].contains(where: \.isBlank)
        let errors = [usernameError, emailError, passwordError, passwordConfirmationError]
        return !hasEmptyFields && errors.allSatisfy { $0 == nil }
    }

    // MARK: - Registro

    /// Creates the account and, if it succeeds, opens the session
    func register(session: SessionViewModel) async {
        didAttemptSubmit = true
        guard isFormValid, !isLoading else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            _ = try await authService.register(
                username: trimmedUsername,
                email: trimmedEmail,
                password: password
            )
            try await session.didAuthenticate()
        } catch let error as APIError {
            // 409: usuario o correo ya registrados; 400: datos inválidos
            errorMessage = error.message
        } catch is URLError {
            errorMessage = "No se pudo conectar con el servidor. Revisa tu conexión."
        } catch {
            errorMessage = "Ocurrió un error inesperado. Inténtalo de nuevo."
        }
    }

    private static func matches(_ value: String, pattern: String) -> Bool {
        value.range(of: pattern, options: .regularExpression) != nil
    }
}
