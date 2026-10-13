//
//  SearchResultsView.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 10/10/26.
//

import SwiftUI

struct SearchResultsView: View {
    
    @State private var hapticTrigger = false
    let category: Int?
    let text: String?
    @State var selectedType: Int? = 0
    
    init(category: Int? = nil, text: String? = nil, type: Int? = nil){
        self.category = category
        self.text = text
    }
    
    private let fraudTypes: [TypeFilter] = [
        TypeFilter(id: 0, title: "Todos"),
        TypeFilter(id: 1, title: "Producto falso"),
        TypeFilter(id: 2, title: "Precio engañoso"),
        TypeFilter(id: 3, title: "Promoción falsa"),
        TypeFilter(id: 4, title: "Vendedor falso"),
        TypeFilter(id: 5, title: "Tienda falsa"),
        TypeFilter(id: 6, title: "Suplantación de marca"),
        TypeFilter(id: 7, title: "Otro")
    ]
    
    
    @StateObject private var viewModel = SearchViewModel()
    
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Text(CatalogStorage.getCatalogs(id: category ?? 0, key: "categories")?.name ?? "Publicaciones")
                        .bold(true)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(Color("BrandBlue"))
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 20)
                
                HStack{
                    Text("Filtrar por tipo")
                        .bold(true)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(Color("BrandBlue"))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.leading, 5)
                
                TypeFilterBar(
                    filters: fraudTypes,
                    selectedType: $selectedType
                ) {
                    type in
                    Task {
                        if let type, type != 0 {
                            viewModel.filters.types = [ type ]
                        } else {
                            viewModel.filters.types = nil
                        }
                        viewModel.filters.page = 1
                        await viewModel.searchPosts()
                    }
                }
                .padding(.bottom, 0)
                
                if let text, text != "" {
                    HStack {
                        Text("Resultados para \"\(text)\"")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color("BrandBlue"))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    HStack {
                        Text("\(viewModel.posts?.total ?? 0) reportes encontrados")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color("BrandBlue"))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 0)
                }
                  
                if viewModel.posts?.totalPages != nil,  viewModel.posts?.totalPages ?? -1 == 0 {
                    VStack {
                        ContentUnavailableView(
                            "No se encontraron publicaciones",
                            systemImage: "magnifyingglass",
                            description: Text(
                                "Intenta con otras palabras clave o ajusta los filtros."
                            )
                            .font(.system(size: 16))
                        )
                        .foregroundStyle(Color("BrandBlue"))
                    }
                } else{
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 20) {
                                Color.clear
                                    .frame(height: 0)
                                    .id("top")
                                ForEach(viewModel.postSummaries, id: \.id) { post in
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
                            .padding(.horizontal, 20)
                            .padding(.bottom, 70)
                            
                            if let posts = viewModel.posts, posts.totalPages > 1 {
                                SearchPaginationView(
                                    currentPage: viewModel.posts?.page ?? 1,
                                    totalPages: viewModel.posts?.totalPages ?? 1
                                ) { page in
                                    Task {
                                        await viewModel.goToPage(page: page)
                                        
                                        withAnimation{
                                            proxy.scrollTo("top", anchor: .top)
                                        }
                                    }
                                }
                                .padding(.bottom, 70)
                                .padding(.top, 10)
                            }
                        }
                        .refreshable {
                            viewModel.filters.page = 1
                            await viewModel.searchPosts()
                        }
                    }
                }
                
            }
        }
        .customBackButton()
        .task {
            if (category != nil) {
                viewModel.filters.categories = [category!]
            } else{
                viewModel.filters.categories = []
            }
            if (text != nil) {
                viewModel.filters.text = text!
            } else{
                viewModel.filters.text = nil
            }
            await viewModel.searchPosts()
        }
        
    }
}


#Preview {
    SearchResultsView(category: 2)
}
