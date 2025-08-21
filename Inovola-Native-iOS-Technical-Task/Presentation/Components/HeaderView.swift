//
//  HeaderView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedFilter: DateFilter
    @State private var isExpanded = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.blue.opacity(0.8))
                .frame(height: 250)
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image("user")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Good Morning")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Text("Ahmed Soliman")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    
                    Menu {
                        Picker("Filter", selection: $selectedFilter) {
                            Text("All").tag(DateFilter.all)
                            Text("Last 7 Days").tag(DateFilter.last7Days)
                            Text("This Month").tag(DateFilter.thisMonth)
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Text(filterLabel(selectedFilter))
                                .font(.caption)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
            .padding(.top, 60)
        }
    }
    
    private func filterLabel(_ f: DateFilter) -> String {
        switch f {
        case .all:        return "All"
        case .last7Days:  return "Last 7 Days"
        case .thisMonth:  return "This Month"
        }
    }
}
