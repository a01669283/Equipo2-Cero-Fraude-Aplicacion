//
//  ResponsePostsDTO.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 04/10/26.
//

import Foundation

struct ResponsePostsDTO: Decodable {
    let data: [PostSummaryDTO]
    let page: Int
    let totalPages: Int
    let total: Int

    enum CodingKeys: String, CodingKey {
        case data
        case page
        case totalPages = "total_pages"
        case total
    }
}
