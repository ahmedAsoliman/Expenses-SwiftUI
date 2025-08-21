//
//  ExpenseRepositoryImpl.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//

import Foundation
import CoreData
import UIKit


final class ExpenseRepositoryImpl: ExpenseRepository {

    private let context = CoreDataManager.shared.context
    
    

    func addExpense(amount: Double, date: Date, isIncome: Bool, category: Category, receiptImage: UIImage?) async throws {
        Task {
            do {
                let converted = try await CurrencyConverterService().convertToUSD(amount: amount, from: "EGP")
                
                let expense = Expense(context: context)
                expense.id = UUID()
                expense.amount = amount
                expense.currency = "USD"
                expense.convertedAmount = converted
                expense.date = date
                expense.isIncome = isIncome
                expense.category = category
                if let imageData = receiptImage?.jpegData(compressionQuality: 0.8) {
                    expense.receiptImage = imageData
                }
                try context.save()
            } catch {
                _ = "Conversion/Save failed: \(error.localizedDescription)"
            }
        }
    }
    
    
    func fetchCategory() async throws -> [Category] {
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
                do {
                    return try context.fetch(request)
                } catch {
                    _ = "Failed to load categories: \(error.localizedDescription)"
                }
        return []
    }

}
