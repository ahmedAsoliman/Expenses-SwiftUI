//
//  ExpensesListCore.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//

import SwiftUI

import CoreData

struct ExpensesListCore: View {
    let records: [Expense]
    var onItemAppear: (Expense) -> Void = { _ in }
    var isLoading: Bool = false
    var hasMore: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(records, id: \.objectID) { item in
                    ExpenseItemRow(record: item)
                        .onAppear { onItemAppear(item) }
                }
                
                if isLoading && hasMore {
                    ProgressView("Loading…")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
    }
}
