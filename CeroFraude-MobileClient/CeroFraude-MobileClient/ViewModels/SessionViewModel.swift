//
//  SessionViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 12/10/26.
//

import Foundation
import Combine

/// Keeps track of whether the user is logged in and decides which screen the app shows
@MainActor
final class SessionViewModel: ObservableObject {

    enum State {
        /// The app is checking for a saved session
        case loading
        /// There is no valid session; the welcome screen is shown
        case loggedOut
        /// The user is authenticated
        case loggedIn(UserDTO)
    }

    @Published private(set) var state: State = .loading

    /// Message shown on the welcome screen when the saved session could not be checked
    @Published private(set) var startupMessage: String?

    /// The authenticated user, or `nil` if there is no session
    ///
    /// Any view below `RootView` can read it with `@EnvironmentObject var session: SessionViewModel`
    /// (for example the profile, or the author when publishing a post).
    var currentUser: UserDTO? {
        if case .loggedIn(let user) = state {
            return user
        }
        return nil
    }

    private let authService = AuthService()
    private let userService = UserService()

    /// Restores the saved session when the app starts
    ///
    /// The loading screen stays visible for at least one second so it doesn't flash.
    func start() async {
        let minimumDisplay = Task {
            try? await Task.sleep(for: .seconds(1))
        }
        let restoredState = await restoreSession()
        await minimumDisplay.value
        state = restoredState
    }

    /// Loads the authenticated user after a successful login or registration
    func didAuthenticate() async throws {
        let user = try await fetchCurrentUser()
        startupMessage = nil
        state = .loggedIn(user)
    }

    /// Reloads the authenticated user from the API, for example after editing the profile
    func reloadCurrentUser() async throws {
        guard currentUser != nil else { return }
        state = .loggedIn(try await fetchCurrentUser())
    }

    /// Removes the stored tokens and returns to the welcome screen
    func logout() {
        authService.logout()
        state = .loggedOut
    }

    private func restoreSession() async -> State {
        guard TokenStorage.getRefreshToken() != nil else {
            return .loggedOut
        }

        do {
            return .loggedIn(try await fetchCurrentUser())
        } catch let error as APIError where error.statusCode == 401 {
            // The refresh token is no longer valid
            authService.logout()
            return .loggedOut
        } catch let error as URLError where error.code == .userAuthenticationRequired {
            authService.logout()
            return .loggedOut
        } catch {
            // Keep the tokens so the session can be restored once the server is reachable
            startupMessage = "No se pudo conectar con el servidor. Revisa tu conexión."
            return .loggedOut
        }
    }

    /// Gets the authenticated user, refreshing the access token once if it expired
    private func fetchCurrentUser() async throws -> UserDTO {
        do {
            return try await userService.getCurrentUser()
        } catch let error as APIError where error.statusCode == 401 {
            _ = try await authService.refreshAccessToken()
            return try await userService.getCurrentUser()
        }
    }
}
