//
//  PostSummaryDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import Foundation

struct PostSummaryDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let statusId: Int
    let isFraud: Int?
    let publishedAt: String
    let author: String?
    let category: Int
    let types: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case statusId = "status_id"
        case isFraud = "is_fraud"
        case publishedAt = "published_at"
        case author
        case category
        case types
    }
}
