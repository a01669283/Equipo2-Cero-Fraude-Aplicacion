//
//  SearchPaginationView.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 10/10/26.
//

import SwiftUI

struct SearchPaginationView: View {
    
    let currentPage: Int
    let totalPages: Int
    let onPageSelected: (Int) -> Void
    @State private var hapticTrigger = false
    
    private var visiblePages: [Int] {
        guard totalPages > 0 else { return [] }
        if totalPages <= 5 {
            return Array(1...totalPages)
        }

        
        if currentPage == 1 {
            let pages = [
                1,
                2,
                3,
                totalPages
            ]
            return pages
        }
        
        if currentPage == 2 {
            let pages = [
                1,
                2,
                3,
                4,
                totalPages
            ]
            return pages
        }
        
        if currentPage == totalPages {
            let pages = [
                1,
                currentPage - 2,
                currentPage - 1,
                currentPage
            ]
            return pages
        }
        
        if currentPage == totalPages - 1 {
            let pages = [
                1,
                currentPage - 2,
                currentPage - 1,
                currentPage,
                currentPage + 1
            ]
            return pages
        }
        
        
        let pages = [
            1,
            currentPage - 1,
            currentPage,
            currentPage + 1,
            totalPages
        ]
        return pages
    }
    
    var body: some View {
        HStack(spacing: 12){
            
            ForEach(visiblePages, id: \.self) { (page : Int) in
                if let previousPage = visiblePages.last(where: { $0 < page}),
                    page - previousPage > 1 {
                        Text("...")
                        .foregroundStyle(.secondary)
                }
                Button {
                    onPageSelected(page)
                    hapticTrigger.toggle()
                } label: {
                    Text("\(page)")
                        .frame(width: 36, height: 36)
                        .background {
                            if page == currentPage {
                                Circle()
                                    .fill(Color.accentColor)
                            }
                        }
                        .foregroundStyle(
                            page == currentPage ? .white : .primary
                        )
                }
                .buttonStyle(.plain)
                .sensoryFeedback(.impact, trigger: hapticTrigger)
                .disabled(page == currentPage)
            }
        }
        .buttonStyle(.plain)
    }
}
