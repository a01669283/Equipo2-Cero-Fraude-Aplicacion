//
//  PantallaInicialView.swift
//  CeroFraude-MobileClient
//
//  Created by Armando Vasquez on 08/09/26.
//

// VISTA DE PRUEBA
// Esta vista de prueba solo muestra la estructura base de las diferentes vistas que se tienen contempladas para el proyecto. No es parte del proyecto final y deberá eliminarse posteriormente antes de la entrega final. 

import SwiftUI

struct PantallaInicialView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "checkmark.shield.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.blue)

            Text("Cero Fraude")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Vista de prueba")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()

            Text("Test inicial para una pantalla")
                .font(.footnote)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 24)
        }
        .padding()
    }
}

#Preview {
    PantallaInicialView()
}
