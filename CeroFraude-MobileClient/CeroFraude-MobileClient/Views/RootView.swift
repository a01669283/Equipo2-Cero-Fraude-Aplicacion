//
//  RootView.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 12/10/26.
//

import SwiftUI

/// Decides which screen to show depending on the session state
struct RootView: View {

    @StateObject private var session = SessionViewModel()

    var body: some View {
        Group {
            switch session.state {
            case .loading:
                LoadingScreenView()
                    .task {
                        await session.start()
                    }
            case .loggedOut:
                WelcomeView()
            case .loggedIn:
                MainTabView()
            }
        }
        .environmentObject(session)
    }
}

#Preview {
    RootView()
}
