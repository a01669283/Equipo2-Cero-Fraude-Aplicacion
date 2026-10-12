//
//  EducationResourceView.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 05/10/26.
//

import SwiftUI

struct EducationResourceView: View {
    let resource: EducationalResource
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    VStack(alignment: .center, spacing: 20) {
                        Image(systemName: "shield.checkered")
                                .font(.system(size: 36))
                                .foregroundStyle(Color("BrandGreen"))
                        
                        Text(resource.title)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(Color("BrandBlue"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        Text(resource.description)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundStyle(Color("TextSecondary"))
                            .frame(maxWidth: 300, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(0)
                    
                    ForEach(resource.recommendations) { recommendation in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(Color("BrandGreen"))
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(recommendation.title)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(Color("BrandBlue"))
                                Text(recommendation.description)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(Color("TextPrimary"))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Fuentes")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color("BrandBlue"))

                        Text("Consulta información oficial y recomendaciones para prevenir fraudes en:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color("TextSecondary"))
                        
                        ForEach(resource.sources) {source in
                            Link(destination: URL(string: source.url)!) {
                                HStack {
                                    Text(source.name)
                                    Image(systemName: "arrow.up.right")
                                }
                                .font(.system(size: 17, weight: .medium))
                                .foregroundStyle(Color("BrandGreen"))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 0)
                .padding(.horizontal, 15)
                .padding(.bottom, 80)
            }
            .customBackButton()
        }
    }
}

//#Preview {
//    EducationResourceView()
//}
