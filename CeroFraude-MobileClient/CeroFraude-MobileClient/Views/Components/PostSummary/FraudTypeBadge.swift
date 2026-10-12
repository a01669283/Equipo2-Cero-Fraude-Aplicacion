//
//  FraudTypeBadge.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

import SwiftUI

/// Displays a fraud type as a styled badge
struct FraudTypeBadge: View {
    
    /// The fraud type displayed in the badge
    let type: String
    
    var body: some View {
        Text(type)
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(Color("BrandBlue"))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color("FraudTypeBackground"))
            .clipShape(.capsule)
    }
}
