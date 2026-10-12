//
//  PostStatusBadge.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

import SwiftUI

enum BadgeVariant {
    case card
    case detail
}

/// Displays the validation status of a post as a styled badge
struct PostStatusBadge: View {
    
    /// The validation status displayed in the badge
    let status: ValidationStatus
    var variant: BadgeVariant = .card
    
    private var style: (text: String, foreground: Color, background: Color) {
        switch status {
        case .unvalidated:
            return (
                "Sin validar",
                Color("StatusUnvalidatedText"),
                Color("StatusUnvalidatedBackground")
            )
        case .notFraud:
            return (
                "No es fraude",
                Color("StatusNotFraudText"),
                Color("StatusNotFraudBackground")
            )
        case .isFraud:
            return (
                "Es fraude",
                Color("StatusFraudText"),
                Color("StatusFraudBackground")
            )
        }
    }
    
    var body: some View {
        Text(style.text)
            .font(variant == .card ? .system(size: 14, weight: .medium) : .system(size: 16, weight: .medium))
            .foregroundStyle(style.foreground)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(style.background)
            .clipShape(.capsule)
    }
}
