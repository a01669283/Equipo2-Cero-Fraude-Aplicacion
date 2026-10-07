//
//  NewFraudPost.swift
//  CeroFraude-MobileClient
//
//  Created by Armando Vasquez on 17/09/26.
//

// Libreria base de tipos de datos
import Foundation

// MARK: - Categoría de fraude
// De dónde provino o apareció la oferta

// Codable convierte desde y hacia JSON
// Identifiable para ForEach
// Hashable para Set<FraudType>
struct FraudCategory: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let code: String
}

// TODO: Reemplazar por valores de GET /categories
extension FraudCategory {
     static let sampleData: [FraudCategory] = [
        FraudCategory(id: 1, name: "Redes sociales", code: "SOCIAL"),
        FraudCategory(id: 2, name: "Marketplace", code: "MARKET"),
        FraudCategory(id: 3, name: "Mensajería", code: "MESSAGE"),
        FraudCategory(id: 4, name: "Correo electrónico", code: "EMAIL"),
        FraudCategory(id: 5, name: "Sitio web", code: "WEBSITE"),
        FraudCategory(id: 6, name: "Otro", code: "OTHER"),
     ]
}

// MARK: - Tipo de fraude
// Qué tipo de oferta o engaño se reporta
 
struct FraudType: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let code: String
}

// TODO: Reemplazar por valores de GET /types
extension FraudType {
     static let sampleData: [FraudType] = [
        FraudType(id: 1, name: "Producto falso", code: "FAKE_PROD"),
        FraudType(id: 2, name: "Precio engañoso", code: "BAD_PRICE"),
        FraudType(id: 3, name: "Promoción falsa", code: "FAKE_PROMO"),
        FraudType(id: 4, name: "Vendedor falso", code: "FAKE_SELL"),
        FraudType(id: 5, name: "Tienda falsa", code: "FAKE_STORE"),
        FraudType(id: 6, name: "Suplantación de marca", code: "BRAND_IMP"),
        FraudType(id: 7, name: "Otro", code: "OTHER")
     ]
}

// MARK: - Estructura base de un reporte
struct NewFraudPost {
    var title = ""
    var description = ""
    var category: FraudCategory?
    var types: Set<FraudType> = []

    var isAnonymous = false
    var sellerName = ""
    var product = ""
    var phoneNumber = ""
    var url = ""
    var platform = ""
    var fraudulentEmail = ""

    enum Limit {
        static let title = 100
        static let sellerName = 100
        static let product = 100
        static let phoneNumber = 25
        static let url = 255
        static let platform = 100
        static let fraudulentEmail = 255
        // TODO: Determinar limite de caracteres de la descripción
        static let description = 2000
    }
}
