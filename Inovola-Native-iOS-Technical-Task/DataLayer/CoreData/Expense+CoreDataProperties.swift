//
//  Expense+CoreDataProperties.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var convertedAmount: Double
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isIncome: Bool
    @NSManaged public var receiptImage: Data?
    @NSManaged public var title: String?
    @NSManaged public var category: Category?

}

extension Expense : Identifiable {

}
