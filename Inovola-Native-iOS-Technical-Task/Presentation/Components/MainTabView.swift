//
//  MainTabView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//


import SwiftUI
import CoreData

struct MainTabView: View {
    @Environment(\.managedObjectContext) private var context

    @State private var selection = 0
    @State private var showAdd = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                // Tab 0: Dashboard
                NavigationStack {
                    DashboardView(context: context)
                }
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
                .tag(0)

                // Tab 1: Placeholder
                NavigationStack {
                    Text("Reports")
                }
                .tabItem {
                    Label("", systemImage: "chart.bar.fill")
                }
                .tag(1)

                // Tab 2:
                Color.clear
                    .tabItem { EmptyView() }
                    .tag(2)

                // Tab 3
                NavigationStack {
                    Text("Wallet")
                }
                .tabItem {
                    Label("", systemImage: "wallet.pass.fill")
                }
                .tag(3)

                // Tab 4
                NavigationStack {
                    Text("Settings")
                }
                .tabItem {
                    Label("", systemImage: "gearshape.fill")
                }
                .tag(4)
            }

            // Floating + Button
            Button {
                showAdd = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 6)
            }
        }
        .ignoresSafeArea(.keyboard)
         .onChange(of: selection) { [selection] newValue in
            if newValue == 2 { self.selection = selection }
        }
         .navigationDestination(isPresented: $showAdd) {
                        AddExpenseView()
                    }
    
    }
}
