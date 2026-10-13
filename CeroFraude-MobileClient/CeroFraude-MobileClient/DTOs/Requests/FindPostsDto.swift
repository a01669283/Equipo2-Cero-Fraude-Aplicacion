//
//  FindPostsDto.swift
//  CeroFraude-MobileClient
//
//  Created by Diego Martínez on 08/10/26.
//

import Foundation

struct FindPostsDto {
    var page: Int? = nil
    var text: String? = nil
    var categories: [Int]? = nil
    var types: [Int]? = nil
    
    enum CodingKeys: String, CodingKey {
        case page
        case text
        case categories = "category"
        case types = "type"
    }
}
