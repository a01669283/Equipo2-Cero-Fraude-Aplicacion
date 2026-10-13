//
//  SearchView.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 08/10/26.
//

import SwiftUI

struct SearchView: View {

    @State private var searchText = ""
    @State private var shouldNavigate = false
    @State private var hapticTrigger = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
                .onTapGesture {
                    dismissKeyboard()
                }
            VStack(spacing: 20) {
                HStack {
                    Text("Buscar")
                        .bold(true)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(Color("BrandBlue"))
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                SearchBar(query: $searchText, text: "Buscar publicaciones") {
                    let query = searchText.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                    
                    guard !query.isEmpty else { return }
                    searchText = query
                    shouldNavigate = true
                }
                    .padding(.bottom, 20)
                    .padding(.top, 5)
                HStack {
                    Text("Explorar por origen")
                        .bold(true)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(Color("BrandBlue"))
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .center, spacing: 30) {
                    NavigationLink {
                        SearchResultsView(category: 1)
                    } label: {
                        CategoryCard(
                            title: "Redes sociales",
                            image: "person.2.fill"
                        )
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hapticTrigger.toggle()
                        }
                    )
                    .sensoryFeedback(.impact, trigger: hapticTrigger)
                    
                    NavigationLink {
                        SearchResultsView(category: 2)
                    } label: {
                        CategoryCard(
                            title: "Marketplace",
                            image: "storefront.fill"
                        )
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hapticTrigger.toggle()
                        }
                    )
                    .sensoryFeedback(.impact, trigger: hapticTrigger)
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .center, spacing: 30) {
                    NavigationLink {
                        SearchResultsView(category: 3)
                    } label: {
                        CategoryCard(
                            title: "Mensajes",
                            image: "message.fill"
                        )
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hapticTrigger.toggle()
                        }
                    )
                    .sensoryFeedback(.impact, trigger: hapticTrigger)
                    
                    NavigationLink {
                        SearchResultsView(category: 4)
                    } label: {
                        CategoryCard(
                            title: "Correo",
                            image: "envelope.fill"
                        )
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hapticTrigger.toggle()
                        }
                    )
                    .sensoryFeedback(.impact, trigger: hapticTrigger)
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .center, spacing: 30) {
                    NavigationLink {
                        SearchResultsView(category: 5)
                        
                    } label: {
                        CategoryCard(
                            title: "Sitios web",
                            image: "globe"
                        )
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hapticTrigger.toggle()
                        }
                    )
                    .sensoryFeedback(.impact, trigger: hapticTrigger)
                    
                    NavigationLink {
                        SearchResultsView(category: 6)
                    } label: {
                        CategoryCard(
                            title: "Otros",
                            image: "ellipsis.circle.fill"
                        )
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hapticTrigger.toggle()
                        }
                    )
                    .sensoryFeedback(.impact, trigger: hapticTrigger)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
            }
            .padding(.top, 20)
        }
        .navigationDestination(isPresented: $shouldNavigate){
            SearchResultsView(text: searchText)
        }
    }
}

private func dismissKeyboard(){
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
    )
}

#Preview {
    SearchView()
}
