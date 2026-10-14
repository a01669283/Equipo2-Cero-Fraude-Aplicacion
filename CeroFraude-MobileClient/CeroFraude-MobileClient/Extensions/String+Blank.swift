//
//  String+Blank.swift
//  CeroFraude-MobileClient
//
//  Created by Hugo Rodríguez on 29/09/26.
//

import Foundation

extension String {
    /// Indica si el texto está vacío o solo tiene espacios y saltos de línea
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
