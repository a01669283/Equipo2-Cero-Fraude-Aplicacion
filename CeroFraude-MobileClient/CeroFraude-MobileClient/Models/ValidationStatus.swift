//
//  ValidationStatus.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 27/09/26.
//

/// Represents the validation result displayed to the user for a post
enum ValidationStatus {
    
    /// The post has not been validated yet
    case unvalidated
    
    /// The post has been validated as fraud
    case isFraud
    
    /// The post has been validated as not fraudulent
    case notFraud
}
