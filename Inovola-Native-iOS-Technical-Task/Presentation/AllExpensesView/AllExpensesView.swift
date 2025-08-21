//
//  AllExpensesView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//

import SwiftUI

struct AllExpensesView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: DashboardViewModel
    @State private var previousFilter: DateFilter = .all
    @State private var didSetup = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("All Expenses").font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            ExpensesListCore(
                records: viewModel.recentExpenses,
                onItemAppear: { exp in
                    viewModel.loadNextPageIfNeeded(currentItem: exp)
                },
                isLoading: viewModel.isLoadingPage,
                hasMore: viewModel.hasMore
            )
        }   .background(Color(.systemGray6))
            .navigationBarTitle("History", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
        
            .task {
                guard !didSetup else { return }
                didSetup = true
                previousFilter = viewModel.selectedFilter
                viewModel.selectedFilter = .all
                await viewModel.refreshAll()
            }
        
            .onDisappear {
                viewModel.selectedFilter = previousFilter
            }
    }
}

