//
//  PostDetailView.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 28/09/26.
//

import SwiftUI
import PhotosUI

struct PostDetailView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Titulo epico")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color("TextPrimary"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
            
                    HStack (spacing: 6) {
                        Text("Por usuario")
                            .font(.system(size: 15))
                            .foregroundStyle(Color("TextSecondary"))
                        Text("·")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color("TextSecondary"))
                        Text("Hace 3 horas")
                            .font(.system(size: 15))
                            .foregroundStyle(Color("TextSecondary"))
                    }
                    .padding(.leading, 5)
                    .padding(.bottom, 10)
                    
                    PostStatusBadge(status: .isFraud, variant: .detail)
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Categoría")
                            .font(.system(size: 16))
                            .foregroundStyle(Color("TextPrimary"))
                            .opacity(0.9)

                        PostTagBadge(name: "Redes Sociales")
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        // TODO: tipo | tipos
                        Text("Tipos")
                            .font(.system(size: 16))
                            .foregroundStyle(Color("TextPrimary"))
                            .opacity(0.9)
                        
//                        ForEach(post.fraudTypes.prefix(2), id: \.self) { fraudType in
//                            FraudTypeBadge(type: fraudType)
//                        }
//                        
//                        if post.fraudTypes.count > 2 {
//                            Text("+\(post.fraudTypes.count - 2)")
//                                .font(.system(size: 12, weight: .medium))
//                                .foregroundStyle(Color("TextSecondary"))
//                        }
                        HStack(spacing: 5) {
                            PostTagBadge(name: "Fraude bancario")
                            PostTagBadge(name: "Fraude bancario")
                        }
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Descripción")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color("TextPrimary"))
                        Text("descripcion ")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(Color("TextPrimary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(3)
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Evidencias")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color("TextPrimary"))
//                        AsyncImage(url: URL(string: imageURL)) { image in
//                            image
//                                .resizable()
//                                .scaledToFill()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(height: 200)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("¿Te resultó útil este reporte?")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(Color("TextPrimary"))
                        HStack {
                            Image(systemName: "hand.thumbsup")
                                .foregroundStyle(Color("BrandGreen"))
                            Image(systemName: "hand.thumbsdown")
                                .foregroundStyle(Color("BrandGreen"))
                        }
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Comentarios del moderador")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color("TextPrimary"))
                        Text("comentario badge")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color("TextPrimary"))
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
            }
            .customBackButton()
            .toolbar {
                if #available(iOS 26.0, *) {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                        .buttonStyle(CircularToolbarButtonStyle())
                    }
                    .sharedBackgroundVisibility(.hidden)
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                        .buttonStyle(CircularToolbarButtonStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    PostDetailView()
}
