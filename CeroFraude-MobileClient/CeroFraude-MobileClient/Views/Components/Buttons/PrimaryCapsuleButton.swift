//
//  PrimaryCapsuleButton.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 09/10/26.
//

import SwiftUI

/// Botón principal en forma de cápsula con el color BrandPrimaryDark.
///

struct PrimaryCapsuleButton: View {
    let title: String

    /// Ocupa todo el ancho disponible, para alinearse con los campos de un formulario
    var isFullWidth = false

    /// Muestra un indicador de progreso junto al título
    var isLoading = false

    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled
    @State private var tapCount = 0

    var body: some View {
        Button {
            tapCount += 1
            action()
        } label: {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
                Text(title)
            }
            .font(.body.weight(.medium))
            .foregroundStyle(isEnabled || isLoading ? Color.white : Color("DisabledContent"))
            .padding(.horizontal, 24)
            .frame(maxWidth: isFullWidth ? .infinity : nil, minHeight: 48)
            .background(isEnabled || isLoading ? Color("BrandPrimaryDark") : Color("DisabledSurface"))
            .clipShape(Capsule())
            .contentShape(Capsule())
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: tapCount)
        .accessibilityLabel(title)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryCapsuleButton(title: "Cerrar sesión") {}
        PrimaryCapsuleButton(title: "Iniciar sesión", isFullWidth: true) {}
        PrimaryCapsuleButton(title: "Iniciar sesión", isFullWidth: true) {}
            .disabled(true)
        PrimaryCapsuleButton(title: "Iniciando sesión…", isFullWidth: true, isLoading: true) {}
            .disabled(true)
    }
    .padding(35)
}
