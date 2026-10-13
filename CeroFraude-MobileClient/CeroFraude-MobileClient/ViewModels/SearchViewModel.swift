//
//  SearchViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 10/10/26.
//

import Combine
import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    
    @Published var posts: ResponsePostsDTO?
    @Published var postSummaries: [PostSummary] = []
    
    @Published var errorMessage: String?
    @Published var resources: [EducationalResource] = []
    @Published var selectedType: Int?
    private let postService = PostService()
    private let localDataService = LocalDataService()
    var filters = FindPostsDto()
    
    func searchPosts() async {
        do {
            let response = try await postService.searchPosts(findPosts: filters)
            posts = response
            postSummaries = response.data.map { dto in
                toPostSummary(dto)
            }
        } catch {
            
        }
    }
    
    private func getValidationStatus(from isFraud: Int?) -> ValidationStatus {
        switch isFraud {
        case 1:
            return .isFraud
        case 0:
            return .notFraud
        default:
            return .unvalidated
        }
    }
    
    private func getTimeAgo(from publishedAt: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = formatter.date(from: publishedAt) else {
            return ""
        }
        
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.locale = Locale(identifier: "es_MX")
        relativeFormatter.unitsStyle = .full
        
        let timeAgo = relativeFormatter.localizedString(
            for: date,
            relativeTo: Date()
        )

        return timeAgo.prefix(1).uppercased() + timeAgo.dropFirst()
    }
    
    private func toPostSummary(_ dto: PostSummaryDTO) -> PostSummary {
        return PostSummary(
            id: dto.id,
            title: dto.title,
            fraudTypes: dto.types,
            description: dto.description,
            validationStatus: getValidationStatus(from: dto.isFraud),
            timeAgo: getTimeAgo(from: dto.publishedAt)
        )
    }
    
    func goToPage(page: Int) async {
        guard page >= 1,
              page <= (posts?.totalPages ?? 1),
              page != filters.page
        else {
            return
        }
        
        filters.page = page
        await searchPosts()
    }
}
