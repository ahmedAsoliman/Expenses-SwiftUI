//
//  AddExpenseViewModel.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//
import Foundation
import SwiftUI
import CoreData

@MainActor
final class AddExpenseViewModel: ObservableObject {
    // MARK: - Input Fields
    @Published var selectedCategory: Category?
    @Published var amount: String = ""
    @Published var date: Date = Date()
    @Published var isIncome: Bool = false
    @Published var showMessage: Bool = false
    @Published var receiptImage: UIImage?
    
    // MARK: - UI State
    @Published var categories: [Category] = []
    @Published var errorMessage: String?
    @Published var isSaving: Bool = false
    @Published var didSave: Bool = false
    private let context = CoreDataManager.shared.context
    private let addExpenseUseCase: AddExpenseUseCase
    private let getCategoryUseCase: GetCategoryUseCase

    // MARK: - Init

    init(repository: ExpenseRepository = ExpenseRepositoryImpl()) {
        self.addExpenseUseCase = AddExpenseUseCase(repository: repository)
        self.getCategoryUseCase = GetCategoryUseCase(repository: repository)
    }
    
    func loadCategories() async {
        do {
            categories = try await getCategoryUseCase.executeCategory()
        } catch {
            errorMessage = "Failed to load categories: \(error.localizedDescription)"
        }
    }
    
    
    private func validate() -> String? {
        guard let _ = selectedCategory else { return "Please select a category." }
        guard let amountValue = Double(amount), amountValue > 0 else { return "Please enter a valid amount." }
        return nil
    }
    
    func saveExpense() async {
        errorMessage = ""
        showMessage = false
        didSave = false
        
        if let validationError = validate() {
            errorMessage = validationError
            showMessage = true
            return
        }
        isSaving = true
        guard let category = selectedCategory, let amountValue = Double(amount) else { return }
        do {
            try await addExpenseUseCase.executeAddExpense(amount: amountValue, date: date, isIncome: isIncome, category: category, receiptImage: receiptImage)
            didSave = true
            isSaving = false
        } catch {
            errorMessage = error.localizedDescription
            showMessage = true
            isSaving = false
        }
        
    }
}
