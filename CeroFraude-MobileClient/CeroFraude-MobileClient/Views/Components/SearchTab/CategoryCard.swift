//
//  CategoryCard.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 08/10/26.
//

import SwiftUI

struct CategoryCard: View {

    let title: String
    let image: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color("BrandGreen"))
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color("BrandBlue"))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray.opacity(0.5), radius: 1, y: 1)
    }
}
