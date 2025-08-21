//
//  DashboardViewModel+Totals.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 19/08/2025.
//

import Foundation
import CoreData

extension DashboardViewModel {
    func fetchDashboardTotals() {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]
                request.fetchLimit = pageSize

                do {
                    let expenses = try context.fetch(request)
                    self.recentExpenses = expenses
                    totalExpenses = expenses.filter { $0.convertedAmount > 0 }.map(\.convertedAmount).reduce(0, +)
                    totalBalance = totalIncome - totalExpenses
                } catch {
                    print("Failed to fetch dashboard data: \(error)")
                }    }
}
