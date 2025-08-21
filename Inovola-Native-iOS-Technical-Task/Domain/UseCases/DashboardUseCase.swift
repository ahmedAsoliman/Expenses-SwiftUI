//
//  DashboardUseCase.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//

import Foundation
import CoreData

final class DashboardUseCase {
    private let repository: DashboardRepository
    
    init(repository: DashboardRepository) {
        self.repository = repository
    }
    
    func executeGetExpense(pageSize:Int, selectedFilter:DateFilter, lastDate:Date?, lastID:UUID?) async throws -> NSFetchRequest<Expense> {
        try await repository.fetchExpenses(pageSize: pageSize, selectedFilter: selectedFilter, lastDate: lastDate, lastID: lastID)
    }
}
