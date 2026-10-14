//
//  RegisterView.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 29/09/26.
//

import SwiftUI

struct RegisterView: View {

    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject private var session: SessionViewModel

    /// Reemplaza esta pantalla por la de inicio de sesión
    var onSwitchToLogin: () -> Void = {}

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                Image("WelcomeLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                    .accessibilityLabel("Cero Fraude")

                Text("Crear cuenta")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color("BrandBlue"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .accessibilityAddTraits(.isHeader)

                Text("Todos los campos son obligatorios")
                    .italic()
                    .foregroundStyle(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 18) {

                    RequiredTextField(
                        label: "Nombre de usuario",
                        placeholder: "Elige un nombre de usuario",
                        text: $viewModel.username,
                        showsError: viewModel.didAttemptSubmit,
                        customError: viewModel.usernameError
                    )

                    RequiredTextField(
                        label: "Correo electrónico",
                        placeholder: "usuario@correo.com",
                        text: $viewModel.email,
                        keyboardType: .emailAddress,
                        showsError: viewModel.didAttemptSubmit,
                        customError: viewModel.emailError
                    )

                    RequiredTextField(
                        label: "Contraseña",
                        placeholder: "Mínimo \(RegisterViewModel.minimumPasswordLength) caracteres",
                        text: $viewModel.password,
                        isSecure: true,
                        showsError: viewModel.didAttemptSubmit,
                        customError: viewModel.passwordError
                    )

                    RequiredTextField(
                        label: "Confirmar contraseña",
                        placeholder: "Confirma tu contraseña",
                        text: $viewModel.passwordConfirmation,
                        isSecure: true,
                        showsError: viewModel.didAttemptSubmit,
                        customError: viewModel.passwordConfirmationError
                    )

                    // Error devuelto por la API o por la conexión
                    if let errorMessage = viewModel.errorMessage {
                        FormErrorMessage(message: errorMessage, announces: true)
                    }

                    // Se desactiva hasta que el formulario sea válido y mientras se envía la solicitud
                    PrimaryCapsuleButton(
                        title: viewModel.isLoading ? "Creando cuenta…" : "Crear cuenta",
                        isFullWidth: true,
                        isLoading: viewModel.isLoading
                    ) {
                        Task { await viewModel.register(session: session) }
                    }
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)
                    .accessibilityHint(viewModel.isFormValid ? "" : "Completa todos los campos correctamente para continuar")
                    .padding(.top, 17)
                }
                .padding(.horizontal, 35)
                .padding(.top, 30)

                VStack(spacing: 8) {
                    Text("¿Ya tienes una cuenta?")
                        .foregroundStyle(Color("TextSecondary"))

                    Button("Iniciar sesión", action: onSwitchToLogin)
                        .foregroundStyle(Color("BrandGreen"))
                        .fontWeight(.medium)
                        .accessibilityHint("Abre el formulario de inicio de sesión")
                }
                .multilineTextAlignment(.center)
                .padding(.top, 30)

                Image("RedCiberseguridadLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 40)
                    .padding(.vertical, 30)
                    .accessibilityLabel("Red de Ciberseguridad")
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .dismissKeyboardOnTap()
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color("Background").ignoresSafeArea())
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .sensoryFeedback(trigger: viewModel.errorMessage) { _, newValue in
            newValue == nil ? nil : .error
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView()
    }
    .environmentObject(SessionViewModel())
}
