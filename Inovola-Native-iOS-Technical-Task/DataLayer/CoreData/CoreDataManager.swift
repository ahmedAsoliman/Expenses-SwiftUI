//
//  CoreDataManager.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 08/08/2025.
//
import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Inovola_Native_iOS_Technical_Task")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error)")
            }
        }
    }
}
