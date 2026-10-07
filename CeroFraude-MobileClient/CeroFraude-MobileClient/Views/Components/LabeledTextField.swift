//
//  LabeledTextField.swift
//  CeroFraude-MobileClient
//
//  Created by Armando Vasquez on 24/09/26.
//

import SwiftUI

/// Campo de texto del formulario con etiqueta, límite de caracteres y mensaje de error opcional.
///
/// Recorta el texto automáticamente cuando supera `maxLength`.
struct LabeledTextField: View {

    //Propiedades
    /// Texto que se muestra arriba del campo.
    let label: String
    /// Texto de ayuda que se muestra cuando el campo está vacío.
    let placeholder: String
    /// Texto del campo. No guarda datos, solo los recibe y los escribe.
    @Binding var text: String
    /// Número máximo de caracteres permitidos.
    let maxLength: Int
    /// Si es `true`, el campo muestra 4 líneas en lugar de 1.
    var isMultiline = false
    /// Tipo de teclado. Si no es `.default`, se desactivan la autocorrección y las mayúsculas automáticas.
    var keyboard: UIKeyboardType = .default
    /// Mensaje de error. Si no es `nil`, se muestra junto a la etiqueta y el borde cambia a rojo.
    var errorMessage: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            FieldHeader(label: label, errorMessage: errorMessage)
            
            TextField(placeholder, text: $text, axis: isMultiline ? .vertical : .horizontal)
            // Modificador de multiline
                .lineLimit(isMultiline ? 4...4 : 1...1)
            // Modificadores de entrada de teclado
                .keyboardType(keyboard)
                .textInputAutocapitalization(keyboard == .default ? .sentences : .never)
                .autocorrectionDisabled(keyboard != .default)
            //Modificadores visuales
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(minHeight: 47)
                .background(.white, in: RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(errorMessage == nil ? Color(.fieldBorder) : Color(.danger), lineWidth: 1))
                .onChange(of: text) {_, newValue in
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
        }
    }
}

// Preview generado del componente aislado
#Preview {
    LabeledTextField(
        label: "Título*",
        placeholder: "Escribe un título",
        text: .constant(""),
        maxLength: 100
    )
    .padding()
}
