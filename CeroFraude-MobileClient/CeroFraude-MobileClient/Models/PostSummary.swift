//
//  PostSummary.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

/// Represents the summarized information of a post
struct PostSummary {
    /// The id of the post
    let id: Int
    
    /// The title of the post
    let title: String
    
    /// The fraud types associated with the post
    let fraudTypes: [Int]
    
    /// The description in the post
    let description: String
    
    /// The validation result of the post
    let validationStatus: ValidationStatus
    
    /// The formatted time elapsed since the post was published
    let timeAgo: String
}
