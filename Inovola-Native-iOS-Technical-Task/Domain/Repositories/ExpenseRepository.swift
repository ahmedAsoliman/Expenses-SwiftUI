//
//  ExpenseRepository.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//


import Foundation
import UIKit


protocol ExpenseRepository {
    func addExpense(amount: Double, date: Date, isIncome: Bool, category: Category, receiptImage: UIImage?)async throws
    func fetchCategory() async throws -> [Category]

}
