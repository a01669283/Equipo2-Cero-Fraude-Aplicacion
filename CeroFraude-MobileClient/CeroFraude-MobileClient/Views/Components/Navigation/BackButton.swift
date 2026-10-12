//
//  BackButton.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    @State private var trigger = false
    
    var body: some View {
        Button {
            trigger.toggle()
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
        .buttonStyle(CircularToolbarButtonStyle())
        .accessibilityLabel("Regresar")
        .sensoryFeedback(.impact, trigger: trigger)
    }
}
