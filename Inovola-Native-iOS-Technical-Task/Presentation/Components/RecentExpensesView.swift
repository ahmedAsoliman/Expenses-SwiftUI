//
//  RecentExpensesView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//
import SwiftUI
import CoreData

struct RecentExpensesView: View {
    let records: [Expense]

     var onItemAppear: (Expense) -> Void = { _ in }
    var onSeeAll: () -> Void = {}

     var isLoading: Bool = false
    var hasMore: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Expenses")
                    .font(.headline)
                Spacer()
                Button(action: onSeeAll) {
                    Text("See all")
                        .font(.caption.bold())
                        .foregroundColor(.black)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)

            if records.isEmpty && !isLoading {
                VStack(spacing: 8) {
                    Text("No expenses yet")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }

            ExpensesListCore(
                         records: records,
                         onItemAppear: onItemAppear,
                         isLoading: isLoading,
                         hasMore: hasMore
                     )
        }
        .padding(.top, -20)
    }
}
