//
//  PostCardView.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

import SwiftUI

/// Displays the summary of a fraud post as an interactive card
struct PostCardView: View {
    
    ///The post whose information is displayed in the card
    let post: PostSummary
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Post title and validation status
            HStack {
                    Text(post.title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color("BrandBlue"))
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    
                    Spacer()
                    
                    PostStatusBadge(status: post.validationStatus)
                }
                
                // Displays uo to two fraud types in the card preview
                HStack(spacing: 8) {
                    let fraudTypes = post.fraudTypes.compactMap { id in
                        CatalogStorage.getCatalogs(
                            id: id,
                            key: "types"
                        )?.name
                    }
                    
                    ForEach(fraudTypes.prefix(2), id: \.self) { fraudType in
                        FraudTypeBadge(type: fraudType)
                    }
                    
                    if fraudTypes.count > 2 {
                        Text("+\(fraudTypes.count - 2)")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color("TextSecondary"))
                    }
                }
                
                Text(post.description)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color("TextPrimary"))
                    .lineLimit(3)
                    .truncationMode(.tail)
                
                Text(post.timeAgo)
                    .font(.system(size: 12))
                    .foregroundStyle(Color("TextSecondary"))
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .gray.opacity(0.5), radius: 6, y: 2)
    }
}
