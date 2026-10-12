//
//  AuthoritiesView.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 05/10/26.
//

import SwiftUI

struct AuthoritiesView: View {
    @StateObject private var viewModel = EducationalContentViewModel()
    @State private var hapticTrigger = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text("Recursos y orientación")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color("BrandBlue"))
                    
                    Text("Aprende a identificar ofertas sospechosas y conoce qué hacer y a quién acudir.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color("TextSecondary"))
                        .opacity(0.8)
                        .frame(width: 300)
                        .multilineTextAlignment(.center)
                    
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(viewModel.resources) { resource in
                            NavigationLink {
                                EducationResourceView(resource: resource)
                            } label: {
                                ResourceCard(
                                title: resource.title,
                                description: resource.description,
                                actionText: "Ver recomendaciones >")
                            }
                            .padding(.horizontal, 5)
                            .buttonStyle(.plain)
                            .simultaneousGesture(
                                TapGesture().onEnded {
                                    hapticTrigger.toggle()
                                }
                            )
                            .sensoryFeedback(.impact, trigger: hapticTrigger)
                        }
                    }
                    
                    Text("¿Necesitas ayuda?")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color("BrandBlue"))
                }
                .onAppear {
                    viewModel.loadResources()
                }
            }
            .padding()
            .padding(.bottom, 80)
        }
        .customBackButton()
    }
}

#Preview {
    NavigationStack {
        AuthoritiesView()
    }
}
