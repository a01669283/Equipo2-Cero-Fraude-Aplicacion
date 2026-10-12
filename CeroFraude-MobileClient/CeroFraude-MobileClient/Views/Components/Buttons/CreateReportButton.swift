//
//  CreateReportButton.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

import SwiftUI

/// A button that allows the user to start creating a new fraud post.
///
/// Displays the primary call-to-action used to navigate to the report creation flow.
struct CreateReportButton: View {
    /// The action performed when the button is tapped
    let action: () -> Void
    
    @State private var trigger = false
    
    var body: some View {
        Button {
            trigger.toggle()
            action()
        } label: {
            Text("Repórtala")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.white)
                .frame(width: 200, height: 36)
        }
        .sensoryFeedback(.impact, trigger: trigger)
        
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .tint(Color("BrandGreen"))
        
        .accessibilityLabel("Crear reporte")
        .accessibilityHint("Abre el formulario para reportar una posible oferta fraudulenta")
    }
}
