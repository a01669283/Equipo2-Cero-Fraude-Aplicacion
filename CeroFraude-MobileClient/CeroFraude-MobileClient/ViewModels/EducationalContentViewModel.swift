//
//  EducationalContentViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 05/10/26.
//

import Combine
import Foundation

@MainActor
final class EducationalContentViewModel: ObservableObject {
    @Published var resources: [EducationalResource] = []
    
    private let localDataService = LocalDataService()
    
    func loadResources() {
        do {
            resources = try localDataService.load(
                "educational_content",
                as: [EducationalResource].self
            )
        } catch {
            // TODO: Handle loading error
        }
    }
}
