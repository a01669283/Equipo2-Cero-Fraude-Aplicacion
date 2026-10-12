//
//  MainTabView.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

import SwiftUI

/// Displays the custom tab bar used for the app's main navigation
struct MainTabBar: View {
    
    /// The index of the currently selected tab
    @Binding var selectedTab: Int
    
    /// The available tabs and their symbols
    let tabs = [
        ("house", "Inicio"),
        ("magnifyingglass", "Buscar"),
        ("chart.bar", "Tendencias"),
        ("person", "Perfil")
    ]
 
    var body: some View {
        GeometryReader { geometry in
            //Calculates the width available for each tab
            let tabWidth = geometry.size.width / CGFloat(tabs.count)
 
            ZStack(alignment: .center) {
                // Highlights the currently selected tab
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray.opacity(0.1))
                    .frame(width: tabWidth - 20, height: 52)
                    .offset(x: CGFloat(selectedTab) * tabWidth - geometry.size.width / 2 + tabWidth / 2)
                    .animation(.spring(response: 0.3), value: selectedTab)
 
                HStack(spacing: 0) {
                    ForEach(tabs.indices, id: \.self) { index in
                        Button {
                            withAnimation(.spring(response: 0.3)) {
                                selectedTab = index
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: tabs[index].0)
                                    .font(.system(size: 20))
                                    .bold()
 
                                if selectedTab == index {
                                    Text(tabs[index].1)
                                        .font(.caption2)
                                        .transition(.opacity)
                                }
                            }
                            .foregroundStyle(selectedTab == index ? Color("BrandGreen") : Color("BrandBlue"))
                            .frame(width: tabWidth, height: 60)
                        }
                        .accessibilityLabel(tabs[index].1)
                        .accessibilityAddTraits(
                            selectedTab == index ? .isSelected : []
                        )
                    }
                }
            }
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
        }
        .padding(.horizontal, 16)
        .frame(height: 70)
    }
}
