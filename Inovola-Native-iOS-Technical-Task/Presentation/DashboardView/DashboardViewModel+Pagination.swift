//
//  DashboardViewModel+Pagination.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 20/08/2025.
//
import Foundation
import CoreData

extension DashboardViewModel {
    func refreshAll() async {
        fetchDashboardTotals()
        resetPagination()
        await loadNextPage()
    }

    func loadNextPageIfNeeded(currentItem: Expense?) {
        guard let currentItem, hasMore, !isLoadingPage else { return }
        let threshold = max(0, recentExpenses.count - 2)
        if let idx = recentExpenses.firstIndex(where: { $0.objectID == currentItem.objectID }),
           idx >= threshold {
            Task { await loadNextPage() }
        }
    }

    func loadNextPage() async {
        guard !isLoadingPage, hasMore else { return }
        isLoadingPage = true
        defer { isLoadingPage = false }

        do {
            let req = try await dashboardUseCase.executeGetExpense(pageSize: pageSize, selectedFilter: selectedFilter, lastDate: lastDate, lastID: lastID)
            let page = try context.fetch(req)

            if page.isEmpty { hasMore = false; return }

            updateCursor(with: page)
            let appended = appendPage(page)
            if page.count < pageSize || !appended { hasMore = false }
        } catch {
            print("Pagination fetch error:", error)
        }
    }

    func resetPagination() {
        recentExpenses.removeAll()
        lastDate = nil
        lastID = nil
        hasMore = true
    }

//    func buildPageRequest() -> NSFetchRequest<Expense> {
//        let req: NSFetchRequest<Expense> = Expense.fetchRequest()
//        req.sortDescriptors = [
//            NSSortDescriptor(keyPath: \Expense.date, ascending: false),
//            NSSortDescriptor(keyPath: \Expense.id,   ascending: false)
//        ]
//        req.fetchLimit = pageSize
//        req.fetchBatchSize = pageSize
//
//        let base = filterPredicate(for: selectedFilter)
//
//        if let lastDate {
//            if let lastID {
//                let p1 = NSPredicate(format: "date < %@", lastDate as NSDate)
//                let p2 = NSPredicate(format: "date == %@ AND id < %@", lastDate as NSDate, lastID as CVarArg)
//                let cursor = NSCompoundPredicate(orPredicateWithSubpredicates: [p1, p2])
//                req.predicate = base.map { NSCompoundPredicate(andPredicateWithSubpredicates: [$0, cursor]) } ?? cursor
//            } else {
//                let after = NSPredicate(format: "date < %@", lastDate as NSDate)
//                req.predicate = base.map { NSCompoundPredicate(andPredicateWithSubpredicates: [$0, after]) } ?? after
//            }
//        } else if let base {
//            req.predicate = base
//        }
//
//        return req
//    }

    func updateCursor(with page: [Expense]) {
        guard let last = page.last else { return }
        lastDate = last.date
        lastID   = last.id
    }

    @discardableResult
    func appendPage(_ page: [Expense]) -> Bool {
        let existing = Set(recentExpenses.map { $0.objectID })
        let newOnes = page.filter { !existing.contains($0.objectID) }
        recentExpenses.append(contentsOf: newOnes)
        return !newOnes.isEmpty
    }
}
