//
//  CatalogStorage.swift
//  CeroFraude-MobileClient
//
//  Created by Carolina González García on 09/10/26.
//

import Foundation

struct CatalogStorage {
    static func saveCatalogs(_ catalogs: [CatalogDTO], key: String) {
        guard let data = try? JSONEncoder().encode(catalogs) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func getCatalogs(id: Int, key: String) -> Catalog? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let catalogs = try? JSONDecoder().decode(
                [CatalogDTO].self,
                from: data
              ),
              let catalog = catalogs.first(where: {$0.id == id})
              
        else {
            return nil
        }
        
        return Catalog(
            id: catalog.id,
            name: catalog.name
        )
    }
}
