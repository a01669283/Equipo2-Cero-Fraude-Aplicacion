//
//  LoadingScreenView.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 06/10/26.
//

import SwiftUI

struct LoadingScreenView: View {
    
    var body: some View {
        Image("LoadingLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 220)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("AppBackground"))
            .ignoresSafeArea()
    }
}

#Preview {
    LoadingScreenView()
}
