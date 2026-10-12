//
//  CustomBackButtonModifier.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import SwiftUI

struct CustomBackButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if #available(iOS 26.0, *) {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton()
                    }
                    .sharedBackgroundVisibility(.hidden)
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton()
                    }
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        modifier(CustomBackButtonModifier())
    }
}
