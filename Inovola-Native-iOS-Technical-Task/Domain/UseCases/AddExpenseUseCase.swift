//
//  AddExpenseUseCase.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//

import Foundation
import UIKit

final class AddExpenseUseCase {
    private let repository: ExpenseRepository
    
    init(repository: ExpenseRepository) {
        self.repository = repository
    }
    
    func executeAddExpense(amount: Double, date: Date, isIncome: Bool, category: Category, receiptImage: UIImage?) async throws {
        try await repository.addExpense(amount: amount, date: date, isIncome: isIncome, category: category, receiptImage: receiptImage)
    }
    func fetchExpenses() async throws -> [Category] {
       return try await repository.fetchCategory()
    }

}
