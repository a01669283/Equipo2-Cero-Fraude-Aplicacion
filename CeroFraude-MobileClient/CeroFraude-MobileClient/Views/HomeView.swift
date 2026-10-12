//
//  HomeView.swift
//  CeroFraude-MobileClient
//
//  Created by Mariana on 21/09/26.
//

import SwiftUI

/// The main screen displayed to authenticated users
///
/// Provides access to fraud post creation, guidance resources,
/// and recently published fraud posts.

struct HomeView: View {
    @State private var hapticTrigger = false
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var postsViewModel = PostSummaryViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                
                // Header
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top) {
                        Image("HomeLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240)
                            .accessibilityHidden(true)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        VStack(spacing: 5){
                            NavigationLink {
                                AuthoritiesView()
                            } label: {
                                Image(systemName: "shield")
                            }
                            .buttonStyle(CircularToolbarButtonStyle())
                            .simultaneousGesture(
                                TapGesture().onEnded {
                                    hapticTrigger.toggle()
                                }
                            )
                            .sensoryFeedback(.impact, trigger: hapticTrigger)
                            .accessibilityLabel("Orientación y actividades")
                            .accessibilityHint("Muestra recursos y autoridades que pueden orientarte")
                            
                            Text("¿Necesitas orientación?")
                                .frame(width: 100, alignment: .center)
                                .font(.footnote)
                                .foregroundStyle(.black.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .accessibilityHidden(true)
                        }
                        .padding(.top, 20)
                    }
                    
                    Text("Hola, \(viewModel.user?.username ?? "")")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color("BrandBlue"))
                        .padding(.top, -15)
                        .padding(.leading, 25)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Report creation
                    Text("¿Viste una oferta que podría ser engañosa?")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(Color("TextSecondary"))
                        .padding(.top, 40)
                        .padding(.bottom, 30)
                    
                    CreateReportButton {}
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 45)
                    
                    // Recent reports
                    VStack(alignment: .leading) {
                        Text("Reportes recientes")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundStyle(Color("BrandBlue"))
                            .padding(.bottom, 1)
                        
                        Text("Consulta algúnos de los últimos reportes.")
                            .font(.callout)
                            .foregroundStyle(Color("TextPrimary"))
                    }
                    .padding(.leading, 5)
                    .padding(.bottom, 10)
                    
                    
                    VStack(spacing: 20) {
                        ForEach(postsViewModel.postSummaries, id: \.id) { post in
                            NavigationLink {
                                PostDetailView()
                            }
                            label: {
                                PostCardView(post: post)
                            }
                            .simultaneousGesture(
                                TapGesture().onEnded {
                                    hapticTrigger.toggle()
                                }
                            )
                            .sensoryFeedback(.impact, trigger: hapticTrigger)
                        }
                    }
                    
                    Button("Ver más") {
                        hapticTrigger.toggle()
                        // TODO: Navigate to the full list of posts
                    }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color("BrandGreen"))
                        .frame(maxWidth: .infinity)
                        .sensoryFeedback(.impact, trigger: hapticTrigger)

                }
                .padding()
                .padding(.bottom, 80)
            }
        }.task {
            await viewModel.loadUser()
        }
    }
}
