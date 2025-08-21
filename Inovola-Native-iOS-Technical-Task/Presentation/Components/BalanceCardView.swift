//
//  BalanceCardView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 19/08/2025.
//
import SwiftUI



struct BalanceCardView: View {
     var totalBalance: Double
    var totalIncome: Double
    var totalExpenses: Double

    var body: some View {
        
        VStack(spacing: 16) {
            HStack() {
                VStack(alignment: .leading) {
                        Text("Total Balance")
                            .font(.subheadline.bold())
                            .foregroundColor(.white.opacity(0.8))
                     Text("$ " + totalBalance.toRoundedString())
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                }
                Spacer()
            }
            HStack(spacing: 40) {
                VStack {
                    HStack() {
                        Text("Income")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Image(systemName: "chevron.up")
                            .foregroundColor(.white)
                    }

                    Text("$ " + totalIncome.toRoundedString())
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack {
                    HStack() {
                        Text("Expenses")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }

                    Text("$ " + totalExpenses.toRoundedString())
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: 200)
        .background(Color.accentColor)
        .cornerRadius(20)
        .padding(.horizontal)
        .offset(y: -40)
    }
    }
