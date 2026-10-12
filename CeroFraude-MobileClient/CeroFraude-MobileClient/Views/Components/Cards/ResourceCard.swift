//
//  ResourceCard.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 05/10/26.
//

import SwiftUI

struct ResourceCard: View {
    let title: String
    let description: String
    let actionText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Post title and validation status
            HStack {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("BrandBlue"))
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color("TextPrimary"))
                    .lineLimit(3)
                    .truncationMode(.tail)
                
                Text(actionText)
                .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color("BrandGreen"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .gray.opacity(0.5), radius: 2, y: 2)
    }
}
