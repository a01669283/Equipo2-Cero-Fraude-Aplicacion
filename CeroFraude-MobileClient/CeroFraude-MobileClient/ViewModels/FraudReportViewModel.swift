//
//  FraudReportViewModel.swift
//  CeroFraude-MobileClient
//
//  Created by Armando Vasquez on 17/09/26.
//

// Maneja la validación, la selección de tipos y la carga de evidencias.

// PhotosUI permite traer una foto de la galeria a traves de PhotosPickerItem
import SwiftUI
import PhotosUI

// MARK: - Evidencia
// Se genera un UUID para identificar cada evidencia, esto permite que cada imagen sea identificable para procesos como 'borrar'
struct EvidenceItem: Identifiable {
    let id = UUID()
    let image: UIImage
}

// MARK: - Campos obligatorios
// Anuncios de campos obligatorios
enum RequiredField: CaseIterable {
    case title, category, types, description

    var errorMessage: String {
        switch self {
        case .title: "Indica un título"
        case .category: "Selecciona la categoría"
        case .types: "Selecciona al menos un tipo"
        case .description: "Incluye una descripción"
        }
    }
}

// MARK: - View model
// final evita que se pueda heredar la clase
@MainActor
@Observable
final class FraudReportViewModel {
    
    // MARK: - Estado
    var post = NewFraudPost()
    
    // Estados de la interfaz
    var isRelatedInfoExpanded = false
    var isShowingSubmitConfirmation = false
    var isShowingSubmitted = false
    
    // MARK: - Catálogos
    // TODO: Cargar valores de GET /categories y GET /types
    private(set) var categories: [FraudCategory] = FraudCategory.sampleData
    private(set) var fraudTypes: [FraudType] = FraudType.sampleData
    
    // MARK: - Evidencias
    // TODO: Determinar maximo de evidencias posibles por el usuario
    static let maxEvidences = 5
    var pickerSelection: [PhotosPickerItem] = []
    private(set) var evidences: [EvidenceItem] = []
    
    /// Cantidad de evidencias que todavía se pueden agregar.
    var remainingEvidenceSlots: Int {
        Self.maxEvidences - evidences.count
    }

    /// Indica si todavía no se alcanza el máximo de evidencias.
    var canAddEvidence: Bool {
        remainingEvidenceSlots > 0
    }

    /// Convierte las fotos elegidas en `pickerSelection` en evidencias y las agrega al inicio.
    ///
    /// Solo agrega las que caben en los espacios disponibles y después limpia la selección.
    func loadSelectedEvidences() async {
        guard !pickerSelection.isEmpty else {
            return
        }
        
        var newItems: [EvidenceItem] = []
        for item in pickerSelection {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                newItems.append(EvidenceItem(image: image))
            }
        }
        // Insertar elementos al inicio del carrete de evidencias
        evidences.insert(contentsOf: newItems.prefix(remainingEvidenceSlots), at: 0)
        pickerSelection = []
    }
    
    /// Quita una evidencia del reporte.
    func removeEvidence(_ evidence: EvidenceItem) {
        evidences.removeAll { $0.id == evidence.id }
    }
    
    // MARK: - Validación
    // Validación para enviar a revisión
    var isShowingValidationErrors = false
    
    private var hasTitle: Bool { !post.title.trimmed.isEmpty }
    private var hasCategory: Bool { post.category != nil }
    private var hasTypes: Bool { !post.types.isEmpty }
    private var hasDescription: Bool { !post.description.trimmed.isEmpty }
    private var hasRelatedInfo: Bool {
        let relatedFields = [
            post.sellerName,
            post.product,
            post.phoneNumber,
            post.url,
            post.platform,
            post.fraudulentEmail
        ]
        return relatedFields.contains { !$0.trimmed.isEmpty }
    }
    
    private func isFilled(_ field: RequiredField) -> Bool {
        switch field {
        case .title: hasTitle
        case .category: hasCategory
        case .types: hasTypes
        case .description: hasDescription
        }
    }
    
    /// Campos obligatorios vacíos, en el mismo orden en que aparecen en el formulario.
    var missingFields: [RequiredField] {
        RequiredField.allCases.filter { !isFilled($0) }
    }

    // TODO: Revisar condiciones para enviar y para guardar borradores
    /// Indica si todos los campos obligatorios están llenos.
    var canSubmit: Bool {
        return missingFields.isEmpty
    }

    /// Indica si al menos un campo del formulario tiene información.
    var canSaveDraft: Bool {
        return (hasTitle || hasCategory || hasTypes || hasDescription || hasRelatedInfo)
    }

    /// Regresa el mensaje de error de un campo, o `nil` si está lleno
    /// o si todavía no se ha intentado enviar el reporte.
    func errorMessage(for field: RequiredField) -> String? {
        guard isShowingValidationErrors, !isFilled(field) else { return nil }
        return field.errorMessage
    }
    
    // MARK: - Acciones
    /// Selecciona el tipo de fraude si no estaba seleccionado, o lo quita si ya lo estaba.
    func toggle(_ type: FraudType) {
        if post.types.contains(type) {
            post.types.remove(type)
        } else {
            post.types.insert(type)
        }
    }
    
    /// Si falta algún campo, muestra los errores y regresa el primero que falta.
    /// Si está completo, abre la confirmación y regresa nil.
    func attemptSubmit() -> RequiredField? {
        if let firstMissing = missingFields.first {
            isShowingValidationErrors = true
            return firstMissing
        }
        isShowingSubmitConfirmation = true
        return nil
    }
    
    /// Envía el reporte a revisión y muestra la alerta de confirmación de envío.
    func submit() {
        // TODO: POST /posts con estado UPLOADED cuando exista el endpoint
        isShowingSubmitted = true
    }

    /// Guarda el reporte como borrador.
    func saveDraft() {
        // TODO: POST /posts con estado DRAFT (los borradores se guardan en el servidor)
    }
    
}

// MARK: - Extensiones
// Extension privada para que no pase a afectar a otros strings
private extension String {
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
