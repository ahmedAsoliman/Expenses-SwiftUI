//
//  CategorySeeder.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import CoreData

final class CategorySeeder {
    static func seedDefaultCategoriesIfNeeded(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                let defaultCategories: [(String, String,String)] = [
                    ("Groceries", "cart","a2d2ff"),
                    ("Entertainment", "popcorn","faedcd"),
                    ("Gas", "fuelpump","ffafcc"),
                    ("Shopping", "bag","ffc8dd"),
                    ("News Paper", "newspaper","cdb4db"),
                    ("Transport", "car","ffb4a2"),
                    ("Rent", "house","e5989b"),
//                    ("Add Category", "plus","f1faee")
                ]
                
                for (name, icon,hexColor) in defaultCategories {
                    let category = Category(context: context)
                    category.id = UUID()
                    category.name = name
                    category.iconName = icon
                    category.colorHex = hexColor
                }
                try context.save()
                print("✅ Default categories seeded.")
            }
        } catch {
            print("❌ Failed to seed categories: \(error.localizedDescription)")
        }
    }
}
