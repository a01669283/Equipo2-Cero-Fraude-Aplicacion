//
//  RequiredTextField.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 29/09/26.
//

import SwiftUI

/// Campo obligatorio de los formularios de inicio de sesión y registro.
///

struct RequiredTextField: View {

    let label: String
    let placeholder: String

    @Binding var text: String

    var isSecure = false
    var keyboardType: UIKeyboardType = .default

    let showsError: Bool
    var customError: String? = nil

    @State private var isTextVisible = false
    /// Se activa cuando el usuario sale del campo después de escribir algo
    @State private var hasLeftField = false
    @FocusState private var isFocused: Bool

    private var errorMessage: String? {
        if text.isBlank {
            return showsError ? "Este campo es obligatorio" : nil
        }
        return showsError || hasLeftField ? customError : nil
    }

    private var placeholderText: Text {
        Text(placeholder).foregroundStyle(Color("IconMuted"))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack(spacing: 3) {
                Text(label)
                    .foregroundStyle(Color("TextLabel"))
                Text("*")
                    .foregroundStyle(errorMessage == nil ? Color("TextSecondary") : Color("Danger"))
            }
            .accessibilityHidden(true)

            HStack {
                Group {
                    if isSecure && !isTextVisible {
                        SecureField(label, text: $text, prompt: placeholderText)
                    } else {
                        TextField(label, text: $text, prompt: placeholderText)
                    }
                }
                .foregroundStyle(Color("TextPrimary"))
                .keyboardType(keyboardType)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .focused($isFocused)
                .onSubmit { isFocused = false }
                .accessibilityLabel(label)
                .accessibilityHint(errorMessage.map { "Error: \($0)" } ?? "Campo obligatorio")

                if isSecure {
                    Button {
                        isTextVisible.toggle()
                    } label: {
                        // El ícono refleja el estado actual: ojo abierto = contraseña visible
                        Image(systemName: isTextVisible ? "eye" : "eye.slash")
                            .foregroundStyle(Color("IconMuted"))
                            .frame(minWidth: 44, minHeight: 44)
                            .contentShape(Rectangle())
                    }
                    .sensoryFeedback(.selection, trigger: isTextVisible)
                    .accessibilityLabel(isTextVisible ? "Ocultar contraseña" : "Mostrar contraseña")
                }
            }
            .padding(.horizontal, 12)
            .frame(minHeight: 52)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(errorMessage == nil ? Color("FieldBorder") : Color("Danger"))
            )

            if let errorMessage {
                FormErrorMessage(message: errorMessage)
                    // VoiceOver ya lo lee como pista del campo
                    .accessibilityHidden(true)
            }
        }
        .onChange(of: isFocused) {
            if !isFocused && !text.isBlank {
                hasLeftField = true
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        RequiredTextField(
            label: "Nombre de usuario",
            placeholder: "Elige un nombre de usuario",
            text: .constant(""),
            showsError: true
        )
        RequiredTextField(
            label: "Contraseña",
            placeholder: "Ingresa tu contraseña",
            text: .constant("corta"),
            isSecure: true,
            showsError: true,
            customError: "La contraseña debe tener al menos 10 caracteres"
        )
    }
    .padding()
}
