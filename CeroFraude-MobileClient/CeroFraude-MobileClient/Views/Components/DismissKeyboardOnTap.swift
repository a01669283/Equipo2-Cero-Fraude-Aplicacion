//
//  DismissKeyboardOnTap.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 29/09/26.
//

import SwiftUI

extension View {
    // Oculta el teclado al tocar fuera de un campo
    func dismissKeyboardOnTap() -> some View {
        contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
    }
}
