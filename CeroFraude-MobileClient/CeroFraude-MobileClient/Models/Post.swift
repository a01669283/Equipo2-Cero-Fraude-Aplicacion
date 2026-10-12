//
//  Post.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 28/09/26.
//

struct Post {
    let title: String
    
    let author: String?
    
    let validationStatus: ValidationStatus
    
    let category: String
    
    let types: [String]
    
    let description: String
    
    let evidences: [String]?
    
    let reactions: String
    
    let comments: String
}
