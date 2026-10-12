//
//  MainTabBar.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

import SwiftUI

/// Manages the app's main navigation between primary tabs
struct MainTabView: View {
    
    /// The index of the currently selected tab
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            NavigationStack {
                HomeView()
            }
            .toolbar(.hidden, for: .tabBar)
            .tag(0)
            
            Text("buscar")
                .toolbar(.hidden, for: .tabBar)
                .tag(1)
            
            Text("tendencias")
                .toolbar(.hidden, for: .tabBar)
                .tag(2)
            
            Text("perfil")
                .toolbar(.hidden, for: .tabBar)
                .tag(3)
        }
        .toolbar(.hidden, for: .tabBar)
        .overlay(alignment: .bottom) {
            MainTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 16)
                .offset(y: 10)
        }
    }
}

#Preview {
    MainTabView()
}
