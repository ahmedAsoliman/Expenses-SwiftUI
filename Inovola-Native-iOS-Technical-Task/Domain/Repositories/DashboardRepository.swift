//
//  DashboardRepository.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//

import Foundation
import CoreData
protocol DashboardRepository {
    func fetchExpenses(pageSize:Int, selectedFilter:DateFilter, lastDate:Date?, lastID:UUID?)  async throws -> NSFetchRequest<Expense>
}
