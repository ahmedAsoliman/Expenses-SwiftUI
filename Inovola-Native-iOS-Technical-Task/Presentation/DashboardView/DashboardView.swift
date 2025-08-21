//
//  DashboardView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//
import Foundation
import SwiftUI
import CoreData

// MARK: - Dashboard View
struct DashboardView: View {
    
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: DashboardViewModel
    @State private var showAdd = false
    @State private var seeallExpenses = false

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: DashboardViewModel(context: context))
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(selectedFilter: $viewModel.selectedFilter)
                BalanceCardView(totalBalance: viewModel.totalBalance, totalIncome: viewModel.totalIncome, totalExpenses: viewModel.totalExpenses)
                    .padding(.top , -90)
                RecentExpensesView(
                    records: viewModel.recentExpenses,
                    onItemAppear: { exp in
                        viewModel.loadNextPageIfNeeded(currentItem: exp)
                    },
                    onSeeAll: {
                        seeallExpenses = true
                    },
                    isLoading: viewModel.isLoadingPage,
                    hasMore: viewModel.hasMore
                )
                Spacer()
            }
            .background(Color(.systemGray6))
            .edgesIgnoringSafeArea(.all)
            
            .task {
                await viewModel.refreshAll()
            }
       
                 .navigationDestination(isPresented: $seeallExpenses) {
                  AllExpensesView(viewModel: viewModel)
                }
        }
        
        
    }
}
