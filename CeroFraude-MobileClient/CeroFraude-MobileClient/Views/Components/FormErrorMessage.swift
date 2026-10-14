//
//  FormErrorMessage.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 13/10/26.
//

import SwiftUI

/// Mensaje de error con ícono de advertencia.
///
///

struct FormErrorMessage: View {

    let message: String

    /// Si es `true`, VoiceOver lee el mensaje en cuanto aparece o cambia.

    var announces = false

    var body: some View {
        Label {
            Text(message)
                .fixedSize(horizontal: false, vertical: true)
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
        }
        .font(.subheadline)
        .foregroundStyle(Color("Danger"))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Error: \(message)")
        .onAppear(perform: announce)
        .onChange(of: message) { announce() }
    }

    private func announce() {
        guard announces else { return }
        AccessibilityNotification.Announcement("Error: \(message)").post()
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        FormErrorMessage(message: "Este campo es obligatorio")
        FormErrorMessage(message: "No se pudo conectar con el servidor. Revisa tu conexión.")
    }
    .padding()
}
