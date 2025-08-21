//
//  DashboardViewModel.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import SwiftUI
import CoreData
import Combine

enum DateFilter: CaseIterable { case all, last7Days, thisMonth }
@MainActor
final class DashboardViewModel: ObservableObject {
    // MARK: - Filters

    // MARK: - Published (UI State)
    @Published var selectedFilter: DateFilter = .all {
        didSet { Task { await refreshAll() } }
    }
    @Published var totalBalance: Double = 0
    @Published var totalIncome:  Double = 10000
    @Published var totalExpenses: Double = 0
    @Published var recentExpenses: [Expense] = []
    @Published var isLoadingPage = false
    @Published var hasMore = true

    // MARK: - Core
    let context: NSManagedObjectContext
    var cancellables = Set<AnyCancellable>()
    let dashboardUseCase: DashboardUseCase

    // MARK: - Pagination Cursor
    var lastDate: Date?
    var lastID: UUID?

    // MARK: - Config
    let pageSize = 10

    init(context: NSManagedObjectContext,repository: DashboardRepositoryImpl = DashboardRepositoryImpl() ) {
        self.dashboardUseCase = DashboardUseCase(repository: repository)
        self.context = context
        observeContextChanges()
    }
}
