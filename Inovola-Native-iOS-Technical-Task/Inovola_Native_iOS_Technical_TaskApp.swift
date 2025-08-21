//
//  Inovola_Native_iOS_Technical_TaskApp.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import SwiftUI

@main
struct InovolaExpenseTrackerApp: App {
    let context = CoreDataManager.shared.context

    init() {
        CategorySeeder.seedDefaultCategoriesIfNeeded(context: context)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {        
                         MainTabView()
                     }
            .environment(\.managedObjectContext, context)        }
    }
}
