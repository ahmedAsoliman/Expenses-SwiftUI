//
//  DashboardRepositoryImpl.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//
import Foundation
import CoreData
 

final class DashboardRepositoryImpl: DashboardRepository {
    private let context = CoreDataManager.shared.context

    func fetchExpenses(pageSize:Int, selectedFilter:DateFilter, lastDate:Date?, lastID:UUID?) async throws -> NSFetchRequest<Expense> {

        let req: NSFetchRequest<Expense> = Expense.fetchRequest()
        req.sortDescriptors = [
            NSSortDescriptor(keyPath: \Expense.date, ascending: false),
            NSSortDescriptor(keyPath: \Expense.id,   ascending: false)
        ]
        req.fetchLimit = pageSize
        req.fetchBatchSize = pageSize

        let base = filterPredicate(for: selectedFilter)

        if let lastDate {
            if let lastID {
                let p1 = NSPredicate(format: "date < %@", lastDate as NSDate)
                let p2 = NSPredicate(format: "date == %@ AND id < %@", lastDate as NSDate, lastID as CVarArg)
                let cursor = NSCompoundPredicate(orPredicateWithSubpredicates: [p1, p2])
                req.predicate = base.map { NSCompoundPredicate(andPredicateWithSubpredicates: [$0, cursor]) } ?? cursor
            } else {
                let after = NSPredicate(format: "date < %@", lastDate as NSDate)
                req.predicate = base.map { NSCompoundPredicate(andPredicateWithSubpredicates: [$0, after]) } ?? after
            }
        } else if let base {
            req.predicate = base
        }

        return req 


    }
    
    func filterPredicate(for filter: DateFilter) -> NSPredicate? {
        switch filter {
        case .all:
            return nil
        case .last7Days:
            let cal = Calendar.current, now = Date()
            guard let start = cal.date(byAdding: .day, value: -6, to: cal.startOfDay(for: now)),
                  let end   = cal.date(byAdding: DateComponents(day: 1, second: -1),
                                       to: cal.startOfDay(for: now)) else { return nil }
            return NSPredicate(format: "date >= %@ AND date <= %@", start as NSDate, end as NSDate)

        case .thisMonth:
            let cal = Calendar.current, now = Date()
            guard let startOfMonth = cal.date(from: cal.dateComponents([.year,.month], from: now)),
                  let startOfNext  = cal.date(byAdding: .month, value: 1, to: startOfMonth),
                  let endOfMonth   = cal.date(byAdding: .second, value: -1, to: startOfNext) else { return nil }
            return NSPredicate(format: "date >= %@ AND date <= %@", startOfMonth as NSDate, endOfMonth as NSDate)
        }
    }
}
