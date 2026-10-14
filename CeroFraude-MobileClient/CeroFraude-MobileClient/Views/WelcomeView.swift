//
//  WelcomeView.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 29/09/26.
//

import SwiftUI

/// Pantallas a las que se puede navegar desde la bienvenida
enum AuthRoute: Hashable {
    case login
    case register
}

struct WelcomeView: View {

    @EnvironmentObject private var session: SessionViewModel

    /// Ruta de navegación. Cambiar entre inicio de sesión y registro reemplaza
    /// la pantalla actual en lugar de apilar una nueva.
    @State private var path: [AuthRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            // El ScrollView solo se desplaza si el contenido no cabe
            // (pantallas pequeñas o tamaños de texto grandes).
            GeometryReader { geometry in
                ScrollView {
                    content
                        .frame(minHeight: geometry.size.height)
                }
                .scrollBounceBehavior(.basedOnSize)
                .background(Color("Background").ignoresSafeArea())
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .login:
                    LoginView(onSwitchToRegister: { path = [.register] })
                case .register:
                    RegisterView(onSwitchToLogin: { path = [.login] })
                }
            }
        }
        .sensoryFeedback(.impact(weight: .light), trigger: path)
    }

    private var content: some View {
        VStack(spacing: 0) {

            Spacer(minLength: 0)

            // Logo
            Image("WelcomeLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 280)
                .accessibilityLabel("Cero Fraude")

            VStack(spacing: 8) {
                Text("Infórmate antes de")
                    .foregroundStyle(Color("BrandBlue"))

                Text("confiar")
                    .foregroundStyle(Color("BrandPrimary"))
            }
            .font(.largeTitle.bold())
            .foregroundStyle(Color("BrandBlue"))
            .multilineTextAlignment(.center)
            .padding(.top, 25)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)

            // El texto se ajusta al ancho disponible en lugar de usar saltos de línea fijos
            Text("Consulta reportes de la comunidad y comparte experiencias sobre ofertas, productos o anuncios sospechosos")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color("TextSecondary"))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 320)
                .padding(.top, 32)

            Spacer(minLength: 32)

            // Aviso cuando no se pudo comprobar la sesión guardada
            if let startupMessage = session.startupMessage {
                FormErrorMessage(message: startupMessage, announces: true)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
            }

            // LoginView, iniciar sesión
            NavigationLink(value: AuthRoute.login) {
                Text("Iniciar sesión")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 62)
                    .background(Color("BrandPrimary"))
                    .clipShape(Capsule())
            }
            .accessibilityHint("Abre el formulario de inicio de sesión")

            // RegisterView, registro
            NavigationLink(value: AuthRoute.register) {
                Text("Crear cuenta")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(Color("BrandPrimary"))
                    .frame(maxWidth: .infinity, minHeight: 62)
                    .overlay(
                        Capsule()
                            .stroke(Color("BrandPrimary"), lineWidth: 1)
                    )
                    .contentShape(Capsule())
            }
            .accessibilityHint("Abre el formulario de registro")
            .padding(.top, 16)

            Spacer(minLength: 24)

            Image("RedCiberseguridadLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
                .accessibilityLabel("Red de Ciberseguridad")
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 30)
    }
}

#Preview {
    WelcomeView()
        .environmentObject(SessionViewModel())
}
