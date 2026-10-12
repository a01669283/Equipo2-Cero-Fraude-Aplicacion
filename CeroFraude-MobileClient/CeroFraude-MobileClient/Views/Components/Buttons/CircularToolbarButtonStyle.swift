//
//  CircularToolbarButtonStyle.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import SwiftUI

struct CircularToolbarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 23))
            .bold()
            .foregroundStyle(Color("BrandBlue"))
            .frame(width: 46, height: 46)
            .background(.white)
            .clipShape(Circle())
            .shadow(
                color: .gray.opacity(0.5),
                radius: 3,
                y: 2
            )
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
