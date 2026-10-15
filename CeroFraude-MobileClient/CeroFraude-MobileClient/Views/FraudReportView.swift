//
//  FraudReportView.swift
//  CeroFraude-MobileClient
//
//  Created by Armando Vasquez on 17/09/26.
//

// Pantalla completa para crear un reporte de fraude

import SwiftUI
import PhotosUI

struct FraudReportView: View {
    // Evita crear un view model nuevo por cambio
    @State private var viewModel = FraudReportViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Cuerpo de la vista
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                // Dentro de este VStack se encuentran todos los campos del formulario
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    evidenceSection
                    requiredFieldsNote
                    titleField
                    categoryPicker
                    typePicker
                    descriptionField
                    anonymousCheckbox
                    relatedInfoSection
                    actionButtons(proxy: proxy)
                }
                .padding(.horizontal, 30)
                // Margenes de campos pueden ocultar el teclado
                .contentShape(Rectangle())
                .onTapGesture {
                    dismissKeyboard()
                }
            }
            .background(Color(.appBackground))
            .scrollDismissesKeyboard(.immediately)
        }
        .alert("¿Enviar reporte?", isPresented: $viewModel.isShowingSubmitConfirmation) {
            Button("Cancelar", role: .cancel) { 
                // No action needed: SwiftUI dismisses the alert on any button tap
            }
            Button("Enviar") {
                viewModel.submit()
            }
        } message: {
            Text("Un administrador lo revisará antes de que sea visible para otros usuarios. Después de enviarlo ya no podrás editarlo.")
        }
        .alert("Reporte enviado", isPresented: $viewModel.isShowingSubmitted) {
            Button("Aceptar") {
                dismiss()
            }
        } message: {
            Text("Tu reporte está en revisión.")
        }
    }
    
    // MARK: - Título de la pantalla
    private var titleSection: some View {
        Text("Reportar una oferta")
            .font(.title.bold())
            .foregroundStyle(Color(.textPrimary))
            .frame(maxWidth: .infinity)
    }
    
    // MARK: - Evidencias
    private var evidenceSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Evidencias (opcional)")
                .font(.headline)
                .foregroundStyle(Color(.textPrimary))
            // Descripción del campo de fotos
            Text("Agrega imágenes que ayuden a complementar tu reporte")
                .font(.subheadline)
                .foregroundStyle(Color(.textSecondary))
                .italic(true)
            HStack(spacing: 10) {
                addEvidenceButton
                if viewModel.evidences.isEmpty{
                    emptyEvidenceState
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(Array(viewModel.evidences.enumerated()), id: \.element.id) {
                                index, evidence in
                                evidenceThumbnail(evidence, number: index + 1)
                            }
                        }
                    }
                }
                
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white, in: RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.fieldBorder), lineWidth: 1)
            )
        }
        .onChange(of: viewModel.pickerSelection) {
            Task {
                await viewModel.loadSelectedEvidences()
            }
        }
    }
    
    private var addEvidenceButton: some View {
        let enabled = viewModel.canAddEvidence
        
        return PhotosPicker(
            selection: $viewModel.pickerSelection,
            maxSelectionCount: max(viewModel.remainingEvidenceSlots, 1),
            matching: .images
        ) {
            VStack(spacing: 6) {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(enabled ? Color(.brandPrimary) : Color(.disabledContent))
                Text("Agregar")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(enabled ? Color(.brandPrimaryDark) : Color(.disabledContent))
            }
            .frame(width: 88, height: 88)
            .background(
                enabled ? Color(.brandSurface) : Color(.disabledSurface),
                in: RoundedRectangle(cornerRadius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        enabled ? Color(.brandPrimary) : Color(.fieldBorder),
                        style: StrokeStyle(lineWidth: 1.5, dash: [4])
                    )
            )
        }
        .disabled(!enabled)
        .accessibilityLabel("Agregar foto")
    }
    
    private var emptyEvidenceState: some View {
        VStack(spacing: 0) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 26))
                .foregroundStyle(Color(.iconMuted))
            Text("Aún no hay evidencias")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color(.textPrimary))
            Text("Las imágenes que agregues aparecerán aquí")
                .font(.subheadline)
                .foregroundStyle(Color(.textSecondary))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
    
    private func evidenceThumbnail(_ evidence: EvidenceItem, number: Int) -> some View {
        Image(uiImage: evidence.image)
            .resizable()
            .scaledToFill()
            .frame(width: 88, height: 88)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.borderSubtle), lineWidth: 1)
            )
            .overlay(alignment: .topTrailing) {
                Button {
                    viewModel.removeEvidence(evidence)
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 26, height: 26)
                        .background(Color(.textPrimary).opacity(0.72), in: Circle())
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .accessibilityLabel("Quitar evidencia \(number)")
            }
    }
    
    // MARK: - Aviso de campos obligatorios
    private var requiredFieldsNote: some View {
        Text("* Campos obligatorios")
            .font(.subheadline)
            .foregroundStyle(Color(.textSecondary))
    }
    
    // MARK: - Título del reporte
    private var titleField: some View {
        LabeledTextField(label: "Título*", placeholder: "Escribe un título", text: $viewModel.post.title, maxLength: NewFraudPost.Limit.title, errorMessage: viewModel.errorMessage(for: .title))
            .id(RequiredField.title)
    }
    
    // MARK: - Categoría de fraude
    private var categoryPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            FieldHeader(
                label: "Categoría*",
                errorMessage: viewModel.errorMessage(for: .category)
            )
            Menu {
                Picker("Categoría", selection: $viewModel.post.category) {
                    ForEach(viewModel.categories) { category in
                        Text(category.name)
                            .tag(Optional(category))
                    }
                }
            } label: {
                HStack {
                    Text(viewModel.post.category?.name ?? "Selecciona categoría")
                        .foregroundStyle(
                            viewModel.post.category == nil
                            ? Color(uiColor: .placeholderText)
                            : Color(.textPrimary)
                        )
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color(.textSecondary))
                }
                .padding(.horizontal, 16)
                .frame(minHeight: 47)
                .background(.white, in: RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(viewModel.errorMessage(for: .category) == nil
                                ? Color(.fieldBorder)
                                : Color(.danger),
                            lineWidth: 1
                        )
                )
            }
        }
        .id(RequiredField.category)
    }
    
    // MARK: - Tipo de fraude
    private var typePicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            FieldHeader(label: "Tipo*", errorMessage: viewModel.errorMessage(for: .types))
            Menu {
                ForEach(viewModel.fraudTypes) { fraudType in
                    Button {
                        viewModel.toggle(fraudType)
                    } label: {
                        if viewModel.post.types.contains(fraudType) {
                            Label(fraudType.name, systemImage: "checkmark")
                        } else {
                            Text(fraudType.name)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedTypesText)
                        .foregroundStyle(
                            viewModel.post.types.isEmpty
                            ? Color(uiColor: .placeholderText)
                            : Color(.textPrimary)
                        )
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color(.textSecondary))
                }
                .padding(.horizontal, 16)
                .frame(minHeight: 47)
                .background(.white, in: RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(viewModel.errorMessage(for: .types) == nil
                                ? Color(.fieldBorder)
                                : Color(.danger),
                            lineWidth: 1)
                )
            }
            .menuActionDismissBehavior(.disabled)
        }
        .id(RequiredField.types)
    }
    
    // Se recorre el catálogo para mantener la vista ordenada siempre
    private var selectedTypesText: String {
        let names = viewModel.fraudTypes
            .filter { viewModel.post.types.contains($0) }
            .map(\.name)
        
        return names.isEmpty ? "Selecciona tipo" : names.joined(separator: ", ")
    }
    
    // MARK: - Descripción
    private var descriptionField: some View {
        LabeledTextField(
            label: "Descripción*",
            placeholder: "Cuéntanos qué ocurrió...",
            text: $viewModel.post.description,
            maxLength: NewFraudPost.Limit.description,
            isMultiline: true,
            errorMessage: viewModel.errorMessage(for: .description)
        )
        .id(RequiredField.description)
    }
    
    // MARK: - Publicación anónima
    private var anonymousCheckbox: some View {
        Button {
            viewModel.post.isAnonymous.toggle()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: viewModel.post.isAnonymous ? "checkmark.square.fill" : "square")
                    .font(.title3)
                    .foregroundStyle(
                        viewModel.post.isAnonymous
                        ? Color(.brandPrimary)
                        : Color(.textSecondary)
                    )
                Text("Publicar de forma anónima")
                    .font(.subheadline)
                    .foregroundStyle(Color(.textPrimary))
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(viewModel.post.isAnonymous ? .isSelected : [])
    }
    
    // MARK: - Información relacionada
    private var relatedInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                withAnimation {
                    viewModel.isRelatedInfoExpanded.toggle()
                }
            } label: {
                Label(
                    "Agregar información relacionada (opcional)",
                    systemImage: viewModel.isRelatedInfoExpanded ? "minus" : "plus"
                )
                .font(.callout.weight(.medium))
                .foregroundStyle(Color(.textPrimary))
            }
            .buttonStyle(.plain)
            
            if viewModel.isRelatedInfoExpanded {
                Text("Agrega los datos que conozcas para facilitar que otros usuarios encuentren este reporte")
                    .font(.subheadline)
                    .italic()
                    .foregroundStyle(Color(.textSecondary))
                
                LabeledTextField(
                    label: "Vendedor",
                    placeholder: "Nombre del vendedor",
                    text: $viewModel.post.sellerName,
                    maxLength: NewFraudPost.Limit.sellerName
                )
                LabeledTextField(
                    label: "Producto o servicio",
                    placeholder: "Nombre del producto o servicio",
                    text: $viewModel.post.product,
                    maxLength: NewFraudPost.Limit.product
                )
                LabeledTextField(
                    label: "Teléfono",
                    placeholder: "Número de teléfono fraudulento",
                    text: $viewModel.post.phoneNumber,
                    maxLength: NewFraudPost.Limit.phoneNumber,
                    keyboard: .phonePad
                )
                LabeledTextField(
                    label: "URL",
                    placeholder: "Enlace del sitio o publicación",
                    text: $viewModel.post.url,
                    maxLength: NewFraudPost.Limit.url,
                    keyboard: .URL
                )
                LabeledTextField(
                    label: "Plataforma",
                    placeholder: "Nombre del sitio o app donde ocurrió",
                    text: $viewModel.post.platform,
                    maxLength: NewFraudPost.Limit.platform
                )
                LabeledTextField(
                    label: "Correo electrónico",
                    placeholder: "Correo electrónico fraudulento",
                    text: $viewModel.post.fraudulentEmail,
                    maxLength: NewFraudPost.Limit.fraudulentEmail,
                    keyboard: .emailAddress
                )
            }
        }
    }
    
    // MARK: - Botones de envío
    // Recibe el proxy para poder hacer scroll al primer campo obligatorio que falte
    private func actionButtons(proxy: ScrollViewProxy) -> some View {
        VStack(spacing: 16) {
            Button {
                if let firstMissing = viewModel.attemptSubmit() {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        proxy.scrollTo(firstMissing, anchor: .top)
                    }
                    AccessibilityNotification.Announcement("Faltan campos obligatorios").post()
                }
            } label: {
                Text("Publicar reporte")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 32)
                    .frame(minWidth: 219, minHeight: 55)
                    .background(Color(.brandPrimary), in: Capsule())
            }
            
            // Botón de borrador
            Button {
                viewModel.saveDraft()
            } label: {
                Text("Guardar borrador")
                    .font(.subheadline)
                    .underline()
                    .foregroundStyle(Color(.brandPrimary))
            }
            .disabled(!viewModel.canSaveDraft)
            .opacity(viewModel.canSaveDraft ? 1 : 0.4)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 24)
        .padding(.bottom, 32)
    }

    // MARK: - Teclado
    // Pregunta que campo tiene el teclado para poder ocultarlo
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    NavigationStack {
        FraudReportView()
    }
}
