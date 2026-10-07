//
//  FieldHeader.swift
//  CeroFraude-MobileClient
//
//  Created by Armando Vasquez on 03/10/26.
//

import SwiftUI

/// Etiqueta de un campo del formulario con mensaje de error opcional.
///
/// Si el mensaje de error cabe, se muestra a la derecha de la etiqueta;
/// si no, se muestra debajo.
struct FieldHeader: View {
    /// Texto de la etiqueta.
    let label: String
    /// Mensaje de error. Si es `nil`, solo se muestra la etiqueta.
    var errorMessage: String? = nil

    var body: some View {
        if let errorMessage {
            ViewThatFits(in: .horizontal) {
                HStack {
                    labelText
                    Spacer()
                    errorLabel(errorMessage)
                }
                VStack(alignment: .leading, spacing: 4) {
                    labelText
                    errorLabel(errorMessage)
                }
            }
        } else {
            labelText
        }
    }

    private var labelText: some View {
        Text(label)
            .font(.subheadline)
            .foregroundStyle(Color(.textLabel))
    }

    private func errorLabel(_ message: String) -> some View {
        Label(message, systemImage: "exclamationmark.circle")
            .font(.subheadline.weight(.medium))
            .foregroundStyle(Color(.danger))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 20) {
        FieldHeader(label: "Título*")
        FieldHeader(label: "Título*", errorMessage: "Falta el título")
    }
    .padding()
}
