//
//  DashboardViewModel+Filtering.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//


import Foundation
import CoreData

extension DashboardViewModel {
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
