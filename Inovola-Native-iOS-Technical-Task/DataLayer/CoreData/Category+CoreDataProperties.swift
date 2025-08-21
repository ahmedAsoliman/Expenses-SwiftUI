//
//  Category+CoreDataProperties.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var colorHex: String?
    @NSManaged public var iconName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var expense: NSSet?

}

// MARK: Generated accessors for expense
extension Category {

    @objc(addExpenseObject:)
    @NSManaged public func addToExpense(_ value: Expense)

    @objc(removeExpenseObject:)
    @NSManaged public func removeFromExpense(_ value: Expense)

    @objc(addExpense:)
    @NSManaged public func addToExpense(_ values: NSSet)

    @objc(removeExpense:)
    @NSManaged public func removeFromExpense(_ values: NSSet)

}

extension Category : Identifiable {

}
