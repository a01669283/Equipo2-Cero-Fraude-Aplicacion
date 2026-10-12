//
//  PostTagBadge.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import SwiftUI

struct PostTagBadge: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color("TextPrimary"))
            .opacity(0.8)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray.opacity(0.25), lineWidth: 1)
            }
            .shadow(
                color: .black.opacity(0.08),
                radius: 2,
                y: 1
            )
    }
}
