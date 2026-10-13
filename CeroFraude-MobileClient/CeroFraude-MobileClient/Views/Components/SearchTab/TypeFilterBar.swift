//
//  TypeFilterBar.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 11/10/26.
//

import SwiftUI

struct TypeFilter: Identifiable {
    let id: Int
    let title: String
}

struct TypeFilterBar: View {
    let filters: [TypeFilter]
    @Binding var selectedType: Int?
    let onSelectionChanged: (Int?) -> Void
    @State private var hapticTrigger = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 8){
                ForEach(filters) { filter in
                    let isSelected = selectedType == filter.id
                
                    Button{
                        let newSelection = isSelected ? nil : filter.id
                        selectedType = newSelection
                        onSelectionChanged(newSelection)
                        hapticTrigger.toggle()
                    } label: {
                        Text(filter.title)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .foregroundStyle(
                                isSelected ? .white :  Color("BrandBlue")
                            )
                            .background {
                                Capsule()
                                    .fill(
                                        isSelected ? Color("BrandGreen") : Color.clear,
                                    )
                            }
                            .overlay {
                                Capsule()
                                    .stroke(
                                        Color("BrandGreen"),
                                        lineWidth: 1
                                    )
                            }
                            .sensoryFeedback(.impact, trigger: hapticTrigger)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
