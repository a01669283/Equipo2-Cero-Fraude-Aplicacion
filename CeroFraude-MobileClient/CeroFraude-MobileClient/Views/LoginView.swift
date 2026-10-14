//
//  LoginView.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 29/09/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var session: SessionViewModel

    /// Reemplaza esta pantalla por la de registro
    var onSwitchToRegister: () -> Void = {}

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                Image("WelcomeLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                    .accessibilityLabel("Cero Fraude")

                Text("Iniciar Sesión")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color("BrandBlue"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 45)
                    .accessibilityAddTraits(.isHeader)

                VStack(alignment: .leading, spacing: 18) {

                    RequiredTextField(
                        label: "Correo o nombre de usuario",
                        placeholder: "Ingresa tu correo o nombre de usuario",
                        text: $viewModel.identifier,
                        showsError: viewModel.didAttemptSubmit
                    )

                    RequiredTextField(
                        label: "Contraseña",
                        placeholder: "Ingresa tu contraseña",
                        text: $viewModel.password,
                        isSecure: true,
                        showsError: viewModel.didAttemptSubmit
                    )

                    // Error devuelto por la API o por la conexión
                    if let errorMessage = viewModel.errorMessage {
                        FormErrorMessage(message: errorMessage, announces: true)
                    }

                    // Se desactiva hasta llenar los campos y mientras se envía la solicitud
                    PrimaryCapsuleButton(
                        title: viewModel.isLoading ? "Iniciando sesión…" : "Iniciar sesión",
                        isFullWidth: true,
                        isLoading: viewModel.isLoading
                    ) {
                        Task { await viewModel.login(session: session) }
                    }
                    .disabled(!viewModel.isFormValid || viewModel.isLoading)
                    .accessibilityHint(viewModel.isFormValid ? "" : "Completa todos los campos para continuar")
                    .padding(.top, 12)
                }
                .padding(.horizontal, 35)
                .padding(.top, 40)

                VStack(spacing: 8) {
                    Text("¿No tienes una cuenta?")
                        .foregroundStyle(Color("TextSecondary"))

                    Button("Crear cuenta", action: onSwitchToRegister)
                        .foregroundStyle(Color("BrandGreen"))
                        .fontWeight(.medium)
                        .accessibilityHint("Abre el formulario de registro")
                }
                .multilineTextAlignment(.center)
                .padding(.top, 50)

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
        LoginView()
    }
    .environmentObject(SessionViewModel())
}
