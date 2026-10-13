//
//  CategoryCard.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 08/10/26.
//

import SwiftUI

struct SearchBar: View {
    @State private var hapticTrigger = false
    @Binding var query: String
    let text: String
    let onSubmit: () -> Void
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("BrandBlue"))
            TextField(
                text,
                text: $query,
                prompt: Text(text).foregroundStyle(Color("BrandBlue").opacity(0.7))
            )
                .textFieldStyle(.plain)
                .foregroundStyle(Color("BrandBlue"))
                .focused($isFocused)
                .submitLabel(.search)
                .onSubmit {
                    isFocused = false
                    onSubmit()
                }
                .onChange(of: query) { oldValue, newValue in
                    if newValue.count > 50 {
                        query = String(newValue.prefix(50))
                    }
                }

            if !query.isEmpty {
                Button {
                    query = ""
                    hapticTrigger.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .sensoryFeedback(.impact, trigger: hapticTrigger)

            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}
