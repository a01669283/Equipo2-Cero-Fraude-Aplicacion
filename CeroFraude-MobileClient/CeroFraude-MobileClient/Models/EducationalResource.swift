//
//  EducationalResource.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 05/10/26.
//

import Foundation

struct EducationalResource: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let recommendations: [Recommendation]
    let sources: [Source]
}

struct Recommendation: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case title
        case description
    }
}

struct Source: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
